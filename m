Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB64C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306362085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jfi1UoAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306362085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FdToNqZTnIgKuZnhVVLMPVTocfjqh7fjLLrnJ/B1rIo=; b=jfi1UoAfQ+zcgx
	hVmoPPvd8rLcExW5JZ7ju5TY9BwRA7UfonrSuvQjGk1BKvNY37OUMYXtneYHdhH7+rRSUzJR2xnKH
	C/Xw8a0oQG4OzcHI/QpmYWzKUmccZmXZuu/I6dSy3qzdlm2zh4rF4TEUQ2csP8DV4fxo6GN27hffa
	zd6vYllYc4xxHeGoVuzcCCuLa7nXahlsR96Ga6Wli4wGP1Nq13cBT/WUGFHrGpvbrHIkGiCdGb6QY
	VbsHuxEbQN3bWInE8wZjjxmiDl9rcFr8e0xCs5ui3vvX3fC5MStyim3WOpep5qfMCK1fFwt4b5QzX
	WYBvRzIsodv6N1Xl5YYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glW4l-0001qv-Tr; Mon, 21 Jan 2019 09:41:03 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glW4i-0001qR-EJ
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:41:01 +0000
Received: from broadband.bt.com (unknown
 [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: martyn)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 05A25263BFA;
 Mon, 21 Jan 2019 09:40:56 +0000 (GMT)
Message-ID: <8746aab308f76b4d8f33a20fea3f54da323832b3.camel@collabora.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6: Add support for Phytec phyBOARD
 i.MX6UL Segin
From: Martyn Welch <martyn.welch@collabora.com>
To: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Jan 2019 09:40:54 +0000
In-Reply-To: <CAOMZO5ASTUDfKkghXq5FftM8-XNztXCYpmdOU9CVfyX3pgKxxA@mail.gmail.com>
References: <20190118194812.3319-1-martyn.welch@collabora.com>
 <20190118194812.3319-2-martyn.welch@collabora.com>
 <CAOMZO5ASTUDfKkghXq5FftM8-XNztXCYpmdOU9CVfyX3pgKxxA@mail.gmail.com>
Organization: Collabora Ltd.
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_014100_611685_7B286A9D 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Stefan =?ISO-8859-1?Q?Riedm=FCller?= <s.riedmueller@phytec.de>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Christian Hemp <c.hemp@phytec.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Fabio,

On Fri, 2019-01-18 at 19:18 -0200, Fabio Estevam wrote:
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-
> > full.dts b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> > new file mode 100644
> > index 000000000000..83cdf4fa10c0
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> > @@ -0,0 +1,96 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> > + * Author: Christian Hemp <c.hemp@phytec.de>
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx6ul-phytec-pcl063.dtsi"
> > +#include "imx6ul-phytec-phyboard-segin.dtsi"
> > +#include "imx6ul-phytec-peb-eval-01.dtsi"
> > +
> > +/ {
> > +       model = "Phytec phyBOARD-Segin i.MX6 UltraLite Full
> > Featured";
> > +       compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-
> > pcl063",
> > +                    "fsl,imx6ul";
> 
> Better keep it in a single line?
> 

It makes it longer than 80 chars, but I'm not adverse to that.

> > +&ecspi3 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_ecspi3>;
> > +       cs-gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> > +       status = "okay";
> > +
> > +       spidev@0 {
> > +               compatible = "spidev";
> 
> Doesn't the kernel complain about spidev dts nodes?
> 

Oh, yes, it does when spidev is loaded...

Removing.

Martyn


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
