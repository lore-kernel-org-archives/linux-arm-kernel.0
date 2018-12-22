Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:53:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3A521A48
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G0IOZ7fh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="L1cg7HV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3A521A48
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8o7PFfl44gx9gQtWr3y2Ivne0ij0bhHILwDue9Bf9HI=; b=G0IOZ7fh2e2y4062h/F5JuSMK1
	yOfDgnvmrtf8ohfiugQv/A/SXQZPdkiN05GPNlhJl2EtOhgLrgkIeXoYRPd8JAA3SOBXP27nFumMz
	OdO2fsDZPp+3sy7zZ6TUNTNgwElKkqZzc7oxPGCkG2L7TxFZDRQ1WEnN6Nk2Ecvpf5tHosGFpUCBo
	8WUYS1lNtat6gaytcnqJFO6H97PQ69tW9uUd/LbOalYCB84wfctZgv+DuUQy4L3SIboGpd+APW6iw
	/u5+u/SFoCTUpXEYjghGMFy7C3d2w37bjds2xQhH1N+7Lk8QAMEIVLW9GzE8m6H/zlaUm7/85Y6lh
	+7qklxAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaeu7-0000y6-SE; Sat, 22 Dec 2018 10:53:11 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaetH-0000IB-MA
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=f1b/l5g3YWe/iiMBWJyDiKFTemL0dLG2Ilu4mAl8AgM=; 
 b=L1cg7HV8SRVTgwpdAV5i25iRY+LkvQXaZSyqYNPoOh3zQVJwyVVaLyFL69kOILBZbceP+SwEANmq5X4X9gz1Ykqb95wMfIWfx3aK8u49paS77u3Y/JK5ZfcsEfMw1qHdt88nuVmsSD20gd7D2G9GK2OB5PI3XJZX/96vLHugpJU=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaet4-00014B-VI; Sat, 22 Dec 2018 13:52:07 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] ARM: i.MX: Remove i.MX21 non-DT device registration
 helpers
Date: Sat, 22 Dec 2018 13:52:00 +0300
Message-Id: <20181222105200.18502-6-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181222105200.18502-1-shc_work@mail.ru>
References: <20181222105200.18502-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: E14BCC6235C710295A78504BD2AC29419868B496DAF47A9F09D114F592D1A9C5231ACB26E422A9DBDAD8DC27BA19C9D8
X-7FA49CB5: 0D63561A33F958A53E4E60E76943A6D9857BED211D07E6A33E8D9A04F4F12CFC8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22498B372E35CF5A2D2DD32BA5DBAC0009BE395957E7521B51C24DA2F55E57A558BE49FD398EE364050FF8AB6B2BE221812676E601842F6C81A1F004C906525384306FED454B719173D6725E5C173C3A84C315AF0D0D4FC4FA3DC4C51A8E3C61424A80CB4917E5AABA03C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D244531C2B742D01D006866AE4AB0A2DC26A2EDE9243E402DDED76B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_025220_182486_D8501D24 
X-CRM114-Status: GOOD (  13.11  )
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

i.MX21 is DT only platforms, so these non-DT device registration helpers
and functions is used nowhere.  Remove them.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/common.h                      |   5 -
 arch/arm/mach-imx/devices-imx21.h               |  59 --------
 arch/arm/mach-imx/devices/Kconfig               |   3 -
 arch/arm/mach-imx/devices/Makefile              |   1 -
 arch/arm/mach-imx/devices/devices-common.h      |   9 --
 arch/arm/mach-imx/devices/platform-imx-fb.c     |   5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c    |   5 -
 arch/arm/mach-imx/devices/platform-imx-keypad.c |   5 -
 arch/arm/mach-imx/devices/platform-imx-ssi.c    |   9 --
 arch/arm/mach-imx/devices/platform-imx-uart.c   |  11 --
 arch/arm/mach-imx/devices/platform-imx2-wdt.c   |   5 -
 arch/arm/mach-imx/devices/platform-imx21-hcd.c  |  41 -----
 arch/arm/mach-imx/devices/platform-mxc-mmc.c    |   9 --
 arch/arm/mach-imx/devices/platform-mxc_nand.c   |   5 -
 arch/arm/mach-imx/devices/platform-mxc_w1.c     |   5 -
 arch/arm/mach-imx/devices/platform-spi_imx.c    |   9 --
 arch/arm/mach-imx/hardware.h                    |   1 -
 arch/arm/mach-imx/iomux-mx21.h                  | 122 ---------------
 arch/arm/mach-imx/mm-imx21.c                    |  99 -------------
 arch/arm/mach-imx/mx21.h                        | 189 ------------------------
 arch/arm/mach-imx/system.c                      |   8 -
 21 files changed, 605 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices-imx21.h
 delete mode 100644 arch/arm/mach-imx/devices/platform-imx21-hcd.c
 delete mode 100644 arch/arm/mach-imx/iomux-mx21.h
 delete mode 100644 arch/arm/mach-imx/mm-imx21.c
 delete mode 100644 arch/arm/mach-imx/mx21.h

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index acfdb8b..b342bca 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -21,7 +21,6 @@ struct device_node;
 enum mxc_cpu_pwr_mode;
 struct of_device_id;
 
-void mx21_map_io(void);
 void mx27_map_io(void);
 void mx31_map_io(void);
 void mx35_map_io(void);
