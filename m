Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19997C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F572083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WwrkgjB8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A/ODVIWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F572083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jHqODbMN+FELZdpmk5vkV8pMWfjz1WT/BmHaWQQEq+E=; b=WwrkgjB8xVgS07
	ExIeMQ2qjWaO9cfXaZ8aZ1uPiz5KviLqZxsDZ23ADHOg4PYD1AKetgiAIjloKqTfEbsq/+k7E4730
	JT7HFbN6iBumoH9Zm50qLT+kmPfo19fvCP6bX897GcOVHkuk8O5ktX6cWO+8kOIitBEJtptlFCH5j
	jYyss/wevy0F5+vfGmJUOBcJzgtWwXNJHwu/ygz9BY7IPBTcH2MOiIaUCS9/djJg5Xro0GDijZ8xJ
	UY5ouzbs3l9hIuwqrwDmsPK21KRRI3qzejBlrTWXt9kMnv4NmrozbQ3RZXmBd0v9Q6IiSihLrIzcL
	shyI9EkXqorFoaOwcGkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt24-0008E1-LJ; Thu, 21 Feb 2019 18:25:16 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt1k-0007AG-6e
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4m3UTpyQQ+F9PI2uSfeavj/Uz2YmPZDd486zfTsx+c=;
 b=A/ODVIWXK5fqccbZxgch+GvBmOCtRDfSQcWN0VpqB4kZDBnWHcQyA3QtPO3X2opw0Tou7oZn1sJDL8B1Xd9k18TbokCJGEWnJu87C7OhIJi7P06UlsVbpCWfYIDmV3tN8F0WJTgGkmgwqA02EpOVHf7sSyenYMFZc4xP0bGJq0c=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:24:52 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:24:52 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/14] arm64: dts: imx8qxp: orginize dts in subsystems
