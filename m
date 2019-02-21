Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D30C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBB020818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nlnODOpb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="etZLvbEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBB020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZMiUHCXTt4NyzpF3E5lO8ap2gosB3m+Ke38SX09xv8o=; b=nlnODOpbW3xeSf
	X7U2WZ/du4vQFCEVbyBtC/c1+VHHR2hAUj/fjVxGFhcY8j9iJ0IEJJ0oukJzplUI4+Wi4YzB4Agvk
	LqwgoGU5ICU9FWgvJSBJcfHT9ObGfbdr9VrGWFj/SzafRQn9ayBq99AY+LYO3D+cEihP3bSfw1Lyb
	utUirK+rqw3HcATp5p83LHg8FdyLgpRhYSaodnCfwurSF1evgKLuDH4xoqS0hgeY9SqsTK8BOjhwM
	nKfIBWk5otZHIATv4i7DTKz8vVklue5UxhSTsOXLGbI2oxygN0byppAJ/3xyfBXv85Cl9VU2DHPAs
	Kf91X1CWq/CF6Yx47ErA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt3l-0002Eb-0e; Thu, 21 Feb 2019 18:27:01 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2V-0007AG-O6
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuHC9mTmiKkaUdAi+pVRDJWwCR7hhRFqpvoCZT/YqsQ=;
 b=etZLvbExcFk5ZCvd46B1WRS9FBQWBEuq2hS8EkHWrOZEAVRIZYNzg5ACOadBb41RXMmRukE1OCS/sRUrS+RWfjE+D93ceR+NvqQvM85hdHtpIe81cdkua8KiKchFnPH5PrQeYRe+Sby3PRTbFcFUEtMnxG4j/QSe3wsuK3Q++uY=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:25:39 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:39 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 12/14] arm64: dts: imx8qm: add dma ss support
Thread-Topic: [PATCH 12/14] arm64: dts: imx8qm: add dma ss support
Thread-Index: AQHUyhLYVWGEzR9y5EyHY4V4iIBxmQ==
Date: Thu, 21 Feb 2019 18:25:39 +0000
Message-ID: <1550773093-13349-13-git-send-email-aisheng.dong@nxp.com>
References: <1550773093-13349-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550773093-13349-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1e90147-8f59-4e22-1f2c-08d69829fad7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:qMtZI1FzNgiF8ftucHMUCwd6ptBXxuzf3d4iofV?=
 =?iso-8859-1?Q?6oTG3LuJVL6nNmvNxgrIYSShQaw8ONsu2Z5OnhF2+9La23x4lvqDayGQzO?=
 =?iso-8859-1?Q?MMHTnHWM/9Nym7wCUx2zCuFFDtqP8IQlfNP751EMh3umfx0iaX7j9N6K03?=
 =?iso-8859-1?Q?sCAWI7MyEnnYkTZmDnBJv6KIBFKrylUUwOQjkf3foimbnmACdKmBp8ox+L?=
 =?iso-8859-1?Q?0cNoRdNEhbFpTHq5n14NIoqwh0p86hZuoEa0cf8fruYiZSxr6PHh0gUxaN?=
 =?iso-8859-1?Q?CRAUpxZb/MSQTtgiLwFdXwOhrToj59PvdvReAmvJ9OPfqehZ9othkhgwZy?=
 =?iso-8859-1?Q?qYLYdFZpnVzsCLrTJ2YVTu4GOQ9A/giWgvc9z/NzPlE0UGJ5EFonl3Xsvj?=
 =?iso-8859-1?Q?LjeOVEgh0phV9qjLbtwJFRnr74SwAdtu0QfD9XCukDwPMw4rLr4w61R0Vk?=
 =?iso-8859-1?Q?ccISMNQHtQhNS95vctGg+PUOsmKoD5MxxDUieZEN3iMpqGIdOvTItBSUKU?=
 =?iso-8859-1?Q?6zpdND5CLT+x65TkADYScx0e2pQQflXbgiLHAZqYVyU4N69aG7rGFCVzne?=
 =?iso-8859-1?Q?SNYweHOow2CXtmGv4IXh81hKc0+baFmVUiJ166Ta4nFNaxBGljSKHxSc+l?=
 =?iso-8859-1?Q?1mTxZuY9ljONNoeJF5gO8WNrARBcLv4cM7Roj5Xzh/RVsZRoSUkP5M2EpH?=
 =?iso-8859-1?Q?Sb1pFES52qOkChA3iiCuw/UT/8Kp8Hbw/UVF/cgcdEMcOQBtmA2UaGUR3E?=
 =?iso-8859-1?Q?o2B8aM2wJ+W1tQ5+tlwGi62IY1/Mk4BmxRIvYzeZotz9EdUzfF0hGN8I90?=
 =?iso-8859-1?Q?Vg6YPS2E2oXFG2MaItzTz6roiSJZa5WhEmweoRzx9LhiaR8BI7GPzIkiC6?=
 =?iso-8859-1?Q?OxwPAHlUvj4xe+K627Z+6l+tA82Ll+3wQsVwC1IebWYWWqmxh2aOCBJsBy?=
 =?iso-8859-1?Q?9bmsbrlzTtKpxEtUzWuvp3LBk4I5vU2wDJB4pD4lAFEPXGSytULQ2pwIQU?=
 =?iso-8859-1?Q?CxULPjfZKXfAzzyRzXG/5sk5GghgJB/r0xI7RQQRN09h6RkzQLVSpNmbSb?=
 =?iso-8859-1?Q?B+kPgfxHr5auB5gz8f4XXmoYrLykOV6j1Rh0ICNKTaWPzFHVY7GbbrzMWU?=
 =?iso-8859-1?Q?eYkDTmLsRWnG7r3L7YPvfERA88qqLvg4XCSc+IugZhEHDhh2MShpE/uqem?=
 =?iso-8859-1?Q?QZj7UbXKCszdB4WnAJqTAeiHgq8MdXKgUQjekXruY1aEPggjXl5sw1Nuks?=
 =?iso-8859-1?Q?If2D6jMmOncq9r22GxPwwV/evsRiQVEZjOzxEl+2ZS0W9s7py9LAzjehBX?=
 =?iso-8859-1?Q?QajHwrbI9knlst4NLOYBFKROzZNSviMwhDF+rj30CwIjA=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4846EB99F85BC804CE65790F807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 42lWEuMlgu7KLCUetSG2Pf/6ooskncFrakdh85HuujxWjN84LJaBkXYtXWM+Y5jVr0XF12HlSTC5vaZY0bAL7+3GUF0R4pa7De+3bLcxAaBT/fwA0oYxBTESZT67Udx9APREpElXo6jxDBYZDdN1WrD7IdojvpaXCufEvs5ki3Kz1WUvGvIST8WQRtdWZu5h3UJcp+7kMheERznGm+eyOYgnXjiqYBQ6DXVRbBsMbvv5k3vP8Cp0y4X2gCMD/ojPly6qTn/vLV60K0m2mM+vgzFUAK2ScQWTeVKfe8qtdHQXOnHPio9K/gRsbBy6itnzOxXRCK+t5L83Gbk9YDTQGwgSMXJj7c/hjT/FInjDkc+u4kf5suTxVGQJKYRJE0LgEMCpCqswDwgOYZbKi7+T+tvDkhxtvAx0ewSICeSaWrA=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e90147-8f59-4e22-1f2c-08d69829fad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:35.1290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102543_883395_6B35B9C7 
