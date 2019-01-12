Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:53:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF302177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="stlIktis";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDgTn0+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF302177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=11PN+tNKIYunCeGVR19hvacqJ0KLSOntS5TEM4oSQac=; b=stlIktis92J7tw
	4G1BAKcvLQVCBmgh0cDd3Sh7gCkhR8jF7ZNydBEswFPwZyxDoG1DqQiVUR1fBksmQRe455e/ilGBR
	h35C+P7JwHff974UwJ9523XntMglDL6DJqFe8CgMZ+vXmq9JBnu4CxBEV/rh/B/xC3sbjDDXtEVa8
	p9wJmTSjU2oHnuStxJDk/nrpubY/IYYWTn7mlvocFChtRKNlfH3JShQSosdsboC6acpTiSAngBy2U
	kHJSdHPEvztNsyFh9w7yx/ms3wuRrGXRaR8txo3RGYF38/k8AiEiSAWdzYw4VWdWOuIb9yiIK3kAw
	QaJV3lr14yUP27ah2hEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9QE-0006p8-5p; Sat, 12 Jan 2019 02:53:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9QB-0006on-Ku
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 02:53:17 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E83A206B6;
 Sat, 12 Jan 2019 02:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547261595;
 bh=NW1nFwlf5cEWjFT7euDmNHzj4da8spTS+1TSD0IL40g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lDgTn0+dbk8+kWpi3xPBW+i5U+Hq52qOcwQCwE2aXtqkYbetOh6whSwjoczxN+etl
 3w1QW4sZ9cAIOA58EqhKzCbGceKLaclpMVg+L7ffHUc3KxlBbN7Pl1mJl60BUhf5A0
 YVXd4oiY7xu4JyG7H1+fEQPMcJPUbAd13iyxBsBs=
Date: Sat, 12 Jan 2019 10:53:03 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 2/6] ARM i.MX21: Add devicetree support
Message-ID: <20190112025302.GQ32649@dragon>
References: <20181222105200.18502-1-shc_work@mail.ru>
 <20181222105200.18502-2-shc_work@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181222105200.18502-2-shc_work@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_185315_729767_FF2D5E4F 
X-CRM114-Status: GOOD (  17.16  )
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 22, 2018 at 01:51:56PM +0300, Alexander Shiyan wrote:
> This patch adds basic devicetree support for i.MX21 based SoCs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

What i.MX21 board are you running devicetree support on?

Shawn

> ---
>  arch/arm/mach-imx/Kconfig      |  7 +++++++
>  arch/arm/mach-imx/Makefile     |  1 +
>  arch/arm/mach-imx/mach-imx21.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>  create mode 100644 arch/arm/mach-imx/mach-imx21.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index abc3371..abf3c0d 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -91,6 +91,13 @@ config MACH_MX21ADS
>  	  Include support for MX21ADS platform. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_IMX21_DT
> +	bool "Support i.MX21 platforms from device tree"
> +	select SOC_IMX21
> +	help
> +	  Include support for Freescale i.MX21 based platforms
> +	  using the device tree for discovery
> +
>  comment "MX27 platforms:"
>  
>  config MACH_MX27ADS
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index bae179a..52a9138 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -38,6 +38,7 @@ endif
>  
>  # i.MX21 based machines
>  obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
> +obj-$(CONFIG_MACH_IMX21_DT) += mach-imx21.o
>  
>  # i.MX27 based machines
>  obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
> diff --git a/arch/arm/mach-imx/mach-imx21.c b/arch/arm/mach-imx/mach-imx21.c
> new file mode 100644
> index 0000000..7eb7de0
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-imx21.c
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Author: Alexander Shiyan <shc_work@mail.ru> */
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <linux/of_platform.h>
> +
> +#include "common.h"
> +#include "hardware.h"
> +
> +#define MX21_AVIC_ADDR	0x10040000
> +
> +static void __init imx21_init_irq(void)
> +{
> +	void __iomem *avic = ioremap(MX21_AVIC_ADDR, SZ_4K);
> +
> +	WARN_ON(!avic);
> +
> +	mxc_init_irq(avic);
> +}
> +
> +static const char * const imx21_dt_board_compat[] __initconst = {
> +	"fsl,imx21",
> +	NULL
> +};
> +
> +DT_MACHINE_START(IMX21_DT, "Freescale i.MX21 (Device Tree Support)")
> +	.init_early	= imx21_init_early,
> +	.init_irq	= imx21_init_irq,
> +	.dt_compat	= imx21_dt_board_compat,
> +MACHINE_END
> -- 
> 2.10.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
