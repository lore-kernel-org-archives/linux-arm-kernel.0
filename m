Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:28:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1982146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aw9bhWEK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q7bK/Fgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1982146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jFHqVyB9m55EYGbtUfA686HUp7B1zIHQL47VCO2FPrY=; b=Aw9bhWEKqKUDkL
	Kyy7reS2BBkJTmb27MbS+KB4Upommhs5fbZyNrAqa9Td9mSV2RIuK2ZpOrvKYTRfmOOs6Toqq3iF3
	DcPSrzE2xqv6c7aEA56QTicKwLngEm2rwpCUWCKmmRtIxoktnstNp02ZIg0iRHPnxHdOHZuNoNtHO
	eksfeRHIrravGhNxtkorZOrfed6bocbEA/I4B8ojlHu8qAa5fcjguPYl5Qxmse7Idl3K9mGvUpmG7
	ai81kO0SwXptnLi1oTkKs8limRYZOgTxW3T2gQYiTvI+6H7jTKAFckirL9u2no0geLTV9RLiKQxcS
	1P++5e3XLhzokkc1sKlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcoRl-0000l4-7n; Fri, 28 Dec 2018 09:28:49 +0000
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcoRh-0000kM-3b
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 09:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fikneUZ9NAKPjgtOA0uOedyqFjoEIl879He2MA/ces8=;
 b=q7bK/FgdAq/TsoJip32QwcMYngqnzNUJyCRg2pAKE8mRvcv0Vdq5uHJRpxhNg6r9Liqkdidn9VluUbWRX9TBAKgZvW9OHj0g5juxWernSjbFLwe2A7aQ/6hDq/AMJ26tbcXHyvp+7c7O0iiHK6sbo+heXOKnKlsGKJyqOfE+dFM=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4912.eurprd04.prod.outlook.com (20.177.49.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 09:28:30 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 09:28:30 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] arm: dts: imx7d-sdb: add SD3.0 support for usdhc1
Thread-Topic: [PATCH 1/2] arm: dts: imx7d-sdb: add SD3.0 support for usdhc1
Thread-Index: AQHUno+xahTDLtjLHEO1IuDUvFqvRg==
Date: Fri, 28 Dec 2018 09:28:30 +0000
Message-ID: <20181228093558.18434-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4912;
 6:NwV9Ft9DUxGcqO4cJCyynenwO8870/yDX9Mafcb9soTOd2Wtp4hjCKbFPvUxk1sqjf9ADah9L85obnwK8+rF918fnHJT67/thlxUn7GYTa27XU85JYbUmkh9h4P4jAAJknc35qPQ/+4+dtapueXSra51DZgSWDO5dXw/bRzSkdAhI0AxxQy1X2Ez2VuQ05ABlE7uJTIDS9K5Dij39VA4x/v9KSxTKIilFmXfr6oUdKQOa3kHlThQ4Eltoa1QoGedb8dDv2UOMqrLEa+hDERVFFJBIfjN75jDEdrf+qB71IKQTRM0+0MacdIjSoMJAY/PKUeQfUOo2TqYkGtDLy2C3eq9UaD+OnMsKrD7jGc9ROD+1HebvW1Id4SDEOEczKtaRtK5PzaZnr0atI1LjkgEU/7WoEhsnf9noy1M8xOrAgjSx+zqfQ4gVy0CnjWpo0YCY+vNUVnMbYcmGUIKkcQICQ==;
 5:YjJ7Xy/4L9hwRMANRZZ7jWaVYNxPlgoFMj4i/PY57B7Gyo9vOB9mDAm99iy7246Z1ZzdElEXw50H7b1LNf25we74CXkgIhDkYfKbSpK3dLeNeBfzm/fSRMI8yF3LMVZ2HKTQMTG09ig2IXur0ur7bFU1eGxpoDGnsxPIy8fgXnQ=;
 7:pejDNKCOdVvYOaM9hrbpWz8A9I5b58ZY8bmZ611UabcWYfehgkQQoBtsrE13nl8O13tebhMcfuSntQcJVEmZc+Va3ZTi4xXrypsUS1Qw17h223W2x103laOK8sA3UmaPE9/y0TiFP2sHhcV7zNETUg==
