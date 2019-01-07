Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAEEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:22:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A452206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T3zFUs42";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DB/mv1Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A452206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z++3PEep6OBc2NcHGjqTdZiKJE7spaVGWVLQ8/16foM=; b=T3zFUs42dhRexT
	HFL7kIMBAikt8VRgokwssW2CDwbcq8JjGhockn7mGACUYlVNMVIPqy3ucjuk9UTau3NzIH7q9GBOo
	qKVxLmDD410fRImXnqPUhUBUaemicj3vd8T0UCRHvP5kDcUkwVRtebiOyEq/JNN7DNu52aFjID4VQ
	8hZ3dLw5yCcskMAmVWMsy2/1Bxn3E/sfNNYTxfmlVUUKZCP27HC+RBl347qFlT0cWV3kO2JLhr8Y+
	XiWDTHtSdviGLMY9lm/KBgq9aGr8HJipJtOUaTwp7Rpa9ltuOEcVRLrM9ZEB3cPk3xYU/0/OvWoHr
	QlQ8SZalDbk5nrfY6Zcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggR6f-0003Py-Tl; Mon, 07 Jan 2019 09:22:01 +0000
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggR6U-0003GX-Uj
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igtrr4jLUrTeJkSo2oKHnZT0jGOfhhdGmfg903Oi+b0=;
 b=DB/mv1Rbfl4u6aYtPq7TfUwIqne+kMkIKLBIdFW8r8eZsnCqwv5pXXiCF2OtwzEyg/MQr7U1G35KlUh3NKC7fIsf/yELoVn0CC1c7J6P059x+wCZU+on4dG1nTpAuStmY19W9PCE95r/3I5aLGWLDyqeeI4mJzGCG0aLLIvFdRw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5697.eurprd04.prod.outlook.com (20.178.119.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 09:21:46 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 09:21:46 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND V5 1/3] arm64: dts: imx: add imx8qxp support
Thread-Topic: [PATCH RESEND V5 1/3] arm64: dts: imx: add imx8qxp support
Thread-Index: AQHUpmpptonz434snkCxYhqNiXGbJg==
Date: Mon, 7 Jan 2019 09:21:46 +0000
Message-ID: <1546852546-29228-2-git-send-email-aisheng.dong@nxp.com>
References: <1546852546-29228-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1546852546-29228-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0043.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::31) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5697;
 6:GEprE25Tu/2AaLPA1TicSNM5oX39MLioJii+Mv1DiBRTSuN4+YZ19gZnHoxys1+tz9k/NvpW2u6y2r527RmueFwiXUJRTmOnEouBeQR1Coixo5GMCG3N+d5Gv1AufR6gFzO3LuRUKLM/jKc6QKm2crTl0qH5SkEP5VCoR6BBGASxJJh5Dcq6FB5TtnmWNGhT1U8mUu5+V8BVGBnSfvI99GakAp7eKsA+XGT03YqGSPiYd79992IzO9djVSrmF6poeOrvWUcvI7fYGXKja2o96O5tsKzcGhsRekc13c6XGLOZNIQfQkTVf0Z3S5wd/d74fQGZjmroL5NBMXc4W38/sBR62+vwUmx3l+6ZBkHlW1K5LXKq1PxbjYTsN8JmtxTPA1urftNtuv/m7DJOQiuTOe3iNRImNenGhvoabwJJ29v78qg2uG3qftf/37v2IEV7XRo2FwCZ8xUXuUdDtAHhvg==;
 5:D2olBopkEYXoRY+IIXFOQiVgl0FZykFCZRuYnvnUF2dMV6ORidw1L56/47SIF3+UN4ygy6CWkF162Pr6ZQ+SamsH5Ztkb1yVr3K2fFTCjK8nbvKhlJ7qyEDAMKfO0Mdj5uFif9adO+hBBJ2+aB444FQw5KFSuW/6Uwovy8mxNWjM7ZgmYOHrtd0T7fSlNxcYyZUCHp8bYO77RSSFFAd8eg==;
 7:WUCZPFmbu2k4+6R5Cds9YecRpo/cGqLiXYlrxr2H6amifPmrj64ARCT5NmfhlaDhg5pnZVV3oDCKGUhtJScHy/c2/5jTs2vb2KLuqNPAavpP75tlhB2ReGJHGcRZbqHiON6E9CIqFGDUFG4pCg83FQ==
