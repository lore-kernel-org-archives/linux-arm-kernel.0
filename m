Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CE7C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:53:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417292082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X/8eH4oE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NAE01EHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417292082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=477GYBPWS47HSKJuUNEAAtPEusV9zvop72tjfgkJE8s=; b=X/8eH4oE7QXgO+
	rjpDiqxZmRzYcMakQiS+T6kZuZ4fG5fgme5ap9s3duSWjConN7ks4XamO9V5Z72Eab5/pbjFviVjS
	5OCodzOXThsKeD6RWEfQC/XB/8Eqnzcl5Ts4hzgnWfWNyvNhTj+2yaHbOL475ZQ+y7dN2lb6cS176
	oLpAdhwg6/uDRZVPP/lvqtRHKGMvki/Afit8erj22cy1vE//gHqvxE7B4PNKGDM4hHgygV+9Qs8hf
	jPlOgEFQlC/uGJrE7qZgCVyPZh7kX9YoOERQw8xZhyu4AW1NXMULEWp/XvCHjCpH2kQf0b4Qj88eM
	xnLvyXl2y78RK5SH+qdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7Nw-0006eI-Ac; Tue, 04 Dec 2018 09:52:56 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7Nj-0006P8-AY
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:52:47 +0000
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; d="scan'208";a="23510446"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Dec 2018 02:52:31 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 4 Dec 2018 02:52:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQARGGPERA+BFGJTGmIpnnkpI4LwGtOI82OBUnPbT9o=;
 b=NAE01EHIbX5Bty2xVvltYBIzhxaQlqp8x/hOU9l9+bXMMyBLlHg7rP9GaGFQx+ohxn3MDc52yCBzp/eKB8nTTcMZLFtEl1t1cw7+LMlcCsW/Iz9UdvgqXCF9P+rfy4puDohCcBuj/2aB3RnGkE2EvEiaOyVg1H5iYDjYY77K/0Q=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2083.namprd11.prod.outlook.com (10.174.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:52:28 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:52:28 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <lgirdwood@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
 <Cristian.Birsan@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 1/3] regulator: dt-bindings: add MCP16502 regulator bindings
Thread-Topic: [PATCH v3 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Thread-Index: AQHUi7cREVr9mxrkH0+y0ZAga/unFg==
Date: Tue, 4 Dec 2018 09:52:28 +0000
Message-ID: <1543917126-32572-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2083;
 6:1QkLC4aDfYCJgZEkqF86TxTeX/Qaz89Em7ZRv7k7KYgIMtEyLQEXRLMSq9zitDgUIAeVQ9P+ghGfwh6zbvq5zgR3PVVciRShcC4QvvjgNnYz2xIOaNlokt79u6hy/W/qcSuymTGUmcJiHDh3UFaOOlOuaNsC0zhMesRcGFqMEElMJGRrYHlqx0SVBIc760LPfDAf+RPaUZTNk8bzDYGW/IKte6KOzWkfHUbE38gDVYE8QNu7VuSJ1xoQTfgHrXGT5vfulyD15UsY8KFtGnyT0JO8NU1gAzY8TFsuO7PALGKC6WF/J6BciPFPg+c8ZP6uqk3ywLbT8Jz4Dj2q7LFSEcpFT8nJJI/Ytz4MMFCxPsAL/Xmjk88MZpKQdOUq/nJuX6ppe4PPcIpbdMoOuw3RbKMN+iCySodOMzL6lxDIjNfFeuKUMMWICovxCMB2D4QqvCcERVQ78OTU3rrJLbaBFg==;
 5:/PixOTwE5l0DQWTdEDRuW3Na09DR7P5wFqaboef/aoMELHJdRwm7/dmmGURQkUtn6fYfkNIn0+demZGzNjH5/Dizu6wTw8cBlADG0yYtU0LRKI/fNAt+23wizW3/QgbwNDUnPRnKDSryLvNh8LhmjIMlXkbx7dFeRBpS9c41CXo=;
 7:PHxfdgh8j+lMAKOObuqfiVE9nsUG4hYTevlBjePS9T1rMMFyf7oiVtjvNnDSc1swXIa4ULME7ZbCzqZR/JIadBObho+UnyO0EU4cFutEx7BvixjnlXyWIhjeUZMntWb9PPa0Vgcm3+kCs2QQ/81Z2Q==
x-ms-office365-filtering-correlation-id: b3b4e8f6-2119-454b-b1a8-08d659ce336f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2083; 
x-ms-traffictypediagnostic: BN6PR1101MB2083:
x-microsoft-antispam-prvs: <BN6PR1101MB208374421592ED682233450AEDAF0@BN6PR1101MB2083.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2083; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2083; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(386003)(54906003)(478600001)(186003)(2501003)(72206003)(14454004)(446003)(110136005)(2616005)(107886003)(11346002)(316002)(26005)(102836004)(105586002)(106356001)(6506007)(4326008)(97736004)(39060400002)(36756003)(53936002)(68736007)(81166006)(7736002)(81156014)(6436002)(256004)(8936002)(8676002)(305945005)(6512007)(6636002)(66066001)(14444005)(86362001)(25786009)(2906002)(476003)(76176011)(486006)(6116002)(99286004)(6486002)(71200400001)(52116002)(5660300001)(71190400001)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2083;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kzbnIznuvQ13IrizGlnPDr9asnstx17yml85sx+B9oA1ec7k6GgLXWVyygxmadZh0heACgbKAA9ggIoF0IHsZedl1Se4kWujGBuYtUGktyaY6JD3eUC8jvcrLX7MRYTekzFTHfyUmC4ZYA2qjPa1z+Evf2I+bTUAD0zoVsUv9bnf6FzR3OLaUizPzt2Ded+vn3/QA/14/S0F6fWmmU/9HIjIm8enjAoAncS9wDS1tNr+wF+EV3xQvzUffbgw9RSwylfjEilmE6598GLO6KU1yVyKLcS+qCFwOH6oyj9pn+gA9tzz8Zju9dJBO0328Veh3xdYWdQlSSuUXBdJko+pmecmKJX5LTlZ76bQ2G7b080=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b4e8f6-2119-454b-b1a8-08d659ce336f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:52:28.3359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2083
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_015243_741817_2958699F 
X-CRM114-Status: GOOD (  13.19  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch describes the compatible and the device tree
bindings necessary for the MCP16502 PMIC.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
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
