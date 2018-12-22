Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BDEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:53:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D3821A48
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="upLqFMBV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="BEUsDBnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D3821A48
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=pKsENSHire3/qSowrNYksi+gAdtg1idnhizmIvH2M2M=; b=upLqFMBV7UMFmTgh1/oks5oldL
	Ivy6eSJAvJgb8uvR9unxiE2Z61vqmw20s6XgHTloMpyHM5ng8FhVoh9NSG3XACS+BrftWklHqeHbp
	3wOkLj8UGEVGPfuO+ESA5WSLV3ZqyoneyLGTpg0YDm/uLIz0EXH14scVIu1cvj6ZZgwqYcv9FEedA
	e3Xq/VeSa9lDLEoqVZI+WpRskVnFI29lL9meXlJQ3qwmsP0iC2S5Fp+bXFF07l0s52hoQsmybeGEa
	Z87zq3cIy6X2q3ntTkEqQphPyEiCs9/sZod/xHnk9zL4nnJU9KZiOiKD0BL4jHWUUR9MAHK/BVxcV
	Ibt9JQvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaeuJ-00018Z-J2; Sat, 22 Dec 2018 10:53:23 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaetH-0000I6-NA
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=uN90BvwctELn9zVd91B7t+jYMWTK3j/pBhz8fYzWPyI=; 
 b=BEUsDBnIaBl79CZIqYVA6t5PCgpTftHyPxmpKzy8WIX5QU5jXv+eerVie6AI6IZlFK8ic+uPBKJdj9uuTAnKB03KbiQs24tdrKWXQ/1/xDqkgqwWHODo8Udl+0kAzrCsA5oSTzIeOkUC9inFlyEXttWFh+wF8rL4bWGiYNF4L08=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaet3-00014B-I6; Sat, 22 Dec 2018 13:52:05 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] ARM: i.MX: Remove i.MX21 Freescale ADS board support
Date: Sat, 22 Dec 2018 13:51:58 +0300
Message-Id: <20181222105200.18502-4-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181222105200.18502-1-shc_work@mail.ru>
References: <20181222105200.18502-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: CF41D5CA8C6D3C0C7F9F52485CB584D75945EECDF71DA5B32CC74D338480644031E35978C183A0E2FD951021161CFB36FEDCCBD3DDE7F493
X-7FA49CB5: 0D63561A33F958A53228BC2C66DA7434857BED211D07E6A39A3407AD3F2919648941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22498B372E35CF5A2D2DD32BA5DBAC0009BE395957E7521B51C24DA2F55E57A558BE49FD398EE364050FF8AB6B2BE221812676E601842F6C81A1F004C906525384306FED454B719173D6725E5C173C3A84C315AF0D0D4FC4FA3DCD86F641C969B2DAB17145F0B7815491C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D244531C2B742D01D006815582FFDB86750E49510AF4DD9469E9E6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_025220_182722_FAB49445 
X-CRM114-Status: GOOD (  15.93  )
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

mach-mx21ads.c can be replaced with devicetree equivalent: imx21-ads.dts,
so remove the board file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig        |  11 --
 arch/arm/mach-imx/Makefile       |   1 -
 arch/arm/mach-imx/mach-mx21ads.c | 348 ---------------------------------------
 3 files changed, 360 deletions(-)
 delete mode 100644 arch/arm/mach-imx/mach-mx21ads.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index abf3c0d..7b49939 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -80,17 +80,6 @@ if ARCH_MULTI_V5
 
 comment "MX21 platforms:"
 
-config MACH_MX21ADS
-	bool "MX21ADS platform"
-	select IMX_HAVE_PLATFORM_IMX_FB
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_MMC
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select SOC_IMX21
-	help
-	  Include support for MX21ADS platform. This includes specific
-	  configurations for the board and its peripherals.
-
 config MACH_IMX21_DT
 	bool "Support i.MX21 platforms from device tree"
 	select SOC_IMX21
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 52a9138..a629af2 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -37,7 +37,6 @@ obj-y += ssi-fiq-ksym.o
 endif
 
 # i.MX21 based machines
-obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 obj-$(CONFIG_MACH_IMX21_DT) += mach-imx21.o
 
 # i.MX27 based machines
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
deleted file mode 100644
index 2e1e540..0000000
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ /dev/null
@@ -1,348 +0,0 @@
-/*
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright (C) 2002 Shane Nay (shane@minirl.com)
- *  Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/physmap.h>
-#include <linux/gpio/driver.h>
-#include <linux/gpio/machine.h>
-#include <linux/gpio.h>
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "devices-imx21.h"
-#include "hardware.h"
-#include "iomux-mx21.h"
-
-#define MX21ADS_CS8900A_REG		(MX21_CS1_BASE_ADDR + 0x000000)
-#define MX21ADS_ST16C255_IOBASE_REG	(MX21_CS1_BASE_ADDR + 0x200000)
-#define MX21ADS_VERSION_REG		(MX21_CS1_BASE_ADDR + 0x400000)
-#define MX21ADS_IO_REG			(MX21_CS1_BASE_ADDR + 0x800000)
-
-#define MX21ADS_MMC_CD			IMX_GPIO_NR(4, 25)
-#define MX21ADS_CS8900A_IRQ_GPIO	IMX_GPIO_NR(5, 11)
-#define MX21ADS_MMGPIO_BASE		(6 * 32)
-
-/* MX21ADS_IO_REG bit definitions */
-#define MX21ADS_IO_SD_WP		(MX21ADS_MMGPIO_BASE + 0)
-#define MX21ADS_IO_TP6			(MX21ADS_IO_SD_WP)
-#define MX21ADS_IO_SW_SEL		(MX21ADS_MMGPIO_BASE + 1)
-#define MX21ADS_IO_TP7			(MX21ADS_IO_SW_SEL)
-#define MX21ADS_IO_RESET_E_UART		(MX21ADS_MMGPIO_BASE + 2)
-#define MX21ADS_IO_RESET_BASE		(MX21ADS_MMGPIO_BASE + 3)
-#define MX21ADS_IO_CSI_CTL2		(MX21ADS_MMGPIO_BASE + 4)
-#define MX21ADS_IO_CSI_CTL1		(MX21ADS_MMGPIO_BASE + 5)
-#define MX21ADS_IO_CSI_CTL0		(MX21ADS_MMGPIO_BASE + 6)
-#define MX21ADS_IO_UART1_EN		(MX21ADS_MMGPIO_BASE + 7)
-#define MX21ADS_IO_UART4_EN		(MX21ADS_MMGPIO_BASE + 8)
-#define MX21ADS_IO_LCDON		(MX21ADS_MMGPIO_BASE + 9)
-#define MX21ADS_IO_IRDA_EN		(MX21ADS_MMGPIO_BASE + 10)
-#define MX21ADS_IO_IRDA_FIR_SEL		(MX21ADS_MMGPIO_BASE + 11)
-#define MX21ADS_IO_IRDA_MD0_B		(MX21ADS_MMGPIO_BASE + 12)
-#define MX21ADS_IO_IRDA_MD1		(MX21ADS_MMGPIO_BASE + 13)
-#define MX21ADS_IO_LED4_ON		(MX21ADS_MMGPIO_BASE + 14)
-#define MX21ADS_IO_LED3_ON		(MX21ADS_MMGPIO_BASE + 15)
-
-static const int mx21ads_pins[] __initconst = {
-
-	/* CS8900A */
-	(GPIO_PORTE | GPIO_GPIO | GPIO_IN | 11),
-
-	/* UART1 */
-	PE12_PF_UART1_TXD,
-	PE13_PF_UART1_RXD,
-	PE14_PF_UART1_CTS,
-	PE15_PF_UART1_RTS,
-
-	/* UART3 (IrDA) - only TXD and RXD */
-	PE8_PF_UART3_TXD,
-	PE9_PF_UART3_RXD,
-
-	/* UART4 */
-	PB26_AF_UART4_RTS,
-	PB28_AF_UART4_TXD,
-	PB29_AF_UART4_CTS,
-	PB31_AF_UART4_RXD,
-
-	/* LCDC */
-	PA5_PF_LSCLK,
-	PA6_PF_LD0,
-	PA7_PF_LD1,
-	PA8_PF_LD2,
-	PA9_PF_LD3,
-	PA10_PF_LD4,
-	PA11_PF_LD5,
-	PA12_PF_LD6,
-	PA13_PF_LD7,
-	PA14_PF_LD8,
-	PA15_PF_LD9,
-	PA16_PF_LD10,
-	PA17_PF_LD11,
-	PA18_PF_LD12,
-	PA19_PF_LD13,
-	PA20_PF_LD14,
-	PA21_PF_LD15,
-	PA22_PF_LD16,
-	PA24_PF_REV,     /* Sharp panel dedicated signal */
-	PA25_PF_CLS,     /* Sharp panel dedicated signal */
-	PA26_PF_PS,      /* Sharp panel dedicated signal */
-	PA27_PF_SPL_SPR, /* Sharp panel dedicated signal */
-	PA28_PF_HSYNC,
-	PA29_PF_VSYNC,
-	PA30_PF_CONTRAST,
-	PA31_PF_OE_ACD,
-
-	/* MMC/SDHC */
-	PE18_PF_SD1_D0,
-	PE19_PF_SD1_D1,
-	PE20_PF_SD1_D2,
-	PE21_PF_SD1_D3,
-	PE22_PF_SD1_CMD,
-	PE23_PF_SD1_CLK,
-
-	/* NFC */
-	PF0_PF_NRFB,
-	PF1_PF_NFCE,
-	PF2_PF_NFWP,
-	PF3_PF_NFCLE,
-	PF4_PF_NFALE,
-	PF5_PF_NFRE,
-	PF6_PF_NFWE,
-	PF7_PF_NFIO0,
-	PF8_PF_NFIO1,
-	PF9_PF_NFIO2,
-	PF10_PF_NFIO3,
-	PF11_PF_NFIO4,
-	PF12_PF_NFIO5,
-	PF13_PF_NFIO6,
-	PF14_PF_NFIO7,
-};
-
-/* ADS's NOR flash: 2x AM29BDS128HE9VKI on 32-bit bus */
-static struct physmap_flash_data mx21ads_flash_data = {
-	.width = 4,
-};
-
-static struct resource mx21ads_flash_resource =
-	DEFINE_RES_MEM(MX21_CS0_BASE_ADDR, SZ_32M);
-
-static struct platform_device mx21ads_nor_mtd_device = {
-	.name = "physmap-flash",
-	.id = 0,
-	.dev = {
-		.platform_data = &mx21ads_flash_data,
-	},
-	.num_resources = 1,
-	.resource = &mx21ads_flash_resource,
-};
-
-static struct resource mx21ads_cs8900_resources[] __initdata = {
-	DEFINE_RES_MEM(MX21ADS_CS8900A_REG, SZ_1K),
-	/* irq number is run-time assigned */
-	DEFINE_RES_IRQ(-1),
-};
-
-static const struct platform_device_info mx21ads_cs8900_devinfo __initconst = {
-	.name = "cs89x0",
-	.id = 0,
-	.res = mx21ads_cs8900_resources,
-	.num_res = ARRAY_SIZE(mx21ads_cs8900_resources),
-};
-
-static const struct imxuart_platform_data uart_pdata_rts __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static const struct imxuart_platform_data uart_pdata_norts __initconst = {
-};
-
-static struct resource mx21ads_mmgpio_resource =
-	DEFINE_RES_MEM_NAMED(MX21ADS_IO_REG, SZ_2, "dat");
-
-static struct bgpio_pdata mx21ads_mmgpio_pdata = {
-	.label	= "mx21ads-mmgpio",
-	.base	= MX21ADS_MMGPIO_BASE,
-	.ngpio	= 16,
-};
-
-static struct platform_device mx21ads_mmgpio = {
-	.name = "basic-mmio-gpio",
-	.id = PLATFORM_DEVID_AUTO,
-	.resource = &mx21ads_mmgpio_resource,
-	.num_resources = 1,
-	.dev = {
-		.platform_data = &mx21ads_mmgpio_pdata,
-	},
-};
-
-static struct regulator_consumer_supply mx21ads_lcd_regulator_consumer =
-	REGULATOR_SUPPLY("lcd", "imx-fb.0");
-
-static struct regulator_init_data mx21ads_lcd_regulator_init_data = {
-	.constraints = {
-		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
-	},
-	.consumer_supplies	= &mx21ads_lcd_regulator_consumer,
-	.num_consumer_supplies	= 1,
-};
-
-static struct fixed_voltage_config mx21ads_lcd_regulator_pdata = {
-	.supply_name	= "LCD",
-	.microvolts	= 3300000,
-	.enable_high	= 1,
-	.init_data	= &mx21ads_lcd_regulator_init_data,
-};
-
-static struct platform_device mx21ads_lcd_regulator = {
-	.name = "reg-fixed-voltage",
-	.id = PLATFORM_DEVID_AUTO,
-	.dev = {
-		.platform_data = &mx21ads_lcd_regulator_pdata,
-	},
-};
-
-static struct gpiod_lookup_table mx21ads_lcd_regulator_gpiod_table = {
-	.dev_id = "reg-fixed-voltage.0", /* Let's hope ID 0 is what we get */
-	.table = {
-		GPIO_LOOKUP("mx21ads-mmgpio", 9, NULL, GPIO_ACTIVE_HIGH),
-		{ },
-	},
-};
-
-/*
- * Connected is a portrait Sharp-QVGA display
- * of type: LQ035Q7DB02
- */
-static struct imx_fb_videomode mx21ads_modes[] = {
-	{
-		.mode = {
-			.name		= "Sharp-LQ035Q7",
-			.refresh	= 60,
-			.xres		= 240,
-			.yres		= 320,
-			.pixclock	= 188679, /* in ps (5.3MHz) */
-			.hsync_len	= 2,
-			.left_margin	= 6,
-			.right_margin	= 16,
-			.vsync_len	= 1,
-			.upper_margin	= 8,
-			.lower_margin	= 10,
-		},
-		.pcr		= 0xfb108bc7,
-		.bpp		= 16,
-	},
-};
-
-static const struct imx_fb_platform_data mx21ads_fb_data __initconst = {
-	.mode = mx21ads_modes,
-	.num_modes = ARRAY_SIZE(mx21ads_modes),
-
-	.pwmr		= 0x00a903ff,
-	.lscr1		= 0x00120300,
-	.dmacr		= 0x00020008,
-};
-
-static int mx21ads_sdhc_get_ro(struct device *dev)
-{
-	return gpio_get_value(MX21ADS_IO_SD_WP);
-}
-
-static int mx21ads_sdhc_init(struct device *dev, irq_handler_t detect_irq,
-	void *data)
-{
-	int ret;
-
-	ret = gpio_request(MX21ADS_IO_SD_WP, "mmc-ro");
-	if (ret)
-		return ret;
-
-	return request_irq(gpio_to_irq(MX21ADS_MMC_CD), detect_irq,
-			   IRQF_TRIGGER_FALLING, "mmc-detect", data);
-}
-
-static void mx21ads_sdhc_exit(struct device *dev, void *data)
-{
-	free_irq(gpio_to_irq(MX21ADS_MMC_CD), data);
-	gpio_free(MX21ADS_IO_SD_WP);
-}
-
-static const struct imxmmc_platform_data mx21ads_sdhc_pdata __initconst = {
-	.ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31, /* 3.0V */
-	.get_ro = mx21ads_sdhc_get_ro,
-	.init = mx21ads_sdhc_init,
-	.exit = mx21ads_sdhc_exit,
-};
-
-static const struct mxc_nand_platform_data
-mx21ads_nand_board_info __initconst = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
-static struct platform_device *platform_devices[] __initdata = {
-	&mx21ads_mmgpio,
-	&mx21ads_lcd_regulator,
-	&mx21ads_nor_mtd_device,
-};
-
-static void __init mx21ads_board_init(void)
-{
-	imx21_soc_init();
-
-	mxc_gpio_setup_multiple_pins(mx21ads_pins, ARRAY_SIZE(mx21ads_pins),
-			"mx21ads");
-
-	imx21_add_imx_uart0(&uart_pdata_rts);
-	imx21_add_imx_uart2(&uart_pdata_norts);
-	imx21_add_imx_uart3(&uart_pdata_rts);
-	imx21_add_mxc_nand(&mx21ads_nand_board_info);
-
-	imx21_add_imx_fb(&mx21ads_fb_data);
-}
-
-static void __init mx21ads_late_init(void)
-{
-	imx21_add_mxc_mmc(0, &mx21ads_sdhc_pdata);
-
-	gpiod_add_lookup_table(&mx21ads_lcd_regulator_gpiod_table);
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-
-	mx21ads_cs8900_resources[1].start =
-			gpio_to_irq(MX21ADS_CS8900A_IRQ_GPIO);
-	mx21ads_cs8900_resources[1].end =
-			gpio_to_irq(MX21ADS_CS8900A_IRQ_GPIO);
-	platform_device_register_full(&mx21ads_cs8900_devinfo);
-}
-
-static void __init mx21ads_timer_init(void)
-{
-	mx21_clocks_init(32768, 26000000);
-}
-
-MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
-	/* maintainer: Freescale Semiconductor, Inc. */
-	.atag_offset = 0x100,
-	.map_io		= mx21_map_io,
-	.init_early = imx21_init_early,
-	.init_irq = mx21_init_irq,
-	.init_time	= mx21ads_timer_init,
-	.init_machine	= mx21ads_board_init,
-	.init_late	= mx21ads_late_init,
-	.restart	= mxc_restart,
-MACHINE_END
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
