Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB53C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFCD2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AXi3uPwn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kI4hAQ3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFCD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KGZjV9Q3iZAAeEB2et7XOgJmn1ytataE4IcbD197Wio=; b=AXi3uPwnuEtdek
	BQJiOs8SEeo0tthEi4qU6S4wxGChx/KeocnK3ml8wVWqShFseUXfiBHIOQ38L3j/Ddo+oIlh7YVYH
	KTE8sXzcQe1MHNhf63bUXpwr0BRWPIzt8NkhJvqdBYm3bCvYKd2TMEWJHFSbC7tw8mX0AEidKRNqn
	5F/ufYNNPqRqIjWMudTVmypgZveXZBjPOlQVExEHusvc8FnfuD61Npl2mdZl0pNe0Ivz61/NtRNjD
	f4Ydh0hl+lY1Vz5rnNta0H+4G7LlPFphxbX1mtfl5mfBHKGutjJtBLtkWTW2KedKJRq6xjAdr+fQ3
	/fDq82k5uQA2GlAkbFXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt3Y-0001z4-Jq; Thu, 21 Feb 2019 18:26:48 +0000
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2I-0000Km-Dm
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbQ6bJ3DXShyhTRSi9+C146fJ4vtWca8gszHLz8PKN4=;
 b=kI4hAQ3BzsAtaaxBYAcVLZ639A738thmPE1GQsVCmbUcbKduZSHIKYEV4NSjqUkht8yAeMjYSGumXbC+2qOp/CyeTXBPVJDw8L39cWNV5sc879+PwVT4flLVVDYMLGN1ih3dprBN7xHtj+wIR7v2v0NpebkUKxl+FijvygeTG1o=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5599.eurprd04.prod.outlook.com (20.178.125.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 18:25:22 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:22 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/14] arm64: dts: imx8: switch to new clock binding
