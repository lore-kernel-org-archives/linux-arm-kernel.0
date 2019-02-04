Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0D7C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FEF2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCKmSwL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FEF2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LveRjuC8+LOtbR0NJ5z0+JrAdaMP/AwqVOoHvyem/Vo=; b=hCKmSwL6OcOZZu
	OWztlBdH9GXHYLWB2NjVYeM9ojZ/U/J6P+3BQHyltTn2F9yV8udoWPMfr2xIWxHWW+CTpfaAfzWFs
	AV2g1UEXzauwAoFh1RXjQat/618GH1/c2ZiQboKk/a80G4Tc8acuWS4K9JZ2I0i/BVCDMH6JRDI1R
	xu8on93gCQX+WxXy+2D4+Uk7Iulhr+pPHFLkDyVxxro0ep4SHz/D62JGJDGVokzvWirxdgcvTyhVO
	Lt00uJoRQiVCSLG4vCZqtI3XMGpBGLh9Gw5j0V6eCQH4IBvQhyPZGKuVRKMgvldosvymCeWAm/Mv6
	7ioI4q2mYDSRfCdlcaPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gql0H-0001RE-LP; Mon, 04 Feb 2019 20:38:05 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gql05-0001HA-ER
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:37:55 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 248A18139;
 Mon,  4 Feb 2019 20:38:01 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Update for moved options
