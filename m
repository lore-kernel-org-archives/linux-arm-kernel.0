Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC01C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:26:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7CD20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UkJ8wRsP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJi2E28s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7CD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fYDAy08oADgTGd1J7pDriKAPTtjbG4x9hBbnrwLmBWY=; b=UkJ8wRsP58TiKd
	yfMq2meNtkB2Grkn0BU73gvqT5eiF++YCTYQ4LmyVb+rUZ7KblxvXfCx68tjtbhaEj5emkWjQC64y
	pgBUpd8CPvBp9F5Uoz2xowJGajWF2wdTauo3qQNOrall5T5MONODKtCLeHPw/IyKLunHUGfisw5NE
	XxFompZdJoZxs8VG6BHcHM1GbjrjoxRaoop0OMcNf/ce2EqvMnqsitJB0Fg7PhSO7mM2jTGIflGMe
	qvgg0cYG1tfcfmhs8AfTm5xSdgRWPwj98oMrc1HD5SbVe6U9laOICkOqudRJ4EkO7i3b8jL96w/9O
	t+AGlVubFaQX4KUUysBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghs9F-0006Eu-Kh; Fri, 11 Jan 2019 08:26:37 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghs9C-0006D7-Mf
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:26:36 +0000
Received: by mail-lj1-x244.google.com with SMTP id x85-v6so12183135ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 00:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AwsmvV8ycm6znxw5ZJNOoNl68SECma4BhkTwPHxsR/A=;
 b=fJi2E28sVMxPUqbF31696jSJfwustejjJMXhW5UaaoOMnFa3N/vqqAha4Pcf4t9ups
 4HNtdd42mY6pVEp4zSpMZeL3qpranLH+AMAaww8Oy4o0FJNgIOjeJPjA9JWN63uH5GLi
 TWBPdJiLCpXW145HzrrnJnmE8owcTlQ6rOst4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AwsmvV8ycm6znxw5ZJNOoNl68SECma4BhkTwPHxsR/A=;
 b=dYy1J7kF6bkby8kgDCzonde5s+NoI66ss/PofqpSi7aKdy+pn4cESNrJ4/pyOgbiSw
 ZQTfM88AceAbWMi6u8l75ktsu5J+PLdXB8xfqSsa0AL20rZFpq8lUDTf5JUwUdaffcvj
 qi+bQQ9BGVGUmlSEcHvgJPq2Pvl4pTYlPmr+Jrer7cPEpZkCgkhh5+EZD8And7PgZXB1
 BacOzAcbyKI0yMumPIrs9SGVB3C9hlOVC04gw/4DJtHoRHrseFNWMKicpEHed1eumTfr
 yPIyJKGOgCbuYdzYAH+7demJAkPmSZIYDVxRpiswP9Vxp2OijmqDSKT/ZA1GqukIMGNp
 PCTw==
X-Gm-Message-State: AJcUukeHENYSn3O5ntlJvxC1LeDPaju+6H/77NDHioNgkAgSDFFmB6w2
 CFl7afKcHGA5GkY5n6pUwFObY2XdSw/7M/MEUdqGng==
X-Google-Smtp-Source: ALg8bN5pKfa+Cb+kHfeQPdOsJ9YxTP3DPlAdPPmshC/lq9q1h05LIWH3mEPo43yxtl1h1l25T3BjIwuhnirlpw9wmqg=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr7926191ljj.9.1547195192319; 
 Fri, 11 Jan 2019 00:26:32 -0800 (PST)
MIME-Version: 1.0
References: <1545146239-30993-1-git-send-email-aisheng.dong@nxp.com>
 <1545146239-30993-3-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545146239-30993-3-git-send-email-aisheng.dong@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 09:26:21 +0100
Message-ID: <CACRpkdaM1XhZ6Ff3qVKTPxG8E9+y0J2Wo2ms2dnnotGDvt+TkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: imx: add imx8qm driver
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_002634_751406_EE254F72 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 4:23 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:

> MX8QM contains a system controller that is responsible for controlling
> the pad setting of the IPs that are present. Communication between the
> host processor running an OS and the system controller happens through
> a SCU protocol. This patch adds the SCU based MX8QM pinctrl driver.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Somehow I managed to apply the DT bindings but not this driver.
I blame it on christmas stress. Patch applied now.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