Thread-Topic: [PATCH 08/14] arm64: dts: imx8: switch to new clock binding
Thread-Index: AQHUyhLOMn/vTkPccUykcZOqFBROug==
Date: Thu, 21 Feb 2019 18:25:22 +0000
Message-ID: <1550773093-13349-9-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6194847e-a528-407b-9a36-08d69829f09f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5599; 
x-ms-traffictypediagnostic: VI1PR04MB5599:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5599;
 23:PiD37mvTsv+j9+LKgOtk7IYg7JpKWpgTu17mrkC?=
 =?iso-8859-1?Q?H+vWH+NnlOE8vcUEqGYHu2iRz6dqpY+GVDtWUXLD4f9wdjF1JuimS5Bvs/?=
 =?iso-8859-1?Q?7UT/tnjwn8HRxnhyRqbjD+XhFR8Y1zGSETkbIz0u285L0doKzyMsOvGnDA?=
 =?iso-8859-1?Q?T3OW9jAbjRZqgNQuYKi4vnej4cOuUr3h4E08OuBbR7ctDUZT/sHREFwDUL?=
 =?iso-8859-1?Q?67OlceI1HUuG/PsR7UAtBVydU7kDHNWDEJaKRcwFuag/KBLE1MmAIFElbM?=
 =?iso-8859-1?Q?s0PW9IZR0FUkQllL+1PwtRlAdbIIIQErdE69WU+DNMqCFZRlQ/x3AVp1Qh?=
 =?iso-8859-1?Q?x7XSihTnERfm/xHytmRiiOuzoUwsP+DgEg/wApDg/3U2ojXylJOZEuuHOo?=
 =?iso-8859-1?Q?bGjJkzQJ0yfyHPMXhGTDKhviBlNCxXaaSLhoJR/LPGbY+NSqcFYDJcFhea?=
 =?iso-8859-1?Q?6YprdkY/LjO+zp63wFvOuZvao2zq50JaNP+yUaNBXXanRGK031VGC8iw+y?=
 =?iso-8859-1?Q?b/pUAqZfCd5vN77ITdpLvA9HtCDR2aL4BZ/HfwKO1MXMh3ubOWEAqslUz8?=
 =?iso-8859-1?Q?/vqYtrFsNCIDkT7UkLKksI8JKeIR9YPjCfbzPbi+NJekPdn1aSRiXvayPr?=
 =?iso-8859-1?Q?EXR1Mm86UTS8IP/9qanWLrChxXFK5aBKCIQazCek1w/zWS4Np5SVfBRy+Z?=
 =?iso-8859-1?Q?zf918UR55wUpMGrIDCGHXr2IQonWEM0pRZCCSBP1luGbJZ05XV1u1yk6ET?=
 =?iso-8859-1?Q?osY9CP3a0jYE+GYBPv2HQ31TwIATWBLkqGa3NoJ627ojZvpwDUQ1bXW3gm?=
 =?iso-8859-1?Q?FhmrsWk/LDD2uY7CGHd+VSEx3opFghY89y3aaqulCpfePM3C9AGsP3PJpZ?=
 =?iso-8859-1?Q?wzxIAE2Bl56++A0woMLWMf3PCkAEGyexX6ujj4TtOoqly7QJJsZByT3P3O?=
 =?iso-8859-1?Q?QV6s1mhQx+jXVLdiUaMrv/sqoC5RFlnB4SpVeBbS9P4tOcAIoFXVOznkcQ?=
 =?iso-8859-1?Q?qC9V1ACMhznJDllRiwxUi39gkS3Db6fNGAEFVgDsHuQyBoba6LiwTEOirg?=
 =?iso-8859-1?Q?rrtx0H4QOpQybz/Xc1BAQ2mg4VIaYScNJ2+vADnQ1Ofb35Kw61ebrWYNWE?=
 =?iso-8859-1?Q?NwAY7HP6YzLjPeq6TxZPcby8vQrNzj6LHPgn3RFrMx0yQ2EqFbmQ405Y0j?=
 =?iso-8859-1?Q?Nvu6wMrCgNCKsEf2u1rtvEx4utzJ1EQ9Afmvl3m2zK/FnVBq9QCACAMVE8?=
 =?iso-8859-1?Q?2DZ2O07SwP1ht4zqJi+eqQVALlUC8Sh+h5BTW/3cyud0pSmp0BtMsdhp56?=
 =?iso-8859-1?Q?XMV/TQXYJxZByHHATigwk8inCfbRLKi8IIda4AqISKd8G2nhS4ZyPI7d4B?=
 =?iso-8859-1?Q?TIx3zuHQ=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB559932AFDDFA4358D91AB6A1807E0@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(256004)(53936002)(106356001)(71200400001)(71190400001)(81166006)(2351001)(2906002)(6916009)(446003)(105586002)(81156014)(44832011)(316002)(305945005)(97736004)(2616005)(8676002)(54906003)(14444005)(6512007)(7736002)(2501003)(68736007)(76176011)(386003)(6506007)(3846002)(486006)(14454004)(5640700003)(86362001)(6486002)(30864003)(52116002)(6436002)(4326008)(8936002)(102836004)(5660300002)(476003)(26005)(99286004)(478600001)(11346002)(6116002)(25786009)(50226002)(186003)(36756003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5599;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DdR7bHogsjTJbHq+bfhJOt5S0l5ug7Sp499afNXmEWlsodmiZbbFBh3cHoE8x7gViITxmmYZcNNCfJDRfh0H65odx7pakBwDjMpP8HKiz4njD4XqcVHQ9hiX6Kb+8EfV2/ydpWW4G1i2Q9VXCgSNOX74OfZjPoQI3ua2VewprqkV33xu81m0aYxX4E5EVLyynMXPL6f2BOJ7/UBD7bI7FABgYCT9Om+gGTb3knMwIziebUwNO72TBaYSo0tr/fLhS8FVMnIc0R0y2uUiWu9sXTDEx/Cl5pQYFxMrZkkKIQW6lBNMHUMcGR2AUDUOFoPafH/+5nZesq5gmKRVstFo9nkvRmdn9efhd0t/dtvWYt+fRlc2aNGnhjDO2NoDFCZOM3MmkqoGxwYz/3c7nCLLxiPjFxyxwdZwuGzhQ2KoQwY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6194847e-a528-407b-9a36-08d69829f09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:17.9920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102531_337954_235E71FB 
X-CRM114-Status: GOOD (  11.49  )
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

switch to new clock binding

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi    |  23 ++---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  40 ++++----
 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi | 104 ++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi |  68 +++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi |  92 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   7 --
 6 files changed, 287 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
index c7adeba..835ecf7 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -219,16 +219,11 @@ adma_subsys: bus@59000000 {
 				     "i2c3_lpcg_ipg_clk";
 	};
 
-	adma_lpcg: clock-controller@59000000 {
-		reg = <0x59000000 0x2000000>;
-		#clock-cells = <1>;
-	};
-
 	adma_lpuart0: serial@5a060000 {
 		reg = <0x5a060000 0x1000>;
 		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
+		clocks = <&uart0_lpcg 0>;
 		clock-names = "ipg";
 		power-domains = <&pd IMX_SC_R_UART_0>;
 		status = "disabled";
@@ -238,9 +233,9 @@ adma_subsys: bus@59000000 {
 		reg = <0x5a800000 0x4000>;
 		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
+		clocks = <&i2c0_lpcg 0>;
 		clock-names = "per";
-		assigned-clocks = <&clk IMX_ADMA_I2C0_CLK>;
+		assigned-clocks = <&i2c0_clk>;
 		assigned-clock-rates = <24000000>;
 		power-domains = <&pd IMX_SC_R_I2C_0>;
 		status = "disabled";
@@ -250,9 +245,9 @@ adma_subsys: bus@59000000 {
 		reg = <0x5a810000 0x4000>;
 		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
+		clocks = <&i2c1_lpcg 0>;
 		clock-names = "per";
-		assigned-clocks = <&clk IMX_ADMA_I2C1_CLK>;
+		assigned-clocks = <&i2c1_clk>;
 		assigned-clock-rates = <24000000>;
 		power-domains = <&pd IMX_SC_R_I2C_1>;
 		status = "disabled";
@@ -262,9 +257,9 @@ adma_subsys: bus@59000000 {
 		reg = <0x5a820000 0x4000>;
 		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
+		clocks = <&i2c2_lpcg 0>;
 		clock-names = "per";
-		assigned-clocks = <&clk IMX_ADMA_I2C2_CLK>;
+		assigned-clocks = <&i2c2_clk>;
 		assigned-clock-rates = <24000000>;
 		power-domains = <&pd IMX_SC_R_I2C_2>;
 		status = "disabled";
@@ -274,9 +269,9 @@ adma_subsys: bus@59000000 {
 		reg = <0x5a830000 0x4000>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
+		clocks = <&i2c3_lpcg 0>;
 		clock-names = "per";
-		assigned-clocks = <&clk IMX_ADMA_I2C3_CLK>;
+		assigned-clocks = <&i2c3_clk>;
 		assigned-clock-rates = <24000000>;
 		power-domains = <&pd IMX_SC_R_I2C_3>;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 33a3584..c6b2870 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -198,11 +198,11 @@ conn_subsys: bus@5b000000 {
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b010000 0x10000>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
+		clocks = <&sdhc0_lpcg 1>,
+			 <&sdhc0_lpcg 0>,
+			 <&sdhc0_lpcg 2>;
 		clock-names = "ipg", "per", "ahb";
-		assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
+		assigned-clocks = <&sdhc0_clk>;
 		assigned-clock-rates = <200000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_0>;
 		status = "disabled";
@@ -212,11 +212,11 @@ conn_subsys: bus@5b000000 {
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b020000 0x10000>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
+		clocks = <&sdhc1_lpcg 1>,
+			 <&sdhc1_lpcg 0>,
+			 <&sdhc1_lpcg 2>;
 		clock-names = "ipg", "per", "ahb";
-		assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
+		assigned-clocks = <&sdhc1_clk>;
 		assigned-clock-rates = <200000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_1>;
 		fsl,tuning-start-tap = <20>;
@@ -228,11 +228,11 @@ conn_subsys: bus@5b000000 {
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b030000 0x10000>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
+		clocks = <&sdhc2_lpcg 1>,
+			 <&sdhc2_lpcg 0>,
+			 <&sdhc2_lpcg 2>;
 		clock-names = "ipg", "per", "ahb";
-		assigned-clocks = <&clk IMX_CONN_SDHC2_CLK>;
+		assigned-clocks = <&sdhc2_clk>;
 		assigned-clock-rates = <200000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_2>;
 		status = "disabled";
@@ -244,10 +244,10 @@ conn_subsys: bus@5b000000 {
 			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET0_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET0_AHB_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET0_TX_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET0_ROOT_CLK>;
+		clocks = <&enet0_lpcg 3>,
+			 <&enet0_lpcg 2>,
+			 <&enet0_lpcg 1>,
+			 <&enet0_lpcg 0>;
 		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
 		fsl,num-tx-queues=<3>;
 		fsl,num-rx-queues=<3>;
@@ -261,10 +261,10 @@ conn_subsys: bus@5b000000 {
 				<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET1_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET1_AHB_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET1_TX_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET1_ROOT_CLK>;
+		clocks = <&enet1_lpcg 3>,
+			 <&enet1_lpcg 2>,
+			 <&enet1_lpcg 1>,
+			 <&enet1_lpcg 0>;
 		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
 		fsl,num-tx-queues=<3>;
 		fsl,num-rx-queues=<3>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
index 2486c72..2368e52 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
@@ -4,8 +4,108 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-&adma_lpcg {
-	compatible = "fsl,imx8qxp-lpcg-adma";
+&adc0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&can0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&ftm0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&ftm1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&i2c0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&i2c1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&i2c2_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&i2c3_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&lcd0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&lcd0_pwm0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&spi0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&spi1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&spi2_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&spi3_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&uart0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&uart1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&uart2_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&uart3_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&uart0_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&uart1_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&uart2_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&uart3_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&i2c0_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&i2c1_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&i2c2_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&i2c3_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
 };
 
 &adma_lpuart0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
index 27a3b46..5f6552d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
@@ -4,8 +4,72 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-&conn_lpcg {
-	compatible = "fsl,imx8qxp-lpcg-conn";
+&enet0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&enet0_bypass_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&enet0_rgmii_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&enet1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&enet1_bypass_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&enet1_rgmii_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&gpmi_bch_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&gpmi_bch_io_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&sdhc0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&sdhc1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&usb3_aclk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&usb3_bus_aclk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&usb3_lpm_aclk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&sdhc0_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&sdhc1_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&enet0_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&enet1_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
 };
 
 &usdhc1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
index 842849b..742e57f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
@@ -4,8 +4,96 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-&lsio_lpcg {
-	compatible = "fsl,imx8qxp-lpcg-lsio";
+&fspi0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&fspi1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&gpt0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&gpt1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&gpt2_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&gpt3_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&gpt4_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm0_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm1_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm2_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm3_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm4_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm5_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm6_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm7_clk {
+	compatible = "fsl,imx8qxp-clock", "fsl,scu-clk";
+};
+
+&pwm0_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&pwm1_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&pwm2_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&pwm3_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&pwm4_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&pwm5_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&pwm6_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
+};
+
+&pwm7_lpcg {
+	compatible = "fsl,imx8qxp-lpcg";
 };
 
 &lsio_mu0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index c27043c..589483a 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -97,13 +97,6 @@
 			  &lsio_mu1 1 2
 			  &lsio_mu1 1 3>;
 
-		clk: clock-controller {
-			compatible = "fsl,imx8qxp-clk";
-			#clock-cells = <1>;
-			clocks = <&xtal32k &xtal24m>;
-			clock-names = "xtal_32KHz", "xtal_24Mhz";
-		};
-
 		iomuxc: pinctrl {
 			compatible = "fsl,imx8qxp-iomuxc";
 		};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
