Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0570C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:52:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCAF21A47
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MHryZEbH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="kXMJ6UuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCAF21A47
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0GUPDlLTeV9GfKkQwTER5JzM2yJXsmf04DAJb/np2n0=; b=MHryZEbHbPhxdXk3w+vUn74j6X
	IUgtsYr9oad1NGYQusQ/ShoNMRiFcqtKIwH5vPPKX8QvL/3uxqt9XEe8jOEQYsgj4QduUCDeBLvVg
	mrJjN4l+rFLPGwU1hN22hJ6pmjaezKacI7e3le89WBzfZu68dhaSJuPw9DUuYHJOgNXUUqzdHLyFG
	TMCWSsgWwL/dIm+EYnFhXMiHetRLG/NBQy0VjQFlcBJ2rszKVjzTUnLaGJTRsb+1VRtHUzUW1qAwN
	Gi72OpX04WvwrRgR9TfPoNUxEWv3d1rhnLlC0sGp03vD+SXbaGDvxdevjoQLG0ojUqgFxCKjT12DX
	9Mayty1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaetV-0000SA-2r; Sat, 22 Dec 2018 10:52:33 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaetH-0000I8-LA
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Qd56fnvUHhZI5ZOAejYW+VoaWF/JU6N1vGtpH09g+RI=; 
 b=kXMJ6UuDtEN/2ErgM4kmddvfjcJnX1CJoRKWFhvS+mq0OzCGtDt8zl4JAFHUjnxWuC7LAeioebewG+6AgVO2rAGkptVTeiewcb0Pu9h8UnV+9lxiJaEFDYh/UcPF/TzeEfCDTmcTt0lPCvBUix1FZmmysSIlynebm6mAphvRDuE=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaet4-00014B-0V; Sat, 22 Dec 2018 13:52:06 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] ARM: i.MX: Move SOC_IMX21 into 'Device tree only'
