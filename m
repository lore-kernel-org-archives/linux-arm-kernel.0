Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:28:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E5020818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSahvKR8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8jDYn7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E5020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FVccErTyiSFLUscu5Bix6ic0JeQAKDkUjPDOJQgxMcw=; b=bSahvKR8BZS4s/
	78oKD5UdfKl2mqRc4MMK0SXWG9HUAyaJf+I7eosK1aZGCTpAEj74DApxFpDJFKkgaCGeaO2087f3+
	GL+ij4VTisNbl3ibSHzqsMqVSArpN+qFzZUqrfn/ESG4yz6RyodMskAVRdzRfGRRrRC/WPJHQ89wk
	VJ34AmCzacdfKkZsJWNUMQCDGW5gdtWJdbXN0b6UVLEGfJI9B3mdFP0LATUwmXlEc0NKyJalg8+36
	5Mj2Zc9ig+QVxvKPTDnCRRu9Gu+FSQrLRV2ocprhmm1jU+jyc4lnwW2vHLza+dDqTYO86WV1zNiiA
	kUvEhFwdxnyi3jqgJwzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt4i-0003Re-Hw; Thu, 21 Feb 2019 18:28:00 +0000
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2t-0000Km-VU
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wW1N80OuAjkStP8HE43HCSeKLGIY6G121882rGLVZ8=;
 b=X8jDYn7G2s/jiSg+MIWO0OXbWxyHZ/YTaMuDbdOwmBRhxiZyTO+yzrk+6eQPAVyu5d9SsqomCnpR1mc5fUKULuFBneO+yd+gJ6hUT5N3R8x8wDyUL6J7JF9CBmN2ZJP3ZV48AOyNza6m/qQ8tP4aNI13uZuuLNT+iGNkfT9RG3Y=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5599.eurprd04.prod.outlook.com (20.178.125.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 18:25:34 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:34 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 11/14] arm64: dts: imx8: split adma ss into dma and audio ss
Thread-Topic: [PATCH 11/14] arm64: dts: imx8: split adma ss into dma and audio
 ss
Thread-Index: AQHUyhLVa4voSQ/PHE68eEoO39rJ3g==
Date: Thu, 21 Feb 2019 18:25:34 +0000
Message-ID: <1550773093-13349-12-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 73520381-a397-4795-3dcd-08d69829f844
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5599; 
x-ms-traffictypediagnostic: VI1PR04MB5599:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5599;
 23:XeTi6zxv0ULH3TyYzoBorbO5AN6GCNAZ1LLIIRR?=
 =?iso-8859-1?Q?CGAnWh8roxHHlWc28Qh/+XaF5lPYx3LgdghwXK6ROHTEYdIEXzTeZi6ncs?=
 =?iso-8859-1?Q?xUSXBY34Z7YSJXgmVdNnCy1ZvwIZP+x+nPibVLtXbfshudKmFnTCim1HTd?=
 =?iso-8859-1?Q?NG1tb7x+1OMgV15XkzsOMjhya7fCj077wkCLIkiX+4UTf4h0GejObSwDAY?=
 =?iso-8859-1?Q?f3FzIRgFKECn/VWWpbrZORNz0omkGkTBtmAhEp7Dp2syamxwg4J78Wc+Ab?=
 =?iso-8859-1?Q?wFSlYSl62Rj6mTEtIpeIXxjz8WA6RZRMalGKbZQQalUmo/w5CclKiIfA/l?=
 =?iso-8859-1?Q?xgKHSUnYtClLIVqBMVmALnVadFCqjiTf8nPfICdL5rCBivT6r68dzyMSg+?=
 =?iso-8859-1?Q?MHjzUlBKXj0MgvGuLxQfts6LIvTpSXIX0flpFnqDAH6o9K0NOFp+oq0Ep5?=
 =?iso-8859-1?Q?T2AmAlS1m1x4ta+0823cOx5UEZ65vool6cbMQ7w8Cs+U6Zc5Iu1KRGOe23?=
 =?iso-8859-1?Q?3YsJLcgTD5swC7/WSvnARUoz0OD25/CL90Ya32RbYv4j6LIfz60rPYrOD0?=
 =?iso-8859-1?Q?P0UuteOds4lOdgUlkEpsPRcenTqopWF7jMI7YTK7hsBGGak2iscuY/fE3y?=
 =?iso-8859-1?Q?8QlB5BXu3z1YSy5iI8LXIlwOWsjPEviBdclzSXW6rBpn8EZSYniLUv9oa0?=
 =?iso-8859-1?Q?hJD1ejYq0Aa84ljUQ62S1ft5esoEXQPrz5DGSvYf4OATL0TkRAy3wFfiGF?=
 =?iso-8859-1?Q?aEZBn98VetVt41wGT42P6r6Tv8MH+Rhy7PhvytqLvK7Mna7Twr/vl0CP/w?=
 =?iso-8859-1?Q?iErggSCfEkp90tHkUDOAR4BmceRl9H7URR+M8EWjnJCRe2gUxO9PZD3b4L?=
 =?iso-8859-1?Q?rmwMTvdH4VRE1nMfAieI6a+fYpNUYfPkGQTv5xJHqWK14J0rqxM3kFJqKO?=
 =?iso-8859-1?Q?Lcv0RlWke5hYQoMgS8tmkszdddCJXcO9aDLpPrZuqR4l82Hty2lAjoyeyo?=
 =?iso-8859-1?Q?gpW9DUYAvVRB67xAm+yX+WYW9enK6NUvBW1vG6AfpbH21exduiE0m5nHcY?=
 =?iso-8859-1?Q?H6jO2x/7bqWrNAvlA+OvoR0HFsAOh9qxIDIJnhZDMr5fI8wAOGF18y+e0r?=
 =?iso-8859-1?Q?sGY/3b/f2Jff7U0hF5JkHziSjLcKuyxLbWPIOx2E+dDLUvxrMRtVD/+tm8?=
 =?iso-8859-1?Q?CyBkuHEE0RKctRYVQmZ6ZQ7iirv0xrbU9DHZSoB/ynMZiE27HbNxD7ug4/?=
 =?iso-8859-1?Q?v1I4anEaTg5i56JlycNrzudXbB6JQPaZPucjdrBGpx1vxj/oARkTJsAk5I?=
 =?iso-8859-1?Q?R+5hOeT4wPxSgv87yzh03CNd1G0uagDs7hDzESp3e0zPUOWCHt+g3/Rxvy?=
 =?iso-8859-1?Q?C088hqRH9U/Wi3yMlfmwkR5vUf65b?=
