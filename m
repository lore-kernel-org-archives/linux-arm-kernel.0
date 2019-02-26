Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9755C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:38:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC5C21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eA73SFe4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZMfDXVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC5C21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s4Zy/+Br9cm64wXY+ldyoY2KOomSesgkgQlLuHT1KGw=; b=eA73SFe4VVzdzX
	Z009Ri+mjBu/mkdhOSu9JMPdBIhBsW+0BTcMeATQvbPDnAChAWX/L4Bjhwv7sH4/AyuYNLgn2s2St
	dI14mA2cf3i4aEQRNmHFXlNbOmHJI7liYxm09eZ9fywvQKJ7OBXYr2epIBoByCp6J63A3JbxxFSQB
	hRLey7i70jzl+nRW+/Dcc9tfwW3A4sXat3zBOQwWxwDjLblJWuApM0nn3pSR9Wcp1LzbTxZNIsIYL
	SXjWhG85orIwYapD9LvJoQqXOoU3xq4J1fZMoAxPXzVvLV66/KkDoEWDMiyso/1etndxgM7b5xOir
	zVRx94mKwRx08TC/Z9Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycwU-0007Iu-My; Tue, 26 Feb 2019 13:38:42 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycwR-0007Hr-Iu
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:38:40 +0000
Received: by mail-oi1-x242.google.com with SMTP id x187so10300141oia.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 05:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=utLRdCBRFM4gyIdZWj/RwZKM2SuYji0tmszj9nFdaK0=;
 b=nZMfDXVM7ZPj1TnJgzQHhTTdw477ESkFFuIApQ1DuXEoRopaGzbiA50AiTUElxQ4yE
 erAV9m4iJeoP282obpeIbNeowhP9yNkzKp02/OzYFfAU/l1HGZtuGEs50zOOaKaGXWXy
 QgUz6lYeSGdj7NhTKGLs/i+vqxzZoqC+lBowlyepJV38C5FyyaSlaE9LxwQfXMKitLro
 9c345lYaEO1ysVhdE1CWV+IibX95Ybl6IBNQ3dxjJdkF243ShulStMCF7sKQJ53tWTLZ
 AARCshOAC1t1kcFXsZCvoUHXuWK4e4NiDqHRb2+Q6iIhbsu8NIsSSL89z7u7I7y+1dDl
 TDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=utLRdCBRFM4gyIdZWj/RwZKM2SuYji0tmszj9nFdaK0=;
 b=CEid+XgflQOSGTUKhh+Vi9ACC2eNNGxXK4J+Zkg5pUOkfmBt1pstf5lZlM5Rk/aXw/
 PHxorXVdaLUQYuz75BTMWvO0Tvr9TzfjMXmtlWoJniVf4TBzyZH6QTN0OH6ao8SgHCO4
 UPTplFspdlvtbZpv+s4ju4DBlWCn9AP5Nx1FjIXWsnPcRqefG63CHiwLDBDEaJ+GeY4h
 U+3AFeY2lCUgynRQqIIGsdcoIEDSBFD2YYO9Ykyzp6x7Uznnvgxmu87R+1uWdkcj2Ub/
 /WEfz0Hv+bKLAQQ1T43dyrQV/fq+ArbDEWMEfVeNDboDf+ucpeUySUm01IWrkVBVCLi4
 J6TA==
X-Gm-Message-State: AHQUAuY0/hJ4f5apyiy71vPnpKoYTpDFWGOTZ5zmu1H5rexLe3wxAVQK
 pq+ZkugeZ2KH3VO/Reu5R9LlTIxODepDWzxkI64=
X-Google-Smtp-Source: AHgI3IYqjATxXn47G5zBKU1PtC+fMUzXmPUE5eweUwBJTuGMzill9BQEMGdTYYcleWPlAn8vSVKh9QtH2yA4e/+NCOo=
X-Received: by 2002:aca:aac7:: with SMTP id t190mr2222649oie.43.1551188318562; 
 Tue, 26 Feb 2019 05:38:38 -0800 (PST)
MIME-Version: 1.0
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5AmRAhxSw2KB-LBY68a+DvVSKPQ1ecAf_YPhQhBAdJ1UQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AmRAhxSw2KB-LBY68a+DvVSKPQ1ecAf_YPhQhBAdJ1UQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Feb 2019 10:38:28 -0300
Message-ID: <CAOMZO5AC+Zna4oYTk7Er-2SpbQayhmeyrbhpZM-wFfO6axcFVQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
To: Abel Vesa <abel.vesa@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_053839_620518_1B535450 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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
Cc: Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, Abel Vesa <abelvesa@linux.com>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Chris Spencer <spencercw@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 10:37 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 7:53 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> > +       magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> > +       if (magic == IMX8MQ_SW_MAGIC_B1)
> > +               rev = REV_B1;
>
> Don't you mean rev == REV_B1; ?

Ops, was looking at the wrong line, sorry :-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
