Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32327C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F406120874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VvY92d1E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="saF5lVrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F406120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ziAow9OWYMS1l+pvGeN7Wk+pH0eG/qH7z0Uwc+4CUQ=; b=VvY92d1E1lrA0m
	7HCSmW8XgwxEqx30HFUsO9GeSmMR31b9L2n5cgr4Jw+Fh/yJw2LiPndtu1p92++8YJNkMJKa9adTR
	WFtJSsCrUbw1F1dv9gJvLlRMhbybKN3iPTooHs5XtFe0mNEX9Vijl4ugVqA6gG/1ega1RUcCFW8hX
	T2J8Dd0jZhszvHaRY1ASObkz4F/JyATfjeHKvmP/kB8xHuBWna1J1OlaU1ZDzLZ2qNrgDPmRrb7QS
	ssN4aalN2JxU2qNHqi1zGp9oGUX3uc8bS4L1KtvhtH0QapNi16p54U1Ze+5Bugq9PDVApU937gPB8
	A8r/r4WFWiPFM312VlnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuPT-0008Un-4L; Mon, 17 Dec 2018 15:02:19 +0000
Received: from mail-he1eur01on0611.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::611]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuOS-0007HY-62
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZHAiKGwzxGNvlViZBklMjLXfU+KBdMx+uxVUib6TNs=;
 b=saF5lVrg+y91W6hYmgM/a4Ag9PKT1LPceb/6eTh3jDH5AtCD4m704VdsWmjvRMgsOyYBtO/A9v/uP/itBLQ5yRs1z3QkfbIP2STr+jUVYp8J72DHehNcqV53SURKpdErsEiCvBtoF3GRpUEmB2HKbnVWjIpYBDcmkWAyL8knI1w=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5139.eurprd04.prod.outlook.com (20.177.40.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 15:01:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 15:01:01 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V5 3/4] arm64: dts: imx: add imx8qxp mek support
Thread-Topic: [PATCH V5 3/4] arm64: dts: imx: add imx8qxp mek support
Thread-Index: AQHUlhlSOOswFoPJeUiD+a+m4JCdJg==
Date: Mon, 17 Dec 2018 15:01:00 +0000
Message-ID: <1545058517-18643-4-git-send-email-aisheng.dong@nxp.com>
References: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5139;
 6:01HLrs8QO8I5BKNgLElW0xbghI9Ep08Oh1qwyOgz+YbYuA0A3qCpxw5i4nFoYUuYvCI9jlitwnL+TVvqIZ8hoYKlNR/OjgZqJCdPqLwt5+kGHQwca2ZzKN2P849OvWhQgcrPk3pZwU6+txXGifM5MOSe/c9UhwoFda1uWiA97erZyuN0uYnL4OcyNBZb8t0xarMR8/4tAKZ08Tma5wD+cKVBvYoPVbJrF5kcvcZ2WKV1v3Y70/PzY7cM6pdP49W2CuF2tkEh7VGEEfqdsZVMxGvDVAbyTkhUWJDeH3A9mvp+/i8RJ9/byWhP45lS7ZzqDSlGsLneUzJ+Bl9CgMrz+w6cRMeSdlhUQzNKQFMW9Nfo3rqAAbeBl6hGfxA7vs+chlXh/Ou6XLpoYtXcrWKSx86Q2GCTF4lN1rhJKfJIQdC1bFUUjEjpVXUrK8Ww6chjg5A+4Qp8/nZyNBu3pJx60g==;
 5:U2LFA8Owdmh05yTZCeP1BAuT5G+E0OVmVG9ncl83nSCzGiGEjVprZwmgEHsu+uv1p0zpvcMvBfooO16zmwxEFzEt3MlTnchFJ5ad5VKUckeNgvr/sfuCvEwo5ECy7qMCgMmIg5sT8Mf/87DxwsJHzqyVazWXAbYPk4ygj5j97nQ=;
 7:hUOb0NCFxWNLBVnQC8EiS8W7VS0QOlwdo1rJSK0v98/Trp4VUE0A9GdiDIn+Igtwve9RVLABeDWknMqAdmJ76NtCCKWAoBm0oU0W8283DpVoNkqt3MTDY3vkp2tep7r7D05OP+l5XXKAuFosAAgTYQ==
