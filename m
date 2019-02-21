Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F81C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0288920818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SKioGlAA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XAOR96tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0288920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2MChdRZ0KmMvQ/te3In4XUo73j+G6nVkG9INEP7FnYc=; b=SKioGlAAI9ZG5y
	7Yf657Gc6tDjvsfYqmHf06ulWq8pMAG8ihbXUTDQv5l34XFfIER4Vxz8bbIf2yhbdFwyU1ZGVucDD
	3f7KPAeSs4tCZX4zZTcE+ziwOuR9TTwwY2Xn1G5JdY39lpnZVjZXZVpvWCBDUJj5Jlt3EWxdnp6RF
	0j2gA9/bjAeCorzkPb2VwQryMWSFi53T4+FNgVmtZQH7/txEhQ6Qz9I+X4cU2FHZNfipX22utzw85
	kXIfKKrhVOll3048KYB4BcXyOn8DHQe9tVC9vtbYNdtrZlt5syj7o8Wdui4H+ZHQoG9pq7YUIitcI
	JAGLPu6CbqWIpM5aU4vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt4W-0003CV-TU; Thu, 21 Feb 2019 18:27:48 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2m-0007AG-Pt
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqLoj0GDktTNL4WReDrsOk04pJugos98DlNzmuu9Bp0=;
 b=XAOR96tuQzMjp7JflQ8lX4uZpggs+5k3PXA/lDQ2mbH8iGkFePb85bx2QsZMDs1B0VQLJJ295zwyWaqtCDPhDTg4k32KBfmGy4l5VqRi8YJeDV3vPPEJX39u7uIGCFLbI6GTIYbuPpYxgUhX/VUpKUdxJH56fTx54XjNLac6ATY=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:25:47 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:47 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 14/14] arm64: dts: imx: add imx8qm mek support
