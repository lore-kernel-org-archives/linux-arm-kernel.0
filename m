Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E41C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB57A21104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jb4jyKsi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PaK5CUfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB57A21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9yCZEln1qXjlLo8D/bjXeTRU4jXH50o+jHbH0egnKpM=; b=jb4jyKsiQc2LDO
	mio6swmwBrJXhe1mp99/g/P0wTVEVPozNpkcwISgwP8Bbw9YtnmWlKkk8hQgEHOfd38ru9A2+mreG
	8+ct4dv0Ts+L3clS2tNVhN+63XPLmMHabcl1uWpiSF9oCBhOLFBVZdvF5e0s2TrdjSnSNmRvMmGpC
	nuX4O5Dexpbp6dVfBUyZQuUXd3emMmzNFr8CeKqE+9zTFr7T05cAOplKotBDrnnNG+usUeL/ljQs2
	j57bVbdVYFbjpFmRvfY+pfb26OBXxgsOeMWx17UzQpNSpAJLKNNmtpW20ITQkABI/ikijlvL/fZM1
	QLcCGE0qdKss7aM2Bskg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkPP-0005xo-OR; Tue, 11 Dec 2018 15:57:19 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkP1-0005U9-MO
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:57:03 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="21377046"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 11 Dec 2018 08:56:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 08:56:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMjS//5o5chhVNv5oD2mdk6g8h2JVhMs2bhRbOyql1Q=;
 b=PaK5CUfBZyE0bMR/N0IOjWfMTIcKabf7gF2oTP7ZmCEoCKdCP9Gp3WEl//v39LGd9ZJE7yMhaNPWCYMoT2XG1rxijcCKdEfQ8c1IEFfqXCyg2GDaYWfC1rcd5c/zy5NaYaPAajHdBOlE7luxWFpWG2QyYgW4Ol/LoIJ7q0qI324=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 15:56:41 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:41 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
Subject: [PATCH v3 2/6] regulator: act8945a-regulator: Implement PM
 functionalities
Thread-Topic: [PATCH v3 2/6] regulator: act8945a-regulator: Implement PM
 functionalities
Thread-Index: AQHUkWobKbo3Wb9xfkSttfEsuRPdCw==
Date: Tue, 11 Dec 2018 15:56:41 +0000
Message-ID: <1544543768-2066-3-git-send-email-claudiu.beznea@microchip.com>
References: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0792;
 6:SIfRWvly44EIT/NFl5M1j1sjU1iYkhIzR+Nn9ToE/+gYrwpM1wehAK06d9w0BjQ3g4lobWevs6QZzksqLj9evdyYfmCFmw2SL3+5OdYyvGf+CGPEx5/qF05ma1K3R9gqAAjAEpN4BkKjGKlJLBsaufOe9TWPxOc1O1apWT61Pxy5eizrmidMBu+9shr2JQXLT70lcWQFmM4Ezdf6rGMjzAq6lR0fQPigvfIddTRjrKWg7oPyZRqUjsiaxHF7636ys260YkPzHXdLtINpEBXIedeYsgT0ZUXeyAdmMKAnROU6ap8EcsIqlObrndlbfM1d3QwxGPvUuAScm2FqSgpH35ETImaCcfJq44t9ENtCf928NpAI35DPB6EH+A+iNo15NofFKJS8kym8+gAzLD1wQei/F9nLfCDNkxY36+5oxvYHQrskea2vv+0jQQlUtNm7rqLUm6s86SneYJBArrPuFg==;
 5:GwhdCAYkvcu8bNDs34OcahkFWXtrYZAbstYmTm8watbN7igbNrAPndvsNwFiWsWEgJAL6TGeobxjN4qNMX/WL9+8ORGCHFgucTRzDS0ccV0ff1Vgi/0B6GG958MaUjcu0z+p21gtbGXtwXpK9ahNltl1MyNmlwCbNcrCLNXEeB8=;
 7:0Xf9oRinBGcy0vfodN98FIHJiJxTqUnr1v8+3CfTKuiC/oWqXH0fqkpIDCqAiSfGV+J2sRNfU8s2w9vng512Qci2fLM1vN9/K9jGnhtOBl1DWJrbnH/cofzlMFU7WRoAF2lRiGBILgXUVWXj2vmd3g==
