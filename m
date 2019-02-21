Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6308D2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ElOY/JlD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SEjC999n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6308D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SZDVA9mZRSPw9kTprOreqzZqIjDWkHBe0vB/L5dOX1I=; b=ElOY/JlDTcon/a
	5h5PxUrUoYfFfqSdZWo/GfYhEdsHxpzROwJv9dtQSoNOZqoAObonfLN6PNjkL9jXSaWQCSIv47JTE
	4Av5mIdlU0E73SoDPW+dMfCPs1wKRS0r4UvOf33Hb6Jv3CKsDo5Xxlsw5b4z8KFK+A/pyuTT4t1i2
	06gCuiyjZZhINue6FXOa0SQ/9QKVIYPP/GfUvky+e0YTbcQ5aJv5a4MY9/B7Zut5yyU5+gBUFcoKw
	B8gt2wUZ/gp2j8sxH+Mfu87DqJZg8w0ZsF6DobhsCDkRDHQwRbotT8eTxt3H8R9TvvS29tLzWBaB3
	0RzvzsacsQh+z7BKLTKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt2o-000102-5L; Thu, 21 Feb 2019 18:26:02 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt24-0007AG-T3
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpGe983iVjSsU9qTK1yl1+5nEj2KABIgIPtUZNLl1uI=;
 b=SEjC999nf0+AoAFBkjc5CLL/uLp851ie3dfZ+yf3XJdJMeTB7pYewdMa7knblkLHmBgFrsb02W4vLGLInwRlhpTi5y86TDDDLey7UReMMsyKko8pLMKNjPiMDlxWpZD96ukleCEL9zhrNlAcLB17wr6Hiqwxtqaogb32VBE7g/0=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:25:05 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:04 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 04/14] arm64: dts: imx8: add adma scu clocks
Thread-Topic: [PATCH 04/14] arm64: dts: imx8: add adma scu clocks
Thread-Index: AQHUyhLEuW5LhJnxz0mCtv38lTB1nQ==
Date: Thu, 21 Feb 2019 18:25:04 +0000
Message-ID: <1550773093-13349-5-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 019a81ab-77be-4e86-63a8-08d69829e668
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:DP4KbqEv4L0AdWRUW1+UDHLPFsmyjjT8wJN2AHL?=
 =?iso-8859-1?Q?J3iteWYJuU+f1N7aaz/oMlEqixloEeUya6+6E/OfZ+JzFgH1hF/oZ3Lk34?=
 =?iso-8859-1?Q?Wtd6eE9rZmLe7aybrT4BllAFQC6buUSAAiU8zQW6Md6B4Ge0ShhueF+lmd?=
 =?iso-8859-1?Q?QTUhgW4n2BGakYhXZhdPvNzn7kQD/5WNbYwMlbUFnx4faCTtLtrL8K6Os1?=
 =?iso-8859-1?Q?+Xt7Eyt6VJLq3HPrrvbcZq2FKgnxpQa/MukW8aPLyN2mxJ6xPkv5pcp32J?=
 =?iso-8859-1?Q?DHCFHgNVOteaO+gaELLBbRaOEPbKQuSRI5Un29rrrGq0kCkgXXyKTvkMlB?=
 =?iso-8859-1?Q?+ChmlMCbwOWvM05TCrLnC2rpfoc8PiNQz1P1WvhT1UMUdZ3ri6a8jsGa8c?=
 =?iso-8859-1?Q?5OT9XCmgQcntgtyLCCaQEFIcafxAz2n3vn5l39yoH1mmWDf36QFrYAt78r?=
 =?iso-8859-1?Q?fkdK2+0Yafksbe72yU3s3vIHO0Idtj8dQObvsd3161TVOwflQ1FNd+Caoi?=
 =?iso-8859-1?Q?2Omfq9jQlNPt7Y4Fh3GRevo1du4d/3klx/Jsv9U5nj3flhCPH1WlLUL9na?=
 =?iso-8859-1?Q?Du+Wkhlq+09Rp6iKjBNfb4wSFnQDDtmPP9iYZEAYV6M3QvwnlA12Hvz/Dd?=
 =?iso-8859-1?Q?89aVdQ8Iq/1kgoh3b9H3dgwUVaCWDCmmFe+bbfECBCev1sIm+PNK/HAhys?=
 =?iso-8859-1?Q?4eMbTfApb0ZOBAPIyuyit/wsxQcrdmsRE+N9RIlXSHHYI47u95T0Q8ZS7q?=
 =?iso-8859-1?Q?pf/nUgogWwJSMj4XItf9mKEyslThQpZipGCATkU/GjGlb6PYrSAt1T1YpS?=
 =?iso-8859-1?Q?usGX9jTFZAkzq9lCSEWZH0Dmy6rzEEJgguWedOgF0IqJ6dyyRL1w2LOBKx?=
 =?iso-8859-1?Q?PrL7h6vseEtJErPqLexAdrYjTMpW/JmRY8Jzf17Aq0SSwTg4Xm2KpWpRKC?=
 =?iso-8859-1?Q?hYswtiPQE+n1+1Ptafr+KvDW2KPQTsUpxMsHAAepZX3b6MH04dvaEFrctO?=
 =?iso-8859-1?Q?zLjpq87YhLgmlYaBDx6oU1vMST4aNN66uJ+V5Kbk4x3MdeKDnjkTfBiaB+?=
 =?iso-8859-1?Q?+oizJ+IrsdENkpIxUS1H3gfWvnS9PqU2w8ykjN0p8DorrHx7ZI+3TWp4VP?=
 =?iso-8859-1?Q?j62s2Mg4SPLwfhn5/s+zfFPcH+Ay9rbG2BYp9KLfCjVkx0c0W6shQtX3GA?=
 =?iso-8859-1?Q?Wi5GOry9gH/PxRSguPQs9vXXKUqv6J+6L4KNgZ4ApWB8SXfkQG9aBJqnxW?=
 =?iso-8859-1?Q?dv4Q1MkAiSHzovZxMFf21m+SYSE8bWa4HpTKC2oQRt9eBR4ebIrRcBZXRs?=
 =?iso-8859-1?Q?d9h8fiWwUQxgmCjMe943qFg?=