x-ms-office365-filtering-correlation-id: 9d041732-ffaa-4bbc-c62e-08d6643074e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5139; 
x-ms-traffictypediagnostic: AM0PR04MB5139:
x-microsoft-antispam-prvs: <AM0PR04MB51395084031C65F1EC7B108F80BC0@AM0PR04MB5139.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5139; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5139; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(2351001)(106356001)(66066001)(186003)(71190400001)(71200400001)(53936002)(81166006)(36756003)(4326008)(14454004)(99286004)(478600001)(316002)(97736004)(6512007)(25786009)(54906003)(6116002)(305945005)(3846002)(7736002)(44832011)(102836004)(6506007)(76176011)(446003)(2616005)(476003)(11346002)(256004)(39060400002)(6436002)(2906002)(2501003)(5640700003)(14444005)(50226002)(486006)(6916009)(386003)(575784001)(86362001)(8936002)(8676002)(52116002)(105586002)(68736007)(6486002)(26005)(5660300001)(81156014)(32563001)(473944003)(414714003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5139;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QfbmLm+l0O9To0+N9Y0Wzp9d973o3GiOfhPF+/1hnjb6rG6zfKMwqFbuHLbM0UdxbngU9SeB15g8WqWdlnIv5TCiEaF4OhnSr1NCGglGW9tps3JMkgU0zdCOxvpy+fRdQBtP3GN79NepNk873PRJl2GjQvUDebbQLyGxK7DXfYOUZyPhKDXAGphT8Ccvh4hlo8DSxUsZ2Xgm8Nx47d87EZjUhKNNb0rTL7B3E2ARVEaqah9UY9HalQmD3r0ld6R3JLNRXNuEWsfpt8oCcRUqCDWaeHKHgnttCqjj7+f0h54JJkAF99F1JVHlOR/cGzTO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d041732-ffaa-4bbc-c62e-08d6643074e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 15:01:00.9074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_070116_657818_B18B4A5C 
X-CRM114-Status: GOOD (  16.03  )
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
graphic and multimedia features. This patch adds imx8qxp mek board
support.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v4->v5:
 * change the dts compiling to depend on ARCH_MXC instead of SOC_IMX8QXP
v3->v4:
 * remove un-documented enet phy properties
v2->v3:
 * Pad names update
 * move memory node to here
 * add no-sd and no-sdio under emmc node
---
 Documentation/devicetree/bindings/arm/fsl.txt |   4 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 137 ++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 9b5be3e..8e64985 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -105,6 +105,10 @@ i.MX7ULP Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp";
 
+i.MX8QXP MEK Board
+Required root node properties:
+    - compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
+
 Generic i.MX boards
 -------------------
 
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index f9be242..0db6e37 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -20,3 +20,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
new file mode 100644
index 0000000..03aad66
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017~2018 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8qxp.dtsi"
+
+/ {
+	model = "Freescale i.MX8QXP MEK";
+	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
+
+	chosen {
+		stdout-path = &adma_lpuart0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	reg_usdhc2_vmmc: usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "SD1_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&adma_lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
+			IMX8QXP_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			IMX8QXP_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x06000020
+			IMX8QXP_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3		0x06000020
+			IMX8QXP_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC		0x06000020
+			IMX8QXP_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x06000020
+			IMX8QXP_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x06000020
+			IMX8QXP_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x06000020
+			IMX8QXP_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2		0x06000020
+			IMX8QXP_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
+		>;
+	};
+
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8QXP_UART0_RX_ADMA_UART0_RX				0x06000020
+			IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD			0x00000021
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0			0x00000021
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1			0x00000021
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2			0x00000021
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3			0x00000021
+			IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4			0x00000021
+			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5			0x00000021
+			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6			0x00000021
+			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7			0x00000021
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE			0x00000041
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK			0x06000041
+			IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD			0x00000021
+			IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0			0x00000021
+			IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1			0x00000021
+			IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2			0x00000021
+			IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3			0x00000021
+			IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT		0x00000021
+		>;
+	};
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
