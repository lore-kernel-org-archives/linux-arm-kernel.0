Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD91C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:55:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898222086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rjn+dH2M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDK7akgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898222086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uZpBas8xgTMjpBerDscIeQpN2i9C/VLlAQhxFiKzvWo=; b=Rjn+dH2MCLmhnu
	lyb8IRFOv5XSfa4ZQHO4RU9b/VmLcvba29RSjkL3dcXnaISQ3f2/t0jDIn8VXhXyrI0SIKlLZy00P
	3BCHAzvpnoyyAftS8AxNXsOeYjp2X/itN5v/Q+Dkqw+C4IWpzuueb//FappOAximpSoOPhzzqEezi
	Ch0rxItlGB7whuEHLetNqAc0Tky+x2G6LFmGWJKe+Ez0xzzBgpVguJHW+c2x2OXa6vLucBteSpS5i
	EfGcxejbSOPNO4y1YJRgo3v0vl6oevgyt6PE6ZMAUT8CffHgIPfNJIIdreif5PacOxazxZVhPjjQ/
	9cvZBl1ROrxvbQnzYTwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSaE-0005Fh-M8; Mon, 10 Dec 2018 20:55:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSaB-0004Ub-H6
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:55:16 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 238702082F;
 Mon, 10 Dec 2018 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544475305;
 bh=GbowKODnpFqwR4aPYcQkndvPuXB0oIO8rYxtHkaFx0k=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=uDK7akgzhMC9ItQKdEDTY/kPdmNTbW04oTOSdUopFi/E0V2omcFPDkwJPbSMJlMLW
 Ryp8h4hxF5uU7ZtZ3Z5HmBBrWR5LJkBIkL1lUqHu0KaBtGNAfUARAYN1hzCFFyqUAK
 heL5zTRv2gpeJW/EM8wCob71jnuCu0YYZ+YQ/uFM=
MIME-Version: 1.0
In-Reply-To: <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
Subject: Re: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
Date: Mon, 10 Dec 2018 12:55:04 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_125515_584926_D69111B5 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-12-04 06:39:22)
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c12a05c..303082c 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -570,6 +580,7 @@ config SOC_IMX7ULP
>  config SOC_VF610
>         bool "Vybrid Family VF610 support"
>         select ARM_GIC if ARCH_MULTI_V7
> +       select MXC_CLK
>         select PINCTRL_VF610
>  

Instead of select can we break this dependency on the arch Kconfig and
have:

	config MXC_CLK
		def_bool ARCH_MXC && !ARM64

> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 5c0b11e..f850424 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-y += \
> +obj-$(CONFIG_MXC_CLK) += \

Because this changes to obj-$(CONFIG) we should change the
drivers/clk/Makefile to have obj-y for this Makefile instead of
depending on ARCH_MXC.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
