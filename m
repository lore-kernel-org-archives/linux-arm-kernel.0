Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54ECC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2042081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H01JaqBv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="IXaYD8ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2042081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1SaBxmJ/f0qSuLi/Uhrz9Vhj7XgsYuXW/3ytmeyLq48=; b=H01JaqBv8snOza
	iU7n39Fjcl7qvDma5D1Nd5Uk/IoM0TQVKoYyOf0iYPE62FvDoDao5aZdLUTsr3P4rXeBsEX/eJjkY
	yYo8BJRUJxx2ePWs5sLMRygufdL2UnEim8DTAa2fklFsjRNvnlzlSkyksxgiHGHtYLxh50diXyHX3
	98D6WJCinffF4LPdTrrOrBHfNm4zs8lsYFLLqt5rJ9T6fO/hvWAGc+xuVhHk6IeSCaWkMAoBP63so
	KeDAuON2AqCKKlrodcc5GRaiyIZ1E1l1OZxvWsPLu2CgBDwQ8MGLDFncnygP+Okc1nvjRORNw7tXs
	GOsE7SHkEVaPALIScdJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWezi-0006bv-5r; Tue, 11 Dec 2018 10:10:26 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeyi-0004Tj-54
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:09:28 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="23778862"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 03:09:12 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 03:09:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bV3niSy8aMTGWJqCjlB8G3ytUtT6IMc2bC/oRnW5PY=;
 b=IXaYD8hoQVi+86nFNlFaTwudkOfqUYfBLleOyfUemod1Zk9+rKYrJWgh3JBzkh7Szb7w/ouW6BnWhaf5nR35nudKCywkgdDTyNZqhHi6YRbassSBpXSj3fHw9AP+hQpu87tkEsaVqUpmc/T63xVoYxOrNyMMN1FcSljs0rdo9UQ=
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com (10.174.105.17) by
 DM5PR1101MB2123.namprd11.prod.outlook.com (10.174.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 10:09:05 +0000
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb]) by DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 10:09:05 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
 <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH v3 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Topic: [RESEND PATCH v3 1/3] regulator: dt-bindings: add MCP16502
 regulator bindings
Thread-Index: AQHUkTmMh8+dfRu54EC/evEHdtHeLA==
Date: Tue, 11 Dec 2018 10:09:05 +0000
Message-ID: <1544522876-15967-2-git-send-email-andrei.stefanescu@microchip.com>
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
 6:de8WGinZXyuNjbvXFhNDFtt4DfyFw61AGmQCVp7dlHq8kxk+JncJYnTZtbXidFxBc0crHluhNHa+HoxDzcCHEGhsJB5SwgDZ6ON+mdgCRVilpW5nAQUkNhtMFVCD3ZfU3EODFJOdu85HRsw22W3c8E8YGJQCDR6sd/eU25thtMs3BmL3t6Gq1CB0dXf9taANUGrv1PkdUQlfK8QKWrLUT4K3iraX4HJ+d/ANrJct9+43EYMRgr9p+JYWjiCVpbMdxw3sUBn5cHsWf1g1ZFPBXaQ47V9qrPPjAyxG1wbVRy9kYD3urI5gTOAwVQtLqqciflUawNQBvB78JxDRqwHG++KEa5h07qJ9AFZtZ2II2QZC6qcmtfVFLBacyHmFnS09heDS9PJdEHu1jJ1qFuRiziPzf2k5ZyYfhu8oN+rgbPgB9x5MeSsB8VehMHzILMmNUrgEK9I4bI2gXg/vnd0+bQ==;
 5:viaeaqLP0fR3Lhj+PZGwJvHHjy8f4xjUXy734HOO0XZogBu72Ka+unZhATxfNHy0WxYPkfGSMpomSeeRfwz00ikzL2u4yj7I/Zm6qqAvLxbCXJCCyMiUdlcHetODT642HsMtDj3rRXeu64PqhuZZQHgJL2h/HmvBxqKuOKcZpaQ=;
 7:pQKneym5zuQuUDRg6i0MxYqz1HV85FbEs3r0jtVUUO0PzSvIDK33CQ+zQXuTagXpk+BIZDHoo/QFqlM4bYbUgPnfvnoXUv/83ridmv2R9aTButGf1Wvr8LcKUAbX40DjdEHGMRidPtvr+MYvk+bhdg==
