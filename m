Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E39C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:57:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0A72086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SX7bUG0z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="AAMzTMVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0A72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LaAwMORUkOW5FcYN78GCZu0nQZMGn8LXCtEQRY731NY=; b=SX7bUG0zJ2HiTB
	9F6Wc89F1ShzG+L+WdumhmMGPDNpWKY7mn7h9EYsJ+vKsf0T2Dx7BvxLIC7v1B2gD+6C3KXipYHVg
	d7iXHyKFSRYKjnPwSa/HJlbvjQ+JXwU3dNLUpkY/y7+NMoa+PYPI+naj54l9xG+vVq2dJdST/oYbp
	0zMqzwRxpBAyc6bRynt+rG0PisDmCsPfLHApEo+0n0pgpfHOrHF8Fii7L6IPs3v13M080f8Wu8ENi
	TygLTB8LdYUdgs7Juu9wzDB20XEV457S5TnEJuXed+f3tcgzbxFcku6idzpNeH2kl6EEAu5k7dYC/
	30QDtnRF1lQp4GfhHc4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX393-0002V3-IW; Wed, 12 Dec 2018 11:57:41 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX38o-0002KP-1Z
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:57:30 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; d="scan'208";a="21415420"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Dec 2018 04:57:18 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 04:57:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aa1kJFIJ+3vdFEnk9ggjxx5kbE9Kw2Z3pCU/u6pAAA=;
 b=AAMzTMVn3RHmLSuxid65LES5ScsV0mK2+Laehm4I5bXTwKWRV5fkYH2GwsqBZr7ft6pm4B0OuztlpAFrW7YtjATOILRtMKR93WpwmPXNGsuF8dZWyh2Mwfp5VBM/AW8BUMcLQmtQiS24DsyV6L+2X+L7I1lUhFhbF/yMEH4z8UY=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2145.namprd11.prod.outlook.com (10.174.112.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 11:57:15 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 11:57:15 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
 <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
 <mark.rutland@arm.com>
Subject: [PATCH v4 2/2] gpio: add driver for SAMA5D2 PIOBU pins
Thread-Topic: [PATCH v4 2/2] gpio: add driver for SAMA5D2 PIOBU pins
Thread-Index: AQHUkhHT82BTQmjnaUurcWDQ0nNa3A==
Date: Wed, 12 Dec 2018 11:57:15 +0000
Message-ID: <1544615784-29331-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::41) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2145;
 6:6GAjhD0iJLVxbKXV5GpwlJfrrCawywyCWlE/QJ3LLv7er0tYKwZBu739j1hRrLqHkFIjb7us3TgTwEI/5RfylCC0SsWQYws/3SgpQxYKDm/ROrj9i8YQcRqA9RdvmILKPqJAx7cWOqatod4j1o7prN8tnGLYUwSYyLw7jY89leTiK3h+exjt+5Z8wVsd/dWIzr2MEAbzESsViqlyOl6ipg5mPiXzU0g5OYYXSJfUgzwneZ5iRoUXtW6jT9kwotocr+EEdI60+mJUdxE1ryQ2falCMezJEZXYncYpj9nBC7ImIm0LZB6fz+hdt5sUoFTkW1J/T6j18WBRd3Tv/OA/GuWNRLknZuSB95LPputx8wQTIAmIDyLtWW38jFA38ntABRdAng9uHTSnToiv0Gc5+zfu/BOy2TcDz7iXh4aNMzI72tHzPcP+iu2RO5lqHLuaVgN6W+/0HX4anaJ5RKk2XQ==;
 5:ZhKRla7XScGklUMxWLu8DIEJhty96mCL84vCGKwnhhl9DxR0My9TggyYIJPMJoMNl76iTQm7uQYLKW4jdeaG4pcssyI7Z4Z7lX2KYx9ziA4rNb4115yyBT279IriAaemldKBrGk/9EBNp0iRQesXeuHkf9HxXta/OOxGK33copg=;
 7:Dx8A+lbZmUj9QZcGti8tXwzEGeC8DRbFtCEyLFfLTxzdSnjR2wpWRTa7HhSwO5Nar00v/T9a4iY61zcb31q6lEoiOhSN3YkMaKiBJ2/H7tpVMZ7MPRFNcEtuobjiTjF1WElgVgZ2y+P9Jdx4D48LLA==
