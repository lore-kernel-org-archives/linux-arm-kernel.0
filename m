Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A24C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D072081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f/2oyyjQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CCpT9rv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D072081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4HDDXzGUF/lbOoDRcLHZgQgGcqko14o/hYQalalPUgE=; b=f/2oyyjQoTfvOa
	nGh0X3L9wYXEi6PItp2Io3nat3mb1SBj8thTZBgXsdkjMBR/dr2PhNooNYMiHrg339tJx8hPhJKTO
	1n+wFcUruN7d1DxbVFQoTMWTTTauazXACiX2mrBrSDDojYdWIYcLvBTCMVjEQDo59khMiqODUEJ3I
	6SeKqCfmazMGaiP74CzJoeHg/1SXF8dac3pPCYhNkxFMkEeQ8BabZziIeKN5ub/pvToU4XyZeRNcC
	MFklDLOlIT3BQDVTQ0BVDt4uAnA/D1QsRrPh/5Ye2vOM7KeB2P1bqKX4X8nlQGHQ+PwsJZR2N4hgj
	zdjDhXj8IlRlL269v5rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWezy-000769-GG; Tue, 11 Dec 2018 10:10:42 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeym-0004WU-SO
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:09:38 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="24073267"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 03:09:17 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 03:09:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQZjE20IDnmXXt73/jZcsBxEhKYoFeYu/0JcvUi/UiY=;
 b=CCpT9rv41rRHnRavfeCA2ssxFe3jKuppA2jrU06vTxa731KstRWI1A+CDc66Ay4Tqb8/lbPH7z42YTICC0VhVkFxLJV08f2PSNj3XEuiaY7Uy6HZmMsHaEPBzKkVMb1M1d2vaO9VU/k/rhWDDoyr8K13bmw2w0/9k4xGLapFM1k=
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com (10.174.105.17) by
 DM5PR1101MB2123.namprd11.prod.outlook.com (10.174.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 10:09:15 +0000
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb]) by DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 10:09:15 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
 <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
