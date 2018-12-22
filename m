Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:52:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FAC21A47
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LMDKPltR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="fyvgAU8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FAC21A47
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kLDG/v3KWdueD9zlSSo1qyRaFfVNiTw8y/zlIZeR08s=; b=LMDKPltRKJzZTE/qDuHdHgMrNT
	5iEw3s/cfqeVg7kM/meZF5AhmSyFNp3nA5jm2itFwhep+WPUYS/G6abjsI42CkSFZ0Z79BvmRmRJt
	KJE9fkhwDK7vZUjLIcXutdagyTi12aMBSQIOuF91NuV0QLhX7+87rgCnGP0ROsQ7oER5XWjgFnHZ7
	kA/BRjPXhBlSKzyYw2Dx3TcYqxGsioC5KGyAraLe+FF7qzjkr+6Auc8aqBxvXGY/X/Vt1cMAmQyGl
	6fvusQkHHx+UCZQtwFX8XoMiEMESxmLdeErukXKmPU8cnENGw0SeA4IGFxv3ZYKKaarONrkXk23FJ
	U10Ntkpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaetL-0000K7-M5; Sat, 22 Dec 2018 10:52:23 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaetH-0000I3-MT
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=yOd4V6Ky+WTar27J8gyU7oPyOioTRFoL5/H3Clc40ng=; 
 b=fyvgAU8WLO2x8p3vmufuHoOV2xanb47CIydOuJtLLsicHUYVa1GJ1VtvGhCZpkYtanVFvdC0j4u8x8f1iImW4jRysIhLq+KAV4jHD0i94FV0yGRphJ3lBTyi3Bh8Yt3k7fnUmcSILYEZzbWOuNVAcqhkMTZSuI1u61S8aB64A4E=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaet2-00014B-M3; Sat, 22 Dec 2018 13:52:04 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] ARM i.MX21: Add devicetree support
Date: Sat, 22 Dec 2018 13:51:56 +0300
Message-Id: <20181222105200.18502-2-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181222105200.18502-1-shc_work@mail.ru>
References: <20181222105200.18502-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 2D1AD755E866B1545A78504BD2AC29419868B496DAF47A9F3B447A53FA0F644D8C565DE45682A88A2E9950252A4F43CC
X-7FA49CB5: 0D63561A33F958A5407A2F134D130819857BED211D07E6A3E085472B1B9DF57E8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22498B372E35CF5A2D2DD32BA5DBAC0009BE395957E7521B51C24DA2F55E57A558BE49FD398EE364050FF8AB6B2BE221812676E601842F6C81A1F004C906525384306FED454B719173D6725E5C173C3A84C315AF0D0D4FC4FA3D20540AC68EC68E9F0B02670E5FEECA50C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D244531C2B742D01D006866E561C505FCFA42A987089A8C7460FA6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_025220_165690_D4CF6D4C 
X-CRM114-Status: GOOD (  13.18  )
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

This patch adds basic devicetree support for i.MX21 based SoCs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig      |  7 +++++++
 arch/arm/mach-imx/Makefile     |  1 +
 arch/arm/mach-imx/mach-imx21.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-imx21.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index abc3371..abf3c0d 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -91,6 +91,13 @@ config MACH_MX21ADS
 	  Include support for MX21ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_IMX21_DT
+	bool "Support i.MX21 platforms from device tree"
+	select SOC_IMX21
+	help
+	  Include support for Freescale i.MX21 based platforms
+	  using the device tree for discovery
+
 comment "MX27 platforms:"
 
 config MACH_MX27ADS
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bae179a..52a9138 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -38,6 +38,7 @@ endif
 
 # i.MX21 based machines
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
+obj-$(CONFIG_MACH_IMX21_DT) += mach-imx21.o
 
 # i.MX27 based machines
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
diff --git a/arch/arm/mach-imx/mach-imx21.c b/arch/arm/mach-imx/mach-imx21.c
new file mode 100644
index 0000000..7eb7de0
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx21.c
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Author: Alexander Shiyan <shc_work@mail.ru> */
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <linux/of_platform.h>
+
+#include "common.h"
+#include "hardware.h"
+
+#define MX21_AVIC_ADDR	0x10040000
+
+static void __init imx21_init_irq(void)
+{
+	void __iomem *avic = ioremap(MX21_AVIC_ADDR, SZ_4K);
+
+	WARN_ON(!avic);
+
+	mxc_init_irq(avic);
+}
+
+static const char * const imx21_dt_board_compat[] __initconst = {
+	"fsl,imx21",
+	NULL
+};
+
+DT_MACHINE_START(IMX21_DT, "Freescale i.MX21 (Device Tree Support)")
+	.init_early	= imx21_init_early,
+	.init_irq	= imx21_init_irq,
+	.dt_compat	= imx21_dt_board_compat,
+MACHINE_END
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
