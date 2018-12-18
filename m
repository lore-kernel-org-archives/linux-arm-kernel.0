Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:23:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB88121871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xnc3l5Xj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qhN0K28B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB88121871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XA2+IOL45aAJWEoO5G+0Z3Tjao1FKlI638umGL1ffTU=; b=Xnc3l5XjiNFYun
	8FGDqIIcicAU4MNZQD1KsfdLfnqKHoucDW4xLYvDqy1Xs9z+uiHkLoTqZdUnvi9njpq/Ek4NLSKS2
	s0s8cNMx3elFe9VnB0/EpBgC0qe0GkGHfldc7HnorL4//toyr2fCw1Cc7lEdJUDrqD9EerHWJPBcP
	K+YWILQvXddhbpzx5yed6jG++eOFxDsKX8bVIwTYVpCWD+M7lr2dbr1mVpfbK4DkCpZoc7fq495nE
	z4YX2D+wdYFabpiam5vKfW5juQ9Oz4Gzl1ofxw+I1U/iN0Vf8y+z6evkhBRh1Ucsv+sI6pyj+qJU2
	64WjECERwm67V0+iJTMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHDk-0004Pd-IV; Tue, 18 Dec 2018 15:23:44 +0000
Received: from mail-eopbgr130070.outbound.protection.outlook.com
 ([40.107.13.70] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHDN-0003pt-Uc
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:23:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hM18H5xiKgfRioz+/zhEM8eAYYGNlsLzemc8QxXd7I=;
 b=qhN0K28Bc/sQeZuVDgDsa2VnDkmnNsyRssjU6EXlEePxxOmF4ffJJ1lpxktygWmCCkWGYnNLRgVgwyKXLnUaVNvPMAvH9nSa2OsjmgQi8GLI6p/0ptaiJR2sbepffjHishSlVwihFFnGymLFezCWkkgRnpin2vBg/kYvxasohAk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4819.eurprd04.prod.outlook.com (20.176.215.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 15:22:58 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 15:22:58 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH 2/2] pinctrl: imx: add imx8qm driver
Thread-Topic: [PATCH 2/2] pinctrl: imx: add imx8qm driver
Thread-Index: AQHUluWOxRnk6Ztp2UyX2PHcy5fSFw==
Date: Tue, 18 Dec 2018 15:22:58 +0000
Message-ID: <1545146239-30993-3-git-send-email-aisheng.dong@nxp.com>
References: <1545146239-30993-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545146239-30993-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4819;
 6:jfze6Yh9IAfFmYfQcTVYcKbRuVarO3CMt7J50Yzi1lQc43fNYPWQCLd92KbHEAbVMRvsDt1JjUqRMrv8knP200/tmSNn9ZOlBycvJVj1fKIwKyT9s2WyktdO2Y1mZ7aSkQWPlIPMl4H6HNdafUrHjW8FtskNKPpes4BrsnqNESpe4lf/viUCIuawl5c0PiabCdVL7s1gN9/FEDYRyYGVbvSPhDf0drr2A+JOtQEhHdm2hjow6fg5jZIXtWepSk3zzcrH3WnKGFcgdUauORWy7UsBb1reLe0n6I90negxGQRxE06wl2oAhDgkiPyylZho6tGV+fUaD8Hz6koBROpS+Xk9OPv7kP7BOVxtx7H1sOD569cyXU5zAcOhpyQx2EZZe2X5D3XIuqM2slbM/bFAkkKRg5fD4X1j2/e8FQ5OMH1Bw4g4kyt3X596SZbWN/ATItss7NgloFpjA6G/gY31ng==;
 5:7gWWhfZECIiKYaPkphvy8W8hAzmPcwXzHT65TDbjxzK4FgJ2YcsCvAL4E2IqQ2L6T7GYmo2bJgnW6XulAfN4hbAO8jcALVh9QwkT1JAf2VTT53ui2ow2MdE8fSvYY6AusVR9Z0UxaeKPtTxku3IG2V1HcTt8ixUDNLPcxt9Ejq8=;
 7:M/wR63HUamqeu6ZN8CYgU5hSmyTUdzjUGofrAHatUHSXpfzyNz2vysT/Mo6ZbX/9KSLhGYWq8YwWsGRcVlB0h+5omSP50bAGlgpDTTOofqE/B4sYj2E0J38nGe5JNMJeYEE9SJu2P8vriJtZY/QY+w==
x-ms-office365-filtering-correlation-id: cc5652e8-3b29-4525-aafa-08d664fcb0ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4819; 
x-ms-traffictypediagnostic: AM0PR04MB4819:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB4819C3F957FEB553351DABB380BD0@AM0PR04MB4819.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4819; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4819; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(81156014)(105586002)(81166006)(86362001)(6512007)(26005)(53936002)(2351001)(6116002)(8676002)(50226002)(97736004)(575784001)(3846002)(54906003)(316002)(36756003)(486006)(2906002)(6916009)(476003)(5640700003)(68736007)(8936002)(446003)(44832011)(11346002)(2616005)(5660300001)(4744004)(71200400001)(14444005)(14454004)(25786009)(478600001)(52116002)(2501003)(76176011)(305945005)(99286004)(66066001)(6436002)(102836004)(4326008)(386003)(71190400001)(6506007)(256004)(186003)(6486002)(106356001)(39060400002)(7736002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4819;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tXSUCSBiUK3Ai68+emIcrGhHFoegRamQloxw/LqmO+em4FK2Hvm1gZQBVn387nJjvGcGjcpPNlDsd5hjHPY+V79/3Te+0iBszCLbEyD6+x1rqoqVG4M8j1oqvsEFeVYXpGN5XS7bhebRCEfhH1VGudUqPpmFqngoCDq2AllclYlHjr6QTBxZmviACFITl6gCklZenx2KeG8e9CLy0uGyql21T6wwcbXkLfHSrDtE1zQEA4iSNRXtNXTTIhB6dDBu2OXvDYizvDts+iv8tJdPDkXj6du8gASeUhETMKtiUY8fcF6jko+qLr5ilpokPXxi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5652e8-3b29-4525-aafa-08d664fcb0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 15:22:58.6241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072321_995345_6D36B0C9 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "dongas86@gmail.com" <dongas86@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "stefan@agner.ch" <stefan@agner.ch>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MX8QM contains a system controller that is responsible for controlling
the pad setting of the IPs that are present. Communication between the
host processor running an OS and the system controller happens through
a SCU protocol. This patch adds the SCU based MX8QM pinctrl driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/pinctrl/freescale/Kconfig          |   7 +
 drivers/pinctrl/freescale/Makefile         |   1 +
 drivers/pinctrl/freescale/pinctrl-imx8qm.c | 326 +++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8qm.c

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index f7d3579..da19f8a 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -128,6 +128,13 @@ config PINCTRL_IMX8MQ
 	help
 	  Say Y here to enable the imx8mq pinctrl driver
 
+config PINCTRL_IMX8QM
+	bool "IMX8QM pinctrl driver"
+	depends on ARCH_MXC && ARM64
+	select PINCTRL_IMX_SCU
+	help
+	  Say Y here to enable the imx8qm pinctrl driver
+
 config PINCTRL_IMX8QXP
 	bool "IMX8QXP pinctrl driver"
 	depends on ARCH_MXC && ARM64
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index 6ee398a..a6783f25 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PINCTRL_IMX6UL)	+= pinctrl-imx6ul.o
 obj-$(CONFIG_PINCTRL_IMX7D)	+= pinctrl-imx7d.o
 obj-$(CONFIG_PINCTRL_IMX7ULP)	+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8MQ)	+= pinctrl-imx8mq.o
