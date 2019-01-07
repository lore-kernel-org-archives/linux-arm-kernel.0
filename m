Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D026DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:22:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14D8206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F5Mg4XAu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bsaEnai9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14D8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijrRmJy/jhnbNRQzOU2CRKNf4MYBuZx4Me399j+ek/A=; b=F5Mg4XAuE5pthm
	ICZsK8yev/BpDl/iFh0WnpuOQOJ0ShMmuLIeyecHlYnALUzgZKNXMyLOmAh4zOEWr2VACm4XDIUzv
	+LldOyodDG6TMPQQZ/Gh+asLnJejsadVA7VNnpmltYQByTwwccVDkH28td/ZlxI38GC1el+Yza/W8
	3MdfoQYctykz/lhk3pt3nrnxUxVAenOOAcpsOHyhym/5zI/7UVIwMxR0UMJf0mA2I7n6Cd6qleBkD
	PoguqJpE1vQsLl+jRRdbhqK+dX4ykr1S+c6C9EEP5anvlVYtcjd5yesDkaqAbEr7PpMClSpDQ23ro
	RIxgXW2+Vx3M/nVmksXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggR71-0003mD-KW; Mon, 07 Jan 2019 09:22:23 +0000
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggR6a-0003Ia-Kq
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRhDmrwjCqbi2rMmKO2wC/ztzOGPRmx9A6aDnYWMEhI=;
 b=bsaEnai9l/7rHVQqn5hyj8KFwf9DOazD6q+mTVK7SyrbeaBSIf4lHe6KdO+2mfCl3cCNd6le3mBsSQFF94uTqD0xaAgbcvCPB0Ms1WUPf88RfITZ+CtXvXeaYowxMUV3pIJprqa1cxq9aleAeT7dR6FsM0s/mB+eu0i+niOjcKA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5697.eurprd04.prod.outlook.com (20.178.119.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 09:21:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 09:21:52 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND V5 2/3] arm64: dts: imx: add imx8qxp mek support
Thread-Topic: [PATCH RESEND V5 2/3] arm64: dts: imx: add imx8qxp mek support
Thread-Index: AQHUpmpsxd11ILOKhE2UqsYVzCyiMA==
Date: Mon, 7 Jan 2019 09:21:52 +0000
Message-ID: <1546852546-29228-3-git-send-email-aisheng.dong@nxp.com>
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
 6:tx4c+zgL1KNnIXhTFINB1R10m2LnBtpum2MLJeDFP6OtYRqRzV9puqAbqRkietbjbdwbo8lakFhn06ocxh11dHup24nR0gHR3MEpM+notVMUcREvtpWTt/NERdBKrnbPyKhCAe1D0X56QQCa0JEnsCB2NThBMKM1/bISMyQ1ZSZis47oYpRihJ4EGczYi3crCcxnzAny/3UsHmiTHHD/WEUlk+gOs85DcH++0ayi4vcgl4RHTvp7LgwXxFgP0OXRvJ5/he84kuB9GqS78azDcj68+W6nI5mRkGUJqNXwc7emkTynTr8yy2BuDxhti+RY+lQUncyP9ri+kBGL8kKLbCp4Y1aX9q9Nmz9l4BBbgIGKaj0f40MKLTqJuLfFMJ0ARSnPW2wj81jpVN7tE2XFibmgMxyvOPbLPuXuQOzoYJnHaHA1dMNMQ7G7AKl+AGIR1u2MH3f01lBGmbX4KYF5oQ==;
 5:vn1PGBT0k8zmjAIEaDKwuV7v5NbkpvL03BwCCNJGT2c1PpgFQsTc5qclUcLgmn2UAbgcmu426VmFvX9LuYEYIr60DAdykiZ0PCVYvwFJKdG1/FaaEw93qu38BWvO/qlyLOktwYrYJvTUyDdhUrwiw2Z1gYaOBu/aSurCTaLMBxGhNmQIc9uPNedr+4MKTB3f648N+hMfK7WGJof51ZWlNA==;
 7:Aj3mzODLgt0yVsgkJFhe4c4XGaTyocM8lvbxxpim+ZMM8On3qLv65H1xtMFDJvNhufBUkqxYcM31K96PobkQw1E8n28yVFq9IKVp0enGyBC6jZoSiWl3NBeyHprpNjNy3CaFlD9bcK1blo0zxv+ZTg==
x-ms-office365-filtering-correlation-id: 0e330c26-b604-4225-6e95-08d674818f2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5697; 
x-ms-traffictypediagnostic: AM0PR04MB5697:
x-microsoft-antispam-prvs: <AM0PR04MB56975B8D2C63D43BFD0C444080890@AM0PR04MB5697.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5697; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5697; 
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(105586002)(2906002)(305945005)(68736007)(14454004)(5660300001)(6486002)(39060400002)(106356001)(5640700003)(478600001)(66066001)(2501003)(6436002)(575784001)(25786009)(217873002)(2616005)(11346002)(54906003)(446003)(86362001)(476003)(6512007)(97736004)(81166006)(36756003)(52116002)(256004)(53936002)(50226002)(76176011)(2351001)(316002)(486006)(6116002)(3846002)(81156014)(8676002)(26005)(8936002)(102836004)(7736002)(99286004)(4326008)(186003)(71200400001)(44832011)(6506007)(71190400001)(386003)(6916009)(32563001)(414714003)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5697;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pnqDyUiQ5eelhPrSznEJS25zWisup818aSfoOvXa+h0Ya953nEEC1DQNlPV0Fqsy3RhQUPFM+GiHTUNpg3PTxEgKlC9MBznpChtDSryB1bebdDrgxJ20Y4qyLoaMBeyv3MpM0TXBwM4itAmIchTNrh/5sjjlyNTFuGpm4/6XMwVlctDGsD2ekHamrcKzvTLOm6fF8Jz+ywjFWDe7JpZH3h2Z6R3kamXzmoQMKLvHo0X4EMQzEoFIXmuJvvi7Zkd23q7buZkyxXDAsS/jGyCtTWiwDJh55ifswI9XQYwlSP5b43FB29qLsf1as2Ff6NSs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e330c26-b604-4225-6e95-08d674818f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 09:21:47.1387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5697
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_012157_260147_8F91F0E6 
X-CRM114-Status: GOOD (  15.25  )
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
