Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E3C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:47:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E213F20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JrUeeiRO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="J7Dk2ipC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E213F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OwQ7Hnk4Y40fzbiwF9P8t3nnXyYGrClguzoyPNjGINg=; b=JrUeeiROiyFHiA
	4n0ArftEWlN2YUWBsC47BNNE1Ow61XK3YKjK8tdOcLc43BavXIpSBksthJw9fQV7ZUrZ//TeGNITf
	jeA47Z+nw7lOSW8cmxR2Vw6X50qlxt5A+RDgjfzm5ZgXRZYHNEnkVNbP+pIQBehdjLah39ltHJW6A
	cqj/Sleq7gTNy8d09pjnC+f+YMUr/BQj9Gggn27oa3WqLprW7JNbtsNwlG0oC9obEMvR8Yy+4KM8c
	HvvOiIhyE4xh/I1g1lDBqjiQ6LbDEgZakOssRbgfe7hWftYyomnZ0p9t/YQfJLug54whGiLOM0Cs+
	eY+jP9353gR6XCcuvb5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV9uq-0001mR-BK; Fri, 07 Dec 2018 06:47:12 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV9uR-0001Jy-LJ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 06:46:51 +0000
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; d="scan'208";a="21237778"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 06 Dec 2018 23:46:36 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 6 Dec 2018 23:46:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi2IPuKtToribu/7uH6SiiBZT5XXaLE6G0qfC3e2Fxg=;
 b=J7Dk2ipCadXvVsCukYvDb1p6qCZtghfejInfUY9UKPq8xtAqfylPOsXEcJ6P4qHNG3xJTT3zcJXu/8pK7UOWwJttIeoDDgPXGxJa/6/bQ4qZ8aMGyU7IX8qlNepDI/8pJxWNopr8dwL2T1V0eEtpWlGUK5C4txz0DPODDUVKTAI=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2257.namprd11.prod.outlook.com (10.174.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 06:46:34 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 06:46:34 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
 <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v3 2/2] gpio: add driver for SAMA5D2 PIOBU pins
Thread-Topic: [PATCH v3 2/2] gpio: add driver for SAMA5D2 PIOBU pins
Thread-Index: AQHUjfiXEv0IctpQo0qk/SagUWESfA==
Date: Fri, 7 Dec 2018 06:46:34 +0000
Message-ID: <1544165160-13653-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1544165160-13653-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544165160-13653-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:802:2::46) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2257;
 6:/GI6qm5mNYkpJcOVc8LVKjqhjRW1gavs8yVu6NeKeuNRS18Q+oPl30hZBN6SWwQIcm4UQEfWkBaP9CMa87mygYC99aEXO7hibNWcIsXHtTF4P7cWFSjkWb7A1OLt5lf2LQ11oL2LiixPHPHdFgfGDogxI46Mjnhbvb7pmUJ6/FT9X0txK528Mqo51+n3lDf5COpitLV/v5IGiER1WEV/8xAqKSw0rgI402gvl9a96dag/1gM0mhT+/wujQN/IHeNK1EnwDAYjP/bNErx7L+Uk/3z8B4S6iNdC1h2WdhUGzZ2A0KFbCZ1bqJ/ypQGXtvJpyEYjEyjmQOqR3KFJlKQNMdGUYZMYZg0hJ4Jm/PScKNJJTw19xuvZwLhUCtm5UCdj2nPqi+9AdQEexwI4I7CBP13SvbHauMOaXjahAidhF0xp8NvdhIO3ab45KKGTdYGK64LCXg/kJlhbjgyayhvMQ==;
 5:OdjlEdQsK8EmHFXT6AM7JSSf/iGPPFUBMWxKU5ppOkpp378x9C5ucTJ62WPG45VwrSlm1t/cl70RdfwTsi/Up8HIxr7GH9stfwifm8QIvp2RjyaKHk5nBLJ1I4B6K+Cw7+fRYAcmYihg9N15ypUM/8flTQsC6IrYN4B6ZeArjV4=;
 7:wNxb/AeNTVPUyu637Ylt5458OG/3dtztEU2N/bH+J134BsfQN0BNJcqdI9zZqv3YthucDK7JD3gpIhKMDJjH/npF3wCEArDPsXN0VbBZe8khBuFOlGfILyNzyaURgcucMPxiwRd0Sm78zf74u31D8A==
x-ms-office365-filtering-correlation-id: 3064967c-f6c9-4492-97dd-08d65c0fba45
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2257; 
x-ms-traffictypediagnostic: BN6PR1101MB2257:
x-microsoft-antispam-prvs: <BN6PR1101MB2257B84B64931A35F9D57CAEEDAA0@BN6PR1101MB2257.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2257; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2257; 
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(6512007)(54906003)(110136005)(7736002)(66066001)(99286004)(102836004)(6506007)(386003)(107886003)(25786009)(52116002)(186003)(26005)(72206003)(53936002)(478600001)(76176011)(4326008)(2501003)(36756003)(14454004)(305945005)(316002)(97736004)(5660300001)(486006)(86362001)(105586002)(6486002)(68736007)(8676002)(476003)(11346002)(8936002)(2616005)(2906002)(446003)(14444005)(6116002)(256004)(71190400001)(71200400001)(3846002)(81156014)(81166006)(106356001)(6436002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2257;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Bxu3+14LSntDZz0k6t0daaWC9CKppTHgvAezCLc8n6jMT8B9jnPD+cXLv1gQQkDj21L++8vgd83PU8Mj3rSLkiAaIg/ynoyZeZkzcLGD1EJpYNqTbgyX2fQnd4dQZsnyK9Vh9yucDn+bEiQVPb6nfQvG4YFKu3BFcAR2QAqTt3WXRPTGoipSqYdGkY67Fw6H32umwx0Kt/RwQHNHQ/+Z9/XdNeunM7SIelfPKA/fY24Qfu/WcRhocU4EHhSotXmKAQ081Ya6prr06/GrmgyCaL3oo+1G1tW8Ho3+nyVmM9YGGjVzVyXvWC20owx2RYMr9Nxum40SreZiqMr5rIrHJUgsj9z/D99zdFLrF0vARWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3064967c-f6c9-4492-97dd-08d65c0fba45
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 06:46:34.2194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2257
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_224647_869623_A5E27D41 
X-CRM114-Status: GOOD (  19.33  )
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
 drivers/gpio/gpio-sama5d2-piobu.c | 253 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 259 insertions(+)
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
