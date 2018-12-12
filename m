Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95531C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6118C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OsTjwlk3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oheJXys6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6118C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sWZRQVemzsgmAwJdUAdSsXGJFc+vogWxYwMYPcztljE=; b=OsTjwlk3wWLcY7
	9W9who/A5Y8NVu5tDQJEUB5QsgalGQepVP2kEXuz76crWLGrZX8RJ3ktUVYY8eepJxmJo3EyxUEsy
	LjkVkEJa5PDWfQiAm1tQ9JkcS38zbDakCkr6u9QZlgA6grAZh49q/Dg0ARiBmsQl+VOxVFYPUYZ9r
	Ir8F/mV7f24NkgAyHldGbESb9t3lr8vJh+hBcbE93zZi4gsGStIrxF76m6HY76G46YzaIwC4WM2Yh
	I18CdHVLQs9XBbphP0KxxOuJTCXhm76mo0ZiSNFgcmc36g9LHEtDHocBOkrDHiigSS3Kpmqdae76z
	9JlezP43MX2EVnSTIpLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWyez-0003NC-De; Wed, 12 Dec 2018 07:10:21 +0000
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWyem-0001tG-Bm
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:10:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqBdb8Da7EoWDj16WF75nT5KJ27Ouw+UaadQJEDz7kY=;
 b=oheJXys6O0TEhNkdZE4xtGgK1apH0uoa10/NJSlIU4dKi0Ac+dQKRyWyUpdKjfr5QT85tvwGsiqgEklE6wzlmTx25nPZm7wTntvV9fhJK09qcj+Z25gdCj/1x4Y0Dx9KSGYcWOAGhdzxRQVU6RgXre2mK3AmHH6dIKMqueqMpwk=
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com (10.167.125.20) by
 HE1PR0402MB2811.eurprd04.prod.outlook.com (10.175.29.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Wed, 12 Dec 2018 07:09:54 +0000
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668]) by HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:09:54 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, Leo
 Li <leoyang.li@nxp.com>
Subject: [PATCH 1/3] dts: arm64: fsl: lsch2: fix status field of serdes
 controlled devices
Thread-Topic: [PATCH 1/3] dts: arm64: fsl: lsch2: fix status field of serdes
 controlled devices
