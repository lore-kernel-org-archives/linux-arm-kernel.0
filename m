Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A2E2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cSyfFEdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A2E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cAPcaz86hpKIXwTJjPQYmUUYUVviTig4vBKxyMTg5MI=; b=cSyfFEdp5RGRFT
	IOU8CjgVIqfpU/1408Pa18CDGfDvoy8tkEUcOxhHX9ibrdaNZYwiSnL2+bCtdXb799Oeh8/7FFAS5
	aI3Gw1a/9qeT2p8tcHTDkusJTu9IReC/DSd22PhIQc+IdFlGEksyfvU4jfBhcwcV2egx3Lc4MXO86
	q9sGVphiRSDduQlks0rIWNGTpw2UQUagd/d6lOOaJHcdWGf0b8qoRlCqPyfNdxwEoda+CnSVCD8bl
	uqQYV2iodWuauOSb4PDnQD+heMq+r+MeU5rAt6NDT2TjrkacZWhrjlKXufBs4iBtzV1WNiyB0IIxo
	35wv2XWjxbnL1+hiEvEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkwK-0007Ja-JM; Mon, 04 Feb 2019 20:34:00 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkw8-00079i-MS
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:33:50 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 5ADED8139;
 Mon,  4 Feb 2019 20:33:57 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Update for moved options
Date: Mon,  4 Feb 2019 12:33:36 -0800
Message-Id: <20190204203336.7031-2-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204203336.7031-1-tony@atomide.com>
References: <20190204203336.7031-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_123348_767319_15FC5D1E 
X-CRM114-Status: UNSURE (   7.39  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These options have just moved around, let's update with make
savedefconfig to make patching the file easier.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 76 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -25,16 +25,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_POWER_AVS_OMAP=y
 CONFIG_POWER_AVS_OMAP_CLASS3=y
@@ -48,15 +38,8 @@ CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCI_DRA7XX_EP=y
-CONFIG_PCI_ENDPOINT=y
-CONFIG_PCI_ENDPOINT_CONFIGFS=y
-CONFIG_PCI_EPF_TEST=m
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -74,8 +57,27 @@ CONFIG_CPUFREQ_DT=m
 CONFIG_ARM_TI_CPUFREQ=y
 CONFIG_CPU_IDLE=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_BINFMT_MISC=y
 CONFIG_PM_DEBUG=y
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM_NEON=m
+CONFIG_CRYPTO_SHA256_ARM=m
+CONFIG_CRYPTO_SHA512_ARM=m
+CONFIG_CRYPTO_AES_ARM=m
+CONFIG_CRYPTO_AES_ARM_BS=m
+CONFIG_CRYPTO_GHASH_ARM_CE=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_OPROFILE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -118,6 +120,12 @@ CONFIG_AF_RXRPC=m
 CONFIG_RXKAD=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DRA7XX_EP=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
@@ -132,13 +140,13 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=m
+CONFIG_MTD_ONENAND=y
+CONFIG_MTD_ONENAND_VERIFY_WRITE=y
+CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
-CONFIG_MTD_ONENAND=y
-CONFIG_MTD_ONENAND_VERIFY_WRITE=y
-CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
@@ -380,10 +388,10 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_NOKIA_RX51=m
-CONFIG_SND_SOC_OMAP_HDMI=m
-CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_SOC_OMAP3_PANDORA=m
 CONFIG_SND_SOC_OMAP3_TWL4030=m
+CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
+CONFIG_SND_SOC_OMAP_HDMI=m
 CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SOC_TLV320AIC23_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
@@ -525,23 +533,8 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_INFO_SPLIT=y
-CONFIG_DEBUG_INFO_DWARF4=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_SCHEDSTATS=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
-CONFIG_ARM_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA256_ARM=m
-CONFIG_CRYPTO_SHA512_ARM=m
-CONFIG_CRYPTO_AES_ARM=m
-CONFIG_CRYPTO_AES_ARM_BS=m
-CONFIG_CRYPTO_GHASH_ARM_CE=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
@@ -550,3 +543,10 @@ CONFIG_LIBCRC32C=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_SPLIT=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SCHEDSTATS=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
