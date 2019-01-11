Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764FD21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cyvsq6qu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1lV1tpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764FD21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/bUYs+lZMKnBdNDL0arCytk9sdaNexe7Vx70IrtAGWQ=; b=cyvsq6qudVtjD9
	4KBpn2q8rfvJ0AgjSIs49S02eqNN0eSf4+BJM8QruheWDfm6X+zzUFven7EibL7ZPY/T2yv0AF7Eh
	zQKqNvKKfc4wjbqci8r63+fbHsYGoZO3oja+1tcjgRMSzpHe0bm1QB4tqnPEwH+NG/WGha5rAm6KK
	iuXaLS/z2gnbJC/8pElJl4ZGnS+mm4ldx+MFAoa01L8acKEzr0wfFjOUuyuqCJwjBUwIFHRBJbz8T
	5ISupytUPlaKBpl+Rd3aHB5YPcPhoo3/ysWd2gme3sbjdUIT6GCAfg/X6NPbIiUv9HtAiV8+xgI9D
	9tGZFLg5Mc8JclcJcIHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv8o-0003tK-Om; Fri, 11 Jan 2019 11:38:22 +0000
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv8A-00037D-Qx
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hymFZ9+Eynvs/XUB5F9UpmrfLLe31m6L01jKd8Ftyqk=;
 b=M1lV1tpqqYhtlbcRMTrBvD965H/PYNfSayi7eQUqrnIzIxqyqV7Cu8geUoz8u0PDJnhjneO2+XPohfx0SztQ6/77p79lRn0qtcn3urEYCHi3Er6Qy2R/OZnAMzionoh/e8doBBNcjNlR9a6oihaNrVLG1Ea2p2v8/wlFLZqQjRA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5251.eurprd04.prod.outlook.com (20.177.42.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 11:37:33 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:37:33 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V6 3/4] arm64: dts: imx: add imx8qxp mek support
Thread-Topic: [PATCH V6 3/4] arm64: dts: imx: add imx8qxp mek support
Thread-Index: AQHUqaILVDoOCpCLdUCRuMPpu0/JfA==
Date: Fri, 11 Jan 2019 11:37:33 +0000
Message-ID: <1547206279-26169-4-git-send-email-aisheng.dong@nxp.com>
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
 6:PEufJa0nekeHQu8pHOy89qieGdDI0VOqmcwOXsmPpstGPC0opC+qIPswCd7NEX+glosL5uuFfYXLozIU5eLrbegS/6fIC/6jJOEliQcc5TvKLtNCsk8figLcxOT/cZ2h3ZFrf9iWUe7nl0v/sBl1anDwVGrtZvjtTqO23aMbsc7MRqr7khB4PbEFugGmPdz2crPzs4YASBDyH7c/NKh60KNRMYc0gwR/oqXEL/1xU8go8explvG6enAZZxY3ca567/BvC2IA8ya5z8M4uFfEGTNk/sh9xbYawysBJ9hUWyj5hPqFrCg+qhFbDetvQBZ3cbt8jIqiZPXMUtbrbbVgnV29Nk6eOyrefpZ1SAhh7xxn+9b3Zz9AaxA+RPi049zNOrC7nh8shwVic3NOZId3TecayftPJGYH07zVmN1GYOSj0nECp4civ81Ze4jomoN9I2UJooJLGid1VkUZ0IyeSQ==;
 5:8AK4FLpsMqm4jpb2A6JriYHmMc0CfC1ixRM2zCjhmj14T+ssqHueSpJM9xHxbKJ77+8qtxEFaWYy3uLWPbT6ExdLffqWZDh+h96U0Y9yfp/EIUnHGdhHH+jGwWQOV7HCam5T3Id/1Y7rHIakFSQBidf18JbxFuU2/mW7J1bajU6P/SIrD94up76ZUku8D8qkETl5H/31e4LqmM0qubJyeQ==;
 7:bWHHQLC+UZ6295xu5ev21W1MblKEFMighzgS6qZaDfN9dtHUnv87TfkE8cf7P00kgR9yQW2QHLzZEYiqQDBGf/c7Ghmnnt30zE/mEUd/wusO+Fe0pMUy92QQv33uaQN8m6SG7prrwQXHJnux9uX+zw==
x-ms-office365-filtering-correlation-id: f66efe78-cdc9-414f-648a-08d677b92d6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5251; 
x-ms-traffictypediagnostic: AM0PR04MB5251:
x-microsoft-antispam-prvs: <AM0PR04MB52514A406FC25D0DB3A0D88780850@AM0PR04MB5251.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(99286004)(68736007)(476003)(4326008)(105586002)(81166006)(81156014)(2351001)(2501003)(36756003)(14444005)(8936002)(256004)(39060400002)(71190400001)(50226002)(6486002)(106356001)(71200400001)(86362001)(14454004)(305945005)(54906003)(575784001)(478600001)(7736002)(316002)(102836004)(6512007)(486006)(6506007)(386003)(446003)(6116002)(3846002)(52116002)(66066001)(76176011)(8676002)(26005)(53936002)(5660300001)(44832011)(186003)(6916009)(6436002)(2906002)(11346002)(2616005)(5640700003)(97736004)(25786009)(32563001)(414714003)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5251;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5qZG7rtroT55P5i8hH9HENmaobksgsQ8ZduZwgIHHCsYeBIw3LuRvNyN2lbdT5oLAKONjH2T7psWV9HDfI9Qk/+G93ilVqafZt9oW7xIaGAvDvdKYD9JSCD3rBek6Ycb+Q9rY7R+8Ai50/ivk5qhHPKzHkaKOeMsXXR5MIfizXIBL6p+N1ySS+qz55urhxi2sRanDdTwcHRIxvbQpEo3W12FjjOxzBYKmVmnRRQTpsIC8GrLooWyqnOB5t8KCsaW0kl9ta16eqGWXrux08O/yo6wd0LuZDhQEhAqe7Jgk4X3WGwSHJegLoy2sa1QvPO7laL52QwF9YNGrQgMVADceqVP0F46v+ZHzWRK48CRY1s9CuEf3MIux6GsM3XKLHBqPofmalWgnof99LmpmG6otHA/MBdFv3U0MMa1dTSO+Is=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66efe78-cdc9-414f-648a-08d677b92d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:37:29.6811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5251
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033743_955783_5354D078 
X-CRM114-Status: GOOD (  16.17  )
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
v5->v6:
 * no changes
v4->v5:
 * change the dts compiling to depend on ARCH_MXC instead of SOC_IMX8QXP
v3->v4:
 * remove un-documented enet phy properties
v2->v3:
 * Pad names update
 * move memory node to here
 * add no-sd and no-sdio under emmc node
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 137 ++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts

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
