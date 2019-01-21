Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4422FC2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:56:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94AC20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q/cePEHq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="R9f/MqSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94AC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YzM1FdvRtJX8xO0iPSMSH/Hs4InW6/8VLD9M7lCJY2k=; b=q/cePEHq8hoxfQ
	DEke/y2RyJo/FTNHAFsGe5VN2ANrQuy8sUsIEe+2nPvDyjk+ipZEWa0aqNZE11NoJd2B5ylBsb5l9
	oxqBpqfPUlUkypoC/MFmn47saRvusJP3X4j2JiuPLkman5lwDVLcdmCvE9NZooyMLS6sMoHJyqvwT
	960eJSb64UyTi3fY3DvgZEooeuEd33RUkgUt4uNVFHkYxlPKQinRtkYnjuh35YyIiaYlkGChF4Luu
	dvgSABI7/LCYsCbIcZ24l/+teIEuA8ee10zZGnqLh/IN8Amx2uIgaR8BSKWMKIg3QhfAvEb0HfckV
	015d4INARGE2D5svXmQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcrp-0007z0-Sq; Mon, 21 Jan 2019 16:56:09 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcrm-0007yJ-Kg
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:56:08 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 2915025B7CB;
 Tue, 22 Jan 2019 03:56:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548089762; bh=uo+Vdh0ANZeKi7twXO/rpTPTlDNZOJtB9fwSWSXiA8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R9f/MqSq+nBQzbbePSoNTgEpwz4FyNcWqrGMD4T667a3/qQWFn1Z7BuYqtjKLjGzV
 9wPDq6HlLWf8YU4dSWF/7J20wxEIkQhhIDz9uk4U6eXuyQW5bZKkNGIH+Bj1azGhPK
 RNmEA+JsY3ap5Y602YMBMhw1p5wu8oTIBQWLlBDY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 6E7B3940459; Mon, 21 Jan 2019 17:56:00 +0100 (CET)
Date: Mon, 21 Jan 2019 17:56:00 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] ARM: shmobile: defconfig: Refresh for v5.0-rc2
Message-ID: <20190121165600.2lavtrk2djj4adgb@verge.net.au>
References: <20190118155938.12124-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118155938.12124-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_085606_866384_3212CD0F 
X-CRM114-Status: GOOD (  16.56  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:59:38PM +0100, Geert Uytterhoeven wrote:
>   - Move SoC config options (moved in commit 062887bf5ef73313 ("ARM:
>     shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")),
>   - Move PCI config options (moved in commit eb01d42a77785ff9 ("PCI:
>     consolidate PCI config entry in drivers/pci")),
>   - Drop CONFIG_I2C_MUX=y (auto-enabled since commit ea6b13e9fed0fda9
>     ("drm/bridge/sii902x: Add missing dependency on I2C_MUX")),
>   - Drop CONFIG_SH_DMAE=y (no longer selectable since commit
>     a19788612f51b787 ("dmaengine: sh: Remove R-Mobile APE6 support")),
>   - Drop CONFIG_ARM_UNWIND (auto-enabled since commit f9b58e8c7d031b0d
>     ("ARM: 8800/1: use choice for kernel unwinders")).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Would this change be any different if it was a refresh for v5.0-rc1?

I ask because the ARM-SoC maintainers prefer the oldest possible of
the current rc series to be used as a base.

> ---
>  arch/arm/configs/shmobile_defconfig | 45 ++++++++++++++---------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index fdac4e4ca04d7380..14e9255e48c3184e 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -8,29 +8,8 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_PERF_EVENTS=y
>  CONFIG_SLAB=y
>  CONFIG_ARCH_RENESAS=y
> -CONFIG_ARCH_EMEV2=y
> -CONFIG_ARCH_R7S72100=y
> -CONFIG_ARCH_R8A73A4=y
> -CONFIG_ARCH_R8A7740=y
> -CONFIG_ARCH_R8A7743=y
> -CONFIG_ARCH_R8A7744=y
> -CONFIG_ARCH_R8A7745=y
> -CONFIG_ARCH_R8A77470=y
> -CONFIG_ARCH_R8A7778=y
> -CONFIG_ARCH_R8A7779=y
> -CONFIG_ARCH_R8A7790=y
> -CONFIG_ARCH_R8A7791=y
> -CONFIG_ARCH_R8A7792=y
> -CONFIG_ARCH_R8A7793=y
> -CONFIG_ARCH_R8A7794=y
> -CONFIG_ARCH_R9A06G032=y
> -CONFIG_ARCH_SH73A0=y
>  CONFIG_PL310_ERRATA_588369=y
>  CONFIG_ARM_ERRATA_754322=y
> -CONFIG_PCI=y
> -CONFIG_PCI_MSI=y
> -CONFIG_PCI_RCAR_GEN2=y
> -CONFIG_PCIE_RCAR=y
>  CONFIG_SMP=y
>  CONFIG_SCHED_MC=y
>  CONFIG_NR_CPUS=8
> @@ -58,6 +37,10 @@ CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
>  CONFIG_CAN=y
>  CONFIG_CAN_RCAR=y
> +CONFIG_PCI=y
> +CONFIG_PCI_MSI=y
> +CONFIG_PCI_RCAR_GEN2=y
> +CONFIG_PCIE_RCAR=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_DMA_CMA=y
> @@ -91,7 +74,6 @@ CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_8250_EM=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_I2C_CHARDEV=y
> -CONFIG_I2C_MUX=y
>  CONFIG_I2C_DEMUX_PINCTRL=y
>  CONFIG_I2C_EMEV2=y
>  CONFIG_I2C_GPIO=y
> @@ -183,12 +165,28 @@ CONFIG_RTC_DRV_S35390A=y
>  CONFIG_RTC_DRV_RX8581=y
>  CONFIG_RTC_DRV_DA9063=y
>  CONFIG_DMADEVICES=y
> -CONFIG_SH_DMAE=y
>  CONFIG_RCAR_DMAC=y
>  CONFIG_RENESAS_USB_DMAC=y
>  CONFIG_STAGING=y
>  CONFIG_STAGING_BOARD=y
>  # CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_ARCH_EMEV2=y
> +CONFIG_ARCH_R7S72100=y
> +CONFIG_ARCH_R8A73A4=y
> +CONFIG_ARCH_R8A7740=y
> +CONFIG_ARCH_R8A7743=y
> +CONFIG_ARCH_R8A7744=y
> +CONFIG_ARCH_R8A7745=y
> +CONFIG_ARCH_R8A77470=y
> +CONFIG_ARCH_R8A7778=y
> +CONFIG_ARCH_R8A7779=y
> +CONFIG_ARCH_R8A7790=y
> +CONFIG_ARCH_R8A7791=y
> +CONFIG_ARCH_R8A7792=y
> +CONFIG_ARCH_R8A7793=y
> +CONFIG_ARCH_R8A7794=y
> +CONFIG_ARCH_R9A06G032=y
> +CONFIG_ARCH_SH73A0=y
>  CONFIG_IIO=y
>  CONFIG_AK8975=y
>  CONFIG_PWM=y
> @@ -212,4 +210,3 @@ CONFIG_NLS_ISO8859_1=y
>  CONFIG_PRINTK_TIME=y
>  # CONFIG_ENABLE_MUST_CHECK is not set
>  CONFIG_DEBUG_KERNEL=y
> -# CONFIG_ARM_UNWIND is not set
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