x-ms-office365-filtering-correlation-id: 3ac0150d-1a05-4fca-d00c-08d65f50aebe
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR1101MB2123; 
x-ms-traffictypediagnostic: DM5PR1101MB2123:
x-microsoft-antispam-prvs: <DM5PR1101MB21239B3AD0667AEEF63BAB3AEDA60@DM5PR1101MB2123.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DM5PR1101MB2123; BCL:0; PCL:0; RULEID:; SRVR:DM5PR1101MB2123; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(256004)(14444005)(217873002)(486006)(97736004)(446003)(2906002)(81166006)(2501003)(8676002)(81156014)(11346002)(8936002)(71200400001)(71190400001)(86362001)(68736007)(72206003)(25786009)(36756003)(6512007)(2201001)(7736002)(53936002)(478600001)(6486002)(14454004)(316002)(54906003)(3846002)(76176011)(110136005)(66066001)(107886003)(106356001)(105586002)(305945005)(39060400002)(99286004)(2616005)(476003)(102836004)(5660300001)(386003)(6116002)(6436002)(186003)(6506007)(4326008)(52116002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1101MB2123;
 H:DM5PR1101MB2249.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R8Is6LNvpkixOk6bYQJGoZkgbDhxWX1Hh0vBQzwcuC32fLyrFKOIY44aUCXT3QRRTNhINXzOm3dv9csJCTDemSDDDPqxjb39AZZBEVx0dZTUbYXqvtmHpmxpIRup6haiAQ4Cy04QMP1MT+CZzwq7EFqk3JwVh6GJ9oXQqiWHKfeJQc873Y+VXrClzodCYqqRU+Pt28JAf1x3Di+tLOYVULKLhzrExAfee7C1A5vD7Nk6V/bRpQM2IkJQVyjRKpK3+nxdvz6KpdWwNYXaQc0bDVX4tCGOU1MWjhNrHaK8eBZdjenPHPljudB2YByd1+hL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac0150d-1a05-4fca-d00c-08d65f50aebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 10:09:05.6249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2123
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_020924_733278_3A18D445 
X-CRM114-Status: GOOD (  12.89  )
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

This patch describes the compatible and the device tree
bindings necessary for the MCP16502 PMIC.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/mcp16502-regulator.txt      | 143 +++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
new file mode 100644
index 0000000..b8f843f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -0,0 +1,143 @@
+MCP16502 PMIC
+
+Required properties:
+- compatible: "microchip,mcp16502"
+- reg: I2C slave address
+- lpm-gpios: GPIO for LPM pin. Note that this GPIO *must* remain high during
+	     suspend-to-ram, keeping the PMIC into HIBERNATE mode.
+- regulators: A node that houses a sub-node for each regulator within
+              the device. Each sub-node is identified using the node's
+              name. The content of each sub-node is defined by the
+              standard binding for regulators; see regulator.txt.
+
+Regualtors of MCP16502 PMIC:
+1) VDD_IO	- Buck (1.2 - 3.7 V)
+2) VDD_DDR	- Buck (0.6 - 1.85 V)
+3) VDD_CORE	- Buck (0.6 - 1.85 V)
+4) VDD_OTHER	- BUCK (0.6 - 1.85 V)
+5) LDO1		- LDO  (1.2 - 3.7 V)
+6) LDO2		- LDO  (1.2 - 3.7 V)
+
+Regulator modes:
+2 - FPWM: higher precision, higher consumption
+4 - AutoPFM: lower precision, lower consumption
+
+Each regulator is defined using the standard binding for regulators.
+
+Example:
+
+mcp16502@5b {
+	compatible = "microchip,mcp16502";
+	reg = <0x5b>;
+	status = "okay";
+	lpm-gpios = <&pioBU 7 GPIO_ACTIVE_HIGH>;
+
+	regulators {
+		VDD_IO {
+			regulator-name = "VDD_IO";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3700000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode = <4>;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		VDD_DDR {
+			regulator-name = "VDD_DDR";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1850000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode = <4>;
+			};
+
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		VDD_CORE {
+			regulator-name = "VDD_CORE";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1850000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode = <4>;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		VDD_OTHER {
+			regulator-name = "VDD_OTHER";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1850000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+				regulator-mode = <4>;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		LDO1 {
+			regulator-name = "LDO1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3700000>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+
+		LDO2 {
+			regulator-name = "LDO2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3700000>;
+			regulator-always-on;
+
+			regulator-state-standby {
+				regulator-on-in-suspend;
+			};
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+
+	};
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
