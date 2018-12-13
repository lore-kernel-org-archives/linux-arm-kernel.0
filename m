Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCEEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:52:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA102086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c25quPuJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="A5T86lNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA102086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jPunogYQXBABP8LNgL1k9RGJbVYKvWi+0BxCA5LnxaQ=; b=c25quPuJcp21MT
	koapasOhJPe/AsI3ea2CDuXlT0+/UkoLhE2NL9UJvmqwLr5/Vdgcq3byNQx0XuOPXYlEg1SI0uUoJ
	TfPRW6LX157QpG4QdFt0ldyEUvWRFLP2SYXpaYK143cLG+xGw61JAfaY//+zGqyQ51tbL96WV6Dq5
	ixfiIfVUn232kj3Fv9Ua2+8OeoWKwxvz+d5Ju8DyEkX+1s+1uyWIkaHMsaCUTyg5cDBrcGQo4NNwL
	J0heHD6IMjEoo8Rg5qvJ28LwtrqYW+jKMI9FIXIWsZp7Kyx3tv0a6SgBP8kjnwzNo2c2I3VOy1rBd
	5laB50u3IfT93F1e8tvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQTO-0008Ot-HF; Thu, 13 Dec 2018 12:52:14 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQRc-000617-8s
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:50:27 +0000
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; d="scan'208";a="24166674"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Dec 2018 05:50:09 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 13 Dec 2018 05:50:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGx4s/LDRaa5QeUMJ6ZlF/2JF6NivYXKwY3ZBvH/iYg=;
 b=A5T86lNa+3WGve5HLa80H/Jx+n5TT609jnNAE3TzYVU0Zrj8q6CgBwwBD34qDUMs4hAUd0/XhmmPKT2Yw0a38lzNo0Jqk0pN63nJNepBSZebllztCOvmKPCRolrz5Yl/GEdbJl81WOipcYN/lx92xGIpD9ob3xYsI50CM9AR5OQ=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:50:06 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:50:06 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH v4 6/6] ARM: dts: at91: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
Thread-Topic: [PATCH v4 6/6] ARM: dts: at91: sama5d2_xplained: Add proper
 regulator states for suspend-to-mem
Thread-Index: AQHUkuJfxvzi//GTI0mj/E3KBut4+A==
Date: Thu, 13 Dec 2018 12:50:06 +0000
Message-ID: <1544703110-27161-7-git-send-email-claudiu.beznea@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0519;
 6:GJ+buYP2DQq82O144aNuHCtJVcy4QBs64Z9Bz2YMZyNJwhrVg+NH1iB5sxB3jDDv+3KyIVavkiUkx8qurDTKoAIQe3gfZsEyepEEqoSZs6DrCUhp2hbqPs7qDdyceQ7hqfQHlgdolxDJfAfQTpWjh6XKtIh93qexYKNXfOQn2vnpJV1UCUCMrsmH8lDXwU1M1/Tagfr4kH+IZLagBI2r60LkS4W4mpH8N7p41BP1cFMm4jK7YlCoh7hE9U/gp7v0lllCeZE0ZVcOE1l/tpmhVRDCbbyX2WU3WJUQu5ViMgCEXf0qAdA4BmuVo3MnZs5+WyJAWf3Dur/vfR006zWi4S3HYp6CYm0x4unliwWMuusM7TUaxAWI5aK/kCvZrYmNbNnqqk7WQtnD6UDbN5ZTFONat4FFe76A8eCQ3g+Ocinl5WO67Vd0AtorHG9Nar8foy+cdHVaKtMd7Vt4q3ZFpQ==;
 5:vjFvQYMNvP3l3gotvmHHM0oc9Ymj4f9IXfbh9EUKn3Hw4SV9AUxFKGLDj0aJfqDPN/8tn7u14slg6Lnz358k4YLQJ7wcjwd9f+f49ToUMoBNZaVR1vqgjdvI9IfL9l/cFw2zTLC1a4K1M/9ezc3e6qh6KWXSBC1socz1BAuzBmM=;
 7:ZAhqA9Nsdk7xYbDq8/E20vgaL+yj7qyb7tjNPWctdeKB6wvlQK/UK3nvYtbSh/OUdFtNsHR5eYq57OKyB2vgtSrn7vOqFlnAtpzmbPP5dPRF5holbp31CQGUctK7mvLIp+Lu6fd1xF8JXxMJcb3sgA==