Thread-Topic: [PATCH 01/14] arm64: dts: imx8qxp: orginize dts in subsystems
Thread-Index: AQHUyhK8LGNIJ2f64kmJFSFcpcpObA==
Date: Thu, 21 Feb 2019 18:24:51 +0000
Message-ID: <1550773093-13349-2-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: bbdd087a-4bc6-4018-dd23-08d69829de8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:DWiS7f4/XQTnOvg55buuD+CxmCoy2HYmuUbQaji?=
 =?iso-8859-1?Q?MJ7ATbaRtVLw1yVQ3s4aYjZ/0gEWnQLdjdL7/OEFceZCTMIrgF0GnhWCyg?=
 =?iso-8859-1?Q?LZfZHOi3zbJ0VtAQNTS61ZuI97IizCkFM7fXwcPhY0bAJ7+KTFpBJuFzyi?=
 =?iso-8859-1?Q?u3x1Z7sqk/7RbzhyTvfevhvLtmN1a2WgFZet+AnhCoEwWT5N8QAr99iR6D?=
 =?iso-8859-1?Q?lYvaUpmteBGXAFqUBdf1ASXdnyX6/pz0unQVrCEAa4iuM44fqZRkrtThK+?=
 =?iso-8859-1?Q?IZ6BstNeho79Xd0guBqyGt67K/d8TUBquHbcwtQrK7iMk8iIz0pDcwD+Te?=
 =?iso-8859-1?Q?TsDUzSBWBE+DE2ebmULpgD0LqHGEYI3NAPHcsIV+SChCed6iNVHm1n3sOq?=
 =?iso-8859-1?Q?CTN90Ww+/ghEP2lxZD4kXyFUjssKlK6sCd6ROJLbM0/zO4uQrfvP2Yd21p?=
 =?iso-8859-1?Q?43EcgcEmnnVlsSrrJwoTdCLcHbJKsGy3k6IMDsXPEgeO5QgeQR+hGEWRql?=
 =?iso-8859-1?Q?jFJRuRBkvpPoQtiqLAqtDDA4oxoT66RSM7cdkDOP9MKm14e/2k5TsFXY4c?=
 =?iso-8859-1?Q?75RWm8WSCqiEePag4GIGAnKltffYLhl40i3+I2wUCc3soYawQZDexIzKiX?=
 =?iso-8859-1?Q?yczNZhLsTZfHIRBG48y99esxDFS6m+dRw2rfdsOLnrU1HUa+qvGscDGefB?=
 =?iso-8859-1?Q?aAmK5lDxCC/XiNRZQAgAhh3LaaMOADbv3OH3PGXWXDRRCDpXnO4Qh8LbxI?=
 =?iso-8859-1?Q?qU3OBby5El/UmOubV4NmfJJguTyUFo6tJ9Q027SKMPG/gThhrHhy24Nj45?=
 =?iso-8859-1?Q?7srWz1SlkV2STsliTs+4QzeVzXD5LW0aa7x16ir5iFm7YYPM6illkxk9Gy?=
 =?iso-8859-1?Q?xxX41UpgxVdU2g7hCSp+vCa3dB2l768CYnqQX5Fc63nA14tv5yq5OMU+Ra?=
 =?iso-8859-1?Q?I972IyMfllZn5xwYbDCOc+YRaX7NjFYhosyggNrUThRvB+Z6Aw9LZyqZsM?=
 =?iso-8859-1?Q?Se/j1kNjET7wAE3zURmFvy+YBKmwKnT1vW2WfKYzt74kbEs8OPFntlsYQQ?=
 =?iso-8859-1?Q?x2+xCkPnBNk2GcG6GQHSQevXKPRCFLTmhBKXtvlnTnDBOcrPvPPFqjbn1V?=
 =?iso-8859-1?Q?HstSznB/G066SDTgRz5RKdsik4g43Mvoj5ie7QcVHvLP1CnxvCwPkAQwAT?=
 =?iso-8859-1?Q?wt6Rz2ydtd9v9+20colQKP5SKkHRS4UL6jnfBhngbHEQrplK+O8ejfdkAD?=
 =?iso-8859-1?Q?tY2C4vDzrVpQ9hDwM5P3VHy1xp/PtvSBEBsRfPy4QPGPmZ0dlosWXLprMR?=
 =?iso-8859-1?Q?Et/Or30VtAEoyAjIZQEDFqubLQlsp6t+aIuXokHwKgPthNgGDC9vy7JXpf?=
 =?iso-8859-1?Q?ABAoXxM3m8yoAXJ7Ln/p+HlGDwLJhvhNa1fAwx/HFNykzG4b1ilz/C2tHe?=
 =?iso-8859-1?Q?g/YPAqPUPxghWE=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4846D1F9200E90D6F2AA11CB807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(14444005)(386003)(105586002)(186003)(26005)(53946003)(478600001)(256004)(86362001)(316002)(102836004)(30864003)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004)(32563001)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sY9wqUsxEZlPgxQC9YqzgG/Egw+W7Pm9aW4hcebYSZXHM7Qtrm0CbyU7QG52oXZwHURjVkmIWO2S5aLUKhfZ0t2kbd7kX4CyIixQnDXIl+WNUsnHdB9f2GVOvMu58Ush2lmwBiREBt0QHCoiUjQE4AREIuhV5Ql1ihC9RkuV85Sq4c9upZvVJJhoaZBuDbGrAOwMi3TiH7hSLV3ke4aethg4ZhvDcqDCsmZUfhmNNU/TVVirDnZECQXBDXwQAA4QMEMsEzoSehUBpUr6SSf3zVeJ85NUDOvtFln5QKDpdZzHfj0sCgc7YY1o+kg5UVyDtiZA1+txJRfMpDauZPB2xNuf2e1V+GLQSEZ7HaK+eoim6y1VDdYK4GurPrXcgMcKDbLYyc7VMzz6uFnc2QrmQEyHKuqWcLZRfhXn+lVUkVM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdd087a-4bc6-4018-dd23-08d69829de8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:24:47.6816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102456_827366_41200FB5 
X-CRM114-Status: GOOD (  15.47  )
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

MX8 SoC is comprised of a few HW subsystems while some of them can be
reused in the different SoCs. So let's re-orginize them into subsystems
in device tree as well for the possible reuse of the common part.