x-ms-office365-filtering-correlation-id: ac2f77d1-993d-47df-1f70-08d65f813daf
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0792; 
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB07929442EB325E27FB1314EA87A60@BY2PR11MB0792.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0792; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0792; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(476003)(14454004)(39060400002)(68736007)(53936002)(72206003)(478600001)(316002)(106356001)(110136005)(305945005)(86362001)(107886003)(7736002)(2906002)(4326008)(102836004)(486006)(81166006)(99286004)(8936002)(25786009)(186003)(3846002)(575784001)(66066001)(26005)(8676002)(76176011)(71190400001)(71200400001)(6506007)(52116002)(386003)(6116002)(2501003)(81156014)(6512007)(5660300001)(97736004)(2616005)(6486002)(446003)(11346002)(6436002)(14444005)(105586002)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0792;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gZU8vlXTzWtB0nl6gHYP0bvujO3BWCzN16uSjMmg4t36p2jQCctv7g8KLopS4jQxkZD9GFlMlLGEdMVfQqamleRizYJNZ0OHU3dBM100HaL0lXNU7yF8LQA84VfnWn+3pz2cAV9i2zUDsJGGl0NFHf7cmT6tad2LArEzwsRiwMKGxC08odiCXN+7PUCUebKEFF51KbyMv1v16n8OTaA2BxT5BK9fF6m8kIODIWOqg+kvQ4NKyFpjNTcs5SEHfoXQeNBc9xxFmeEPs1iBzGKbup1frXfgp7XcNdRXAjS7wNuPoa+qRycay2X/qw04kkS1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2f77d1-993d-47df-1f70-08d65f813daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:41.3794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_075656_168927_EA1B4A2A 
X-CRM114-Status: GOOD (  22.37  )
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
Cc: devicetree@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 boris.brezillon@bootlin.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