x-microsoft-antispam-prvs: <VI1PR04MB5599A383986F806B4FAB0D47807E0@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(256004)(53936002)(106356001)(71200400001)(71190400001)(81166006)(2351001)(2906002)(6916009)(446003)(105586002)(81156014)(44832011)(53946003)(316002)(305945005)(97736004)(2616005)(8676002)(54906003)(14444005)(6512007)(7736002)(2501003)(68736007)(76176011)(386003)(6506007)(3846002)(486006)(14454004)(5640700003)(86362001)(6486002)(30864003)(52116002)(6436002)(4326008)(8936002)(102836004)(5660300002)(476003)(26005)(99286004)(478600001)(11346002)(6116002)(25786009)(50226002)(186003)(36756003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5599;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AX0K6A+BAb99Nlx1S1CrwqeGNzayPY+kBGrRfOm0lKb899+cfY/eo7NqBFlhvacmpLV/VxE/1gFr3PEodbraRHDyKDFGgpQeHAk7dhv7gmAA0qpDJ9xgg3pUgReph16DKTouAYxQMMw3Virglm9NsnXo9XbCRaUaKZTUUfua/vSW4ViDXW4UxoXfm4p49iEtThKAvXHGlIosz/vcUBaTkLmpp1b+AZ4pHF2OSSGXUVDft3CdzOVPOOBrI2FUydOGpEGZ9rNnitGqmGFiPzH3tqSvFxHvnXZTE8DDZVmt+IOSZuph5iQkXshbmt4jLznM1D1FapROx9v2R9LtV9iiB8VMzpxRljMj0zHeeOddoLJezfOXWjeSU5VjpuN/A14nqsxKZkpFscfMBNIQyZtCM15UbzmDFYOEQvlPZZmDMZ4=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73520381-a397-4795-3dcd-08d69829f844
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:31.3494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102608_713743_894EF333 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
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

amda ss is consisted of dma and audio ss in qxp which are
also used in qm.
Let's split them into two ss for better code reuse.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi    | 274 +-------------------
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 279 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |   4 +-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi |  10 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   2 +-
 5 files changed, 288 insertions(+), 281 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
index 835ecf7..991aaab 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -4,276 +4,4 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-#include <dt-bindings/firmware/imx/rsrc.h>
-
-adma_subsys: bus@59000000 {
-	compatible = "simple-bus";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x59000000 0x0 0x59000000 0x2000000>;
-
-	/* SCU clocks */
-	adma_ipg_clk: clock-adma-ipg {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <120000000>;
-		clock-output-names = "adma_ipg_clk";
-	};
-
-	adc0_clk: clock-adc0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_ADC_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "adc0_clk";
-	};
-
-	can0_clk: clock-can0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_CAN_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "can0_clk";
-	};
-
-	ftm0_clk: clock-ftm0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_FTM_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "ftm0_clk";
-	};
-
-	ftm1_clk: clock-ftm1 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_FTM_1>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "ftm1_clk";
-	};
-
-	i2c0_clk: clock-i2c0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_I2C_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "i2c0_clk";
-	};
-
-	i2c1_clk: clock-i2c1 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_I2C_1>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "i2c1_clk";
-	};
-
-	i2c2_clk: clock-i2c2 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_I2C_2>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "i2c2_clk";
-	};
-
-	i2c3_clk: clock-i2c3 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_I2C_3>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "i2c3_clk";
-	};
-
-	lcd0_clk: clock-lcd0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_LCD_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "lcd0_clk";
-	};
-
-	lcd0_pwm0_clk: clock-lcd0-pwm0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_LCD_0_PWM_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "lcd0_pwm0_clk";
-	};
-
-	spi0_clk: clock-spi0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_SPI_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "spi0_clk";
-	};
-
-	spi1_clk: clock-spi1 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_SPI_1>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "spi1_clk";
-	};
-
-	spi2_clk: clock-spi2 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_SPI_2>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "spi2_clk";
-	};
-
-	spi3_clk: clock-spi3 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_SPI_3>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "spi3_clk";
-	};
-
-	uart0_clk: clock-uart0 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_UART_0>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "uart0_clk";
-	};
-
-	uart1_clk: clock-uart1 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_UART_1>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "uart1_clk";
-	};
-
-	uart2_clk: clock-uart2 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_UART_2>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "uart2_clk";
-	};
-
-	uart3_clk: clock-uart3 {
-		#clock-cells = <0>;
-		rsrc-id = <IMX_SC_R_UART_3>;
-		clk-type = <IMX_SC_PM_CLK_PER>;
-		clock-output-names = "uart3_clk";
-	};
-
-	/* LPCG clocks */
-	uart0_lpcg: clock-controller@5a460000 {
-		reg = <0x5a460000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&uart0_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "uart0_lpcg_baud_clk",
-				     "uart0_lpcg_ipg_clk";
-	};
-
-	uart1_lpcg: clock-controller@5a470000 {
-		reg = <0x5a470000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&uart1_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "uart1_lpcg_baud_clk",
-				     "uart1_lpcg_ipg_clk";
-	};
-
-	uart2_lpcg: clock-controller@5a480000 {
-		reg = <0x5a480000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&uart2_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "uart2_lpcg_baud_clk",
-				     "uart2_lpcg_ipg_clk";
-	};
-
-	uart3_lpcg: clock-controller@5a490000 {
-		reg = <0x5a490000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&uart3_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "uart3_lpcg_baud_clk",
-				     "uart3_lpcg_ipg_clk";
-	};
-
-	i2c0_lpcg: clock-controller@5ac00000 {
-		reg = <0x5ac00000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&i2c0_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "i2c0_lpcg_clk",
-				     "i2c0_lpcg_ipg_clk";
-	};
-
-	i2c1_lpcg: clock-controller@5ac10000 {
-		reg = <0x5ac10000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&i2c1_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "i2c1_lpcg_clk",
-				     "i2c1_lpcg_ipg_clk";
-	};
-
-	i2c2_lpcg: clock-controller@5ac20000 {
-		reg = <0x5ac20000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&i2c2_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "i2c2_lpcg_clk",
-				     "i2c2_lpcg_ipg_clk";
-	};
-
-	i2c3_lpcg: clock-controller@5ac30000 {
-		reg = <0x5ac30000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&i2c3_clk>, <&adma_ipg_clk>;
-		bit-offset = <0 16>;
-		clock-output-names = "i2c3_lpcg_clk",
-				     "i2c3_lpcg_ipg_clk";
-	};
-
-	adma_lpuart0: serial@5a060000 {
-		reg = <0x5a060000 0x1000>;
-		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-		clocks = <&uart0_lpcg 0>;
-		clock-names = "ipg";
-		power-domains = <&pd IMX_SC_R_UART_0>;
-		status = "disabled";
-	};
-
-	adma_i2c0: i2c@5a800000 {
-		reg = <0x5a800000 0x4000>;
-		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-		clocks = <&i2c0_lpcg 0>;
-		clock-names = "per";
-		assigned-clocks = <&i2c0_clk>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_0>;
-		status = "disabled";
-	};
-
-	adma_i2c1: i2c@5a810000 {
-		reg = <0x5a810000 0x4000>;
-		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-		clocks = <&i2c1_lpcg 0>;
-		clock-names = "per";
-		assigned-clocks = <&i2c1_clk>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_1>;
-		status = "disabled";
-	};
-
-	adma_i2c2: i2c@5a820000 {
-		reg = <0x5a820000 0x4000>;
-		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-		clocks = <&i2c2_lpcg 0>;
-		clock-names = "per";
-		assigned-clocks = <&i2c2_clk>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_2>;
-		status = "disabled";
-	};
-
-	adma_i2c3: i2c@5a830000 {
-		reg = <0x5a830000 0x4000>;
-		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-		clocks = <&i2c3_lpcg 0>;
-		clock-names = "per";
-		assigned-clocks = <&i2c3_clk>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_3>;
-		status = "disabled";
-	};
-};
+#include "imx8-ss-dma.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
new file mode 100644
index 0000000..fda5fa7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+dma_subsys: bus@5a000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x5a000000 0x0 0x5a000000 0x1000000>;
+
+	/* SCU clocks */
+	dma_ipg_clk: clock-dma-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "dma_ipg_clk";
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
+	/* LPCG clocks */
+	uart0_lpcg: clock-controller@5a460000 {
+		reg = <0x5a460000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart0_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart0_lpcg_baud_clk",
+				     "uart0_lpcg_ipg_clk";
+	};
+
+	uart1_lpcg: clock-controller@5a470000 {
+		reg = <0x5a470000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart1_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart1_lpcg_baud_clk",
+				     "uart1_lpcg_ipg_clk";
+	};
+
+	uart2_lpcg: clock-controller@5a480000 {
+		reg = <0x5a480000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart2_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart2_lpcg_baud_clk",
+				     "uart2_lpcg_ipg_clk";
+	};
+
+	uart3_lpcg: clock-controller@5a490000 {
+		reg = <0x5a490000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart3_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart3_lpcg_baud_clk",
+				     "uart3_lpcg_ipg_clk";
+	};
+
+	i2c0_lpcg: clock-controller@5ac00000 {
+		reg = <0x5ac00000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c0_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c0_lpcg_clk",
+				     "i2c0_lpcg_ipg_clk";
+	};
+
+	i2c1_lpcg: clock-controller@5ac10000 {
+		reg = <0x5ac10000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c1_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c1_lpcg_clk",
+				     "i2c1_lpcg_ipg_clk";
+	};
+
+	i2c2_lpcg: clock-controller@5ac20000 {
+		reg = <0x5ac20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c2_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c2_lpcg_clk",
+				     "i2c2_lpcg_ipg_clk";
+	};
+
+	i2c3_lpcg: clock-controller@5ac30000 {
+		reg = <0x5ac30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c3_clk>, <&dma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c3_lpcg_clk",
+				     "i2c3_lpcg_ipg_clk";
+	};
+
+	dma_lpuart0: serial@5a060000 {
+		reg = <0x5a060000 0x1000>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&uart0_lpcg 0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_UART_0>;
+		status = "disabled";
+	};
+
+	dma_i2c0: i2c@5a800000 {
+		reg = <0x5a800000 0x4000>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&i2c0_lpcg 0>;
+		clock-names = "per";
+		assigned-clocks = <&i2c0_clk>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_0>;
+		status = "disabled";
+	};
+
+	dma_i2c1: i2c@5a810000 {
+		reg = <0x5a810000 0x4000>;
+		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&i2c1_lpcg 0>;
+		clock-names = "per";
+		assigned-clocks = <&i2c1_clk>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_1>;
+		status = "disabled";
+	};
+
+	dma_i2c2: i2c@5a820000 {
+		reg = <0x5a820000 0x4000>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&i2c2_lpcg 0>;
+		clock-names = "per";
+		assigned-clocks = <&i2c2_clk>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_2>;
+		status = "disabled";
+	};
+
+	dma_i2c3: i2c@5a830000 {
+		reg = <0x5a830000 0x4000>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&i2c3_lpcg 0>;
+		clock-names = "per";
+		assigned-clocks = <&i2c3_clk>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_3>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 03aad66..1f9c2f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -12,7 +12,7 @@
 	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
 
 	chosen {
-		stdout-path = &adma_lpuart0;
+		stdout-path = &dma_lpuart0;
 	};
 
 	memory@80000000 {
@@ -30,7 +30,7 @@
 	};
 };
 
-&adma_lpuart0 {
+&dma_lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
index 2368e52..67b8807 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
@@ -108,22 +108,22 @@
 	compatible = "fsl,imx8qxp-lpcg";
 };
 
-&adma_lpuart0 {
+&dma_lpuart0 {
 	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 };
 
-&adma_i2c0 {
+&dma_i2c0 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
 
-&adma_i2c1 {
+&dma_i2c1 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
 
-&adma_i2c2 {
+&dma_i2c2 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
 
-&adma_i2c3 {
+&dma_i2c3 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 589483a..161f6c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -20,7 +20,7 @@
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
-		serial0 = &adma_lpuart0;
+		serial0 = &dma_lpuart0;
 	};
 
 	cpus {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