+obj-$(CONFIG_PINCTRL_IMX8QM)	+= pinctrl-imx8qm.o
 obj-$(CONFIG_PINCTRL_IMX8QXP)	+= pinctrl-imx8qxp.o
 obj-$(CONFIG_PINCTRL_VF610)	+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8qm.c b/drivers/pinctrl/freescale/pinctrl-imx8qm.c
new file mode 100644
index 0000000..0b6029b
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-imx8qm.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/pinctrl/pads-imx8qm.h>
+#include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-imx.h"
+
+static const struct pinctrl_pin_desc imx8qm_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(IMX8QM_SIM0_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_SIM0_RST),
+	IMX_PINCTRL_PIN(IMX8QM_SIM0_IO),
+	IMX_PINCTRL_PIN(IMX8QM_SIM0_PD),
+	IMX_PINCTRL_PIN(IMX8QM_SIM0_POWER_EN),
+	IMX_PINCTRL_PIN(IMX8QM_SIM0_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_SIM),
+	IMX_PINCTRL_PIN(IMX8QM_M40_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_M40_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_M40_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_M40_GPIO0_01),
+	IMX_PINCTRL_PIN(IMX8QM_M41_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_M41_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_M41_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_M41_GPIO0_01),
+	IMX_PINCTRL_PIN(IMX8QM_GPT0_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_GPT0_CAPTURE),
+	IMX_PINCTRL_PIN(IMX8QM_GPT0_COMPARE),
+	IMX_PINCTRL_PIN(IMX8QM_GPT1_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_GPT1_CAPTURE),
+	IMX_PINCTRL_PIN(IMX8QM_GPT1_COMPARE),
+	IMX_PINCTRL_PIN(IMX8QM_UART0_RX),
+	IMX_PINCTRL_PIN(IMX8QM_UART0_TX),
+	IMX_PINCTRL_PIN(IMX8QM_UART0_RTS_B),
+	IMX_PINCTRL_PIN(IMX8QM_UART0_CTS_B),
+	IMX_PINCTRL_PIN(IMX8QM_UART1_TX),
+	IMX_PINCTRL_PIN(IMX8QM_UART1_RX),
+	IMX_PINCTRL_PIN(IMX8QM_UART1_RTS_B),
+	IMX_PINCTRL_PIN(IMX8QM_UART1_CTS_B),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOLH),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_PMIC_MEMC_ON),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_WDOG_OUT),
+	IMX_PINCTRL_PIN(IMX8QM_PMIC_I2C_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_PMIC_I2C_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_PMIC_EARLY_WARNING),
+	IMX_PINCTRL_PIN(IMX8QM_PMIC_INT_B),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_01),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_02),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_03),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_04),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_05),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_06),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_GPIO0_07),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_BOOT_MODE0),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_BOOT_MODE1),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_BOOT_MODE2),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_BOOT_MODE3),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_BOOT_MODE4),
+	IMX_PINCTRL_PIN(IMX8QM_SCU_BOOT_MODE5),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS0_GPIO00),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS0_GPIO01),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS0_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS0_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS0_I2C1_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS0_I2C1_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS1_GPIO00),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS1_GPIO01),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS1_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS1_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS1_I2C1_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_LVDS1_I2C1_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_LVDSGPIO),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI0_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI0_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI0_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI0_GPIO0_01),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI1_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI1_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI1_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_DSI1_GPIO0_01),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_MIPIDSIGPIO),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI0_MCLK_OUT),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI0_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI0_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI0_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI0_GPIO0_01),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI1_MCLK_OUT),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI1_GPIO0_00),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI1_GPIO0_01),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI1_I2C0_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_MIPI_CSI1_I2C0_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_HDMI_TX0_TS_SCL),
+	IMX_PINCTRL_PIN(IMX8QM_HDMI_TX0_TS_SDA),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_3V3_HDMIGPIO),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_FSR),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_FST),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_SCKR),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_SCKT),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_TX0),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_TX1),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_TX2_RX3),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_TX3_RX2),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_TX4_RX1),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI1_TX5_RX0),
+	IMX_PINCTRL_PIN(IMX8QM_SPDIF0_RX),
+	IMX_PINCTRL_PIN(IMX8QM_SPDIF0_TX),
+	IMX_PINCTRL_PIN(IMX8QM_SPDIF0_EXT_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_SPI3_SCK),
+	IMX_PINCTRL_PIN(IMX8QM_SPI3_SDO),
+	IMX_PINCTRL_PIN(IMX8QM_SPI3_SDI),
+	IMX_PINCTRL_PIN(IMX8QM_SPI3_CS0),
+	IMX_PINCTRL_PIN(IMX8QM_SPI3_CS1),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIORHB),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_FSR),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_FST),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_SCKR),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_SCKT),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_TX0),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_TX1),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_TX2_RX3),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_TX3_RX2),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_TX4_RX1),
+	IMX_PINCTRL_PIN(IMX8QM_ESAI0_TX5_RX0),
+	IMX_PINCTRL_PIN(IMX8QM_MCLK_IN0),
+	IMX_PINCTRL_PIN(IMX8QM_MCLK_OUT0),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIORHC),
+	IMX_PINCTRL_PIN(IMX8QM_SPI0_SCK),
+	IMX_PINCTRL_PIN(IMX8QM_SPI0_SDO),
+	IMX_PINCTRL_PIN(IMX8QM_SPI0_SDI),
+	IMX_PINCTRL_PIN(IMX8QM_SPI0_CS0),
+	IMX_PINCTRL_PIN(IMX8QM_SPI0_CS1),
+	IMX_PINCTRL_PIN(IMX8QM_SPI2_SCK),
+	IMX_PINCTRL_PIN(IMX8QM_SPI2_SDO),
+	IMX_PINCTRL_PIN(IMX8QM_SPI2_SDI),
+	IMX_PINCTRL_PIN(IMX8QM_SPI2_CS0),
+	IMX_PINCTRL_PIN(IMX8QM_SPI2_CS1),
+	IMX_PINCTRL_PIN(IMX8QM_SAI1_RXC),
+	IMX_PINCTRL_PIN(IMX8QM_SAI1_RXD),
+	IMX_PINCTRL_PIN(IMX8QM_SAI1_RXFS),
+	IMX_PINCTRL_PIN(IMX8QM_SAI1_TXC),
+	IMX_PINCTRL_PIN(IMX8QM_SAI1_TXD),
+	IMX_PINCTRL_PIN(IMX8QM_SAI1_TXFS),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIORHT),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN7),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN6),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN5),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN4),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN3),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN2),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN1),
+	IMX_PINCTRL_PIN(IMX8QM_ADC_IN0),
+	IMX_PINCTRL_PIN(IMX8QM_MLB_SIG),
+	IMX_PINCTRL_PIN(IMX8QM_MLB_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_MLB_DATA),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOLHT),
+	IMX_PINCTRL_PIN(IMX8QM_FLEXCAN0_RX),
+	IMX_PINCTRL_PIN(IMX8QM_FLEXCAN0_TX),
+	IMX_PINCTRL_PIN(IMX8QM_FLEXCAN1_RX),
+	IMX_PINCTRL_PIN(IMX8QM_FLEXCAN1_TX),
+	IMX_PINCTRL_PIN(IMX8QM_FLEXCAN2_RX),
+	IMX_PINCTRL_PIN(IMX8QM_FLEXCAN2_TX),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOTHR),
+	IMX_PINCTRL_PIN(IMX8QM_USB_SS3_TC0),
+	IMX_PINCTRL_PIN(IMX8QM_USB_SS3_TC1),
+	IMX_PINCTRL_PIN(IMX8QM_USB_SS3_TC2),
+	IMX_PINCTRL_PIN(IMX8QM_USB_SS3_TC3),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_3V3_USB3IO),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_RESET_B),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_VSELECT),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_RESET_B),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_VSELECT),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_WP),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_CD_B),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_VSELSEP),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_MDIO),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_MDC),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_REFCLK_125M_25M),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_REFCLK_125M_25M),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_MDIO),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_MDC),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOCT),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_SS0_B),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_SS1_B),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_SCLK),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_DQS),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_DATA3),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_DATA2),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_DATA1),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI1A_DATA0),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_QSPI1),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_DATA0),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_DATA1),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_DATA2),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_DATA3),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_DQS),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_SS0_B),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_SS1_B),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0A_SCLK),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_SCLK),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_DATA0),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_DATA1),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_DATA2),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_DATA3),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_DQS),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_SS0_B),
+	IMX_PINCTRL_PIN(IMX8QM_QSPI0B_SS1_B),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_QSPI0),
+	IMX_PINCTRL_PIN(IMX8QM_PCIE_CTRL0_CLKREQ_B),
+	IMX_PINCTRL_PIN(IMX8QM_PCIE_CTRL0_WAKE_B),
+	IMX_PINCTRL_PIN(IMX8QM_PCIE_CTRL0_PERST_B),
+	IMX_PINCTRL_PIN(IMX8QM_PCIE_CTRL1_CLKREQ_B),
+	IMX_PINCTRL_PIN(IMX8QM_PCIE_CTRL1_WAKE_B),
+	IMX_PINCTRL_PIN(IMX8QM_PCIE_CTRL1_PERST_B),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_PCIESEP),
+	IMX_PINCTRL_PIN(IMX8QM_USB_HSIC0_DATA),
+	IMX_PINCTRL_PIN(IMX8QM_USB_HSIC0_STROBE),
+	IMX_PINCTRL_PIN(IMX8QM_CALIBRATION_0_HSIC),
+	IMX_PINCTRL_PIN(IMX8QM_CALIBRATION_1_HSIC),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_CMD),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA0),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA1),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA2),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA3),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA4),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA5),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA6),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_DATA7),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_STROBE),
+	IMX_PINCTRL_PIN(IMX8QM_EMMC0_RESET_B),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_SD1FIX),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_CMD),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA0),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA1),
+	IMX_PINCTRL_PIN(IMX8QM_CTL_NAND_RE_P_N),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA2),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA3),
+	IMX_PINCTRL_PIN(IMX8QM_CTL_NAND_DQS_P_N),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA4),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA5),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA6),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_DATA7),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC1_STROBE),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_VSEL2),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_CLK),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_CMD),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_DATA0),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_DATA1),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_DATA2),
+	IMX_PINCTRL_PIN(IMX8QM_USDHC2_DATA3),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_VSEL3),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_TXC),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_TX_CTL),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_TXD0),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_TXD1),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_TXD2),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_TXD3),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_RXC),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_RX_CTL),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_RXD0),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_RXD1),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_RXD2),
+	IMX_PINCTRL_PIN(IMX8QM_ENET0_RGMII_RXD3),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_TXC),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_TX_CTL),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_TXD0),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_TXD1),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_TXD2),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_TXD3),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_RXC),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_RX_CTL),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_RXD0),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_RXD1),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_RXD2),
+	IMX_PINCTRL_PIN(IMX8QM_ENET1_RGMII_RXD3),
+	IMX_PINCTRL_PIN(IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA),
+};
+
+static const struct imx_pinctrl_soc_info imx8qm_pinctrl_info = {
+	.pins = imx8qm_pinctrl_pads,
+	.npins = ARRAY_SIZE(imx8qm_pinctrl_pads),
+	.flags = IMX_USE_SCU,
+};
+
+static const struct of_device_id imx8qm_pinctrl_of_match[] = {
+	{ .compatible = "fsl,imx8qm-iomuxc", },
+	{ /* sentinel */ }
+};
+
+static int imx8qm_pinctrl_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = imx_pinctrl_sc_ipc_init(pdev);
+	if (ret)
+		return ret;
+
+	return imx_pinctrl_probe(pdev, &imx8qm_pinctrl_info);
+}
+
+static struct platform_driver imx8qm_pinctrl_driver = {
+	.driver = {
+		.name = "imx8qm-pinctrl",
+		.of_match_table = of_match_ptr(imx8qm_pinctrl_of_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = imx8qm_pinctrl_probe,
+};
+
+static int __init imx8qm_pinctrl_init(void)
+{
+	return platform_driver_register(&imx8qm_pinctrl_driver);
+}
+arch_initcall(imx8qm_pinctrl_init);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