The regulator supports a dedicated suspend mode.
Implement the appropriate ->set_suspend_xx() hooks, add support for
->set_mode(), and provide basic PM ops functionalities to setup the
regulator in a suspend state when the system is entering suspend.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea@microchip.com: remove shutdown function, use dev_pm_ops,
 fix checkpatch warning, adapt commit message, add LDO modes support,
 move modes constants to active-semi,8945a-regulator.h, remove rdevs from
 struct act8945a_pmic, add op_mode to act8945a_pmic]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c             | 186 ++++++++++++++++++++-
 .../regulator/active-semi,8945a-regulator.h        |  30 ++++
 2 files changed, 211 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulator.h

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 8d71d9893d0d..f37d1a860407 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
 
 /**
  * ACT8945A Global Register Map.
@@ -28,20 +29,27 @@
 #define ACT8945A_DCDC1_VSET1	0x20
 #define ACT8945A_DCDC1_VSET2	0x21
 #define ACT8945A_DCDC1_CTRL	0x22
+#define ACT8945A_DCDC1_SUS	0x24
 #define ACT8945A_DCDC2_VSET1	0x30
 #define ACT8945A_DCDC2_VSET2	0x31
 #define ACT8945A_DCDC2_CTRL	0x32
+#define ACT8945A_DCDC2_SUS	0x34
 #define ACT8945A_DCDC3_VSET1	0x40
 #define ACT8945A_DCDC3_VSET2	0x41
 #define ACT8945A_DCDC3_CTRL	0x42
+#define ACT8945A_DCDC3_SUS	0x44
 #define ACT8945A_LDO1_VSET	0x50
 #define ACT8945A_LDO1_CTRL	0x51
+#define ACT8945A_LDO1_SUS	0x52
 #define ACT8945A_LDO2_VSET	0x54
 #define ACT8945A_LDO2_CTRL	0x55
+#define ACT8945A_LDO2_SUS	0x56
 #define ACT8945A_LDO3_VSET	0x60
 #define ACT8945A_LDO3_CTRL	0x61
+#define ACT8945A_LDO3_SUS	0x62
 #define ACT8945A_LDO4_VSET	0x64
 #define ACT8945A_LDO4_CTRL	0x65
+#define ACT8945A_LDO4_SUS	0x66
 
 /**
  * Field Definitions.
@@ -62,7 +70,12 @@ enum {
 	ACT8945A_ID_LDO2,
 	ACT8945A_ID_LDO3,
 	ACT8945A_ID_LDO4,
-	ACT8945A_REG_NUM,
+	ACT8945A_ID_MAX,
+};
+
+struct act8945a_pmic {
+	struct regmap *regmap;
+	u32 op_mode[ACT8945A_ID_MAX];
 };
 
 static const struct regulator_linear_range act8945a_voltage_ranges[] = {
@@ -71,6 +84,143 @@ static const struct regulator_linear_range act8945a_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(2400000, 48, 63, 100000),
 };
 
+static int act8945a_set_suspend_state(struct regulator_dev *rdev, bool enable)
+{
+	struct regmap *regmap = rdev->regmap;
+	int id = rdev->desc->id, reg, val;
+
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg = ACT8945A_DCDC1_SUS;
+		val = 0xa8;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg = ACT8945A_DCDC2_SUS;
+		val = 0xa8;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg = ACT8945A_DCDC3_SUS;
+		val = 0xa8;
+		break;
+	case ACT8945A_ID_LDO1:
+		reg = ACT8945A_LDO1_SUS;
+		val = 0xe8;
+		break;
+	case ACT8945A_ID_LDO2:
+		reg = ACT8945A_LDO2_SUS;
+		val = 0xe8;
+		break;
+	case ACT8945A_ID_LDO3:
+		reg = ACT8945A_LDO3_SUS;
+		val = 0xe8;
+		break;
+	case ACT8945A_ID_LDO4:
+		reg = ACT8945A_LDO4_SUS;
+		val = 0xe8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (enable)
+		val |= BIT(4);
+
+	/*
+	 * Ask the PMIC to enable/disable this output when entering hibernate
+	 * mode.
+	 */
+	return regmap_write(regmap, reg, val);
+}
+
+static int act8945a_set_suspend_enable(struct regulator_dev *rdev)
+{
+	return act8945a_set_suspend_state(rdev, true);
+}
+
+static int act8945a_set_suspend_disable(struct regulator_dev *rdev)
+{
+	return act8945a_set_suspend_state(rdev, false);
+}
+
+static unsigned int act8945a_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case ACT8945A_REGULATOR_MODE_FIXED:
+	case ACT8945A_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case ACT8945A_REGULATOR_MODE_LOWPOWER:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev->regmap;
+	int id = rdev->desc->id;
+	int reg, ret, val = 0;
+
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg = ACT8945A_DCDC1_CTRL;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg = ACT8945A_DCDC2_CTRL;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg = ACT8945A_DCDC3_CTRL;
+		break;
+	case ACT8945A_ID_LDO1:
+		reg = ACT8945A_LDO1_SUS;
+		break;
+	case ACT8945A_ID_LDO2:
+		reg = ACT8945A_LDO2_SUS;
+		break;
+	case ACT8945A_ID_LDO3:
+		reg = ACT8945A_LDO3_SUS;
+		break;
+	case ACT8945A_ID_LDO4:
+		reg = ACT8945A_LDO4_SUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		if (rdev->desc->id > ACT8945A_ID_DCDC3)
+			val = BIT(5);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		if (rdev->desc->id <= ACT8945A_ID_DCDC3)
+			val = BIT(5);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(regmap, reg, BIT(5), val);
+	if (ret)
+		return ret;
+
+	act8945a->op_mode[id] = mode;
+
+	return 0;
+}
+
+static unsigned int act8945a_get_mode(struct regulator_dev *rdev)
+{
+	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
+	int id = rdev->desc->id;
+
+	if (id < ACT8945A_ID_DCDC1 || id >= ACT8945A_ID_MAX)
+		return -EINVAL;
+
+	return act8945a->op_mode[id];
+}
+
 static const struct regulator_ops act8945a_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
