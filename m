Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023D32083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X5co6DeR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iOXv+CXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023D32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6VN7M+fzfD4aVE8S83xHgSTpjTLLRuBIQxB6ib4yNno=; b=X5co6DeRjfCSY6
	O6T9BwOigeY+WHvUZSgRwxT1Dx9btFiXNimXelEO70bswXGHy+jv7VBZEDdAgfBQnX6aYg/wktBgD
	oCfYjfcY3TdVCFogjRqUFNf70LPL1HqV6jrwi2nwS7ZgBaN6X9q9dZvz1vcaNfwnPoOkg9qKs+vAQ
	wbOvCldGbXg/IXtmAYURhnxNZ9b04npeYIAjW2LVBFSaJEmtWT96v65BUgyvtM6+0U8bH2wzTFZHt
	Dcvtrq8bKFuPEtybpKZ/dlyPBRaqxJxNPKHIe4af4jt4ahncriGpWlDGMmlbEOQoKZmuA4ENALoTQ
	PGbgfxLaFnxE9xvkzK7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt2d-0000oY-RK; Thu, 21 Feb 2019 18:25:51 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt20-0007AG-33
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAFAoDLvezY3E9laxPXlG9A9ZdeOs7v0RGWqxsor8+g=;
 b=iOXv+CXFk93Rl3lcCG4GdTVK3kZMlp+frrLl4wa5hyGfsNy8PUlKSXvbH/WjESJY+zIfhsTaJMh0uoeW2PUyDnOsiI99GC6okIEVvx1YnMUI+1hmWULxd1fu/bVf4OZrp5+45XJlSiGJzOquPnOPgDtRYh2xw4gUV+v5/AKG/Fc=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:25:00 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:00 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 03/14] arm64: dts: imx8: add conn scu clocks
Thread-Topic: [PATCH 03/14] arm64: dts: imx8: add conn scu clocks
Thread-Index: AQHUyhLB5z/Vto5y+UCugWB9Z0rq3w==
Date: Thu, 21 Feb 2019 18:25:00 +0000
Message-ID: <1550773093-13349-4-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: f5fe5824-6981-4879-c8ce-08d69829e3d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:iV0Xi4dI5V+wLsbaqcKMXcanL8QV86dFXPOVvSj?=
 =?iso-8859-1?Q?PdEbIQCpy7wEgTMGpsZiPMF/uJUfm6dUJpOh0sLNjG/hR2sitRVV09QIZD?=
 =?iso-8859-1?Q?jfd2oTcU0BJ0hC7wuSE8BZ5QYpPDIpKncKbEPwnGWyfSJG2vaM8wWBP7OI?=
 =?iso-8859-1?Q?Pa7p8lo1Vwa+zl0tAmk62M96BPr6YtXHMmi+0n//WIpaT2P0QxZqWVGqJC?=
 =?iso-8859-1?Q?Ipb30Vwv8P2+v/9peN7qOAsF9JfAP0HDlXQ2NcSL29vGO3Bc7Lis0UsBd1?=
 =?iso-8859-1?Q?YAfS6e+kXFQalEqkln8K9uiAYhwSd1IznxkHLnmKu7ngZvL3MFfH/FFgrB?=
 =?iso-8859-1?Q?3plpLW09hq7CwGgJEJyqHhIejcSwRd1272aWC67r0RFx2FLi4AUjWqwtcv?=
 =?iso-8859-1?Q?+g7Bn07vyBlkA/CY/5pG+EnPfPBN6A9EL1S6qloreIXLs/tvWnr09k6/lr?=
 =?iso-8859-1?Q?Tlvx2E+a8v9PSzKRBp5m84zXzA7TEFzCNJhBvkT0GQUriefy1S2Mjz6B/Z?=
 =?iso-8859-1?Q?4Yopy5/aUrjUXETm2jNoOxIAaKcusJ1U7uVyO8A+iL6Muq0FNPzbxgmbrX?=
 =?iso-8859-1?Q?xEMkevlhmd/CQUgVZDpXx4K5CrBHuTZYx8r6rwQl9uktHW/WtimVuna2yx?=
 =?iso-8859-1?Q?BOSPqREOshSau9fVEGz1AqyceGPHD7trlhrpOGPxdXNg7bBBlioWsP16Uj?=
 =?iso-8859-1?Q?hbXUyyfDMdF1nNX6v5BGAQ8mex4+YdANMlFoehZZsppyywQK9tbp/aKG1E?=
 =?iso-8859-1?Q?TMTVNabOGs+8zkyRL7TYHtbbHX+S9MC9cqIux4/kYUoP6AfPB90Rp8efaB?=
 =?iso-8859-1?Q?OG4cvXkEKO3v53+uLt3LDAYnirLJObbPzuLZbK0gtBeVu/F6lNzAc1Nf5i?=
 =?iso-8859-1?Q?jCpLYpQw/FQZxX2kohXLadJmRnIxYM5SiaaXijz6hdb5NMceac9Ib7PQ+8?=
 =?iso-8859-1?Q?ahw1HGhZPvVfgCNKwMbABH+XNXsIww/cypeDyMRSGUYl0AtUopOB3t3exp?=
 =?iso-8859-1?Q?V5/jpiYg2QBehvLMH+chDCAlOXkFjvDkgHTz0ANVtkOy/J/kRltqK3odzE?=
 =?iso-8859-1?Q?N/3M0araPmkqJE/filjK3y7IKlReE5gKSBlIQDdSkZm1zgqfQeS53DYqzD?=
 =?iso-8859-1?Q?TRMhJTJ5b1mgMfM3jWBAiNV8KdGkpn6YYklqLTxOnTiIisQDP81N6U7WHQ?=
 =?iso-8859-1?Q?2gayUqrnpCixQ3HAD/47O7Qbh/FUmG0p8IWtOoZ1MnmM8HIspYVhUFZwVN?=
 =?iso-8859-1?Q?p5FOVREKn5I8e2TXazFZYwXqYm0ADQAKyy1earHGuYGf7WSEFrPKHzQvmL?=
 =?iso-8859-1?Q?TMNbEJZJ8kAysJsqqhg3fxt?=