@@ -29,15 +28,12 @@ void imx27_init_early(void);
 void imx31_init_early(void);
 void imx35_init_early(void);
 void mxc_init_irq(void __iomem *);
-void mx21_init_irq(void);
 void mx27_init_irq(void);
 void mx31_init_irq(void);
 void mx35_init_irq(void);
-void imx21_soc_init(void);
 void imx27_soc_init(void);
 void imx31_soc_init(void);
 void imx35_soc_init(void);
-int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
 int mx31_clocks_init(unsigned long fref);
 int mx35_clocks_init(void);
@@ -46,7 +42,6 @@ struct platform_device *mxc_register_gpio(char *name, int id,
 void mxc_set_cpu_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
-void imx1_reset_init(void __iomem *);
 void imx_set_aips(void __iomem *);
 void imx_aips_allow_unprivileged_access(const char *compat);
 int mxc_device_init(void);
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
deleted file mode 100644
index bd93932..0000000
--- a/arch/arm/mach-imx/devices-imx21.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (C) 2010 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-#include "devices/devices-common.h"
-
-extern const struct imx_imx21_hcd_data imx21_imx21_hcd_data;
-#define imx21_add_imx21_hcd(pdata)	\
-	imx_add_imx21_hcd(&imx21_imx21_hcd_data, pdata)
-
-extern const struct imx_imx2_wdt_data imx21_imx2_wdt_data;
-#define imx21_add_imx2_wdt()	\
-	imx_add_imx2_wdt(&imx21_imx2_wdt_data)
-
-extern const struct imx_imx_fb_data imx21_imx_fb_data;
-#define imx21_add_imx_fb(pdata)	\
-	imx_add_imx_fb(&imx21_imx_fb_data, pdata)
-
-extern const struct imx_imx_i2c_data imx21_imx_i2c_data;
-#define imx21_add_imx_i2c(pdata)	\
-	imx_add_imx_i2c(&imx21_imx_i2c_data, pdata)
-
-extern const struct imx_imx_keypad_data imx21_imx_keypad_data;
-#define imx21_add_imx_keypad(pdata)	\
-	imx_add_imx_keypad(&imx21_imx_keypad_data, pdata)
-
-extern const struct imx_imx_ssi_data imx21_imx_ssi_data[];
-#define imx21_add_imx_ssi(id, pdata)	\
-	imx_add_imx_ssi(&imx21_imx_ssi_data[id], pdata)
-
-extern const struct imx_imx_uart_1irq_data imx21_imx_uart_data[];
-#define imx21_add_imx_uart(id, pdata)	\
-	imx_add_imx_uart_1irq(&imx21_imx_uart_data[id], pdata)
-#define imx21_add_imx_uart0(pdata)	imx21_add_imx_uart(0, pdata)
-#define imx21_add_imx_uart1(pdata)	imx21_add_imx_uart(1, pdata)
-#define imx21_add_imx_uart2(pdata)	imx21_add_imx_uart(2, pdata)
-#define imx21_add_imx_uart3(pdata)	imx21_add_imx_uart(3, pdata)
-
-extern const struct imx_mxc_mmc_data imx21_mxc_mmc_data[];
-#define imx21_add_mxc_mmc(id, pdata)	\
-	imx_add_mxc_mmc(&imx21_mxc_mmc_data[id], pdata)
-
-extern const struct imx_mxc_nand_data imx21_mxc_nand_data;
-#define imx21_add_mxc_nand(pdata)	\
-	imx_add_mxc_nand(&imx21_mxc_nand_data, pdata)
-
-extern const struct imx_mxc_w1_data imx21_mxc_w1_data;
-#define imx21_add_mxc_w1()	\
-	imx_add_mxc_w1(&imx21_mxc_w1_data)
-
-extern const struct imx_spi_imx_data imx21_cspi_data[];
-#define imx21_add_cspi(id, pdata)	\
-	imx_add_spi_imx(&imx21_cspi_data[id], pdata)
-#define imx21_add_spi_imx0(pdata)	imx21_add_cspi(0, pdata)
-#define imx21_add_spi_imx1(pdata)	imx21_add_cspi(1, pdata)
diff --git a/arch/arm/mach-imx/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
index 6ffe572..fa23275 100644
--- a/arch/arm/mach-imx/devices/Kconfig
+++ b/arch/arm/mach-imx/devices/Kconfig
@@ -11,9 +11,6 @@ config IMX_HAVE_PLATFORM_FSL_USB2_UDC
 config IMX_HAVE_PLATFORM_GPIO_KEYS
 	bool
 
-config IMX_HAVE_PLATFORM_IMX21_HCD
-	bool
-
 config IMX_HAVE_PLATFORM_IMX27_CODA
 	bool
 	default y if SOC_IMX27
diff --git a/arch/arm/mach-imx/devices/Makefile b/arch/arm/mach-imx/devices/Makefile
index e44758a..c365eb9 100644
--- a/arch/arm/mach-imx/devices/Makefile
+++ b/arch/arm/mach-imx/devices/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
 obj-y += platform-gpio-mxc.o
-obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX27_CODA) += platform-imx27-coda.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-y += platform-imx-dma.o
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 6920e35..169b584 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -73,15 +73,6 @@ struct platform_device *__init imx_add_fsl_usb2_udc(
 struct platform_device *__init imx_add_gpio_keys(
 		const struct gpio_keys_platform_data *pdata);
 
-#include <linux/platform_data/usb-mx2.h>
-struct imx_imx21_hcd_data {
-	resource_size_t iobase;
-	resource_size_t irq;
-};
-struct platform_device *__init imx_add_imx21_hcd(
-		const struct imx_imx21_hcd_data *data,
-		const struct mx21_usbh_platform_data *pdata);
-
 struct imx_imx27_coda_data {
 	resource_size_t iobase;
 	resource_size_t iosize;
diff --git a/arch/arm/mach-imx/devices/platform-imx-fb.c b/arch/arm/mach-imx/devices/platform-imx-fb.c
index aa00272..4372862 100644
--- a/arch/arm/mach-imx/devices/platform-imx-fb.c
+++ b/arch/arm/mach-imx/devices/platform-imx-fb.c
@@ -19,11 +19,6 @@
 		.irq = soc ## _INT_LCDC,				\
 	}
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_imx_fb_data imx21_imx_fb_data __initconst =
-	imx_imx_fb_data_entry_single(MX21, "imx21-fb", SZ_4K);
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_fb_data imx27_imx_fb_data __initconst =
 	imx_imx_fb_data_entry_single(MX27, "imx21-fb", SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-imx-i2c.c b/arch/arm/mach-imx/devices/platform-imx-i2c.c
index 9822bed..2d0ebe1 100644
--- a/arch/arm/mach-imx/devices/platform-imx-i2c.c
+++ b/arch/arm/mach-imx/devices/platform-imx-i2c.c
@@ -21,11 +21,6 @@
 #define imx_imx_i2c_data_entry(soc, _devid, _id, _hwid, _size)		\
 	[_id] = imx_imx_i2c_data_entry_single(soc, _devid, _id, _hwid, _size)
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst =
-	imx_imx_i2c_data_entry_single(MX21, "imx21-i2c", 0, , SZ_4K);
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst = {
 #define imx27_imx_i2c_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-imx-keypad.c b/arch/arm/mach-imx/devices/platform-imx-keypad.c
index 479e4d7..74caf1f 100644
--- a/arch/arm/mach-imx/devices/platform-imx-keypad.c
+++ b/arch/arm/mach-imx/devices/platform-imx-keypad.c
@@ -16,11 +16,6 @@
 		.irq = soc ## _INT_KPP,					\
 	}
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_imx_keypad_data imx21_imx_keypad_data __initconst =
-	imx_imx_keypad_data_entry_single(MX21, SZ_16);
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX27, SZ_16);
diff --git a/arch/arm/mach-imx/devices/platform-imx-ssi.c b/arch/arm/mach-imx/devices/platform-imx-ssi.c
index 6f0e94e..24a44ea 100644
--- a/arch/arm/mach-imx/devices/platform-imx-ssi.c
+++ b/arch/arm/mach-imx/devices/platform-imx-ssi.c
@@ -21,15 +21,6 @@
 		.dmarx1 = soc ## _DMA_REQ_SSI ## _hwid ## _RX1,		\
 	}
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst = {
-#define imx21_imx_ssi_data_entry(_id, _hwid)				\
-	imx_imx_ssi_data_entry(MX21, _id, _hwid, SZ_4K)
-	imx21_imx_ssi_data_entry(0, 1),
-	imx21_imx_ssi_data_entry(1, 2),
-};
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst = {
 #define imx27_imx_ssi_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-imx-uart.c b/arch/arm/mach-imx/devices/platform-imx-uart.c
index e3c89e9..25aa6c4 100644
--- a/arch/arm/mach-imx/devices/platform-imx-uart.c
+++ b/arch/arm/mach-imx/devices/platform-imx-uart.c
@@ -27,17 +27,6 @@
 		.irq = soc ## _INT_UART ## _hwid,			\
 	}
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst = {
-#define imx21_imx_uart_data_entry(_id, _hwid)				\
-	imx_imx_uart_1irq_data_entry(MX21, _id, _hwid, SZ_4K)
-	imx21_imx_uart_data_entry(0, 1),
-	imx21_imx_uart_data_entry(1, 2),
-	imx21_imx_uart_data_entry(2, 3),
-	imx21_imx_uart_data_entry(3, 4),
-};
-#endif
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst = {
 #define imx27_imx_uart_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-imx2-wdt.c b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
index 8c134c8..1f8ce02 100644
--- a/arch/arm/mach-imx/devices/platform-imx2-wdt.c
+++ b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
@@ -20,11 +20,6 @@
 #define imx_imx2_wdt_data_entry(soc, _id, _hwid, _size)			\
 	[_id] = imx_imx2_wdt_data_entry_single(soc, _id, _hwid, _size)
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX21, 0, , SZ_4K);
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
 	imx_imx2_wdt_data_entry_single(MX27, 0, , SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-imx21-hcd.c b/arch/arm/mach-imx/devices/platform-imx21-hcd.c
deleted file mode 100644
index 30c8161..0000000
--- a/arch/arm/mach-imx/devices/platform-imx21-hcd.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright (C) 2010 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-#include "../hardware.h"
-#include "devices-common.h"
-
-#define imx_imx21_hcd_data_entry_single(soc)				\
-	{								\
-		.iobase = soc ## _USBOTG_BASE_ADDR,			\
-		.irq = soc ## _INT_USBHOST,				\
-	}
-
-#ifdef CONFIG_SOC_IMX21
-const struct imx_imx21_hcd_data imx21_imx21_hcd_data __initconst =
-	imx_imx21_hcd_data_entry_single(MX21);
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
-struct platform_device *__init imx_add_imx21_hcd(
-		const struct imx_imx21_hcd_data *data,
-		const struct mx21_usbh_platform_data *pdata)
-{
-	struct resource res[] = {
-		{
-			.start = data->iobase,
-			.end = data->iobase + SZ_8K - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = data->irq,
-			.end = data->irq,
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-	return imx_add_platform_device_dmamask("imx21-hcd", 0,
-			res, ARRAY_SIZE(res),
-			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
-}
diff --git a/arch/arm/mach-imx/devices/platform-mxc-mmc.c b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
index b8203c7..c4ef45f 100644
--- a/arch/arm/mach-imx/devices/platform-mxc-mmc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
@@ -23,15 +23,6 @@
 #define imx_mxc_mmc_data_entry(soc, _devid, _id, _hwid, _size)		\
 	[_id] = imx_mxc_mmc_data_entry_single(soc, _devid, _id, _hwid, _size)
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst = {
-#define imx21_mxc_mmc_data_entry(_id, _hwid)				\
-	imx_mxc_mmc_data_entry(MX21, "imx21-mmc", _id, _hwid, SZ_4K)
-	imx21_mxc_mmc_data_entry(0, 1),
-	imx21_mxc_mmc_data_entry(1, 2),
-};
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst = {
 #define imx27_mxc_mmc_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-mxc_nand.c b/arch/arm/mach-imx/devices/platform-mxc_nand.c
index 676df49..c628927 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_nand.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_nand.c
@@ -29,11 +29,6 @@
 		.irq = soc ## _INT_NFC					\
 	}
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst =
-	imx_mxc_nand_data_entry_single(MX21, "imx21-nand", SZ_4K);
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX27, "imx27-nand", SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-mxc_w1.c b/arch/arm/mach-imx/devices/platform-mxc_w1.c
index 88c18b7..fefe006 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_w1.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_w1.c
@@ -14,11 +14,6 @@
 		.iobase = soc ## _OWIRE_BASE_ADDR,			\
 	}
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_mxc_w1_data imx21_mxc_w1_data __initconst =
-	imx_mxc_w1_data_entry_single(MX21);
-#endif /* ifdef CONFIG_SOC_IMX21 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_w1_data imx27_mxc_w1_data __initconst =
 	imx_mxc_w1_data_entry_single(MX27);
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index d93c446..21de5bb 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -21,15 +21,6 @@
 #define imx_spi_imx_data_entry(soc, type, devid, id, hwid, size)	\
 	[id] = imx_spi_imx_data_entry_single(soc, type, devid, id, hwid, size)
 
-#ifdef CONFIG_SOC_IMX21
-const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
-#define imx21_cspi_data_entry(_id, _hwid)                            \
-	imx_spi_imx_data_entry(MX21, CSPI, "imx21-cspi", _id, _hwid, SZ_4K)
-	imx21_cspi_data_entry(0, 1),
-	imx21_cspi_data_entry(1, 2),
-};
-#endif
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_spi_imx_data imx27_cspi_data[] __initconst = {
 #define imx27_cspi_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 90e10cb..8fcb633 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -110,7 +110,6 @@
 #include "mx31.h"
 #include "mx35.h"
 #include "mx2x.h"
-#include "mx21.h"
 #include "mx27.h"
 
 #define imx_map_entry(soc, name, _type)	{				\
diff --git a/arch/arm/mach-imx/iomux-mx21.h b/arch/arm/mach-imx/iomux-mx21.h
deleted file mode 100644
index a70cffc..0000000
--- a/arch/arm/mach-imx/iomux-mx21.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * Copyright (C) 2009 by Holger Schurig <hs4233@mail.mn-solutions.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-#ifndef __MACH_IOMUX_MX21_H__
-#define __MACH_IOMUX_MX21_H__
-
-#include "iomux-mx2x.h"
-#include "iomux-v1.h"
-
-/* Primary GPIO pin functions */
-
-#define PB22_PF_USBH1_BYP	(GPIO_PORTB | GPIO_PF | 22)
-#define PB25_PF_USBH1_ON	(GPIO_PORTB | GPIO_PF | 25)
-#define PC5_PF_USBOTG_SDA	(GPIO_PORTC | GPIO_PF | 5)
-#define PC6_PF_USBOTG_SCL	(GPIO_PORTC | GPIO_PF | 6)
-#define PC7_PF_USBOTG_ON	(GPIO_PORTC | GPIO_PF | 7)
-#define PC8_PF_USBOTG_FS	(GPIO_PORTC | GPIO_PF | 8)
-#define PC9_PF_USBOTG_OE	(GPIO_PORTC | GPIO_PF | 9)
-#define PC10_PF_USBOTG_TXDM	(GPIO_PORTC | GPIO_PF | 10)
-#define PC11_PF_USBOTG_TXDP	(GPIO_PORTC | GPIO_PF | 11)
-#define PC12_PF_USBOTG_RXDM	(GPIO_PORTC | GPIO_PF | 12)
-#define PC13_PF_USBOTG_RXDP	(GPIO_PORTC | GPIO_PF | 13)
-#define PC16_PF_SAP_FS		(GPIO_PORTC | GPIO_PF | 16)
-#define PC17_PF_SAP_RXD		(GPIO_PORTC | GPIO_PF | 17)
-#define PC18_PF_SAP_TXD		(GPIO_PORTC | GPIO_PF | 18)
-#define PC19_PF_SAP_CLK		(GPIO_PORTC | GPIO_PF | 19)
-#define PE0_PF_TEST_WB2		(GPIO_PORTE | GPIO_PF | 0)
-#define PE1_PF_TEST_WB1		(GPIO_PORTE | GPIO_PF | 1)
-#define PE2_PF_TEST_WB0		(GPIO_PORTE | GPIO_PF | 2)
-#define PF1_PF_NFCE		(GPIO_PORTF | GPIO_PF | 1)
-#define PF3_PF_NFCLE		(GPIO_PORTF | GPIO_PF | 3)
-#define PF7_PF_NFIO0		(GPIO_PORTF | GPIO_PF | 7)
-#define PF8_PF_NFIO1		(GPIO_PORTF | GPIO_PF | 8)
-#define PF9_PF_NFIO2		(GPIO_PORTF | GPIO_PF | 9)
-#define PF10_PF_NFIO3		(GPIO_PORTF | GPIO_PF | 10)
-#define PF11_PF_NFIO4		(GPIO_PORTF | GPIO_PF | 11)
-#define PF12_PF_NFIO5		(GPIO_PORTF | GPIO_PF | 12)
-#define PF13_PF_NFIO6		(GPIO_PORTF | GPIO_PF | 13)
-#define PF14_PF_NFIO7		(GPIO_PORTF | GPIO_PF | 14)
-#define PF16_PF_RES		(GPIO_PORTF | GPIO_PF | 16)
-
-/* Alternate GPIO pin functions */
-
-#define PA5_AF_BMI_CLK_CS	(GPIO_PORTA | GPIO_AF | 5)
-#define PA6_AF_BMI_D0		(GPIO_PORTA | GPIO_AF | 6)
-#define PA7_AF_BMI_D1		(GPIO_PORTA | GPIO_AF | 7)
-#define PA8_AF_BMI_D2		(GPIO_PORTA | GPIO_AF | 8)
-#define PA9_AF_BMI_D3		(GPIO_PORTA | GPIO_AF | 9)
-#define PA10_AF_BMI_D4		(GPIO_PORTA | GPIO_AF | 10)
-#define PA11_AF_BMI_D5		(GPIO_PORTA | GPIO_AF | 11)
-#define PA12_AF_BMI_D6		(GPIO_PORTA | GPIO_AF | 12)
-#define PA13_AF_BMI_D7		(GPIO_PORTA | GPIO_AF | 13)
-#define PA14_AF_BMI_D8		(GPIO_PORTA | GPIO_AF | 14)
-#define PA15_AF_BMI_D9		(GPIO_PORTA | GPIO_AF | 15)
-#define PA16_AF_BMI_D10		(GPIO_PORTA | GPIO_AF | 16)
-#define PA17_AF_BMI_D11		(GPIO_PORTA | GPIO_AF | 17)
-#define PA18_AF_BMI_D12		(GPIO_PORTA | GPIO_AF | 18)
-#define PA19_AF_BMI_D13		(GPIO_PORTA | GPIO_AF | 19)
-#define PA20_AF_BMI_D14		(GPIO_PORTA | GPIO_AF | 20)
-#define PA21_AF_BMI_D15		(GPIO_PORTA | GPIO_AF | 21)
-#define PA22_AF_BMI_READ_REQ	(GPIO_PORTA | GPIO_AF | 22)
-#define PA23_AF_BMI_WRITE	(GPIO_PORTA | GPIO_AF | 23)
-#define PA29_AF_BMI_RX_FULL	(GPIO_PORTA | GPIO_AF | 29)
-#define PA30_AF_BMI_READ	(GPIO_PORTA | GPIO_AF | 30)
-
-/* AIN GPIO pin functions */
-
-#define PC14_AIN_SYS_CLK	(GPIO_PORTC | GPIO_AIN | GPIO_OUT | 14)
-#define PD21_AIN_USBH2_FS	(GPIO_PORTD | GPIO_AIN | GPIO_OUT | 21)
-#define PD22_AIN_USBH2_OE	(GPIO_PORTD | GPIO_AIN | GPIO_OUT | 22)
-#define PD23_AIN_USBH2_TXDM	(GPIO_PORTD | GPIO_AIN | GPIO_OUT | 23)
-#define PD24_AIN_USBH2_TXDP	(GPIO_PORTD | GPIO_AIN | GPIO_OUT | 24)
-#define PE8_AIN_IR_TXD		(GPIO_PORTE | GPIO_AIN | GPIO_OUT | 8)
-#define PF0_AIN_PC_RST		(GPIO_PORTF | GPIO_AIN | GPIO_OUT | 0)
-#define PF1_AIN_PC_CE1		(GPIO_PORTF | GPIO_AIN | GPIO_OUT | 1)
-#define PF2_AIN_PC_CE2		(GPIO_PORTF | GPIO_AIN | GPIO_OUT | 2)
-#define PF3_AIN_PC_POE		(GPIO_PORTF | GPIO_AIN | GPIO_OUT | 3)
-#define PF4_AIN_PC_OE		(GPIO_PORTF | GPIO_AIN | GPIO_OUT | 4)
-#define PF5_AIN_PC_RW		(GPIO_PORTF | GPIO_AIN | GPIO_OUT | 5)
-
-/* BIN GPIO pin functions */
-
-#define PC14_BIN_SYS_CLK	(GPIO_PORTC | GPIO_BIN | GPIO_OUT | 14)
-#define PD27_BIN_EXT_DMA_GRANT	(GPIO_PORTD | GPIO_BIN | GPIO_OUT | 27)
-
-/* CIN GPIO pin functions */
-
-#define PB26_CIN_USBH1_RXDAT	(GPIO_PORTB | GPIO_CIN | GPIO_OUT | 26)
-
-/* AOUT GPIO pin functions */
-
-#define PA29_AOUT_BMI_WAIT	(GPIO_PORTA | GPIO_AOUT | GPIO_IN | 29)
-#define PD19_AOUT_USBH2_RXDM	(GPIO_PORTD | GPIO_AOUT | GPIO_IN | 19)
-#define PD20_AOUT_USBH2_RXDP	(GPIO_PORTD | GPIO_AOUT | GPIO_IN | 20)
-#define PD25_AOUT_EXT_DMAREQ	(GPIO_PORTD | GPIO_AOUT | GPIO_IN | 25)
-#define PD26_AOUT_USBOTG_RXDAT	(GPIO_PORTD | GPIO_AOUT | GPIO_IN | 26)
-#define PE9_AOUT_IR_RXD		(GPIO_PORTE | GPIO_AOUT | GPIO_IN | 9)
-#define PF6_AOUT_PC_BVD2	(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 6)
-#define PF7_AOUT_PC_BVD1	(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 7)
-#define PF8_AOUT_PC_VS2		(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 8)
-#define PF9_AOUT_PC_VS1		(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 9)
-#define PF10_AOUT_PC_WP		(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 10)
-#define PF11_AOUT_PC_READY	(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 11)
-#define PF12_AOUT_PC_WAIT	(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 12)
-#define PF13_AOUT_PC_CD2	(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 13)
-#define PF14_AOUT_PC_CD1	(GPIO_PORTF | GPIO_AOUT | GPIO_IN | 14)
-
-#endif /* ifndef __MACH_IOMUX_MX21_H__ */
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
deleted file mode 100644
index 2e91ab2..0000000
--- a/arch/arm/mach-imx/mm-imx21.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * arch/arm/mach-imx/mm-imx21.c
- *
- * Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/pinctrl/machine.h>
-#include <asm/pgtable.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "devices/devices-common.h"
-#include "hardware.h"
-#include "iomux-v1.h"
-
-/* MX21 memory map definition */
-static struct map_desc imx21_io_desc[] __initdata = {
-	/*
-	 * this fixed mapping covers:
-	 * - AIPI1
-	 * - AIPI2
-	 * - AITC
-	 * - ROM Patch
-	 * - and some reserved space
-	 */
-	imx_map_entry(MX21, AIPI, MT_DEVICE),
-	/*
-	 * this fixed mapping covers:
-	 * - CSI
-	 * - ATA
-	 */
-	imx_map_entry(MX21, SAHB1, MT_DEVICE),
-	/*
-	 * this fixed mapping covers:
-	 * - EMI
-	 */
-	imx_map_entry(MX21, X_MEMC, MT_DEVICE),
-};
-
-/*
- * Initialize the memory map. It is called during the
- * system startup to create static physical to virtual
- * memory map for the IO modules.
- */
-void __init mx21_map_io(void)
-{
-	iotable_init(imx21_io_desc, ARRAY_SIZE(imx21_io_desc));
-}
-
-void __init imx21_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX21);
-	imx_iomuxv1_init(MX21_IO_ADDRESS(MX21_GPIO_BASE_ADDR),
-			MX21_NUM_GPIO_PORT);
-}
-
-void __init mx21_init_irq(void)
-{
-	mxc_init_irq(MX21_IO_ADDRESS(MX21_AVIC_BASE_ADDR));
-}
-
-static const struct resource imx21_audmux_res[] __initconst = {
-	DEFINE_RES_MEM(MX21_AUDMUX_BASE_ADDR, SZ_4K),
-};
-
-void __init imx21_soc_init(void)
-{
-	mxc_arch_reset_init(MX21_IO_ADDRESS(MX21_WDOG_BASE_ADDR));
-	mxc_device_init();
-
-	mxc_register_gpio("imx21-gpio", 0, MX21_GPIO1_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 1, MX21_GPIO2_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 2, MX21_GPIO3_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 3, MX21_GPIO4_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 4, MX21_GPIO5_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 5, MX21_GPIO6_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-
-	pinctrl_provide_dummies();
-	imx_add_imx_dma("imx21-dma", MX21_DMA_BASE_ADDR,
-			MX21_INT_DMACH0, 0); /* No ERR irq */
-	platform_device_register_simple("imx21-audmux", 0, imx21_audmux_res,
-					ARRAY_SIZE(imx21_audmux_res));
-}
diff --git a/arch/arm/mach-imx/mx21.h b/arch/arm/mach-imx/mx21.h
deleted file mode 100644
index 468738a..0000000
--- a/arch/arm/mach-imx/mx21.h
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel@pengutronix.de
- * Copyright 2009 Holger Schurig, hs4233@mail.mn-solutions.de
- *
- * This contains i.MX21-specific hardware definitions. For those
- * hardware pieces that are common between i.MX21 and i.MX27, have a
- * look at mx2x.h.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
- */
-
-#ifndef __MACH_MX21_H__
-#define __MACH_MX21_H__
-
-#define MX21_AIPI_BASE_ADDR		0x10000000
-#define MX21_AIPI_SIZE			SZ_1M
-#define MX21_DMA_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x01000)
-#define MX21_WDOG_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x02000)
-#define MX21_GPT1_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x03000)
-#define MX21_GPT2_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x04000)
-#define MX21_GPT3_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x05000)
-#define MX21_PWM_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x06000)
-#define MX21_RTC_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x07000)
-#define MX21_KPP_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x08000)
-#define MX21_OWIRE_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x09000)
-#define MX21_UART1_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x0a000)
-#define MX21_UART2_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x0b000)
-#define MX21_UART3_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x0c000)
-#define MX21_UART4_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x0d000)
-#define MX21_CSPI1_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x0e000)
-#define MX21_CSPI2_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x0f000)
-#define MX21_SSI1_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x10000)
-#define MX21_SSI2_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x11000)
-#define MX21_I2C_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x12000)
-#define MX21_SDHC1_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x13000)
-#define MX21_SDHC2_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x14000)
-#define MX21_GPIO_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x15000)
-#define MX21_GPIO1_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x000)
-#define MX21_GPIO2_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x100)
-#define MX21_GPIO3_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x200)
-#define MX21_GPIO4_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x300)
-#define MX21_GPIO5_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x400)
-#define MX21_GPIO6_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x500)
-#define MX21_AUDMUX_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x16000)
-#define MX21_CSPI3_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x17000)
-#define MX21_LCDC_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x21000)
-#define MX21_SLCDC_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x22000)
-#define MX21_USBOTG_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x24000)
-#define MX21_EMMA_PP_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x26000)
-#define MX21_EMMA_PRP_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x26400)
-#define MX21_CCM_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x27000)
-#define MX21_SYSCTRL_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x27800)
-#define MX21_JAM_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x3e000)
-#define MX21_MAX_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x3f000)
-
-#define MX21_AVIC_BASE_ADDR		0x10040000
-
-#define MX21_SAHB1_BASE_ADDR		0x80000000
-#define MX21_SAHB1_SIZE			SZ_1M
-#define MX21_CSI_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x0000)
-
-/* Memory regions and CS */
-#define MX21_SDRAM_BASE_ADDR		0xc0000000
-#define MX21_CSD1_BASE_ADDR		0xc4000000
-
-#define MX21_CS0_BASE_ADDR		0xc8000000
-#define MX21_CS1_BASE_ADDR		0xcc000000
-#define MX21_CS2_BASE_ADDR		0xd0000000
-#define MX21_CS3_BASE_ADDR		0xd1000000
-#define MX21_CS4_BASE_ADDR		0xd2000000
-#define MX21_PCMCIA_MEM_BASE_ADDR	0xd4000000
-#define MX21_CS5_BASE_ADDR		0xdd000000
-
-/* NAND, SDRAM, WEIM etc controllers */
-#define MX21_X_MEMC_BASE_ADDR		0xdf000000
-#define MX21_X_MEMC_SIZE		SZ_256K
-
-#define MX21_SDRAMC_BASE_ADDR		(MX21_X_MEMC_BASE_ADDR + 0x0000)
-#define MX21_EIM_BASE_ADDR		(MX21_X_MEMC_BASE_ADDR + 0x1000)
-#define MX21_PCMCIA_CTL_BASE_ADDR	(MX21_X_MEMC_BASE_ADDR + 0x2000)
-#define MX21_NFC_BASE_ADDR		(MX21_X_MEMC_BASE_ADDR + 0x3000)
-
-#define MX21_IRAM_BASE_ADDR		0xffffe800	/* internal ram */
-
-#define MX21_IO_P2V(x)			IMX_IO_P2V(x)
-#define MX21_IO_ADDRESS(x)		IOMEM(MX21_IO_P2V(x))
-
-/* fixed interrupt numbers */
-#include <asm/irq.h>
-#define MX21_INT_CSPI3		(NR_IRQS_LEGACY + 6)
-#define MX21_INT_GPIO		(NR_IRQS_LEGACY + 8)
-#define MX21_INT_FIRI		(NR_IRQS_LEGACY + 9)
-#define MX21_INT_SDHC2		(NR_IRQS_LEGACY + 10)
-#define MX21_INT_SDHC1		(NR_IRQS_LEGACY + 11)
-#define MX21_INT_I2C		(NR_IRQS_LEGACY + 12)
-#define MX21_INT_SSI2		(NR_IRQS_LEGACY + 13)
-#define MX21_INT_SSI1		(NR_IRQS_LEGACY + 14)
-#define MX21_INT_CSPI2		(NR_IRQS_LEGACY + 15)
-#define MX21_INT_CSPI1		(NR_IRQS_LEGACY + 16)
-#define MX21_INT_UART4		(NR_IRQS_LEGACY + 17)
-#define MX21_INT_UART3		(NR_IRQS_LEGACY + 18)
-#define MX21_INT_UART2		(NR_IRQS_LEGACY + 19)
-#define MX21_INT_UART1		(NR_IRQS_LEGACY + 20)
-#define MX21_INT_KPP		(NR_IRQS_LEGACY + 21)
-#define MX21_INT_RTC		(NR_IRQS_LEGACY + 22)
-#define MX21_INT_PWM		(NR_IRQS_LEGACY + 23)
-#define MX21_INT_GPT3		(NR_IRQS_LEGACY + 24)
-#define MX21_INT_GPT2		(NR_IRQS_LEGACY + 25)
-#define MX21_INT_GPT1		(NR_IRQS_LEGACY + 26)
-#define MX21_INT_WDOG		(NR_IRQS_LEGACY + 27)
-#define MX21_INT_PCMCIA		(NR_IRQS_LEGACY + 28)
-#define MX21_INT_NFC		(NR_IRQS_LEGACY + 29)
-#define MX21_INT_BMI		(NR_IRQS_LEGACY + 30)
-#define MX21_INT_CSI		(NR_IRQS_LEGACY + 31)
-#define MX21_INT_DMACH0		(NR_IRQS_LEGACY + 32)
-#define MX21_INT_DMACH1		(NR_IRQS_LEGACY + 33)
-#define MX21_INT_DMACH2		(NR_IRQS_LEGACY + 34)
-#define MX21_INT_DMACH3		(NR_IRQS_LEGACY + 35)
-#define MX21_INT_DMACH4		(NR_IRQS_LEGACY + 36)
-#define MX21_INT_DMACH5		(NR_IRQS_LEGACY + 37)
-#define MX21_INT_DMACH6		(NR_IRQS_LEGACY + 38)
-#define MX21_INT_DMACH7		(NR_IRQS_LEGACY + 39)
-#define MX21_INT_DMACH8		(NR_IRQS_LEGACY + 40)
-#define MX21_INT_DMACH9		(NR_IRQS_LEGACY + 41)
-#define MX21_INT_DMACH10	(NR_IRQS_LEGACY + 42)
-#define MX21_INT_DMACH11	(NR_IRQS_LEGACY + 43)
-#define MX21_INT_DMACH12	(NR_IRQS_LEGACY + 44)
-#define MX21_INT_DMACH13	(NR_IRQS_LEGACY + 45)
-#define MX21_INT_DMACH14	(NR_IRQS_LEGACY + 46)
-#define MX21_INT_DMACH15	(NR_IRQS_LEGACY + 47)
-#define MX21_INT_EMMAENC	(NR_IRQS_LEGACY + 49)
-#define MX21_INT_EMMADEC	(NR_IRQS_LEGACY + 50)
-#define MX21_INT_EMMAPRP	(NR_IRQS_LEGACY + 51)
-#define MX21_INT_EMMAPP		(NR_IRQS_LEGACY + 52)
-#define MX21_INT_USBWKUP	(NR_IRQS_LEGACY + 53)
-#define MX21_INT_USBDMA		(NR_IRQS_LEGACY + 54)
-#define MX21_INT_USBHOST	(NR_IRQS_LEGACY + 55)
-#define MX21_INT_USBFUNC	(NR_IRQS_LEGACY + 56)
-#define MX21_INT_USBMNP		(NR_IRQS_LEGACY + 57)
-#define MX21_INT_USBCTRL	(NR_IRQS_LEGACY + 58)
-#define MX21_INT_SLCDC		(NR_IRQS_LEGACY + 60)
-#define MX21_INT_LCDC		(NR_IRQS_LEGACY + 61)
-
-/* fixed DMA request numbers */
-#define MX21_DMA_REQ_CSPI3_RX	1
-#define MX21_DMA_REQ_CSPI3_TX	2
-#define MX21_DMA_REQ_EXT	3
-#define MX21_DMA_REQ_FIRI_RX	4
-#define MX21_DMA_REQ_SDHC2	6
-#define MX21_DMA_REQ_SDHC1	7
-#define MX21_DMA_REQ_SSI2_RX0	8
-#define MX21_DMA_REQ_SSI2_TX0	9
-#define MX21_DMA_REQ_SSI2_RX1	10
-#define MX21_DMA_REQ_SSI2_TX1	11
-#define MX21_DMA_REQ_SSI1_RX0	12
-#define MX21_DMA_REQ_SSI1_TX0	13
-#define MX21_DMA_REQ_SSI1_RX1	14
-#define MX21_DMA_REQ_SSI1_TX1	15
-#define MX21_DMA_REQ_CSPI2_RX	16
-#define MX21_DMA_REQ_CSPI2_TX	17
-#define MX21_DMA_REQ_CSPI1_RX	18
-#define MX21_DMA_REQ_CSPI1_TX	19
-#define MX21_DMA_REQ_UART4_RX	20
-#define MX21_DMA_REQ_UART4_TX	21
-#define MX21_DMA_REQ_UART3_RX	22
-#define MX21_DMA_REQ_UART3_TX	23
-#define MX21_DMA_REQ_UART2_RX	24
-#define MX21_DMA_REQ_UART2_TX	25
-#define MX21_DMA_REQ_UART1_RX	26
-#define MX21_DMA_REQ_UART1_TX	27
-#define MX21_DMA_REQ_BMI_TX	28
-#define MX21_DMA_REQ_BMI_RX	29
-#define MX21_DMA_REQ_CSI_STAT	30
-#define MX21_DMA_REQ_CSI_RX	31
-
-#endif /* ifndef __MACH_MX21_H__ */
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index c06af65..8ef3a1b 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -83,14 +83,6 @@ void __init mxc_arch_reset_init(void __iomem *base)
 		clk_prepare(wdog_clk);
 }
 
-#ifdef CONFIG_SOC_IMX1
-void __init imx1_reset_init(void __iomem *base)
-{
-	wcr_enable = (1 << 0);
-	mxc_arch_reset_init(base);
-}
-#endif
-
 #ifdef CONFIG_CACHE_L2X0
 void __init imx_init_l2cache(void)
 {
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