x-ms-office365-filtering-correlation-id: f94b5f3a-768e-4c95-6bd0-08d66ca6d41c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4912; 
x-ms-traffictypediagnostic: VI1PR04MB4912:
x-microsoft-antispam-prvs: <VI1PR04MB49127F5AF6051291C8AB18B090B70@VI1PR04MB4912.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4912; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4912; 
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(2616005)(99286004)(486006)(105586002)(66066001)(256004)(14444005)(5660300001)(102836004)(476003)(478600001)(25786009)(186003)(110136005)(14454004)(97736004)(36756003)(106356001)(316002)(6506007)(53346004)(1076003)(6486002)(53936002)(6436002)(26005)(6512007)(386003)(50226002)(7736002)(6116002)(3846002)(2906002)(2201001)(71190400001)(305945005)(575784001)(86362001)(52116002)(2501003)(68736007)(71200400001)(81156014)(8676002)(81166006)(8936002)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4912;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +sHwzsF56uON//HLP7tRaVC47fbS9gtDEmxL2c+8zaCxZkhoCwYV5B8XQ/YsbhsfkrqcU90EPhiIi1IXv4R/GxYFSuMupjaeSLYn0ixR00rlfEedn+Ei3nIPmShWlBbZsVP9OXWzJRmzcge2jQMXOUiKhRKMfurTWtHGDspC2ZpaNew9nucWXpLUw4+7ys0mPsRFRgHbSCqcQTSJWG4sNI95S3m/0QhgOUKbKQVNhOMz8mQsio8LaydzzUUpc+b72XGzkwQg9fmTSnDx2bW6u7aqF4IevBS5E9gdgKqY2xnPFq2dekIrsmhch3dsxQPj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94b5f3a-768e-4c95-6bd0-08d66ca6d41c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 09:28:30.1929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4912
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_012845_149895_CA3F08AF 
X-CRM114-Status: GOOD (  13.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add usdhc1 support SD3.0.

Besides, add fsl,tuning-start-tap for all usdhc, imx usdhc IP
logic require the tuning-start-tap larger than 10, to make
sure the tuning logical can work normal.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 55 +++++++++++++++++++++++++++------
 arch/arm/boot/dts/imx7s.dtsi    |  6 ++++
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 202922ed3754..ded43decf46c 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -87,6 +87,16 @@
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_SD1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <200000>;
+		enable-active-high;
+	};
+
 	reg_brcm: regulator-brcm {
 		compatible = "regulator-fixed";
 		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
@@ -408,12 +418,13 @@
 };
 
 &usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
 	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-	wakeup-source;
-	keep-power-in-suspend;
+	vmmc-supply = <&reg_sd1_vmmc>;
 	status = "okay";
 };
 
@@ -426,7 +437,6 @@
 	keep-power-in-suspend;
 	non-removable;
 	vmmc-supply = <&reg_brcm>;
-	fsl,tuning-step = <2>;
 	status = "okay";
 };
 
@@ -438,7 +448,6 @@
 	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
 	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
-	fsl,tuning-step = <2>;
 	non-removable;
 	status = "okay";
 };
@@ -638,6 +647,15 @@
 			>;
 		};
 
+		pinctrl_usdhc1_gpio: usdhc1_gpiogrp {
+			fsl,pins = <
+				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
+				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
+				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /* vmmc */
+				MX7D_PAD_GPIO1_IO08__SD1_VSELECT	0x59 /* VSELECT */
+			>;
+		};
+
 		pinctrl_usdhc1: usdhc1grp {
 			fsl,pins = <
 				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
@@ -646,9 +664,28 @@
 				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
 				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
 				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
-				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
-				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
-				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /* vmmc */
+			>;
+		};
+
+		pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+			fsl,pins = <
+				MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
+				MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
+				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
+				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
+				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
+				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
+			>;
+		};
+
+		pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+			fsl,pins = <
+				MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
+				MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
+				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
+				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
+				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
+				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index e88f53a4c7f4..bee8dc2f614b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1036,6 +1036,8 @@
 					<&clks IMX7D_USDHC1_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1048,6 +1050,8 @@
 					<&clks IMX7D_USDHC2_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1060,6 +1064,8 @@
 					<&clks IMX7D_USDHC3_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
