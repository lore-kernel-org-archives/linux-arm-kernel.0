Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4C020836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dvAmVzho";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cuaZnP14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BWTAHGKoVbbP8dkomdnHh2AadADiBzqJMIiKiE57MaA=; b=dvAmVzhoSNI0YP
	4r56pNYKB1M6ux21xiWEUwriVKAfNq66vOKYd8VfreXEGlSOqi98VAhvLgHTsMB08NIdEUMi9WN2n
	vCW+VyqSNpoO8NTN5G0TK6iKANRcfxu5WGCHIPNKlaDKmRl5AYF2ZeDgSix252yQ2lBeD/KriGWHc
	4gHV60f6lRs4qjqoM74PehONsl+BsdfdXibQxql3Vj1R419zW17a90QbtHj6Ylx1gPV+0dexAij7D
	2s8MiZ+SydrprO8BtEJ5aCurrXhAXJUydS6RP0knAGFWukx9S4HssWFZiIC5NdIx/MvePrJMpOa0M
	vrmZNxacNPgBvrx2iRkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwshX-0006cx-JB; Thu, 21 Feb 2019 18:04:03 +0000
Received: from mail-db5eur03on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::62e]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwshK-0006Mm-Dx
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL5R9WCj4omn5WNCf1ygp4iDP5b9SN7wpC82d1LsMMc=;
 b=cuaZnP14yVxIjupqUXQZrs/k8qFMAgNenL5acWwSoJL0mQSXbEB2l/q6ipwS3H2QtJ5EeZ9e9QlJBL3jNuvOCqkeMTwRTd1hAOTB44d5jYxuz4nNpFkoCr8XPQrCODQt7h1Bx6vXpuPjhwsuCYet+bamNMGpsVk1eWcCj/0vhBw=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB1663.eurprd04.prod.outlook.com (10.164.85.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 18:03:44 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:03:44 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: firmware: imx-scu: new binding to parse
 clocks from device tree
Thread-Topic: [PATCH 1/4] dt-bindings: firmware: imx-scu: new binding to parse
 clocks from device tree
Thread-Index: AQHUyg/ILVDNycVxtkiL1Tyb3hPiwQ==
Date: Thu, 21 Feb 2019 18:03:43 +0000
Message-ID: <1550771836-10014-2-git-send-email-aisheng.dong@nxp.com>
References: <1550771836-10014-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550771836-10014-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e8aff01-a314-4eea-74a6-08d69826eae4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1663; 
x-ms-traffictypediagnostic: VI1PR04MB1663:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB1663;
 23:r1RFtNaLwCf2nvHhUFPQJESoqnXRZrR1OeV3SXO?=
 =?iso-8859-1?Q?S/3ePEbs1h1sg0w+voltx5JhRFril1u+2d09Y01IdAY7wPFdu0cmc+Apy9?=
 =?iso-8859-1?Q?dvNOGP7sxveFrHip6vWcreLLNXaO+KKep/MM+fQ6mLolDCtYiYsTNsuMts?=
 =?iso-8859-1?Q?OI3qtdOwEBK4G2GmfZ1Er88SdT5bXcYXHww9A3u08XFuExubFxYuK8tFT6?=
 =?iso-8859-1?Q?s+Ah1Njyp1TalExqCE1xDtQjaELLb+wKjCZQxGfWEQorxw9W3FGHicY49i?=
 =?iso-8859-1?Q?jGTf5+wLQaqHzPEUInV+GjRHyNA/F3rL3QLUqFYXTh6IYihWF3ArDUIIRL?=
 =?iso-8859-1?Q?k4Lp9UnLbK0Er1Egj1AAAIRxbt+G2lvCFxc8hWwzjPDS6vAithO3XHZfgv?=
 =?iso-8859-1?Q?SobdhwIdvYY15uonSaWTadNM2hoV+YD0vAUjXb/FHW36nQxFc8n9TFmI/Z?=
 =?iso-8859-1?Q?vkj1npWAGxm5VUYq/pcunWd33N0D/p0duQR15aBtq9tlK8kZYvWFOLoe54?=
 =?iso-8859-1?Q?flrF/M5Q6RCDcVsatKQE2xb/L4GFWBaUGCNKa9pFVVXzdJ2gMRFjjTUZ6p?=
 =?iso-8859-1?Q?Y+ffVy8IArsJqQBYPuPyv1NdFSVwqHiVzZ2Vo/VnvBycS+Oo2/axX4/3K+?=
 =?iso-8859-1?Q?7aV7g13hQcsMVukPfavhodkMYEDD3IEhjxhsG0h+R6C53vho29dKRK+yUY?=
 =?iso-8859-1?Q?pm24WYFKxjObpyZw0PEAhzflat/GW5s3mZn9f/lJ3HXS4wJkihrRJ86eik?=
 =?iso-8859-1?Q?LXLRtfyJQXj+4FvopXmklX9AmW2EYhiyFaIKtSaiyWQBDRWFTDsxtBCN1A?=
 =?iso-8859-1?Q?v/oCEeU5hoNC+HlP0F2JE2e9M8df8GHblBJs+CRCmkLkXt9aksI73MWkLs?=
 =?iso-8859-1?Q?hho5atwnU2OexGZ7OYaSrL4L4gfXGNX42vlKr08yMSTkTQ4fRt2juhc/tp?=
 =?iso-8859-1?Q?emusevEwrKaTjg3jJuKFwxKev4Ce3W2hd4mjbd/h0CAya2w3AqTWnJmq0P?=
 =?iso-8859-1?Q?bTs2VAgQQtxN9SH4Iaj8ddl70mP7l5Ogzpf2QeQER+9iz41UCQYkvq6kne?=
 =?iso-8859-1?Q?jqltnmR/ZOL0ntQTJmfw5dTCnW/xYpeGEaPfElNoN7O2nSDcymEBpR1ol/?=
 =?iso-8859-1?Q?izlmLG/IuBo2EwVurbK/315zQu/W5nDa4+YoCmMpNEXgqsiZYRIVGGDIjt?=
 =?iso-8859-1?Q?vDCLz1tE6YZmZL6uyhKIz9WhG19F0dGIl1xAxFQEi77SCu1Ze/KPlT1PuW?=
 =?iso-8859-1?Q?7eywrqOGjgUpSf99tefy+OOfFc8qSF6bv+49V+p9eUzgti/KB727/SuD9y?=
 =?iso-8859-1?Q?Lwuzju+sgldpJVh+WHumtINyFCntv8+4yHds36qVYgy5A=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB16632E7BA8D855112F77DC98807E0@VI1PR04MB1663.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(2906002)(8936002)(186003)(81156014)(4326008)(71200400001)(71190400001)(6506007)(97736004)(99286004)(102836004)(26005)(50226002)(2351001)(6512007)(68736007)(81166006)(386003)(3846002)(14454004)(6116002)(476003)(316002)(8676002)(5660300002)(478600001)(54906003)(2616005)(25786009)(44832011)(36756003)(305945005)(446003)(105586002)(106356001)(6486002)(486006)(76176011)(7736002)(14444005)(53936002)(66066001)(52116002)(256004)(2501003)(6436002)(5640700003)(11346002)(6916009)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1663;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EAXG5fsPFZXOIG/XsMSByP1sZoh9CHr+6uiA3aoC6pn5Q/Ht/qmWs9zNnoQe/7IlbFkEDFrmVZw3UVZ+yQuLZg8E6XLMkie2YHHol5pusMnEbz1m1YIheecVFpzks+cgykgle9i3UPACCwaqlmn7PEd450hafg6Pd0OUuTwcMaocbNKe3OVggDMcP2hD86Cz7J0PCkmYdKbAwCRo/DCt2HPetvJ80fDtcSTUlS1zJaZMJJ3pK8HGZdS/0afXNaGUESUU0ITxR0G0c3SVoF6GLs7weSQjA6Ed3nNp8bxz6cxNxxqNsaHgU0TlfQuCKwBtmeK+pTwkw/NWhthXjJnzvtPVR37ev+XAGLRCV/boNEi5XCEGcLWCAGFr6mIrZ4AZROzjMJu3Ic1Invk0cuXBFTrhdLFMA0XTtgmqOhKEtnM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8aff01-a314-4eea-74a6-08d69826eae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:03:40.2800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_100350_483360_5414E687 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There's a few limitations on one cell clock binding (#clock-cells = <1>)
that we have to define all clock IDs for device tree to reference.
This may cause troubles if we want to use common clock IDs for multi
platforms support when the clock of those platforms are mostly the same.
e.g. Current clock IDs name are defined with SS prefix. However the device
may reside in different SS across CPUs, that means the SS prefix may
not valid anymore for a new SoC. Furthermore, the device availability of
those clocks may also vary a bit.

For such situation, We formerly planned to add all new IDs for each SS
and dynamically check availability for different SoC in driver. That can
be done but that may involve a lot effort and may result in more changes
and duplicated code in driver, also make device tree upstreaming hard which
depends on Clock IDs.

To relief this situation, we want to move the clock definition into
device tree which can fully decouple the dependency of Clock ID definition
from device tree. And no frequent changes required in clock driver any more.

Then we can use the existence of clock nodes in device tree to address the
device and clock availability differences across different SoCs.

For SCU clocks, only two params required, thus two new property created:
rsrc-id = <IMX_SC_R_UART_0>;
clk-type = <IMX_SC_PM_CLK_PER>;

And as we want to support clock set parent function, 'clocks' property
is also used to pass all the possible input parents.

Cc: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 29 ++++++++++++++++------
 include/dt-bindings/firmware/imx/rsrc.h            | 17 +++++++++++++
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..2816789 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -78,6 +78,19 @@ Required properties:
 			  "fsl,imx8qm-clock"
 			  "fsl,imx8qxp-clock"
 			followed by "fsl,scu-clk"
+- #clock-cells:		Should be 0.
+- rsrc-id:		Resource ID associated with this clock
+- clk-type:		Type of this clock.
+			Refer to <include/dt-bindings/firmware/imx/rsrc.h> for
+			available clock types supported by SCU.
+- clock-output-names:	Shall be the corresponding names of the outputs.
+
+Optional properties:
+- clocks:		Shall be the input parent clock(s) phandle for the clock.
+			For multiplexed clocks, the list order must match the hardware
+			programming order.
+
+Legacy Clock binding (DEPRECATED):
 - #clock-cells:		Should be 1. Contains the Clock ID value.
 - clocks:		List of clock specifiers, must contain an entry for
 			each required entry in clock-names
@@ -129,6 +142,13 @@ lsio_mu1: mailbox@5d1c0000 {
 	#mbox-cells = <2>;
 };
 
+uart0_clk: uart0-clock-controller {
+	compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-clk";
+	#clock-cells = <0>;
+	rsrc-id = <IMX_SC_R_UART_0>;
+	clk-type = <IMX_SC_PM_CLK_PER>;
+};
+
 firmware {
 	scu {
 		compatible = "fsl,imx-scu";
@@ -143,11 +163,6 @@ firmware {
 			  &lsio_mu1 1 2
 			  &lsio_mu1 1 3>;
 
-		clk: clk {
-			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
-			#clock-cells = <1>;
-		};
-
 		iomuxc {
 			compatible = "fsl,imx8qxp-iomuxc";
 
@@ -175,8 +190,6 @@ serial@5a060000 {
 	...
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
-	clocks = <&clk IMX8QXP_UART0_CLK>,
-		 <&clk IMX8QXP_UART0_IPG_CLK>;
-	clock-names = "per", "ipg";
+	clocks = <&uart0_clk>;
 	power-domains = <&pd IMX_SC_R_UART_0>;
 };
diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 4481f2d..f650fc3 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -556,4 +556,21 @@
 #define IMX_SC_R_VPU			540
 #define IMX_SC_R_LAST			541
 
+/*
+ * Defines for SC PM CLK
+ */
+#define IMX_SC_PM_CLK_SLV_BUS		0	/* Slave bus clock */
+#define IMX_SC_PM_CLK_MST_BUS		1	/* Master bus clock */
+#define IMX_SC_PM_CLK_PER		2	/* Peripheral clock */
+#define IMX_SC_PM_CLK_PHY		3	/* Phy clock */
+#define IMX_SC_PM_CLK_MISC		4	/* Misc clock */
+#define IMX_SC_PM_CLK_MISC0		0	/* Misc 0 clock */
+#define IMX_SC_PM_CLK_MISC1		1	/* Misc 1 clock */
+#define IMX_SC_PM_CLK_MISC2		2	/* Misc 2 clock */
+#define IMX_SC_PM_CLK_MISC3		3	/* Misc 3 clock */
+#define IMX_SC_PM_CLK_MISC4		4	/* Misc 4 clock */
+#define IMX_SC_PM_CLK_CPU		2	/* CPU clock */
+#define IMX_SC_PM_CLK_PLL		4	/* PLL */
+#define IMX_SC_PM_CLK_BYPASS		4	/* Bypass clock */
+
 #endif /* __DT_BINDINGS_RSCRC_IMX_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