Date: Sat, 22 Dec 2018 13:51:59 +0300
Message-Id: <20181222105200.18502-5-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181222105200.18502-1-shc_work@mail.ru>
References: <20181222105200.18502-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC29419868B496DAF47A9F09D114F592D1A9C5FD37BF2438964BA1BD192FC3E792B9BD
X-7FA49CB5: 0D63561A33F958A53E4E60E76943A6D9857BED211D07E6A3E4437CF7B4A7BD2E8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22498B372E35CF5A2D2DD32BA5DBAC0009BE395957E7521B51C24DA2F55E57A558BE49FD398EE364050FF8AB6B2BE221812676E601842F6C81A1F004C906525384306FED454B719173D6725E5C173C3A84C315AF0D0D4FC4FA3D50B0466AFD115EEE262FEC7FBD7D1F5BB5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D244531C2B742D01D006866AE4AB0A2DC26A2B878F0385D4217396B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_025220_147961_7AF1ECD8 
X-CRM114-Status: GOOD (  13.39  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Russell King <linux@armlinux.org.uk>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch moves SOC_IMX21 into 'Device tree only' category and
updates imx_v4_v5 and multi_v5 default configs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/imx_v4_v5_defconfig |  2 +-
 arch/arm/configs/multi_v5_defconfig  | 22 +++++++++++-----------
 arch/arm/mach-imx/Kconfig            | 23 ++++++++---------------
 arch/arm/mach-imx/Makefile           |  5 +----
 arch/arm/mach-imx/common.h           |  1 -
 arch/arm/mach-imx/mach-imx21.c       |  5 +++++
 6 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 8661dd9..0ce6105 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -15,13 +15,13 @@ CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXC=y
-CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_MX27_3DS=y
 CONFIG_MACH_IMX27_VISSTRIM_M10=y
 CONFIG_MACH_PCA100=y
 CONFIG_MACH_IMX27_DT=y
 CONFIG_SOC_IMX1=y
+CONFIG_SOC_IMX21=y
 CONFIG_SOC_IMX25=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 318b76f..86b92dd 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -1,26 +1,23 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=19
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91SAM9=y
 CONFIG_ARCH_MXC=y
-CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_MX27_3DS=y
 CONFIG_MACH_IMX27_VISSTRIM_M10=y
 CONFIG_MACH_PCA100=y
 CONFIG_MACH_IMX27_DT=y
+CONFIG_SOC_IMX21=y
 CONFIG_SOC_IMX25=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
@@ -48,7 +45,6 @@ CONFIG_MACH_RD88F5181L_FXO=y
 CONFIG_MACH_RD88F6183AP_GE=y
 CONFIG_ARCH_U300=y
 CONFIG_PCI_MVEBU=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -60,6 +56,10 @@ CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_KIRKWOOD_CPUIDLE=y
+CONFIG_OPROFILE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -275,6 +275,11 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_DEV_MARVELL_CESA=y
+CONFIG_CRC_CCITT=y
+CONFIG_LIBCRC32C=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
@@ -283,8 +288,3 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_DEV_MARVELL_CESA=y
-CONFIG_CRC_CCITT=y
-CONFIG_LIBCRC32C=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7b49939..cd928d6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -52,12 +52,6 @@ config IMX_HAVE_IOMUX_V1
 config ARCH_MXC_IOMUX_V3
 	bool
 
-config SOC_IMX21
-	bool
-	select CPU_ARM926T
-	select IMX_HAVE_IOMUX_V1
-	select MXC_AVIC
-
 config SOC_IMX27
 	bool
 	select CPU_ARM926T
@@ -78,15 +72,6 @@ config SOC_IMX35
 
 if ARCH_MULTI_V5
 
-comment "MX21 platforms:"
-
-config MACH_IMX21_DT
-	bool "Support i.MX21 platforms from device tree"
-	select SOC_IMX21
-	help
-	  Include support for Freescale i.MX21 based platforms
-	  using the device tree for discovery
-
 comment "MX27 platforms:"
 
 config MACH_MX27ADS
@@ -421,6 +406,14 @@ endif
 
 if ARCH_MULTI_V5
 
+config SOC_IMX21
+	bool "i.MX21 support"
+	select CPU_ARM926T
+	select MXC_AVIC
+	select PINCTRL_IMX21
+	help
+	  This enables support for Freescale i.MX21 processor
+
 config SOC_IMX25
 	bool "i.MX25 support"
 	select ARCH_MXC_IOMUX_V3
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index a629af2..1d56728 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := cpu.o system.o irq-common.o
 
-obj-$(CONFIG_SOC_IMX21) += mm-imx21.o
+obj-$(CONFIG_SOC_IMX21) += mach-imx21.o
 
 obj-$(CONFIG_SOC_IMX25) += cpu-imx25.o mach-imx25.o pm-imx25.o
 
@@ -36,9 +36,6 @@ obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
 
-# i.MX21 based machines
-obj-$(CONFIG_MACH_IMX21_DT) += mach-imx21.o
-
 # i.MX27 based machines
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
 obj-$(CONFIG_MACH_MX27_3DS) += mach-mx27_3ds.o
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 423dd76..acfdb8b 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -25,7 +25,6 @@ void mx21_map_io(void);
 void mx27_map_io(void);
 void mx31_map_io(void);
 void mx35_map_io(void);
-void imx21_init_early(void);
 void imx27_init_early(void);
 void imx31_init_early(void);
 void imx35_init_early(void);
diff --git a/arch/arm/mach-imx/mach-imx21.c b/arch/arm/mach-imx/mach-imx21.c
index 7eb7de0..c841539 100644
--- a/arch/arm/mach-imx/mach-imx21.c
+++ b/arch/arm/mach-imx/mach-imx21.c
@@ -10,6 +10,11 @@
 
 #define MX21_AVIC_ADDR	0x10040000
 
+static void __init imx21_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX21);
+}
+
 static void __init imx21_init_irq(void)
 {
 	void __iomem *avic = ioremap(MX21_AVIC_ADDR, SZ_4K);
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