@@ -78,7 +228,11 @@ static const struct regulator_ops act8945a_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
+	.set_mode		= act8945a_set_mode,
+	.get_mode		= act8945a_get_mode,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_enable	= act8945a_set_suspend_enable,
+	.set_suspend_disable	= act8945a_set_suspend_disable,
 };
 
 #define ACT89xx_REG(_name, _family, _id, _vsel_reg, _supply)		\
@@ -86,6 +240,7 @@ static const struct regulator_ops act8945a_ops = {
 		.name			= _name,			\
 		.supply_name		= _supply,			\
 		.of_match		= of_match_ptr("REG_"#_id),	\
+		.of_map_mode		= act8945a_of_map_mode,		\
 		.regulators_node	= of_match_ptr("regulators"),	\
 		.id			= _family##_ID_##_id,		\
 		.type			= REGULATOR_VOLTAGE,		\
@@ -124,13 +279,17 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 {
 	struct regulator_config config = { };
 	const struct regulator_desc *regulators;
+	struct act8945a_pmic *act8945a;
 	struct regulator_dev *rdev;
-	struct regmap *regmap;
 	int i, num_regulators;
 	bool voltage_select;
 
-	regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!regmap) {
+	act8945a = devm_kzalloc(&pdev->dev, sizeof(*act8945a), GFP_KERNEL);
+	if (!act8945a)
+		return -ENOMEM;
+
+	act8945a->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!act8945a->regmap) {
 		dev_err(&pdev->dev,
 			"could not retrieve regmap from parent device\n");
 		return -EINVAL;
@@ -149,6 +308,7 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 
 	config.dev = &pdev->dev;
 	config.dev->of_node = pdev->dev.parent->of_node;
+	config.driver_data = act8945a;
 	for (i = 0; i < num_regulators; i++) {
 		rdev = devm_regulator_register(&pdev->dev, &regulators[i], &config);
 		if (IS_ERR(rdev)) {
@@ -159,13 +319,29 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
+	platform_set_drvdata(pdev, act8945a);
+
 	/* Unlock expert registers. */
-	return regmap_write(regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
+	return regmap_write(act8945a->regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
 
+static int act8945a_suspend(struct device *pdev)
+{
+	struct act8945a_pmic *act8945a = dev_get_drvdata(pdev);
+
+	/*
+	 * Ask the PMIC to enter the suspend mode on the next PWRHLD
+	 * transition.
+	 */
+	return regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x42);
+}
+
+SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
+
 static struct platform_driver act8945a_pmic_driver = {
 	.driver = {
 		.name = "act8945a-regulator",
+		.pm = &act8945a_pm,
 	},
 	.probe = act8945a_pmic_probe,
 };
diff --git a/include/dt-bindings/regulator/active-semi,8945a-regulator.h b/include/dt-bindings/regulator/active-semi,8945a-regulator.h
new file mode 100644
index 000000000000..9bdba5e3141a
--- /dev/null
+++ b/include/dt-bindings/regulator/active-semi,8945a-regulator.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Microchip Technology, Inc. All rights reserved.
+ *
+ * Device Tree binding constants for the ACT8945A PMIC regulators
+ */
+
+#ifndef _DT_BINDINGS_REGULATOR_ACT8945A_H
+#define _DT_BINDINGS_REGULATOR_ACT8945A_H
+
+/*
+ * These constants should be used to specify regulator modes in device tree for
+ * ACT8945A regulators as follows:
+ * ACT8945A_REGULATOR_MODE_FIXED:	It is specific to DCDC regulators and it
+ *					specifies the usage of fixed-frequency
+ *					PWM.
+ *
+ * ACT8945A_REGULATOR_MODE_NORMAL:	It is specific to LDO regulators and it
+ *					specifies the usage of normal mode.
+ *
+ * ACT8945A_REGULATOR_MODE_LOWPOWER:	For DCDC and LDO regulators; it specify
+ *					the usage of proprietary power-saving
+ *					mode.
+ */
+
+#define ACT8945A_REGULATOR_MODE_FIXED		1
+#define ACT8945A_REGULATOR_MODE_NORMAL		2
+#define ACT8945A_REGULATOR_MODE_LOWPOWER	3
+
+#endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