Thread-Topic: [PATCH 14/14] arm64: dts: imx: add imx8qm mek support
Thread-Index: AQHUyhLdcNRG7RPy9EmclB9tHfNQcQ==
Date: Thu, 21 Feb 2019 18:25:47 +0000
Message-ID: <1550773093-13349-15-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: d43d861a-5bbb-47be-2254-08d69829fffa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:0MAFaE+nP7UzAPE8w4yDY9jmYtTpvfHrgUfCzF3?=
 =?iso-8859-1?Q?H5Ifct/1cfEkXF9Bka8bRqCNZ3l8gnpiJxepicyO5hlxP0preL+sz73bJm?=
 =?iso-8859-1?Q?vv15IjKcwjTaP2Gu20gWNmvtU1oNLvg8QrswZtt/wobpVxjOPFncBJT7Qh?=
 =?iso-8859-1?Q?16Dmpz1JbBNgTIjQM65HR6B4+RfpCcdpAo0k1FsCmGeLUdjYaZRlHy6hcW?=
 =?iso-8859-1?Q?iKRLjNVI9Sx7jNybQUw2VLFUAUQhfJofbfytX6p4xmb548LAgI5CQ7oJh4?=
 =?iso-8859-1?Q?FzspmxgRWC+VKRTV63e1UeR79bOHicliwf2GCsNhzezqNQJnlT8vMCenX7?=
 =?iso-8859-1?Q?XPbTz3K8KIoFQQekXGMJWQLXOZbiP5LQbpl5QG2u/KklpKUv45cqBFTqzc?=
 =?iso-8859-1?Q?4Rv2eHJ6ahCYKQyj2p1EPWdZKuhrE0kC2aVf2O65AVK2cQDxbEftglKa7B?=
 =?iso-8859-1?Q?5UMxMmUnxAdtZ+9lijTQ5oCEw1ZOng05JmFenMGLqDVoa6inVy3ZYVK323?=
 =?iso-8859-1?Q?pJK/wY3ie21z9G7JJnDig8imGwuUR8IiVOz9ZMSRHvMR9nYrmkw/JUZ+ea?=
 =?iso-8859-1?Q?3br+l4Ud6sF+HLpBlwv62VdL/peYsQL7tLsEjcOY9M6baiI685f8JYaoS2?=
 =?iso-8859-1?Q?xdPj1NOgj+ikX13qgF10bQVfugcM3m3FTQIZnSuYD21mhhgKJ51tFim9V7?=
 =?iso-8859-1?Q?zp0LO4zDfWwcoJBDuh/feiJtwFUSP/rEUFyqbgEPIEF42w7L3CDMo83+o2?=
 =?iso-8859-1?Q?MaAeG9ZIOrIxt5Eu9J9nGXWBwwIncR0MdutCpUmxJGHqzHk1DcQ+fXNDEd?=
 =?iso-8859-1?Q?Ags+tNfmL8zR1sWW+07oXVs0jiSoPmLtf3jxuJ0WzV5ax9YEgWqrtdZqWY?=
 =?iso-8859-1?Q?2hp39RFybjMyB3lyAFxemhvWZ4s+G1MI7SrP1nzW8C6TxY2MxAx3nlHFBT?=
 =?iso-8859-1?Q?WVJNG9JNDtYrxcwAqesDedYST0BJgdfQNjiQmj41OBF30lgRqcULRtsZOh?=
 =?iso-8859-1?Q?j+p99ET4bK3td2uPyubZ1I2gP5cnD6A4o6wClzcik9i5HBX9Cu6KCiTvar?=
 =?iso-8859-1?Q?2zWbkJftQmLKEbt8J6RJ0ix8EynQ8b7J3assCjFdcLmlpaY1aVZwY05B00?=
 =?iso-8859-1?Q?SyMV/FkhqnZjD49NY5XbCc0+DKBIjaVySaxjn93nNW3w0U4N2TGk4QaRI0?=
 =?iso-8859-1?Q?+IdPfGKjyCgHkkq9yKixY2+O4bpgal5LNYlbaPHLT8Si5P4IAIKs6RK2/A?=
 =?iso-8859-1?Q?l4UKd2qzPqXdc9Rrox7zB55N8DtQykkN2zp0u7+ldyWPxpp1jLnnkn+Fwk?=
 =?iso-8859-1?Q?MiMO3zPARLIAdh2kEbERptFAe/QFPAsOttJu2uzom1r50xkBjjxYYAyiFx?=
 =?iso-8859-1?Q?/McUBLH/Dfw3Eerh1ZPgLGa+t8QVAOu1sSH38WthEXezkCar2FQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB48467202CB6DB5CBFD7CE875807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(14444005)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004)(32563001)(473944003)(414714003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wRnLoxEoO+e2G83rFtYXo30VIuEamg1AjVETSd+1hyreXliXAM7sBIH5Ewx5Av7CISrtwuMgUS3DRKGBwDO0fm2x0lj1bce0o03f593wazoas91dibxNZ3RnGSao4RNWM9KPKxcvhcPGJRMeSAc/c4QkD9wO8/6sTCrSvlxoB3CZ4hvSWBXhckx58g2QzWFl8t6xzMHbgI94EgBkgFhGzzpUeWa2h7/kQQBo777njEq1k5GbybzMIFNyTLt8gs32UQZ7ypwUdYA91C0OEkrQN6mTKMGBDZW5+/h8aIgr25fLWOYDT0OD7v+ers7WOP6I2hVyUc6zPwe0U9Qb2RJj8k61tV7clXo1Zbqe75WvbPi3/iYr6e1A4B/Jr1l+EUgnvFGtz7dPXa6xLCX9xLSjqWapBfOM09acPCVNWc++zAk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43d861a-5bbb-47be-2254-08d69829fffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:43.7441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102601_532625_76731BD8 
X-CRM114-Status: GOOD (  16.50  )
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

The i.MX8QuadMax is a Dual (2x) Cortex-A72 and Quad (4x) Cortex-A53
proccessor with powerful graphic and multimedia features.
This patch adds i.MX8QuadMax MEK board support.

Note that MX8QM needs a special workaround for TLB flush due to a SoC
errata, otherwise there may be random crash if enable both clusters of
A72 and A53. As the errata workaround is still not in mainline, so we
disable A72 cluster first for MX8QM MEK.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |   1 +
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 144 +++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-mek.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 13604e5..b8e5e3b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -21,4 +21,5 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
new file mode 100644
index 0000000..80d8da1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+/dts-v1/;
+
+#include "imx8qm.dtsi"
+
+/ {
+	model = "Freescale i.MX8QM MEK";
+	compatible = "fsl,imx8qm-mek", "fsl,imx8qm";
+
+	chosen {
+		stdout-path = &dma_lpuart0;
+	};
+
+	cpus {
+		/delete-node/ cpu-map;
+		/delete-node/ cpu@100;
+		/delete-node/ cpu@101;
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
+&dma_lpuart0 {
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
+			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020
+			IMX8QM_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			IMX8QM_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x06000020
+			IMX8QM_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC		0x06000020
+			IMX8QM_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x06000020
+			IMX8QM_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x06000020
+			IMX8QM_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2		0x06000020
+			IMX8QM_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3		0x06000020
+			IMX8QM_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC		0x06000020
+			IMX8QM_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x06000020
+			IMX8QM_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x06000020
+			IMX8QM_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x06000020
+			IMX8QM_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2		0x06000020
+			IMX8QM_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
+		>;
+	};
+
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
+			IMX8QM_UART0_TX_DMA_UART0_TX				0x06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041
+			IMX8QM_EMMC0_CMD_CONN_EMMC0_CMD				0x00000021
+			IMX8QM_EMMC0_DATA0_CONN_EMMC0_DATA0			0x00000021
+			IMX8QM_EMMC0_DATA1_CONN_EMMC0_DATA1			0x00000021
+			IMX8QM_EMMC0_DATA2_CONN_EMMC0_DATA2			0x00000021
+			IMX8QM_EMMC0_DATA3_CONN_EMMC0_DATA3			0x00000021
+			IMX8QM_EMMC0_DATA4_CONN_EMMC0_DATA4			0x00000021
+			IMX8QM_EMMC0_DATA5_CONN_EMMC0_DATA5			0x00000021
+			IMX8QM_EMMC0_DATA6_CONN_EMMC0_DATA6			0x00000021
+			IMX8QM_EMMC0_DATA7_CONN_EMMC0_DATA7			0x00000021
+			IMX8QM_EMMC0_STROBE_CONN_EMMC0_STROBE			0x00000041
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8QM_USDHC1_CLK_CONN_USDHC1_CLK			0x06000041
+			IMX8QM_USDHC1_CMD_CONN_USDHC1_CMD			0x00000021
+			IMX8QM_USDHC1_DATA0_CONN_USDHC1_DATA0			0x00000021
+			IMX8QM_USDHC1_DATA1_CONN_USDHC1_DATA1			0x00000021
+			IMX8QM_USDHC1_DATA2_CONN_USDHC1_DATA2			0x00000021
+			IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3			0x00000021
+			IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT		0x00000021
+		>;
+	};
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