x-microsoft-antispam-prvs: <VI1PR04MB484681CF923D74B170D156C3807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bh+4TkI5aMydizP0Kd3LrZXFUzGYz0n3jIrMTYz7eUp2ugFub0aaTv4LjkgrL87t3xKZYd2J+4+ryfiYAcqDFOOgD+0/eUhEcfB7C5Dlvd1VnkbfCVIjQuNyO7bQnB44sBMpXPEmMwwHdw72PIGY4d9bFD0ws2NV8+ldv6OUHlcynPto8SOpUYHL7sjZCbY9tXpEhlvAuzT5h+mN77FdRBFx2hdvoQePu+VAwvGnm7Mk/FZtVpAe8uf9RmJdFzjGnXSPCjpi5oll/Ywh5DOw9UwD1y/TN6uxNTSBfZUX4xCJeG4tn/+jiM3p3ERWXTC013uz/cnnkyHkqkqiXB9yTAmZFXVCSezGsWA6eryNvoKpnXvrGa2IZ0rpWjv1+qeJKnddxNzRCp7YHkykrD0JpSX4imnADGQYQKMJpSa+wwM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019a81ab-77be-4e86-63a8-08d69829e668
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:00.8719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102517_261988_8FE4E77A 
X-CRM114-Status: GOOD (  11.48  )
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

Add adma scu clocks

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi | 136 ++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
index f6f2b94..5f0e9e3 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -4,12 +4,148 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
+
 adma_subsys: bus@59000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0x59000000 0x0 0x59000000 0x2000000>;
 
+	/* SCU clocks */
+	adma_ipg_clk: clock-adma-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "adma_ipg_clk";
+	};
+
+	adc0_clk: clock-adc0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ADC_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "adc0_clk";
+	};
+
+	can0_clk: clock-can0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_CAN_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "can0_clk";
+	};
+
+	ftm0_clk: clock-ftm0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_FTM_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "ftm0_clk";
+	};
+
+	ftm1_clk: clock-ftm1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_FTM_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "ftm1_clk";
+	};
+
+	i2c0_clk: clock-i2c0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_I2C_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "i2c0_clk";
+	};
+
+	i2c1_clk: clock-i2c1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_I2C_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "i2c1_clk";
+	};
+
+	i2c2_clk: clock-i2c2 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_I2C_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "i2c2_clk";
+	};
+
+	i2c3_clk: clock-i2c3 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_I2C_3>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "i2c3_clk";
+	};
+
+	lcd0_clk: clock-lcd0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_LCD_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "lcd0_clk";
+	};
+
+	lcd0_pwm0_clk: clock-lcd0-pwm0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_LCD_0_PWM_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "lcd0_pwm0_clk";
+	};
+
+	spi0_clk: clock-spi0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_SPI_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "spi0_clk";
+	};
+
+	spi1_clk: clock-spi1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_SPI_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "spi1_clk";
+	};
+
+	spi2_clk: clock-spi2 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_SPI_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "spi2_clk";
+	};
+
+	spi3_clk: clock-spi3 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_SPI_3>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "spi3_clk";
+	};
+
+	uart0_clk: clock-uart0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_UART_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "uart0_clk";
+	};
+
+	uart1_clk: clock-uart1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_UART_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "uart1_clk";
+	};
+
+	uart2_clk: clock-uart2 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_UART_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "uart2_clk";
+	};
+
+	uart3_clk: clock-uart3 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_UART_3>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "uart3_clk";
+	};
+
 	adma_lpcg: clock-controller@59000000 {
 		reg = <0x59000000 0x2000000>;
 		#clock-cells = <1>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