Thread-Topic: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Thread-Index: AQHUkTmSRQO8vdR2CEWafmmGWx4+QQ==
Date: Tue, 11 Dec 2018 10:09:15 +0000
Message-ID: <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To DM5PR1101MB2249.namprd11.prod.outlook.com
 (2603:10b6:4:52::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR1101MB2123;
 6:H2W4qjb6HMZ5WPWnHxnuIPM9235of9Y3VTwPnclncMFRBuT6fHxGpNYmUnHTFpdCgvFY621jxTrnVCNFRLrfND/OyWlpUdqBiPbQsaNrGzT9XSe9Wv9xEeCsyv9BLOcI4T+qW67TyWh1PeNz2QNzb5uXq8u0TkQ5oIo6QLWIbB8dQVI21bpbdyAxSSWy7MIfnntP2/WEgyCge7mcP2r/kWqcU4q9AEuIgaqlUfeleg/BzeFLaKaOGrOzgYTLfGqB5v8F6i9CqTTjg77Z/t7KN2l0DGH7TskW2tmOeCyTgOyNRh2RR2BVf5RmhTm6gTp5b01b7gS3vU0E1+d+Ot3sggelH5cOsbk1/o9WjS5ULIrPo23rNfjoQJoT8xUeq5bB4nLW5PaZiJ7YyYnXoYIVSaQqfAcfO9iTEm8/4Jwqs5jEfD1DRCVpLAGfNSIj9aKGQp/fHU4QeVGly4mSow82fw==;
 5:3vqCQ6uqRcgbdAuMG+8BZZSy4lhzsHqSN1XgYLfavc67M05hgbIlOpVH46grtXm/4hor4S2woEwuJE5sO1UiibnEGEf5nzl+03yCivc/x1CJspGXIFXrB7b7IJM5XAilhJR+1Du2+PrwEH+QAy4OU9rz6iI+UlDHaB7sqP2qJ7M=;
 7:A0Awqn/lXclXmmw/JTcZmyb10P6ail5flhYmGZykKF51v3yPzUdI+6vFACuO1vhUZ2mb7QH9w6brW/emZGQNh5Sc26GWb3AdIjforqlTvsAf0wbk5x/4nyDBpVFIpU5T120sZgmDyDhSmwsL7TPW0A==
x-ms-office365-filtering-correlation-id: 6e317771-d3d4-442b-2bbc-08d65f50b4a1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR1101MB2123; 
x-ms-traffictypediagnostic: DM5PR1101MB2123:
x-microsoft-antispam-prvs: <DM5PR1101MB2123388292B70B3017D72247EDA60@DM5PR1101MB2123.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DM5PR1101MB2123; BCL:0; PCL:0; RULEID:; SRVR:DM5PR1101MB2123; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(45074003)(256004)(14444005)(217873002)(486006)(97736004)(446003)(2906002)(81166006)(2501003)(8676002)(81156014)(11346002)(8936002)(71200400001)(4744004)(71190400001)(86362001)(68736007)(575784001)(72206003)(25786009)(36756003)(6512007)(2201001)(53946003)(7736002)(53936002)(478600001)(6486002)(14454004)(316002)(54906003)(3846002)(76176011)(110136005)(66066001)(107886003)(106356001)(105586002)(305945005)(39060400002)(99286004)(2616005)(476003)(102836004)(5660300001)(386003)(6116002)(6436002)(186003)(6506007)(4326008)(52116002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1101MB2123;
 H:DM5PR1101MB2249.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sk8+o2xWnd/s+rmjoHrx3e/Fvbiq4q1AG6GCmo8wglNqrlywL5TSQWoCiTsRzu/vRPMs+M7inao2mSwrkD1lY9rt6gcV4r6TGqa0cq0pWPZMAPcmLMQBgxvKhLe9/ySo8k9AH+GkJ3QqlagPKMvd+eavQ2RB3p9QwzvIuG1eNkXzi0LJG2PnIAtAwPAWoNu+llJzB7/BuI7zowxmvvLItoPSrUWZn8M1a5bzEhbBlkYq3C/Qqn9LcLMgVO7W8JBAlKmgV+888p1sI+ca6dWMSiX/LNYnWFzEF3AoAXH5e2TRRz5Iz50af9WRcWE+4UAh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e317771-d3d4-442b-2bbc-08d65f50b4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 10:09:15.5220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2123
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_020929_831374_43EAB998 
X-CRM114-Status: GOOD (  24.03  )
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
 linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds a regulator driver for the MCP16502 PMIC.
This drivers supports basic operations through the
regulator interface such as:
- setting/reading voltage
- setting/reading operating mode
- reading current status
- transitioning to/from suspend-to-ram and standby
  power states

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/Kconfig    |   9 +
 drivers/regulator/Makefile   |   1 +
 drivers/regulator/mcp16502.c | 555 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 565 insertions(+)
 create mode 100644 drivers/regulator/mcp16502.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 926cee0..719d9d6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -567,6 +567,15 @@ config REGULATOR_MC13892
 	  Say y here to support the regulators found on the Freescale MC13892
 	  PMIC.
 
+config REGULATOR_MCP16502
+	tristate "Microchip MCP16502 PMIC"
+	depends on I2C && OF
+	help
+	  Say y here to support the MCP16502 PMIC. This driver supports
+	  basic operations (get/set voltage, get/set operating mode)
+	  through the regulator interface. In addition it enables
+	  suspend-to-ram/standby transition.
+
 config REGULATOR_MT6311
 	tristate "MediaTek MT6311 PMIC"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 72488ef..b12e1c9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_REGULATOR_MAX77802) += max77802-regulator.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
+obj-$(CONFIG_REGULATOR_MCP16502) += mcp16502.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
new file mode 100644
index 0000000..54db3df
--- /dev/null
+++ b/drivers/regulator/mcp16502.c
@@ -0,0 +1,555 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * MCP16502 PMIC driver
+ *
+ * Copyright (C) 2018 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Andrei Stefanescu <andrei.stefanescu@microchip.com>
+ *
+ * Inspired from tps65086-regulator.c
+ */
+
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/suspend.h>
+
+#define VDD_LOW_SEL 0x0D
+#define VDD_HIGH_SEL 0x3F
+
+#define MCP16502_FLT BIT(7)
+#define MCP16502_ENS BIT(0)
+
+/*
+ *
+ * The PMIC has four sets of registers corresponding to four power modes:
+ * Performance, Active, Low-power, Hibernate.
+ *
+ * Registers:
+ * Each regulator has a register for each power mode. To access a register
+ * for a specific regulator and mode BASE_* and OFFSET_* need to be added.
+ *
+ * Operating modes:
+ * In order for the PMIC to transition to operating modes it has to be
+ * controlled via GPIO lines called LPM and HPM.
+ *
+ * The registers are fully configurable such that you can put all regulators in
+ * a low-power state while the PMIC is in Active mode. They are supposed to be
+ * configured at startup and then simply transition to/from a global low-power
+ * state by setting the GPIO lpm pin high/low.
+ *
+ * This driver keeps the PMIC in Active mode, Low-power state is set for the
+ * regulators by enabling/disabling operating mode (FPWM or Auto PFM).
+ *
+ * The PMIC's Low-power and Hibernate modes are used during standby/suspend.
+ * To enter standby/suspend the PMIC will go to Low-power mode. From there, it
+ * will transition to Hibernate when the PWRHLD line is set to low by the MPU.
+ */
+
+/*
+ * This function is useful for iterating over all regulators and accessing their
+ * registers in a generic way or accessing a regulator device by its id.
+ */
+#define MCP16502_BASE(i) (((i) + 1) << 4)
+#define MCP16502_STAT_BASE(i) ((i) + 5)
+
+#define MCP16502_OFFSET_MODE_A 0
+#define MCP16502_OFFSET_MODE_LPM 1
+#define MCP16502_OFFSET_MODE_HIB 2
+
+#define MCP16502_OPMODE_ACTIVE REGULATOR_MODE_NORMAL
+#define MCP16502_OPMODE_LPM REGULATOR_MODE_IDLE
+#define MCP16502_OPMODE_HIB REGULATOR_MODE_STANDBY
+
+#define MCP16502_MODE_AUTO_PFM 0
+#define MCP16502_MODE_FPWM BIT(6)
+
+#define MCP16502_VSEL 0x3F
+#define MCP16502_EN BIT(7)
+#define MCP16502_MODE BIT(6)
+
+#define MCP16502_MIN_REG 0x0
+#define MCP16502_MAX_REG 0x65
+
+static unsigned int mcp16502_of_map_mode(unsigned int mode)
+{
+	if (mode == REGULATOR_MODE_NORMAL || mode == REGULATOR_MODE_IDLE)
+		return mode;
+
+	return REGULATOR_MODE_INVALID;
+}
+
+#define MCP16502_REGULATOR(_name, _id, _ranges, _ops)			\
+	[_id] = {							\
+		.name			= _name,			\
+		.regulators_node	= of_match_ptr("regulators"),	\
+		.id			= _id,				\
+		.ops			= &(_ops),			\
+		.type			= REGULATOR_VOLTAGE,		\
+		.owner			= THIS_MODULE,			\
+		.linear_ranges		= _ranges,			\
+		.n_linear_ranges	= ARRAY_SIZE(_ranges),		\
+		.of_match		= of_match_ptr(_name),		\
+		.of_map_mode		= mcp16502_of_map_mode,		\
+		.vsel_reg		= (((_id) + 1) << 4),		\
+		.vsel_mask		= MCP16502_VSEL,		\
+		.enable_reg		= (((_id) + 1) << 4),		\
+		.enable_mask		= MCP16502_EN,			\
+	}
+
+enum {
+	BUCK1 = 0,
+	BUCK2,
+	BUCK3,
+	BUCK4,
+	LDO1,
+	LDO2,
+	NUM_REGULATORS
+};
+
+/*
+ * struct mcp16502 - PMIC representation
+ * @rdev: the regulators belonging to this chip
+ * @rmap: regmap to be used for I2C communication
+ * @lpm: LPM GPIO descriptor
+ */
+struct mcp16502 {
+	struct regulator_dev *rdev[NUM_REGULATORS];
+	struct regmap *rmap;
+	struct gpio_desc *lpm;
+};
+
+/*
+ * mcp16502_gpio_set_mode() - set the GPIO corresponding value
+ *
+ * Used to prepare transitioning into hibernate or resuming from it.
+ */
+static void mcp16502_gpio_set_mode(struct mcp16502 *mcp, int mode)
+{
+	switch (mode) {
+	case MCP16502_OPMODE_ACTIVE:
+		gpiod_set_value(mcp->lpm, 0);
+		break;
+	case MCP16502_OPMODE_LPM:
+	case MCP16502_OPMODE_HIB:
+		gpiod_set_value(mcp->lpm, 1);
+		break;
+	default:
+		pr_err("%s: %d invalid\n", __func__, mode);
+	}
+}
+
+/*
+ * mcp16502_get_reg() - get the PMIC's configuration register for opmode
+ *
+ * @rdev: the regulator whose register we are searching
+ * @opmode: the PMIC's operating mode ACTIVE, Low-power, Hibernate
+ */
+static int mcp16502_get_reg(struct regulator_dev *rdev, int opmode)
+{
+	int reg = MCP16502_BASE(rdev_get_id(rdev));
+
+	switch (opmode) {
+	case MCP16502_OPMODE_ACTIVE:
+		return reg + MCP16502_OFFSET_MODE_A;
+	case MCP16502_OPMODE_LPM:
+		return reg + MCP16502_OFFSET_MODE_LPM;
+	case MCP16502_OPMODE_HIB:
+		return reg + MCP16502_OFFSET_MODE_HIB;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * mcp16502_get_mode() - return the current operating mode of a regulator
+ *
+ * Note: all functions that are not part of entering/exiting standby/suspend
+ *	 use the Active mode registers.
+ *
+ * Note: this is different from the PMIC's operatig mode, it is the
+ *	 MODE bit from the regulator's register.
+ */
+static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret, reg;
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+
+	reg = mcp16502_get_reg(rdev, MCP16502_OPMODE_ACTIVE);
+	if (reg < 0)
+		return reg;
+
+	ret = regmap_read(mcp->rmap, reg, &val);
+	if (ret)
+		return ret;
+
+	switch (val & MCP16502_MODE) {
+	case MCP16502_MODE_FPWM:
+		return REGULATOR_MODE_NORMAL;
+	case MCP16502_MODE_AUTO_PFM:
+		return REGULATOR_MODE_IDLE;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+/*
+ * _mcp16502_set_mode() - helper for set_mode and set_suspend_mode
+ *
+ * @rdev: the regulator for which we are setting the mode
+ * @mode: the regulator's mode (the one from MODE bit)
+ * @opmode: the PMIC's operating mode: Active/Low-power/Hibernate
+ */
+static int _mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode,
+			      unsigned int op_mode)
+{
+	int val;
+	int reg;
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+
+	reg = mcp16502_get_reg(rdev, op_mode);
+	if (reg < 0)
+		return reg;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = MCP16502_MODE_FPWM;
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = MCP16502_MODE_AUTO_PFM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = regmap_update_bits(mcp->rmap, reg, MCP16502_MODE, val);
+	return reg;
+}
+
+/*
+ * mcp16502_set_mode() - regulator_ops set_mode
+ */
+static int mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	return _mcp16502_set_mode(rdev, mode, MCP16502_OPMODE_ACTIVE);
+}
+
+/*
+ * mcp16502_get_status() - regulator_ops get_status
+ */
+static int mcp16502_get_status(struct regulator_dev *rdev)
+{
+	int ret;
+	unsigned int val;
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(mcp->rmap, MCP16502_STAT_BASE(rdev_get_id(rdev)),
+			  &val);
+	if (ret)
+		return ret;
+
+	if (val & MCP16502_FLT)
+		return REGULATOR_STATUS_ERROR;
+	else if (val & MCP16502_ENS)
+		return REGULATOR_STATUS_ON;
+	else if (!(val & MCP16502_ENS))
+		return REGULATOR_STATUS_OFF;
+
+	return REGULATOR_STATUS_UNDEFINED;
+}
+
+#ifdef CONFIG_SUSPEND
+/*
+ * mcp16502_suspend_get_target_reg() - get the reg of the target suspend PMIC
+ *				       mode
+ */
+static int mcp16502_suspend_get_target_reg(struct regulator_dev *rdev)
+{
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_STANDBY:
+		return mcp16502_get_reg(rdev, MCP16502_OPMODE_LPM);
+	case PM_SUSPEND_ON:
+	case PM_SUSPEND_MEM:
+		return mcp16502_get_reg(rdev, MCP16502_OPMODE_HIB);
+	default:
+		dev_err(&rdev->dev, "invalid suspend target: %d\n",
+			pm_suspend_target_state);
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * mcp16502_set_suspend_voltage() - regulator_ops set_suspend_voltage
+ */
+static int mcp16502_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+	int sel = regulator_map_voltage_linear_range(rdev, uV, uV);
+	int reg = mcp16502_suspend_get_target_reg(rdev);
+
+	if (sel < 0)
+		return sel;
+
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(mcp->rmap, reg, MCP16502_VSEL, sel);
+}
+
+/*
+ * mcp16502_set_suspend_mode() - regulator_ops set_suspend_mode
+ */
+static int mcp16502_set_suspend_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_STANDBY:
+		return _mcp16502_set_mode(rdev, mode, MCP16502_OPMODE_LPM);
+	case PM_SUSPEND_ON:
+	case PM_SUSPEND_MEM:
+		return _mcp16502_set_mode(rdev, mode, MCP16502_OPMODE_HIB);
+	default:
+		dev_err(&rdev->dev, "invalid suspend target: %d\n",
+			pm_suspend_target_state);
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * mcp16502_set_suspend_enable() - regulator_ops set_suspend_enable
+ */
+static int mcp16502_set_suspend_enable(struct regulator_dev *rdev)
+{
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+	int reg = mcp16502_suspend_get_target_reg(rdev);
+
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, MCP16502_EN);
+}
+
+/*
+ * mcp16502_set_suspend_disable() - regulator_ops set_suspend_disable
+ */
+static int mcp16502_set_suspend_disable(struct regulator_dev *rdev)
+{
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+	int reg = mcp16502_suspend_get_target_reg(rdev);
+
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, 0);
+}
+#endif /* CONFIG_SUSPEND */
+
+static const struct regulator_ops mcp16502_buck_ops = {
+	.list_voltage			= regulator_list_voltage_linear_range,
+	.map_voltage			= regulator_map_voltage_linear_range,
+	.get_voltage_sel		= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel		= regulator_set_voltage_sel_regmap,
+	.enable				= regulator_enable_regmap,
+	.disable			= regulator_disable_regmap,
+	.is_enabled			= regulator_is_enabled_regmap,
+	.get_status			= mcp16502_get_status,
+
+	.set_mode			= mcp16502_set_mode,
+	.get_mode			= mcp16502_get_mode,
+
+#ifdef CONFIG_SUSPEND
+	.set_suspend_voltage		= mcp16502_set_suspend_voltage,
+	.set_suspend_mode		= mcp16502_set_suspend_mode,
+	.set_suspend_enable		= mcp16502_set_suspend_enable,
+	.set_suspend_disable		= mcp16502_set_suspend_disable,
+#endif /* CONFIG_SUSPEND */
+};
+
+/*
+ * LDOs cannot change operating modes.
+ */
+static const struct regulator_ops mcp16502_ldo_ops = {
+	.list_voltage			= regulator_list_voltage_linear_range,
+	.map_voltage			= regulator_map_voltage_linear_range,
+	.get_voltage_sel		= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel		= regulator_set_voltage_sel_regmap,
+	.enable				= regulator_enable_regmap,
+	.disable			= regulator_disable_regmap,
+	.is_enabled			= regulator_is_enabled_regmap,
+	.get_status			= mcp16502_get_status,
+
+#ifdef CONFIG_SUSPEND
+	.set_suspend_voltage		= mcp16502_set_suspend_voltage,
+	.set_suspend_enable		= mcp16502_set_suspend_enable,
+	.set_suspend_disable		= mcp16502_set_suspend_disable,
+#endif /* CONFIG_SUSPEND */
+};
+
+static const struct of_device_id mcp16502_ids[] = {
+	{ .compatible = "microchip,mcp16502", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mcp16502_ids);
+
+static const struct regulator_linear_range b1l12_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, VDD_LOW_SEL, VDD_HIGH_SEL, 50000),
+};
+
+static const struct regulator_linear_range b234_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, VDD_LOW_SEL, VDD_HIGH_SEL, 25000),
+};
+
+static const struct regulator_desc mcp16502_desc[] = {
+	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops) */
+	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops),
+	MCP16502_REGULATOR("LDO2", LDO2, b1l12_ranges, mcp16502_ldo_ops)
+};
+
+static const struct regmap_range mcp16502_ranges[] = {
+	regmap_reg_range(MCP16502_MIN_REG, MCP16502_MAX_REG)
+};
+
+static const struct regmap_access_table mcp16502_yes_reg_table = {
+	.yes_ranges = mcp16502_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp16502_ranges),
+};
+
+static const struct regmap_config mcp16502_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MCP16502_MAX_REG,
+	.cache_type	= REGCACHE_NONE,
+	.rd_table	= &mcp16502_yes_reg_table,
+	.wr_table	= &mcp16502_yes_reg_table,
+};
+
+/*
+ * set_up_regulators() - initialize all regulators
+ */
+static int setup_regulators(struct mcp16502 *mcp, struct device *dev,
+			    struct regulator_config config)
+{
+	int i;
+
+	for (i = 0; i < NUM_REGULATORS; i++) {
+		mcp->rdev[i] = devm_regulator_register(dev,
+						       &mcp16502_desc[i],
+						       &config);
+		if (IS_ERR(mcp->rdev[i])) {
+			dev_err(dev,
+				"failed to register %s regulator %ld\n",
+				mcp16502_desc[i].name, PTR_ERR(mcp->rdev[i]));
+			return PTR_ERR(mcp->rdev[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int mcp16502_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct regulator_config config = { };
+	struct device *dev;
+	struct mcp16502 *mcp;
+	int ret = 0;
+
+	dev = &client->dev;
+	config.dev = dev;
+
+	mcp = devm_kzalloc(dev, sizeof(*mcp), GFP_KERNEL);
+	if (!mcp)
+		return -ENOMEM;
+
+	mcp->rmap = devm_regmap_init_i2c(client, &mcp16502_regmap_config);
+	if (IS_ERR(mcp->rmap)) {
+		ret = PTR_ERR(mcp->rmap);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, mcp);
+	config.regmap = mcp->rmap;
+	config.driver_data = mcp;
+
+	mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
+	if (IS_ERR(mcp->lpm)) {
+		dev_err(dev, "failed to get lpm pin: %ld\n", PTR_ERR(mcp->lpm));
+		return PTR_ERR(mcp->lpm);
+	}
+
+	ret = setup_regulators(mcp, dev, config);
+	if (ret != 0)
+		return ret;
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
+
+	return 0;
+}
+
+#ifdef CONFIG_SUSPEND
+static int mcp16502_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp16502 *mcp = i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM);
+
+	return 0;
+}
+
+static int mcp16502_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp16502 *mcp = i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
+
+	return 0;
+}
+#else /* !CONFIG_SUSPEND */
+#define mcp16502_suspend NULL
+#define mcp16502_resume NULL
+#endif /* !CONFIG_SUSPEND */
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops mcp16502_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend, mcp16502_resume)
+};
+#endif
+static const struct i2c_device_id mcp16502_i2c_id[] = {
+	{ "mcp16502", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp16502_i2c_id);
+
+static struct i2c_driver mcp16502_drv = {
+	.probe		= mcp16502_probe,
+	.driver		= {
+		.name	= "mcp16502-regulator",
+		.of_match_table	= of_match_ptr(mcp16502_ids),
+#ifdef CONFIG_PM
+		.pm = &mcp16502_pm_ops,
+#endif
+	},
+	.id_table	= mcp16502_i2c_id,
+};
+
+module_i2c_driver(mcp16502_drv);
+
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MCP16502 PMIC driver");
+MODULE_AUTHOR("Andrei Stefanescu andrei.stefanescu@microchip.com");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