x-ms-office365-filtering-correlation-id: 9c51d150-f32f-4ade-565d-08d66028f551
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2145; 
x-ms-traffictypediagnostic: BN6PR1101MB2145:
x-microsoft-antispam-prvs: <BN6PR1101MB2145FE8431BC8C13EFE16DE5EDA70@BN6PR1101MB2145.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2145; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2145; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(189003)(8676002)(110136005)(6506007)(76176011)(386003)(102836004)(52116002)(53936002)(11346002)(2616005)(446003)(8936002)(81156014)(316002)(81166006)(36756003)(106356001)(54906003)(68736007)(105586002)(7736002)(2501003)(97736004)(186003)(107886003)(99286004)(66066001)(71200400001)(71190400001)(5660300001)(86362001)(72206003)(26005)(2906002)(478600001)(3846002)(6116002)(14454004)(305945005)(14444005)(256004)(4326008)(486006)(25786009)(476003)(6512007)(6436002)(6486002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2145;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YiGAXz2EE3V/tAby2zCACydil2n+TpxXzhKl6M+Tc8/qLYmZUvSZdLmFgXmxnpoiCxXLyRFvCto8uZd1k5A9DkBc7dmdg/8ZnFArVpVGKusygh8PISi8q//oS59Zir1jczOjhadVALE2JlK3MW6kFkAjV88iaN5h7ZXWZtCWaUuIetN5R/Ess2UWyhvTgdTG30kRhW/fUsK1vbQvkDUjFYmVRoJSLvsDr5rUJWBPXNtirzyyW6o82HymQGkpJ3UZ1MrKWQ4hkQWMUY2X/aQjraxqbvIgJCss2/VzpGmvhyCTmHZ97wtvSKa5SaFXBjpK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c51d150-f32f-4ade-565d-08d66028f551
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 11:57:15.3179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_035726_444150_163230D3 
X-CRM114-Status: GOOD (  21.38  )
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
Cc: devicetree@vger.kernel.org, Andrei.Stefanescu@microchip.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Ludovic.Desroches@microchip.com, Cristian.Birsan@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PIOBU pins do not lose their voltage during Backup/Self-refresh.
This patch adds a simple GPIO controller for them and a
maintainer for the driver.

This driver adds support for using the pins as GPIO
offering the possibility to read/set the voltage.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 MAINTAINERS                       |   6 +
 drivers/gpio/Kconfig              |  11 ++
 drivers/gpio/Makefile             |   1 +
 drivers/gpio/gpio-sama5d2-piobu.c | 253 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 271 insertions(+)
 create mode 100644 drivers/gpio/gpio-sama5d2-piobu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..fadc96d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9760,6 +9760,12 @@ M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
+MICROCHIP SAMA5D2-COMPATIBLE PIOBU GPIO
+M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-gpio@vger.kernel.org
+F:	drivers/gpio/gpio-sama5d2-piobu.c
+
 MICROCHIP SPI DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 833a1b5..1c41fac 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -429,6 +429,17 @@ config GPIO_REG
 	  A 32-bit single register GPIO fixed in/out implementation.  This
 	  can be used to represent any register as a set of GPIO signals.
 
+config GPIO_SAMA5D2_PIOBU
+	tristate "SAMA5D2 PIOBU GPIO support"
+	depends on MFD_SYSCON
+	select GPIO_SYSCON
+	help
+	  Say yes here to use the PIOBU pins as GPIOs.
+
+	  PIOBU pins on the SAMA5D2 can be used as GPIOs.
+	  The difference from regular GPIOs is that they
+	  maintain their value during backup/self-refresh.
+
 config GPIO_SIOX
 	tristate "SIOX GPIO support"
 	depends on SIOX
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 671c447..f18d345 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_RCAR)		+= gpio-rcar.o
 obj-$(CONFIG_GPIO_REG)		+= gpio-reg.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
+obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+= gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SCH311X)	+= gpio-sch311x.o
 obj-$(CONFIG_GPIO_SNPS_CREG)	+= gpio-creg-snps.o
diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
new file mode 100644
index 0000000..03a0006
--- /dev/null
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SAMA5D2 PIOBU GPIO controller
+ *
+ * Copyright (C) 2018 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Andrei Stefanescu <andrei.stefanescu@microchip.com>
+ *
+ */
+#include <linux/bits.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define PIOBU_NUM 8
+#define PIOBU_REG_SIZE 4
+
+/*
+ * backup mode protection register for tamper detection
+ * normal mode protection register for tamper detection
+ * wakeup signal generation
+ */
+#define PIOBU_BMPR 0x7C
+#define PIOBU_NMPR 0x80
+#define PIOBU_WKPR 0x90
+
+#define PIOBU_BASE 0x18 /* PIOBU offset from SECUMOD base register address. */
+
+#define PIOBU_DET_OFFSET 16
+
+/* In the datasheet this bit is called OUTPUT */
+#define PIOBU_DIRECTION BIT(8)
+#define PIOBU_OUT BIT(8)
+#define PIOBU_IN 0
+
+#define PIOBU_SOD BIT(9)
+#define PIOBU_PDS BIT(10)
+
+#define PIOBU_HIGH BIT(9)
+#define PIOBU_LOW 0
+
+struct sama5d2_piobu {
+	struct gpio_chip chip;
+	struct regmap *regmap;
+};
+
+/**
+ * sama5d2_piobu_setup_pin() - prepares a pin for set_direction call
+ *
+ * Do not consider pin for tamper detection (normal and backup modes)
+ * Do not consider pin as tamper wakeup interrupt source
+ */
+static int sama5d2_piobu_setup_pin(struct gpio_chip *chip, unsigned int pin)
+{
+	int ret;
+	struct sama5d2_piobu *piobu = container_of(chip, struct sama5d2_piobu,
+						   chip);
+	unsigned int mask = BIT(PIOBU_DET_OFFSET + pin);
+
+	ret = regmap_update_bits(piobu->regmap, PIOBU_BMPR, mask, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(piobu->regmap, PIOBU_NMPR, mask, 0);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(piobu->regmap, PIOBU_WKPR, mask, 0);
+}
+
+/**
+ * sama5d2_piobu_write_value() - writes value & mask at the pin's PIOBU register
+ */
+static int sama5d2_piobu_write_value(struct gpio_chip *chip, unsigned int pin,
+				     unsigned int mask, unsigned int value)
+{
+	int reg;
+	struct sama5d2_piobu *piobu = container_of(chip, struct sama5d2_piobu,
+						   chip);
+
+	reg = PIOBU_BASE + pin * PIOBU_REG_SIZE;
+
+	return regmap_update_bits(piobu->regmap, reg, mask, value);
+}
+
+/**
+ * sama5d2_piobu_read_value() - read the value with masking from the pin's PIOBU
+ *			      register
+ */
+static int sama5d2_piobu_read_value(struct gpio_chip *chip, unsigned int pin,
+				    unsigned int mask)
+{
+	struct sama5d2_piobu *piobu = container_of(chip, struct sama5d2_piobu,
+						   chip);
+	unsigned int val, reg;
+	int ret;
+
+	reg = PIOBU_BASE + pin * PIOBU_REG_SIZE;
+	ret = regmap_read(piobu->regmap, reg, &val);
+	if (ret < 0)
+		return ret;
+
+	return val & mask;
+}
+
+/**
+ * sama5d2_piobu_set_direction() - mark pin as input or output
+ */
+static int sama5d2_piobu_set_direction(struct gpio_chip *chip,
+				       unsigned int direction,
+				       unsigned int pin)
+{
+	return sama5d2_piobu_write_value(chip, pin, PIOBU_DIRECTION, direction);
+}
+
+/**
+ * sama5d2_piobu_get_direction() - gpiochip get_direction
+ */
+static int sama5d2_piobu_get_direction(struct gpio_chip *chip,
+				       unsigned int pin)
+{
+	int ret = sama5d2_piobu_read_value(chip, pin, PIOBU_DIRECTION);
+
+	if (ret < 0)
+		return ret;
+
+	return (ret == PIOBU_IN) ? 1 : 0;
+}
+
+/**
+ * sama5d2_piobu_direction_input() - gpiochip direction_input
+ */
+static int sama5d2_piobu_direction_input(struct gpio_chip *chip,
+					 unsigned int pin)
+{
+	return sama5d2_piobu_set_direction(chip, PIOBU_IN, pin);
+}
+
+/**
+ * sama5d2_piobu_direction_output() - gpiochip direction_output
+ */
+static int sama5d2_piobu_direction_output(struct gpio_chip *chip,
+					  unsigned int pin, int value)
+{
+	return sama5d2_piobu_set_direction(chip, PIOBU_OUT, pin);
+}
+
+/**
+ * sama5d2_piobu_get() - gpiochip get
+ */
+static int sama5d2_piobu_get(struct gpio_chip *chip, unsigned int pin)
+{
+	/* if pin is input, read value from PDS else read from SOD */
+	int ret = sama5d2_piobu_get_direction(chip, pin);
+
+	if (ret == 1)
+		ret = sama5d2_piobu_read_value(chip, pin, PIOBU_PDS);
+	else if (!ret)
+		ret = sama5d2_piobu_read_value(chip, pin, PIOBU_SOD);
+
+	if (ret < 0)
+		return ret;
+
+	return !!ret;
+}
+
+/**
+ * sama5d2_piobu_set() - gpiochip set
+ */
+static void sama5d2_piobu_set(struct gpio_chip *chip, unsigned int pin,
+			      int value)
+{
+	if (!value)
+		value = PIOBU_LOW;
+	else
+		value = PIOBU_HIGH;
+
+	sama5d2_piobu_write_value(chip, pin, PIOBU_SOD, value);
+}
+
+static int sama5d2_piobu_probe(struct platform_device *pdev)
+{
+	struct sama5d2_piobu *piobu;
+	int ret, i;
+
+	piobu = devm_kzalloc(&pdev->dev, sizeof(*piobu), GFP_KERNEL);
+	if (!piobu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, piobu);
+	piobu->chip.label = pdev->name;
+	piobu->chip.parent = &pdev->dev;
+	piobu->chip.of_node = pdev->dev.of_node;
+	piobu->chip.owner = THIS_MODULE,
+	piobu->chip.get_direction = sama5d2_piobu_get_direction,
+	piobu->chip.direction_input = sama5d2_piobu_direction_input,
+	piobu->chip.direction_output = sama5d2_piobu_direction_output,
+	piobu->chip.get = sama5d2_piobu_get,
+	piobu->chip.set = sama5d2_piobu_set,
+	piobu->chip.base = -1,
+	piobu->chip.ngpio = PIOBU_NUM,
+	piobu->chip.can_sleep = 0,
+
+	piobu->regmap = syscon_node_to_regmap(pdev->dev.of_node);
+	if (IS_ERR(piobu->regmap)) {
+		dev_err(&pdev->dev, "Failed to get syscon regmap %ld\n",
+			PTR_ERR(piobu->regmap));
+		return PTR_ERR(piobu->regmap);
+	}
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &piobu->chip, piobu);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add gpiochip %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < PIOBU_NUM; ++i) {
+		ret = sama5d2_piobu_setup_pin(&piobu->chip, i);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to setup pin: %d %d\n",
+				i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sama5d2_piobu_ids[] = {
+	{ .compatible = "atmel,sama5d2-secumod" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sama5d2_piobu_ids);
+
+static struct platform_driver sama5d2_piobu_driver = {
+	.driver = {
+		.name		= "sama5d2-piobu",
+		.of_match_table	= of_match_ptr(sama5d2_piobu_ids)
+	},
+	.probe = sama5d2_piobu_probe,
+};
+
+module_platform_driver(sama5d2_piobu_driver);
+
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("SAMA5D2 PIOBU controller driver");
+MODULE_AUTHOR("Andrei Stefanescu <andrei.stefanescu@microchip.com>");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