Date: Mon,  4 Feb 2019 12:37:47 -0800
Message-Id: <20190204203747.7376-2-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204203747.7376-1-tony@atomide.com>
References: <20190204203747.7376-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_123753_532177_4A60BB22 
X-CRM114-Status: UNSURE (   8.19  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Russell King <linux@armlinux.org.uk>, Olof Johansson <olof@lixom.net>,
 Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These options have just moved around, let's update with make
savedefconfig to make patching the file easier.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 116 ++++++++++++++--------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -5,10 +5,6 @@ CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_ARTPEC=y
@@ -48,8 +44,8 @@ CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
-CONFIG_SOC_IMX7D=y
 CONFIG_SOC_LS1021A=y
+CONFIG_SOC_IMX7D=y
 CONFIG_SOC_VF610=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MEDIATEK=y
@@ -74,23 +70,6 @@ CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_ARCH_EMEV2=y
-CONFIG_ARCH_R7S72100=y
-CONFIG_ARCH_R8A73A4=y
-CONFIG_ARCH_R8A7740=y
-CONFIG_ARCH_R8A7743=y
-CONFIG_ARCH_R8A7744=y
-CONFIG_ARCH_R8A7745=y
-CONFIG_ARCH_R8A77470=y
-CONFIG_ARCH_R8A7778=y
-CONFIG_ARCH_R8A7779=y
-CONFIG_ARCH_R8A7790=y
-CONFIG_ARCH_R8A7791=y
-CONFIG_ARCH_R8A7792=y
-CONFIG_ARCH_R8A7793=y
-CONFIG_ARCH_R8A7794=y
-CONFIG_ARCH_R9A06G032=y
-CONFIG_ARCH_SH73A0=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
@@ -106,16 +85,6 @@ CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_TC2_PM=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
-CONFIG_PCIEPORTBUS=y
-CONFIG_PCI_MVEBU=y
-CONFIG_PCI_TEGRA=y
-CONFIG_PCI_RCAR_GEN2=y
-CONFIG_PCIE_RCAR=y
-CONFIG_PCI_DRA7XX_EP=y
-CONFIG_PCI_KEYSTONE=y
-CONFIG_PCI_ENDPOINT=y
-CONFIG_PCI_ENDPOINT_CONFIGFS=y
-CONFIG_PCI_EPF_TEST=m
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_SECCOMP=y
@@ -138,6 +107,26 @@ CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
+CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_BCM47XX_NVRAM=y
+CONFIG_BCM47XX_SPROM=y
+CONFIG_EFI_VARS=m
+CONFIG_EFI_CAPSULE_LOADER=m
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM_NEON=m
+CONFIG_CRYPTO_SHA1_ARM_CE=m
+CONFIG_CRYPTO_SHA2_ARM_CE=m
+CONFIG_CRYPTO_SHA512_ARM=m
+CONFIG_CRYPTO_AES_ARM=m
+CONFIG_CRYPTO_AES_ARM_BS=m
+CONFIG_CRYPTO_AES_ARM_CE=m
+CONFIG_CRYPTO_GHASH_ARM_CE=m
+CONFIG_CRYPTO_CRC32_ARM_CE=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_PARTITION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -172,6 +161,16 @@ CONFIG_MAC80211=m
 CONFIG_RFKILL=y
 CONFIG_RFKILL_INPUT=y
 CONFIG_RFKILL_GPIO=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_MVEBU=y
+CONFIG_PCI_TEGRA=y
+CONFIG_PCI_RCAR_GEN2=y
+CONFIG_PCIE_RCAR=y
+CONFIG_PCI_DRA7XX_EP=y
+CONFIG_PCI_KEYSTONE=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_CMA_SIZE_MBYTES=64
@@ -497,8 +496,6 @@ CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=m
-CONFIG_CROS_EC_I2C=m
-CONFIG_CROS_EC_SPI=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
@@ -620,10 +617,12 @@ CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
-CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
-CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
+CONFIG_DRM_STM=m
+CONFIG_DRM_STM_DSI=m
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
+CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
+CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_DUMB_VGA_DAC=m
@@ -634,8 +633,6 @@ CONFIG_DRM_TOSHIBA_TC358764=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_STI=m
-CONFIG_DRM_STM=m
-CONFIG_DRM_STM_DSI=m
 CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_MXSFB=m
@@ -880,6 +877,8 @@ CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_STAGING_BOARD=y
+CONFIG_CROS_EC_I2C=m
+CONFIG_CROS_EC_SPI=m
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_S2MPS11=m
@@ -901,6 +900,23 @@ CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMD_RPM=m
 CONFIG_QCOM_WCNSS_CTRL=m
+CONFIG_ARCH_EMEV2=y
+CONFIG_ARCH_R7S72100=y
+CONFIG_ARCH_R8A73A4=y
+CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7743=y
+CONFIG_ARCH_R8A7744=y
+CONFIG_ARCH_R8A7745=y
+CONFIG_ARCH_R8A77470=y
+CONFIG_ARCH_R8A7778=y
+CONFIG_ARCH_R8A7779=y
+CONFIG_ARCH_R8A7790=y
+CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7792=y
+CONFIG_ARCH_R8A7793=y
+CONFIG_ARCH_R8A7794=y
+CONFIG_ARCH_R9A06G032=y
+CONFIG_ARCH_SH73A0=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
@@ -960,24 +976,19 @@ CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_ROCKCHIP_DP=m
 CONFIG_PHY_ROCKCHIP_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
+CONFIG_PHY_UNIPHIER_USB2=y
+CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_STIH407_USB=y
 CONFIG_PHY_STM32_USBPHYC=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_DM816X_USB=m
-CONFIG_PHY_UNIPHIER_USB3=y
-CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_TWL4030_USB=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
-CONFIG_RASPBERRYPI_FIRMWARE=y
-CONFIG_BCM47XX_NVRAM=y
-CONFIG_BCM47XX_SPROM=y
-CONFIG_EFI_VARS=m
-CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
@@ -999,8 +1010,6 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
@@ -1014,14 +1023,5 @@ CONFIG_CRYPTO_DEV_ATMEL_TDES=m
 CONFIG_CRYPTO_DEV_ATMEL_SHA=m
 CONFIG_CRYPTO_DEV_SUN4I_SS=m
 CONFIG_CRYPTO_DEV_ROCKCHIP=m
-CONFIG_ARM_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA1_ARM_CE=m
-CONFIG_CRYPTO_SHA2_ARM_CE=m
-CONFIG_CRYPTO_SHA512_ARM=m
-CONFIG_CRYPTO_AES_ARM=m
-CONFIG_CRYPTO_AES_ARM_BS=m
-CONFIG_CRYPTO_AES_ARM_CE=m
-CONFIG_CRYPTO_GHASH_ARM_CE=m
-CONFIG_CRYPTO_CRC32_ARM_CE=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