Thread-Index: AQHUkemu/BhHBLScV0Gg+FtG6GMfdg==
Date: Wed, 12 Dec 2018 07:09:54 +0000
Message-ID: <20181212123505.32415-2-pankaj.bansal@nxp.com>
References: <20181212123505.32415-1-pankaj.bansal@nxp.com>
In-Reply-To: <20181212123505.32415-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::11) To HE1PR0402MB3323.eurprd04.prod.outlook.com
 (2603:10a6:7:81::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0402MB2811;
 6:PaHIo+CO1Gcs1cqZLFJuwJQsUD8lXZJOb7qaB6zgm4IIu6sQVrrLzE3GqrN/4/PU6s+sIGiPvHEKErkMgc8RI8RotGOnS7nqF/JO4yMTh7fFrzTUBsdqYICHiB6kzdzTDXxe4juWLqlgLSREvU9suHWts4UA+qjTrbE+HqO8N/f352i6hjFkKUNYAQEFqOmoZfW21TZP+RCMW/BbpUTd8jqBVyIYlA2X9jOlLzTGlKILqr8x2YFOJ+I2vnqf/SwJOBxA/0qRWzJjQEBNb5ZDUZlqJupU6pHYKllSI7W6q+QN5o8eHUeflq+e4UDA0dar0GzZFPQFeR5MP5294OiifQwB5HyMUaxT1kJra1JsGXP1GTBshlydMul3YUhDn/l1aiHzB2KN5mB39ZOkXdqX69EhssgRSX7Z++DIpvdGZp8VIEz2TBgVbLjj3CwvPdci145Nk7GNHULGdfDS02Veeg==;
 5:GlNWuI++o5PE59HEKJhCD6KnVNGIMPJzZAv84a2/EfFJ9zyN7IR+oNV0tUvRbr8JxWSZy+nsKAeqrMS3jLiUnpRA/0Trzhwvzq35ApQTDa3yXy8h5WRg/rfsFsHGlgDQ/hn/zbmevlCQjgt4V8maJL3E0Pdt9/06FqJiARoXCTc=;
 7:TAXqqrApdTVVvz1P0mYEDclW4uFCj/4LJ0t3VWg6JWz3/cjOAgQNY83gbXSV+myOp+kUdRc2/hzabWVYXMeSXPCN1ym0fOHJh7v+M/oMq3YTiD8keuC2kXMJr8irJjL6rA0YfRDhb+Pl5kB7zckHKw==
x-ms-office365-filtering-correlation-id: 716277df-e900-43a1-d7e6-08d66000d126
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2811; 
x-ms-traffictypediagnostic: HE1PR0402MB2811:
x-microsoft-antispam-prvs: <HE1PR0402MB2811FE8FDAC150C5334AFBE6F1A70@HE1PR0402MB2811.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR0402MB2811; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2811; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(55236004)(446003)(2501003)(81166006)(7736002)(11346002)(305945005)(76176011)(14444005)(486006)(66066001)(8936002)(476003)(2616005)(5660300001)(44832011)(81156014)(8676002)(256004)(106356001)(25786009)(105586002)(97736004)(2906002)(52116002)(4326008)(966005)(6486002)(1076002)(6636002)(478600001)(6436002)(6116002)(3846002)(575784001)(99286004)(110136005)(6306002)(36756003)(316002)(14454004)(54906003)(386003)(6506007)(6512007)(186003)(102836004)(86362001)(26005)(71200400001)(71190400001)(53936002)(78486014)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2811;
 H:HE1PR0402MB3323.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iMNQF41TcJdBSK0skl4B5tbL7tdXZMD+ghFvkNAlb3WrjDLQ7+KmXDHPHrzeSXnTNnH8hWJ2f+U7Gve2AjLB9SzMRx6zzWJhnFfqCa+B3yTPgQ8DUkZNOzPH9hB7EaCiERVVqB6nvU3QDG3DDBnKQzNY3GGLq4HbhieklP88/rlKahJEqFQxDmZPAxAdAwHkpvjFurolGsFvxM6yF+HCAqxhpBpZ4iXG16pEPvRAreD+PUQL6Y4CzJdTM+aVMMrxnwmXUo0xGfVS3vgZN3LZy6Ao6hpyv/foEM+gMAd0U+o2m5V2/8QoNvc/CUw3xTgf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716277df-e900-43a1-d7e6-08d66000d126
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:09:54.8596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_231008_414504_82EC7A90 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch disables that devices that are controlled by serdes
(pcie, sata, ethernet macs) in SOC dtsi files and enables the
interfaces in board dts file.

Actually this practise should be followed for all the devices and
not for only serdes controlled devices.

refer https://elinux.org/Device_Tree_Linux#disabled_nodes

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 .../boot/dts/freescale/fsl-ls1043a-qds.dts   | 18 +++++++++++++
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts   | 17 +++++++++++++
 .../boot/dts/freescale/fsl-ls1043a.dtsi      |  1 +
 .../boot/dts/freescale/fsl-ls1046a-qds.dts   | 18 +++++++++++++
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts   | 24 ++++++++++++++++++
 .../boot/dts/freescale/fsl-ls1046a.dtsi      |  1 +
 .../dts/freescale/qoriq-fman3-0-10g-0.dtsi   |  1 +
 .../dts/freescale/qoriq-fman3-0-10g-1.dtsi   |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-0.dtsi    |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-1.dtsi    |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-2.dtsi    |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-3.dtsi    |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-4.dtsi    |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-5.dtsi    |  1 +
 14 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index dff3d648172e..384b21f8a606 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -65,6 +65,20 @@
 		compatible = "fsl,ls1043aqds-fpga", "fsl,fpga-qixis";
 		reg = <0x2 0x0 0x0000100>;
 	};
