Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E11AC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D964208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tG/WgJmo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dnkNnegH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D964208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jPunogYQXBABP8LNgL1k9RGJbVYKvWi+0BxCA5LnxaQ=; b=tG/WgJmovmL9dk
	8JiY8fpPAZJKeHxSf5v+fcHe7nBbmQr7GVaDOWeRdIeY3O4uZht3O8ynOBtPW+W2jIF7gWgphDW1N
	RpBBDJPzBKKrzyTQdOHBUKC7BG46eggjBdRxauqFudXqcBvnkN74vOwFaImZX5lxHQrzsZU3nqK00
	NMU9Nk+PIb3noSx7u/d+ayxWOpCSA4AbUOk+WNQI7vMP6QojmkXuIT+DReSLhpDukPxEZC2i1bTui
	3iW6nGFZ50CUBzxWBnN4Q35FhgzR8SZgPsJ1290X8aYbTZ+es89gK8CPvxgV49jkGMw+4G4JpFfay
	qt+TfaSdgP+H2aNl/MOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkQW-0006s6-4k; Tue, 11 Dec 2018 15:58:28 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkP9-0005c7-Kz
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:57:05 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="24239888"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 08:56:57 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 11 Dec 2018 08:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGx4s/LDRaa5QeUMJ6ZlF/2JF6NivYXKwY3ZBvH/iYg=;
 b=dnkNnegHzXGWPamlbP4Aldv6r/7NTOek6N0YQWSlH67f1ksHaE6qUsFLC8CZgbFgFV1CyWT/SuXCSTsac75WVt4cueZbY76jaiOKul+d9IppTEuG+Rvu2p2gfkFIQdbIySTP8mZNb/5+xpGNsZWYHrgaS0UpE4rDhVAqknItATs=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 15:56:55 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:55 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
Subject: [PATCH v3 5/6] ARM: dts: at91: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
Thread-Topic: [PATCH v3 5/6] ARM: dts: at91: sama5d2_xplained: Add proper
 regulator states for suspend-to-mem
Thread-Index: AQHUkWojNt33A1ZmaEmet4DeQfrHFQ==
Date: Tue, 11 Dec 2018 15:56:54 +0000
Message-ID: <1544543768-2066-6-git-send-email-claudiu.beznea@microchip.com>
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
 6:D0OVWm0i7TnhlQJJ8DCMKw+HV/5EyNMYNXHiLBIigttOSngYMCbyik78gTQMHmgN/zhRPYa5cRbSYBLo8PymtP6G8fBQe5hx/8aRxFVoUZqwuBi+BLXkXlDbyDTrwoWgbhSv2Dhm6uVFuGOpqEOfprvWeuoucBgk1lQoLKG/JpjuGXwnqNkv0+jgLtKQdNr9cLAZ26ZtAYM+hHJqHOhyMYbtgWdreQlKn7HIQfEOx1VEs0SyzSupuJnMSJWo+4euxSwQJv0bIGAqlWJQvxInbnljSK3g/IngNZI1zWaKLtjr6wfZ5gn0z6sZkK//PBhnybuydvGuZyxjrmp0zPwK3SZt7pzUubBS0/jYUMxLC/34SzDmnMZbSnJDNAGExvJgPMORQwCl+GYYXAxnowb9wjGPmkVxvjeFSgg/SctQKx6Hs6rkbbQqgESuwMIQjMm1inP+2bh7RBokEa41xDFByg==;
 5:3SU8STKYYUz9iLRnPRWN+6KEqHMsavZ8woMkYEfeXAPhn9eZ17gJ+H4YQCP2Lso5AzpbsbHNcz82zeBchJ2z9+hlCGsLr9J9DHchV2gVpfQRltlUaAb7Q32qnYYXVqjtcA5ZS9TsXx6Op9rkggRvYybRiM7UjP5gKaDXTAz2bBE=;
 7:Z//cDQVIKkQ5xuQz4OfMmSWbys7pw/dggUz3KbROH2+gnkq+i3EiIu3we4koieKkUJAAMjrdy3gJZeFU8H9voZyL++XSShYNLGsi2m8wBfpg/itT7ThtYALE59ujUNWrB2EFDgduYXeS6AnHSOAo2Q==
x-ms-office365-filtering-correlation-id: 8b8d3ee0-1bb8-4bd2-78d9-08d65f8145c5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0792; 
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB0792D42B3DCE43843584516D87A60@BY2PR11MB0792.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0792; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0792; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(476003)(14454004)(39060400002)(68736007)(53936002)(72206003)(478600001)(316002)(106356001)(110136005)(305945005)(86362001)(107886003)(7736002)(2906002)(4326008)(102836004)(486006)(15650500001)(81166006)(99286004)(8936002)(25786009)(186003)(3846002)(66066001)(26005)(8676002)(76176011)(71190400001)(71200400001)(6506007)(52116002)(386003)(6116002)(2501003)(81156014)(6512007)(5660300001)(97736004)(2616005)(6486002)(446003)(11346002)(6436002)(14444005)(105586002)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0792;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NGQnd60+hzZkCm/JLJMCsQuGUzDjZBUiZ3JH2Wm6fKKXD+w7Sz6PVIh687CewJqOj8+74jwFFKMm1UrsiDdVJqIxwlpA6TGCcIi9YQEjhQG3zggix76bDLNMvF0Tu+OalQY2ifxK/JuDrh93xQjm7XKwEHUREc99f1IhM8hOnRlQuSLGRzaw/AtwmGpzDmBAvVKsAvUYRGdwGggWzY3qplRJwvKOPsJlXZODonMR7SXS0mYQ+ASmpyQFx0y4PT/aTJ9ys/D1pOe6UsiSsB0hrMczb5p8JICRbN7qZq/lAsQGd7MChunQHp12DqUgfXs4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8d3ee0-1bb8-4bd2-78d9-08d65f8145c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:54.8686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_075703_887854_42601E0B 
X-CRM114-Status: GOOD (  10.90  )
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
