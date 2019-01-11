Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:38:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF8A2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvpxj1xS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XqMYIjTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF8A2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iG8XhvKcdoT4G+QekfoGYZ6V51QPtTnA7LPNpv7AKv0=; b=cvpxj1xSknRdeY
	9yDMHFrzAJ05yvY8lJkdZpI07lXog4REWgEixzxRyMA/5VevzZicQE3uxyHrnGcEIYMnUpCbR20L+
	x1tgr0u2YGRc+zNsFO59fKBkOCs0qy6e04tA0SFoBF3b2mpi8R6jmadXFi2kpHww6V/sOFi0nrjBc
	IJQzHxkYw2pOmLLL6p4N2QGu7rRKHYG95ePaoz0LUuvACHXsQ9+ZiByspcxpGvLlB2DFKetLxd5k0
	zI/TGtzkeeB+0pcWrov+FyAVXrYb7ZktLH6PGkfFA2lfMgOw+t1y8KNJthaGrR9AtKVQi+fH8wBXi
	iSy/Cokn0L7dd89Kj8wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv8W-0003bL-Dn; Fri, 11 Jan 2019 11:38:04 +0000
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv80-00037D-Dn
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij+anrzdK2Bpx+G1c0WK2HBc69tAhWWe5uG0MHJU69U=;
 b=XqMYIjTPFU7+YO0W/jKSQbNuqfbOqSIvnbIEWQ3jKiKPTHR0eljj7afot2t34zfcEaznRSHYwcYV9lZDwjRVVnZXaw3Y3F5h+EWoXYlBkPyFfdzXdOBeNEr07SJoQpBMqFUPShy9fXlgkSc84akbZFJOzYC5w4kQc+9N0OwwWFk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5251.eurprd04.prod.outlook.com (20.177.42.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 11:37:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:37:29 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V6 2/4] arm64: dts: imx: add imx8qxp support
Thread-Topic: [PATCH V6 2/4] arm64: dts: imx: add imx8qxp support
Thread-Index: AQHUqaII+UBSPbmOeUiEuGzp7AlZ+w==
Date: Fri, 11 Jan 2019 11:37:29 +0000
Message-ID: <1547206279-26169-3-git-send-email-aisheng.dong@nxp.com>
References: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5251;
 6:6tHA7uhzEheOLCI686olmIjbFzjl2L7QdLy+kpwODa3XPVGuvXiNkAXcRGDr9l3AVnKz+mySxKqGf+d7ZscWmOAt5g5rh6PnVEc1SCFMtspqMdoBbD0lfsVFqKBDQ78M2lN1Pr3RmOG20T+DEoFvDpopEHqPdc0mMhlYJ91j+I87w2m4UNdt5RwjlN2X0XQU8I/gjOzhFSnFADlhkRrHTT1SPJrxFmUwqNzOr2zBokKKXC0WQaoVrX4yN20N9qtyI8uWM1E5kCnYBxDuW400qtzT7NO/3byd4MvDh5eW5/WSJE31n60fcKuRuef3/F0dEa6i0W5iswd/9psTRGTpWBtipbqxYhUqrinf81xaHKxX1/ycjLphTFRM1NGxqflwNsKP0E+3+Ikq/4kuCRWOdr6zfVUCw64BYP5DwUzz4WPj1ZnfQEHB3nn1yHWNzjXLlIEQIbXi2TJeDiFWwhMzyg==;
 5:k4iWPKUqRwV9Z994TBD0viksw7B59EO/t0VVp8TM7JhIpwIfl4E3Yw7pjJp8XSBTTvZ0a0Yq9X278zJG0gmvNrTXsT9FhhV35RhMfvAypDEvi/adtSQPyYSOO/QMD3gnsuFaYHRJHj1heYXo/LGJaqLhqKuBpC2s/YZkQb8b8rXeJuKBRvdD0go3tXhpUQUD4ooJmx7PTmduACmVyTUzVQ==;
 7:lhr++ppOXJVoK0GXex0d34w/xRswHXfzBOphHcRL2jDn7qwJxKreFve7rVYn1Zx/7PmG/MGsUVEIBrFjAy3IauXcXgE0w0Le8czBBFPKPp4KU8115BwdQ81GcLRfD2bT/4Zj63qlWdKHDc2F12WCUg==
x-ms-office365-filtering-correlation-id: 13c67e50-57dd-48c7-afc1-08d677b92ab8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5251; 
x-ms-traffictypediagnostic: AM0PR04MB5251:
x-microsoft-antispam-prvs: <AM0PR04MB525148F66454E2C24BFE3FF380850@AM0PR04MB5251.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(99286004)(68736007)(476003)(4326008)(105586002)(81166006)(81156014)(2351001)(2501003)(36756003)(14444005)(8936002)(256004)(39060400002)(71190400001)(50226002)(6486002)(106356001)(71200400001)(86362001)(14454004)(305945005)(54906003)(575784001)(478600001)(7736002)(316002)(102836004)(6512007)(486006)(6506007)(386003)(446003)(6116002)(3846002)(52116002)(66066001)(76176011)(8676002)(30864003)(26005)(53936002)(5660300001)(44832011)(186003)(6916009)(6436002)(2906002)(11346002)(2616005)(5640700003)(97736004)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5251;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8/zqpZR/VrU3it4rbSSfv+wgO0h8fL+LWA8LdX3sz7PKf6U7Cpbnn1yhUMLFzHZtT9tuQtl0Eko5h/+eB+nXgq+H8ASbbC7dQ4lHgljSvlhnUWgo+uq8mpjr04jXCsBCuAtDziEdqW9YxvgQXG1esaah0GVCPBGvVfSy72I+Co3+lVvMeeCBJcXAfnarM2xSRgfOVR7/ExayaMLEWK9yGPOZxyggh4uMFDsTbpLb8nYOMEHgoRZwCtn0xfSYSwFSpF72iC/E65LB95uX0CtLjVU3Ccej97OCYpyx3PlOLLjpv8GlLIOsoMRpeseHp0O8hqA4etHgd0kgbVOTNOZWMCRbpcWV9ytsWB64BPWjoDdhOHmXXguU+NBCVWVLg0T1VJDN4h5O+CVphKjjciuZHS2YZfppYNFhZSDWhix1IRA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c67e50-57dd-48c7-afc1-08d677b92ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:37:25.1429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5251
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033732_944346_95C08831 
X-CRM114-Status: GOOD (  16.43  )
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
v5->v6:
 * separate binding doc
 * merge imx8-ca35.dtsi into imx8qxp.dtsi
 * remove still unused nodes
v4->v5:
 * no changes
v3->v4:
 * update to new power domain binding
   power domain subnodes removed from dts
 * add LPCG clock nodes
 * clock ID updated accordingly
v2->v3:
 * add more SoC specific compatible string to IP nodes
 * move memory node into board dts
 * change pd reg value into hex
 * add more explanation about SoC in commit message
 * add external clocks
 * remove pmu compatible string which is not supported
v1->v2:
 * mu binding usage update
 * no define for node address
 * do not use '_' for node name
 * drop 'fsl-' prefix for imx dtsi
 * no defines for unit address
 * generic node names
 * range map for 32bit register
 * separate board dts
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 442 +++++++++++++++++++++++++++++
 1 file changed, 442 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
new file mode 100644
index 0000000..c312697
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -0,0 +1,442 @@
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
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		serial0 = &adma_lpuart0;
+	};
+
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
+	gic: interrupt-controller@51a00000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
+		      <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
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
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
