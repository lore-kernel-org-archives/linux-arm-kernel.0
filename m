Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E947C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C858D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YEaTDnBO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3dga7ILP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C858D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xvt3pXn0h8P1wKjzW9QMprGtqCBFrlfFbhalZYhN7Qg=; b=YEaTDnBOz/x3tH
	GShC8o0QwwcRDXkQpyLxNdfAgYF8qoOx9G20WSAQ8ohoLkclq3hsYIvcfhGEiXjBnF9jUPVOLJ1qR
	MG/lJe2NzExKmvZM92u3r3bxJZQ+Gi8e4nv4smZrmhsUwLAWDK8jy55i9OJcBDoPURxX/3mgU1DvZ
	CqZ44mX0F1Y9XZp7+67gIAqaFUHT5wfs+2lNZ8TqWKm+rHspDqrDT3LjyMFNojQf1GQ5QR74MFhbt
	DrHXOyQ0sL0BqroYLmZ+e7G6nKMsElVha7z3rOZoHbfNTfwQqAjMtDR+IF9X0q6PDTIhJ5A9/2AD+
	m/419kx7PYALPaun2JPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQRx-000734-I0; Thu, 13 Dec 2018 12:50:45 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQRK-0005F1-2o
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:50:11 +0000
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; d="scan'208";a="24317955"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Dec 2018 05:49:54 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 13 Dec 2018 05:49:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VDelNaYoZi06blo7DOytcYmGylaIR9j15XgJ0pLicE=;
 b=3dga7ILPGrMYF+if4KkDgYPCjzTwpbabEdr1ZhM/k6IibNhEDDHTP3fryIKKF5sMF3erhjyIHDfzvo3RrQRm6QCeTfapzct85j12ci8TB+sCAF9kKPpT0pp0VV4ImprR67SzJEJlBz81sopC4A2u4T3KgdhQapX5fJ4TaqJEImU=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:49:51 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:49:51 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH v4 2/6] regulator: add documentation for regulator modes and
 suspend states
Thread-Topic: [PATCH v4 2/6] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUkuJW3a2QPjq8ykCtYQzHkUZEIg==
Date: Thu, 13 Dec 2018 12:49:51 +0000
Message-ID: <1544703110-27161-3-git-send-email-claudiu.beznea@microchip.com>
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
 6:jhnthA35DSfQvi+XGCO3Ar+QWgHbWKcJh1Lafav8EEisgYLnCrOw8ZYflCIL3Bacv0vHqyZjq0lRW7636+loeOgubqkQV+oZBiIbyAhKIqusAcPUUcFYcQ7KTMXLasWWSH8RDHxL357a0HIMtupFhIgO/Sv9yOG9zz482u02ngSdMf3To0clMZUT+YZpXTF/t9Wg4wAlEY35JEERGnstL0JAQR0jKbcBrViPjIvr+oaidfo8v/Jai0x0McgHCey84uxo0vlHxMLRj9FPdbqd0qaKdKqWyCstpeT9Y3ik6AAgV3AzgvhH0O218ED2aWWahZq0SmKbmMaVeZruOAB0YrmNpgJ+UNUcjEeFrnCp3HFA9GFK6y7wqpGOCvriUky0snBZx8r2xElE/MfiUMAvsTwS7YDlBGELtsz8zeYPVJ0YV3c5AnDxJShC8jAC3DE4LHS02vNQE59D5XKLEOOUpjKsP/q/AAgdk2CjBuANUWc=;
 5:0wMdUDILyvszBIbMVHUX/LSQPe5+BCNX5DSpHJ5OZ9QlrqYTUxcEPd2LQlWwAjAsQoZSrLZdT/9P8QvbB6rySG2wc+2b6l2UgP8tKn5Zwd/f5KTV/Xi6NIDzxsMFUlX6xfAaZTnkA4excAEFoJRHQ4N5/TA2cmKwXtLS5JXSltY=;
 7:mgN1SwIrIfDk8bpEkq5dV06ZsKyaekOKogBmaocs9zPBC10FUCnNFN7gRkJTtyDUYt/NEis3k65cB94LtKtFZRQNo2mHaMYc12SZ6Auvjm7OhIeLnY/xswTMu2VwvYdlGkqToFtXdPB3eUeMmajL9g==
x-ms-office365-filtering-correlation-id: 447fad87-7922-4904-7044-08d660f97914
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0519; 
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB05196456D0022DF070E70B7A87A00@BY2PR11MB0519.namprd11.prod.outlook.com>
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
x-microsoft-antispam-message-info: M2M5xLtntEhDYAhuZqJlWWEGIbjJhdGjC+hooS7oNmDexyx/3RZCuiyDeUG29FkkP3FgPLFlTxvScFpCyTupr0ZVVzrHaN++ObhvM9h5hgNcP2SX2LSTeBAbUoESBzXGT9eGE98o1HK+kHEIGqVPqMRhy4xdlzbkcjTJZ5emYqDKdibBNc0y420HEyAOUdpcjQOmIen3SqWxXfX4hVHwskSrqq7Zr1bU2NiSQOfZLA22r9nnthMnDkKjZk/kYaoL+YbH+7WcsPnfQcx22pBl+72NyTCtfWD4U31gREd5ISni+fImazwDjiNarffUSTwF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 447fad87-7922-4904-7044-08d660f97914
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:49:51.7172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_045006_686979_861319C4 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for regulator modes and suspend states.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
 .../regulator/active-semi,8945a-regulator.h        | 30 +++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
index ac955dea00d1..4017527619ab 100644
--- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
@@ -15,11 +15,17 @@ Optional input supply properties:
   - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
 
 Any standard regulator properties can be used to configure the single regulator.
+regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
+specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
+file.
 
 The valid names for regulators are:
 	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
 
 Example:
+
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
+
 	pmic@5b {
 		compatible = "active-semi,act8945a";
 		reg = <0x5b>;
@@ -32,6 +38,18 @@ Example:
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-min-microvolt=<1400000>;
+					regulator-suspend-max-microvolt=<1400000>;
+					regulator-changeable-in-suspend;
+					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				};
 			};
 
 			vdd_1v2_reg: REG_DCDC2 {
@@ -39,6 +57,14 @@ Example:
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_3v3_reg: REG_DCDC3 {
@@ -53,6 +79,14 @@ Example:
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_3v3_lp_reg: REG_LDO2 {
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