x-ms-office365-filtering-correlation-id: b61982b2-3f4e-43c6-3243-08d660f981f0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0519; 
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB0519135B12DF79EBE2DF716B87A00@BY2PR11MB0519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0519; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0519; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(316002)(5660300001)(305945005)(8936002)(97736004)(2501003)(102836004)(26005)(6436002)(36756003)(99286004)(476003)(68736007)(3846002)(386003)(6506007)(7736002)(14444005)(76176011)(52116002)(6486002)(106356001)(6116002)(186003)(4326008)(105586002)(6512007)(256004)(53936002)(15650500001)(81166006)(81156014)(8676002)(2906002)(66066001)(39060400002)(25786009)(2616005)(86362001)(486006)(446003)(6636002)(478600001)(54906003)(107886003)(110136005)(71200400001)(71190400001)(72206003)(11346002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0519;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gPwp5usTitosk/DM3khWdQQ5qa2LiSvrUCB9xFRFVbxmiotVGZpCbWhrmJu93gHmhM49zptGg3o680aWLHrAVjRjANo9DdUTi9gwhgAT7TG3Yj6/KHXikvFHjyNesIXdHjCPhRYSJ0VX3UMRM2X4kwPFEDhBKIFFQmHQ+8j5hx+b2l7E1UTHIxPoAXDLLXVedBrB7WeFpJ1uq0yFcAzEB8QS6v5SODyw/eP3Keu5zqewgmj12loxoIGAzfbuMKLK+gK97b13z+0uTaZMO1WFV1Py/kuq19/DYXVEhJdc9q5XM4H8TIG6c/s9c2qbObro
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b61982b2-3f4e-43c6-3243-08d660f981f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:50:06.7013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_045024_490625_4686EE7D 
X-CRM114-Status: GOOD (  10.95  )
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

When entering suspend-to-mem, all PMIC outputs are disabled except
VDDIODDR which is put in power saving mode, and whose voltage is
increased (probably to counter the poor accuracy of power saving mode).

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea@microchip.com: use regulator-changeable-in-suspend,
 regulator-suspend-max-microvolt, regulator-suspend-max-microvolt,
 use macros for regulators' states, add regulator-inital-state]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 54 +++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 518e2b095ccf..438e6576cf7c 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -47,6 +47,7 @@
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
 
 / {
 	model = "Atmel SAMA5D2 Xplained";
@@ -181,49 +182,102 @@
 							regulator-name = "VDD_1V35";
 							regulator-min-microvolt = <1350000>;
 							regulator-max-microvolt = <1350000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-on-in-suspend;
+								regulator-suspend-min-microvolt=<1400000>;
+								regulator-suspend-max-microvolt=<1400000>;
+								regulator-changeable-in-suspend;
+								regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							};
 						};
 
 						vdd_1v2_reg: REG_DCDC2 {
 							regulator-name = "VDD_1V2";
 							regulator-min-microvolt = <1100000>;
 							regulator-max-microvolt = <1300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_reg: REG_DCDC3 {
 							regulator-name = "VDD_3V3";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_fuse_reg: REG_LDO1 {
 							regulator-name = "VDD_FUSE";
 							regulator-min-microvolt = <2500000>;
 							regulator-max-microvolt = <2500000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_lp_reg: REG_LDO2 {
 							regulator-name = "VDD_3V3_LP";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_led_reg: REG_LDO3 {
 							regulator-name = "VDD_LED";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_sdhc_1v8_reg: REG_LDO4 {
 							regulator-name = "VDD_SDHC_1V8";
 							regulator-min-microvolt = <1800000>;
 							regulator-max-microvolt = <1800000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 					};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