x-microsoft-antispam-prvs: <VI1PR04MB48462C47A3B9FA47598F9695807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /3dPcMusMQqRSi9dVhf6USBhm43qh3d8Bn4XfnF+jX27fTgUdVuQ2656AkmJRSWr6TUysQMJn734dPQH84EVHI3nfkAn6cw5eYd/DkNQHKwIX3hOWq6vBp+Het+lIWGfqpbjKMapszetGhqt1jNSi1lKNSWduMWu3w/cmUYgIGjslBW2NNZ1mtDToaDGrDzgH5BDVvgBBoBiBJRF1ciVbj6pn8JeetVjw9BxArbzeW8AQN+nwISHbo2xgdsSOAEPjwJoZWHp7WtGvdlLxVMqF5HpgrFwdN7CpOGK8F6ACiZxfLzhPS1FDhHeB3MExvirguSlOQUZc/PPRMPPIl0CVPuq6L3suP0PATAIpS5ABavhDoYo0Kz1vrnxpLuAALt8rKyVae+/pAA19zdqfXmxcTG5rMRT3wX4n5HrTYDyWGc=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fe5824-6981-4879-c8ce-08d69829e3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:24:56.5599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102512_268956_3CF6598E 
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

Add conn scu clocks

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 122 ++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index ac5131d..0765cb2 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -4,12 +4,134 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
+
 conn_subsys: bus@5b000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
 
+	/* SCU clocks */
+	conn_axi_clk: clock-conn-axi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <333333333>;
+		clock-output-names = "conn_axi_clk";
+	};
+
+	conn_ahb_clk: clock-conn-ahb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <166666666>;
+		clock-output-names = "conn_ahb_clk";
+	};
+
+	conn_ipg_clk: clock-conn-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <83333333>;
+		clock-output-names = "conn_ipg_clk";
+	};
+
+	enet0_clk: clock-enet0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ENET_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "enet0_clk";
+	};
+
+	enet0_bypass_clk: clock-enet0-bypass {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ENET_0>;
+		clk-type = <IMX_SC_PM_CLK_BYPASS>;
+		clock-output-names = "enet0_bypass_clk";
+	};
+
+	enet0_rgmii_clk: clock-enet0-rgmii {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ENET_0>;
+		clk-type = <IMX_SC_PM_CLK_MISC0>;
+		clock-output-names = "enet0_rgmii_clk";
+	};
+
+	enet1_clk: clock-enet1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ENET_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "enet1_clk";
+	};
+
+	enet1_bypass_clk: clock-enet1-bypass {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ENET_1>;
+		clk-type = <IMX_SC_PM_CLK_BYPASS>;
+		clock-output-names = "enet1_bypass_clk";
+	};
+
+	enet1_rgmii_clk: clock-enet1-rgmii {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_ENET_1>;
+		clk-type = <IMX_SC_PM_CLK_MISC0>;
+		clock-output-names = "enet1_rgmii_clk";
+	};
+
+	gpmi_bch_clk: clock-gpmi-bch {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_NAND>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "gpmi_bch_clk";
+	};
+
+	gpmi_bch_io_clk: clock-gpmi-bch-io {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_NAND>;
+		clk-type = <IMX_SC_PM_CLK_MST_BUS>;
+		clock-output-names = "gpmi_bch_io_clk";
+	};
+
+	sdhc0_clk: clock-sdhc0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_SDHC_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "sdhc0_clk";
+	};
+
+	sdhc1_clk: clock-sdhc1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_SDHC_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "sdhc1_clk";
+	};
+
+	sdhc2_clk: clock-sdhc2 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_SDHC_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "sdhc2_clk";
+	};
+
+	usb3_aclk: clock-usb3-aclk {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_USB_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "usb3_aclk";
+	};
+
+	usb3_bus_aclk: clock-usb3-bus {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_USB_2>;
+		clk-type = <IMX_SC_PM_CLK_MST_BUS>;
+		clock-output-names = "usb3_bus_aclk";
+	};
+
+	usb3_lpm_aclk: clock-usb3-lpm {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_USB_2>;
+		clk-type = <IMX_SC_PM_CLK_MISC>;
+		clock-output-names = "usb3_lpm_aclk";
+	};
+
 	conn_lpcg: clock-controller@5b200000 {
 		reg = <0x5b200000 0xb0000>;
 		#clock-cells = <1>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