x-ms-office365-filtering-correlation-id: e4a5d397-ca79-41b3-de80-08d674818bd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5697; 
x-ms-traffictypediagnostic: AM0PR04MB5697:
x-microsoft-antispam-prvs: <AM0PR04MB569797811B8394C8721AADB880890@AM0PR04MB5697.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5697; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5697; 
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(105586002)(2906002)(305945005)(68736007)(14454004)(5660300001)(6486002)(39060400002)(106356001)(5640700003)(478600001)(66066001)(2501003)(6436002)(575784001)(25786009)(217873002)(2616005)(11346002)(54906003)(446003)(86362001)(476003)(6512007)(97736004)(81166006)(36756003)(52116002)(14444005)(256004)(53936002)(50226002)(76176011)(2351001)(316002)(486006)(6116002)(3846002)(81156014)(8676002)(26005)(8936002)(102836004)(7736002)(99286004)(4326008)(186003)(71200400001)(44832011)(6506007)(71190400001)(386003)(4744004)(6916009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5697;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kTZsJDWOWn52gTmoCf7BSWfeRmG0PHOuroNgJQTTaRy/5Y4uRdXA6m+VummBR5cmhSi4/4jMl2GmMJ6EXxIbEHNJ7J3OlF2LEvLxFmfTIym3t2k2Ge13yQ2B+9U44SEvwFeUeMAMYxgqda2nSqpqa4OhTBiRcsbnS+9JprB24sMqrAPMqFgVos4/xecOjvgUpzTcAY46XtEvcpuTcNOtzKgRn56iRBtsWewJQHqlvosGal8hS9tiH32tAEXasqKVocEJkBgRbqimGk83BF8Ps0oV41XD0G+pQIy6zNCQeEx9lQ4TsnChjBGns16GiXD7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a5d397-ca79-41b3-de80-08d674818bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 09:21:42.4454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5697
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_012150_995362_47FEC4E3 
X-CRM114-Status: GOOD (  16.63  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
graphic and multimedia features. This patch adds the core SoC dtsi
file support.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt |   4 +
 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 409 ++++++++++++++++++++++++++
 3 files changed, 474 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 7fbc424..9b5be3e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -131,6 +131,10 @@ i.MX7ULP generic board
 Required root node properties:
     - compatible = "fsl,imx7ulp";
 
+i.MX8QXP generic board
+Required root node properties:
+    - compatible = "fsl,imx8qxp";
+
 Freescale Vybrid Platform Device Tree Bindings
 ----------------------------------------------
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
new file mode 100644
index 0000000..c79e97a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/{
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		/* We have 1 clusters with 4 Cortex-A35 cores */
+		A35_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&A35_L2>;
+		};
+
+		A35_L2: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
new file mode 100644
index 0000000..488e2d1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/clock/imx8-clock.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+#include "imx8-ca35.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &adma_lpuart0;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+	};
+
+	gic: interrupt-controller@51a00000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
+		      <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
+	};
+
+	xtal32k: clock-xtal32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xtal_32KHz";
+	};
+
+	xtal24m: clock-xtal24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal_24MHz";
+	};
+
+	scu {
+		compatible = "fsl,imx-scu";
+		mbox-names = "tx0", "tx1", "tx2", "tx3",
+			     "rx0", "rx1", "rx2", "rx3";
+		mboxes = <&lsio_mu1 0 0
+			  &lsio_mu1 0 1
+			  &lsio_mu1 0 2
+			  &lsio_mu1 0 3
+			  &lsio_mu1 1 0
+			  &lsio_mu1 1 1
+			  &lsio_mu1 1 2
+			  &lsio_mu1 1 3>;
+
+		clk: clock-controller {
+			compatible = "fsl,imx8qxp-clk";
+			#clock-cells = <1>;
+			clocks = <&xtal32k &xtal24m>;
+			clock-names = "xtal_32KHz", "xtal_24Mhz";
+		};
+
+		iomuxc: pinctrl {
+			compatible = "fsl,imx8qxp-iomuxc";
+		};
+
+		pd: imx8qx-pd {
+			compatible = "fsl,imx8qxp-scu-pd";
+			#power-domain-cells = <1>;
+		};
+	};
+
+	adma_subsys: bus@59000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x59000000 0x0 0x59000000 0x2000000>;
+
+		adma_lpcg: clock-controller@59000000 {
+			compatible = "fsl,imx8qxp-lpcg-adma";
+			reg = <0x59000000 0x2000000>;
+			#clock-cells = <1>;
+		};
+
+		adma_lpuart0: serial@5a060000 {
+			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			reg = <0x5a060000 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_UART_0>;
+			status = "disabled";
+		};
+
+		adma_i2c0: i2c@5a800000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x5a800000 0x4000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX_ADMA_I2C0_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_I2C_0>;
+			status = "disabled";
+		};
+
+		adma_i2c1: i2c@5a810000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x5a810000 0x4000>;
+			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX_ADMA_I2C1_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_I2C_1>;
+			status = "disabled";
+		};
+
+		adma_i2c2: i2c@5a820000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x5a820000 0x4000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX_ADMA_I2C2_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_I2C_2>;
+			status = "disabled";
+		};
+
+		adma_i2c3: i2c@5a830000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x5a830000 0x4000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
+			clock-names = "per";
+			assigned-clocks = <&clk IMX_ADMA_I2C3_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_I2C_3>;
+			status = "disabled";
+		};
+	};
+
+	conn_subsys: bus@5b000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
+
+		conn_lpcg: clock-controller@5b200000 {
+			compatible = "fsl,imx8qxp-lpcg-conn";
+			reg = <0x5b200000 0xb0000>;
+			#clock-cells = <1>;
+		};
+
+		usdhc1: mmc@5b010000 {
+			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x5b010000 0x10000>;
+			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
+			clock-names = "ipg", "per", "ahb";
+			assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
+			assigned-clock-rates = <200000000>;
+			power-domains = <&pd IMX_SC_R_SDHC_0>;
+			status = "disabled";
+		};
+
+		usdhc2: mmc@5b020000 {
+			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x5b020000 0x10000>;
+			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
+			clock-names = "ipg", "per", "ahb";
+			assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
+			assigned-clock-rates = <200000000>;
+			power-domains = <&pd IMX_SC_R_SDHC_1>;
+			fsl,tuning-start-tap = <20>;
+			fsl,tuning-step= <2>;
+			status = "disabled";
+		};
+
+		usdhc3: mmc@5b030000 {
+			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x5b030000 0x10000>;
+			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
+			clock-names = "ipg", "per", "ahb";
+			assigned-clocks = <&clk IMX_CONN_SDHC2_CLK>;
+			assigned-clock-rates = <200000000>;
+			power-domains = <&pd IMX_SC_R_SDHC_2>;
+			status = "disabled";
+		};
+
+		fec1: ethernet@5b040000 {
+			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
+			reg = <0x5b040000 0x10000>;
+			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&conn_lpcg IMX_CONN_LPCG_ENET0_IPG_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_ENET0_AHB_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_ENET0_TX_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_ENET0_ROOT_CLK>;
+			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+			fsl,num-tx-queues=<3>;
+			fsl,num-rx-queues=<3>;
+			power-domains = <&pd IMX_SC_R_ENET_0>;
+			status = "disabled";
+		};
+
+		fec2: ethernet@5b050000 {
+			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
+			reg = <0x5b050000 0x10000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&conn_lpcg IMX_CONN_LPCG_ENET1_IPG_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_ENET1_AHB_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_ENET1_TX_CLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_ENET1_ROOT_CLK>;
+			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+			fsl,num-tx-queues=<3>;
+			fsl,num-rx-queues=<3>;
+			power-domains = <&pd IMX_SC_R_ENET_1>;
+			status = "disabled";
+		};
+	};
+
+	db_subsys: bus@5c000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
+
+		ddr_pmu0: pmu@5c020000 {
+			reg = <0x5c020000 0x10000>;
+		};
+	};
+
+	lsio_subsys: bus@5d000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
+
+		lsio_lpcg: clock-controller@5d400000 {
+			compatible = "fsl,imx8qxp-lpcg-lsio";
+			reg = <0x5d400000 0x400000>;
+			#clock-cells = <1>;
+		};
+
+		lsio_mu0: mailbox@5d1b0000 {
+			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+			reg = <0x5d1b0000 0x10000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+			status = "disabled";
+		};
+
+		lsio_mu1: mailbox@5d1c0000 {
+			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+			reg = <0x5d1c0000 0x10000>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		lsio_mu3: mailbox@5d1e0000 {
+			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+			reg = <0x5d1e0000 0x10000>;
+			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+			status = "disabled";
+		};
+
+		lsio_mu4: mailbox@5d1f0000 {
+			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+			reg = <0x5d1f0000 0x10000>;
+			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+			status = "disabled";
+		};
+
+		lsio_gpio0: gpio@5d080000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d080000 0x10000>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_0>;
+		};
+
+		lsio_gpio1: gpio@5d090000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d090000 0x10000>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_1>;
+		};
+
+		lsio_gpio2: gpio@5d0a0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d0a0000 0x10000>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_2>;
+		};
+
+		lsio_gpio3: gpio@5d0b0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d0b0000 0x10000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_3>;
+		};
+
+		lsio_gpio4: gpio@5d0c0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d0c0000 0x10000>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_4>;
+		};
+
+		lsio_gpio5: gpio@5d0d0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d0d0000 0x10000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_5>;
+		};
+
+		lsio_gpio6: gpio@5d0e0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d0e0000 0x10000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_6>;
+		};
+
+		lsio_gpio7: gpio@5d0f0000 {
+			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+			reg = <0x5d0f0000 0x10000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			power-domains = <&pd IMX_SC_R_GPIO_7>;
+		};
+	};
+
+	hsio_subsys: bus@5f000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
+	};
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