Note, as there's still no devices of hsio subsys, so removed it
first instead of creating a subsys headfile with no devices.
They will be added back when new devices added.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi    |  75 +++++
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  95 +++++++
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    | 124 ++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi |  29 ++
 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi |  25 ++
 arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi |  57 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         | 311 +--------------------
 7 files changed, 412 insertions(+), 304 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
new file mode 100644
index 0000000..f6f2b94
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+adma_subsys: bus@59000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x59000000 0x0 0x59000000 0x2000000>;
+
+	adma_lpcg: clock-controller@59000000 {
+		reg = <0x59000000 0x2000000>;
+		#clock-cells = <1>;
+	};
+
+	adma_lpuart0: serial@5a060000 {
+		reg = <0x5a060000 0x1000>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_UART_0>;
+		status = "disabled";
+	};
+
+	adma_i2c0: i2c@5a800000 {
+		reg = <0x5a800000 0x4000>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C0_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_0>;
+		status = "disabled";
+	};
+
+	adma_i2c1: i2c@5a810000 {
+		reg = <0x5a810000 0x4000>;
+		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C1_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_1>;
+		status = "disabled";
+	};
+
+	adma_i2c2: i2c@5a820000 {
+		reg = <0x5a820000 0x4000>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C2_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_2>;
+		status = "disabled";
+	};
+
+	adma_i2c3: i2c@5a830000 {
+		reg = <0x5a830000 0x4000>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C3_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_3>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
new file mode 100644
index 0000000..ac5131d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+conn_subsys: bus@5b000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
+
+	conn_lpcg: clock-controller@5b200000 {
+		reg = <0x5b200000 0xb0000>;
+		#clock-cells = <1>;
+	};
+
+	usdhc1: mmc@5b010000 {
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x5b010000 0x10000>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
+		clock-names = "ipg", "per", "ahb";
+		assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
+		assigned-clock-rates = <200000000>;
+		power-domains = <&pd IMX_SC_R_SDHC_0>;
+		status = "disabled";
+	};
+
+	usdhc2: mmc@5b020000 {
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x5b020000 0x10000>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
+		clock-names = "ipg", "per", "ahb";
+		assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
+		assigned-clock-rates = <200000000>;
+		power-domains = <&pd IMX_SC_R_SDHC_1>;
+		fsl,tuning-start-tap = <20>;
+		fsl,tuning-step= <2>;
+		status = "disabled";
+	};
+
+	usdhc3: mmc@5b030000 {
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x5b030000 0x10000>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
+		clock-names = "ipg", "per", "ahb";
+		assigned-clocks = <&clk IMX_CONN_SDHC2_CLK>;
+		assigned-clock-rates = <200000000>;
+		power-domains = <&pd IMX_SC_R_SDHC_2>;
+		status = "disabled";
+	};
+
+	fec1: ethernet@5b040000 {
+		reg = <0x5b040000 0x10000>;
+		interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET0_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET0_AHB_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET0_TX_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET0_ROOT_CLK>;
+		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+		fsl,num-tx-queues=<3>;
+		fsl,num-rx-queues=<3>;
+		power-domains = <&pd IMX_SC_R_ENET_0>;
+		status = "disabled";
+	};
+
+	fec2: ethernet@5b050000 {
+		reg = <0x5b050000 0x10000>;
+		interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET1_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET1_AHB_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET1_TX_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET1_ROOT_CLK>;
+		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+		fsl,num-tx-queues=<3>;
+		fsl,num-rx-queues=<3>;
+		power-domains = <&pd IMX_SC_R_ENET_1>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
new file mode 100644
index 0000000..1c6ba8d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+lsio_subsys: bus@5d000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
+
+	lsio_lpcg: clock-controller@5d400000 {
+		reg = <0x5d400000 0x400000>;
+		#clock-cells = <1>;
+	};
+
+	lsio_mu0: mailbox@5d1b0000 {
+		reg = <0x5d1b0000 0x10000>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <0>;
+		status = "disabled";
+	};
+
+	lsio_mu1: mailbox@5d1c0000 {
+		reg = <0x5d1c0000 0x10000>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+	};
+
+	lsio_mu3: mailbox@5d1e0000 {
+		reg = <0x5d1e0000 0x10000>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <0>;
+		status = "disabled";
+	};
+
+	lsio_mu4: mailbox@5d1f0000 {
+		reg = <0x5d1f0000 0x10000>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <0>;
+		status = "disabled";
+	};
+
+	lsio_gpio0: gpio@5d080000 {
+		reg = <0x5d080000 0x10000>;
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_0>;
+	};
+
+	lsio_gpio1: gpio@5d090000 {
+		reg = <0x5d090000 0x10000>;
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_1>;
+	};
+
+	lsio_gpio2: gpio@5d0a0000 {
+		reg = <0x5d0a0000 0x10000>;
+		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_2>;
+	};
+
+	lsio_gpio3: gpio@5d0b0000 {
+		reg = <0x5d0b0000 0x10000>;
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_3>;
+	};
+
+	lsio_gpio4: gpio@5d0c0000 {
+		reg = <0x5d0c0000 0x10000>;
+		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_4>;
+	};
+
+	lsio_gpio5: gpio@5d0d0000 {
+		reg = <0x5d0d0000 0x10000>;
+		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_5>;
+	};
+
+	lsio_gpio6: gpio@5d0e0000 {
+		reg = <0x5d0e0000 0x10000>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_6>;
+	};
+
+	lsio_gpio7: gpio@5d0f0000 {
+		reg = <0x5d0f0000 0x10000>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_7>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
new file mode 100644
index 0000000..2486c72
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&adma_lpcg {
+	compatible = "fsl,imx8qxp-lpcg-adma";
+};
+
+&adma_lpuart0 {
+	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+};
+
+&adma_i2c0 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&adma_i2c1 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&adma_i2c2 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&adma_i2c3 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
new file mode 100644
index 0000000..27a3b46
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&conn_lpcg {
+	compatible = "fsl,imx8qxp-lpcg-conn";
+};
+
+&usdhc1 {
+	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+};
+
+&fec1 {
+	compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
+};
+
+&fec2 {
+	compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
new file mode 100644
index 0000000..842849b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&lsio_lpcg {
+	compatible = "fsl,imx8qxp-lpcg-lsio";
+};
+
+&lsio_mu0 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu1 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu3 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu4 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_gpio0 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio1 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio2 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio3 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio4 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio5 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio6 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio7 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..c27043c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -139,308 +139,11 @@
 		clock-frequency = <24000000>;
 		clock-output-names = "xtal_24MHz";
 	};
-
-	adma_subsys: bus@59000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x59000000 0x0 0x59000000 0x2000000>;
-
-		adma_lpcg: clock-controller@59000000 {
-			compatible = "fsl,imx8qxp-lpcg-adma";
-			reg = <0x59000000 0x2000000>;
-			#clock-cells = <1>;
-		};
-
-		adma_lpuart0: serial@5a060000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
-			reg = <0x5a060000 0x1000>;
-			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
-			clock-names = "ipg";
-			power-domains = <&pd IMX_SC_R_UART_0>;
-			status = "disabled";
-		};
-
-		adma_i2c0: i2c@5a800000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a800000 0x4000>;
-			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C0_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_0>;
-			status = "disabled";
-		};
-
-		adma_i2c1: i2c@5a810000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a810000 0x4000>;
-			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C1_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_1>;
-			status = "disabled";
-		};
-
-		adma_i2c2: i2c@5a820000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a820000 0x4000>;
-			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C2_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_2>;
-			status = "disabled";
-		};
-
-		adma_i2c3: i2c@5a830000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a830000 0x4000>;
-			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-parent = <&gic>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C3_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_3>;
-			status = "disabled";
-		};
-	};
-
-	conn_subsys: bus@5b000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
-
-		conn_lpcg: clock-controller@5b200000 {
-			compatible = "fsl,imx8qxp-lpcg-conn";
-			reg = <0x5b200000 0xb0000>;
-			#clock-cells = <1>;
-		};
-
-		usdhc1: mmc@5b010000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x5b010000 0x10000>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
-			clock-names = "ipg", "per", "ahb";
-			assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
-			assigned-clock-rates = <200000000>;
-			power-domains = <&pd IMX_SC_R_SDHC_0>;
-			status = "disabled";
-		};
-
-		usdhc2: mmc@5b020000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x5b020000 0x10000>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
-			clock-names = "ipg", "per", "ahb";
-			assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
-			assigned-clock-rates = <200000000>;
-			power-domains = <&pd IMX_SC_R_SDHC_1>;
-			fsl,tuning-start-tap = <20>;
-			fsl,tuning-step= <2>;
-			status = "disabled";
-		};
-
-		usdhc3: mmc@5b030000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x5b030000 0x10000>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
-			clock-names = "ipg", "per", "ahb";
-			assigned-clocks = <&clk IMX_CONN_SDHC2_CLK>;
-			assigned-clock-rates = <200000000>;
-			power-domains = <&pd IMX_SC_R_SDHC_2>;
-			status = "disabled";
-		};
-
-		fec1: ethernet@5b040000 {
-			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
-			reg = <0x5b040000 0x10000>;
-			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_ENET0_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET0_AHB_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET0_TX_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET0_ROOT_CLK>;
-			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
-			fsl,num-tx-queues=<3>;
-			fsl,num-rx-queues=<3>;
-			power-domains = <&pd IMX_SC_R_ENET_0>;
-			status = "disabled";
-		};
-
-		fec2: ethernet@5b050000 {
-			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
-			reg = <0x5b050000 0x10000>;
-			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_ENET1_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET1_AHB_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET1_TX_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET1_ROOT_CLK>;
-			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
-			fsl,num-tx-queues=<3>;
-			fsl,num-rx-queues=<3>;
-			power-domains = <&pd IMX_SC_R_ENET_1>;
-			status = "disabled";
-		};
-	};
-
-	lsio_subsys: bus@5d000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
-
-		lsio_lpcg: clock-controller@5d400000 {
-			compatible = "fsl,imx8qxp-lpcg-lsio";
-			reg = <0x5d400000 0x400000>;
-			#clock-cells = <1>;
-		};
-
-		lsio_mu0: mailbox@5d1b0000 {
-			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1b0000 0x10000>;
-			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <0>;
-			status = "disabled";
-		};
-
-		lsio_mu1: mailbox@5d1c0000 {
-			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1c0000 0x10000>;
-			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-		};
-
-		lsio_mu3: mailbox@5d1e0000 {
-			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1e0000 0x10000>;
-			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <0>;
-			status = "disabled";
-		};
-
-		lsio_mu4: mailbox@5d1f0000 {
-			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1f0000 0x10000>;
-			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <0>;
-			status = "disabled";
-		};
-
-		lsio_gpio0: gpio@5d080000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d080000 0x10000>;
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_0>;
-		};
-
-		lsio_gpio1: gpio@5d090000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d090000 0x10000>;
-			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_1>;
-		};
-
-		lsio_gpio2: gpio@5d0a0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0a0000 0x10000>;
-			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_2>;
-		};
-
-		lsio_gpio3: gpio@5d0b0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0b0000 0x10000>;
-			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_3>;
-		};
-
-		lsio_gpio4: gpio@5d0c0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0c0000 0x10000>;
-			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_4>;
-		};
-
-		lsio_gpio5: gpio@5d0d0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0d0000 0x10000>;
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_5>;
-		};
-
-		lsio_gpio6: gpio@5d0e0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0e0000 0x10000>;
-			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_6>;
-		};
-
-		lsio_gpio7: gpio@5d0f0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0f0000 0x10000>;
-			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_7>;
-		};
-	};
+	#include "imx8-ss-adma.dtsi"
+	#include "imx8-ss-conn.dtsi"
+	#include "imx8-ss-lsio.dtsi"
 };
+
+#include "imx8qxp-ss-adma.dtsi"
+#include "imx8qxp-ss-conn.dtsi"
+#include "imx8qxp-ss-lsio.dtsi"
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
