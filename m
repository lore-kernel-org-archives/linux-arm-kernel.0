Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:16:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E74B206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RFzLnYt1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iz1LApfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E74B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FVAZ8UO7Y3aRc8HhutyYfGVpZTfyoMYU9aSUTPrbYTs=; b=RFzLnYt1VJymIX
	wzfuiR7EmWwQkmlH1iKlysZQtkCuws1tCUuRALstm8JG/wgPqSx0pxI2D1wsFskbY3Ebh9UP/GZGQ
	BzWX2hekHDzWhC80V6K8VaJAnHTP6Silh+Atci2lm5DtwKi/6wSv8DZRhsLYOAOLZ/9w+/260LVTj
	IdAXc7EJxjOAxLf65RbTAECiIY4LgvAlwkJ7UK0yaYSqnLgV43iKKED6tsUWg07VFWfjySvPEPSTw
	in2XmIl0kZHpb/Cr8SmS1YLDypigHchHydRR0xxwV4MXw9QkU0XhsCeZvHAD9yA3pXF6Z4jwHRCcC
	Xk3B9SI6n78xoZTImtaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvjR-0005ad-IM; Fri, 11 Jan 2019 12:16:13 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvjM-0005Xv-Jb
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:16:11 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so12719081ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nJvZ9aA7kxJjZFLo1RF/B2VvSXiNkbAu9KeR5An6hXg=;
 b=iz1LApfXrv4XxZ+SXzgkPFB8g6QClp7K7ozwAW1s1F4nkJlMRyfchOPQGBuOL2aW8F
 3u/CLsz+DQlU0nmKCm5ZH2t10gvdNFtDox+2pry5MYpPdp3zmf1/ZDQrPp4mKUWngaKv
 +Z9q8oRXBz0f7TAM9IKypRJFffAh62uExhjVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nJvZ9aA7kxJjZFLo1RF/B2VvSXiNkbAu9KeR5An6hXg=;
 b=EUoBEEV6OpVyeUWrvGK6qe92Kr+D6ZiUzxZW4/kJX45xMvM4NYUtcSCHfj5DiEaK0C
 1Hrjt4I82BCm04rnTgKUflzB3+bvW0Fdt30rzPPI7i8BQAzi9b10KJcN85ROdc8281tu
 yGbzMiQmzRRfz1xD9eo5hJULJZMO36vJy9gKOP6U9gMXRElrmS/5Z7q61mENDhy052RM
 U6FY7gi3RxeoA9vRA8LwvWSDMNEr3shNYl6OJlo+zviUOnukHLft4Nw647GLuS0sL9vr
 s7fiuUbs7zCXzNtgWzjQCulytVsMDE0CkG3wPCqIGzKkjlhswr8C/OxOT23N3mq1XpXg
 ruPw==
X-Gm-Message-State: AJcUukcIeEiWXeGbrQtmH/kTr3naJ4Rbg4EAXVmnL736YXwXu0NAUYI+
 Nkbwc5DyEon8dMGJ5117L/ophQaxwgHjl+BH5x7Zvg==
X-Google-Smtp-Source: ALg8bN41O3reEE+JTtBEo9wmOu52QK/F0wo/fZAIr5YSpubH6XUtUqJfyDFNoBgO3RbPfsOkv98W822XrAfXo/jTjCQ=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr8436654ljg.23.1547208966250; 
 Fri, 11 Jan 2019 04:16:06 -0800 (PST)
MIME-Version: 1.0
References: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 13:15:54 +0100
Message-ID: <CACRpkdaF+PFv-oUkLiWT7M2hYESsAYxaPN5OM2=XraeAx9zP4Q@mail.gmail.com>
Subject: Re: [PATCH v5] pinctrl: mediatek: add EINT support to virtual GPIOs
To: chuanjia.liu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_041608_747898_CA750D07 
X-CRM114-Status: GOOD (  10.38  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 Sean Wang <sean.wang@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 hailong.fan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 huang eddie <eddie.huang@mediatek.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 4:38 AM <chuanjia.liu@mediatek.com> wrote:

> From: "chuanjia.liu" <Chuanjia.Liu@mediatek.com>
>
> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't need SMT.
> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: chuanjia.liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v5: This patch is the same as v4,re-upload due to
>       mail permissions issues

Patch applied with Sean's ACK.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