+
+	soc {
+		pcie@3400000 {
+			status = "okay";
+		};
+
+		pcie@3500000 {
+			status = "okay";
+		};
+
+		pcie@3600000 {
+			status = "okay";
+		};
+	};
 };
 
 &i2c0 {
@@ -147,4 +161,8 @@
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 #include "fsl-ls1043-post.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 17ca357e854f..50a744c3c428 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -25,6 +25,16 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	soc {
+		pcie@3500000 {
+			status = "okay";
+		};
+
+		pcie@3600000 {
+			status = "okay";
+		};
+	};
 };
 
 &i2c0 {
@@ -111,36 +121,43 @@
 	ethernet@e0000 {
 		phy-handle = <&qsgmii_phy1>;
 		phy-connection-type = "qsgmii";
+		status = "okay";
 	};
 
 	ethernet@e2000 {
 		phy-handle = <&qsgmii_phy2>;
 		phy-connection-type = "qsgmii";
+		status = "okay";
 	};
 
 	ethernet@e4000 {
 		phy-handle = <&rgmii_phy1>;
 		phy-connection-type = "rgmii-txid";
+		status = "okay";
 	};
 
 	ethernet@e6000 {
 		phy-handle = <&rgmii_phy2>;
 		phy-connection-type = "rgmii-txid";
+		status = "okay";
 	};
 
 	ethernet@e8000 {
 		phy-handle = <&qsgmii_phy3>;
 		phy-connection-type = "qsgmii";
+		status = "okay";
 	};
 
 	ethernet@ea000 {
 		phy-handle = <&qsgmii_phy4>;
 		phy-connection-type = "qsgmii";
+		status = "okay";
 	};
 
 	ethernet@f0000 { /* 10GEC1 */
 		phy-handle = <&aqr105_phy>;
 		phy-connection-type = "xgmii";
+		status = "okay";
 	};
 
 	mdio@fc000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 70057b4e46e8..eea23b84daee 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -639,6 +639,7 @@
 			interrupts = <0 69 0x4>;
 			clocks = <&clockgen 4 0>;
 			dma-coherent;
+			status = "disabled";
 		};
 
 		msi1: msi-controller1@1571000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index e58a8ca1386c..1c3ccf17a554 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -30,6 +30,20 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	soc {
+		pcie@3400000 {
+			status = "okay";
+		};
+
+		pcie@3500000 {
+			status = "okay";
+		};
+
+		pcie@3600000 {
+			status = "okay";
+		};
+	};
 };
 
 &dspi {
@@ -176,4 +190,8 @@
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 #include "fsl-ls1046-post.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index a59b48203688..65ea27c8341a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -25,6 +25,20 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	soc {
+		pcie@3400000 {
+			status = "okay";
+		};
+
+		pcie@3500000 {
+			status = "okay";
+		};
+
+		pcie@3600000 {
+			status = "okay";
+		};
+	};
 };
 
 &duart0 {
@@ -120,37 +134,47 @@
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 #include "fsl-ls1046-post.dtsi"
 
 &fman0 {
 	ethernet@e4000 {
 		phy-handle = <&rgmii_phy1>;
 		phy-connection-type = "rgmii";
+		status = "okay";
 	};
 
 	ethernet@e6000 {
 		phy-handle = <&rgmii_phy2>;
 		phy-connection-type = "rgmii";
+		status = "okay";
 	};
 
 	ethernet@e8000 {
 		phy-handle = <&sgmii_phy1>;
 		phy-connection-type = "sgmii";
+		status = "okay";
 	};
 
 	ethernet@ea000 {
 		phy-handle = <&sgmii_phy2>;
 		phy-connection-type = "sgmii";
+		status = "okay";
 	};
 
 	ethernet@f0000 { /* 10GEC1 */
 		phy-handle = <&aqr106_phy>;
 		phy-connection-type = "xgmii";
+		status = "okay";
 	};
 
 	ethernet@f2000 { /* 10GEC2 */
 		fixed-link = <0 1 1000 0 0>;
 		phy-connection-type = "xgmii";
+		status = "okay";
 	};
 
 	mdio@fc000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 9a2106e60e19..49a363abf2ad 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -599,6 +599,7 @@
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		msi1: msi-controller@1580000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
index dbd2fc3ba790..515be7448e3e 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
@@ -27,6 +27,7 @@ fman@1a00000 {
 		reg = <0xf0000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x10 &fman0_tx_0x30>;
 		pcsphy-handle = <&pcsphy6>;
+		status = "disabled";
 	};
 
 	mdio@f1000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
index 6fc5d2560057..3fc43b0faa3f 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -27,6 +27,7 @@ fman@1a00000 {
 		reg = <0xf2000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x11 &fman0_tx_0x31>;
 		pcsphy-handle = <&pcsphy7>;
+		status = "disabled";
 	};
 
 	mdio@f3000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
index 4e02276fcf99..fa16a914e53b 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
@@ -26,6 +26,7 @@ fman@1a00000 {
 		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy0>;
+		status = "disabled";
 	};
 
 	mdio@e1000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
index 0312fa43fa77..8813d433d891 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
@@ -26,6 +26,7 @@ fman@1a00000 {
 		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy1>;
+		status = "disabled";
 	};
 
 	mdio@e3000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
index af2df07971dd..65663d449430 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
@@ -26,6 +26,7 @@ fman@1a00000 {
 		fsl,fman-ports = <&fman0_rx_0x0a &fman0_tx_0x2a>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy2>;
+		status = "disabled";
 	};
 
 	mdio@e5000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
index 4ac98dc8b227..8ae370f11518 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
@@ -26,6 +26,7 @@ fman@1a00000 {
 		fsl,fman-ports = <&fman0_rx_0x0b &fman0_tx_0x2b>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy3>;
+		status = "disabled";
 	};
 
 	mdio@e7000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
index bd932d8b0160..3ff5a97e0a58 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
@@ -26,6 +26,7 @@ fman@1a00000 {
 		fsl,fman-ports = <&fman0_rx_0x0c &fman0_tx_0x2c>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy4>;
+		status = "disabled";
 	};
 
 	mdio@e9000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
index 7de1c5203f3e..4e9bd0b25499 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
@@ -26,6 +26,7 @@ fman@1a00000 {
 		fsl,fman-ports = <&fman0_rx_0x0d &fman0_tx_0x2d>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy5>;
+		status = "disabled";
 	};
 
 	mdio@eb000 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