X-CRM114-Status: GOOD (  14.21  )
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

The DMA SS of MX8QM is mostly the same as the DMA part in MX8QXP ADMA SS
while it has one more instance for each of LPUART, ADC and LPI2C. And unlike
MX8QXP that flexcan clocks are shared between multiple CAN instances,
MX8QM has separate flexcan clock slice.

So we reuse the most part of common imx8-ss-dma.dtsi and add new things
based on it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 171 +++++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
new file mode 100644
index 0000000..7645612
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+&dma_subsys {
+	adc1_clk: clock-adc1 {
+		compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ADC_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "adc1_clk";
+	};
+
+	can1_clk: clock-can1 {
+		compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_CAN_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "can1_clk";
+	};
+
+	can2_clk: clock-can2 {
+		compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_CAN_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "can2_clk";
+	};
+
+	uart4_clk: clock-uart4 {
+		compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_UART_4>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "uart4_clk";
+	};
+
+	uart4_lpcg: clock-controller@5a4a0000 {
+		reg = <0x5a4a0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart4_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart4_lpcg_baud_clk",
+				     "uart4_lpcg_ipg_clk";
+	};
+};
+
+&adc0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&can0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&ftm0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&ftm1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&i2c0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&i2c1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&i2c2_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&i2c3_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&lcd0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&lcd0_pwm0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&spi0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&spi1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&spi2_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&spi3_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&uart0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&uart1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&uart2_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&uart3_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&uart0_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&uart1_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&uart2_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&uart3_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&i2c0_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&i2c1_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&i2c2_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&i2c3_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&dma_lpuart0 {
+	compatible = "fsl,imx8qm-lpuart", "fsl,imx7ulp-lpuart";
+};
+
+&dma_i2c0 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&dma_i2c1 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&dma_i2c2 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&dma_i2c3 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
