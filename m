Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:32:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC64207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kwUK43YK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TmGS8qEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC64207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Jax3Ee8iaYjZYVG8C+d6sP/VHmOOJQF5XwHpZikXfGY=; b=kwUK43YKo8UNjG
	NPZLDTfQeNgb8FX+v0i5ZRRq73O1B610tIv3w/kQHbGu9OgE7W9sccL/LA6b73W80CZ1RHcf6VwtQ
	SwMIxrxcxQDa2GZGn/pCfSTPh7THBe1yG9kEVBRDgnHhND3V9j4dAGkWuogjyd2ziTcHK20e8XLiB
	+rrxFlBmDGXbuIEr+/LNaoIWi3PkZ2kH8iN2lgMhpxFD80a6XiCeDZBQ+bfmxy01lfZwfmHoFowCV
	W9J+HNaL6MGD+zFByyAij+YAGbWdWgFQ8zTgxN3gc1amom+G9k1OfoB047uwfAjLEVaiuXAObhP1k
	oT1rHKa5i7FmND395lbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx0dK-00058B-MF; Fri, 22 Feb 2019 02:32:14 +0000
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx0dH-00057c-2e
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 02:32:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdV7Qhfg2wpF9TiAkSAHH4TP7FJ9bu9kcip9QUpmxYA=;
 b=TmGS8qEG+ABxjeqCAq6hDg9cSYIOnfmJqyS7XY/Lomr+5J1Sde3tMOHRoDiV83aTsiBBURDAigXwqzeLUx/SMNbGIPaQTgJwWdtQUbxcV6JQ8t4HX19ER2FzoxEE5Yw0S7SBHAPUJ01VSXKAoH/Zx0Gufyu4FSHSXz080b8MQ8I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 02:32:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 02:32:05 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: [PATCH RESEND V6 1/2] arm64: dts: freescale: imx8qxp: add cpu opp
 table
Thread-Topic: [PATCH RESEND V6 1/2] arm64: dts: freescale: imx8qxp: add cpu
 opp table
Thread-Index: AQHUylbM3dkepF7MlU6VPQE3muhucA==
Date: Fri, 22 Feb 2019 02:32:05 +0000
Message-ID: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d4daa63-7ae0-41a7-494e-08d6986def47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3771; 
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3771;
 23:FPZcchUY63NaYzORTau38ebAZvs+5m5x3OurN?=
 =?iso-8859-1?Q?DgKgvbRvutAmUfRMLR8/1287nPdbJLphah6Laf/j/BLme3o5p87bPVZbH+?=
 =?iso-8859-1?Q?ay/aGbbUSy3/5b8cfhfQguJ+0HP/L41DSBRmJRE8YddjFm3JBZwJX+R3tL?=
 =?iso-8859-1?Q?kH+1xS8U+Pv68gfLvD0qWJylcmXoVp6qFjTcZN1jZyNnxLXznMyOe+W6C4?=
 =?iso-8859-1?Q?lGvgDrTGTRxAYDTS1G2iXaBKygsH31p/sOBE5Z8OWrjwxJIgKu7xUidt+U?=
 =?iso-8859-1?Q?k9yFmoDXIjQG7ssVriS+3+Z1PDov0GzW5xiii7/xo0wN8XcSV1HQ7FYQex?=
 =?iso-8859-1?Q?bej0PakCa4Qjaw6QGx+d6M5hOpjj2m58GaPlsTFdius2FzZFw5NJC32z5+?=
 =?iso-8859-1?Q?y8K86GJSaZFidtwmqRU6RngXXqWF7XNAw6TSnHzvj3dDPRccDqlSPhSw02?=
 =?iso-8859-1?Q?aGzXf3ZNlnYRPyQXSn9MmvvXzXdZL+JMaFtsIcDpDg8WaamlAgBzIuxqxh?=
 =?iso-8859-1?Q?Ays0gZJy3Yp3PDGKpzGmPf1jW4ZrJ+jUW7uNAdD9G81222VeFK6MNI89dZ?=
 =?iso-8859-1?Q?EFt+c0FEBhx2E1Mq6ci+9D/GS7MhrzEOUF7T/LSGi0Rg/75beYLlfC7YIo?=
 =?iso-8859-1?Q?SJfQfD4MREnMcTfwoZw/rUNyKZ0BUkmAhM9fwwH9hplCdIlP7OpTT7li7C?=
 =?iso-8859-1?Q?x/F5uCu4qttuQkcD67Z5KcwuLi0wivhhdIvQOdYHoERzwxKZmuSOfI4iVX?=
 =?iso-8859-1?Q?+fZ+W24Db31yAouQhG84Plw51L4g5h67ZpsplLzydHc3MJn9Sh1sxuYuIj?=
 =?iso-8859-1?Q?hlpTocRVTR1sSEKz+c2lIUQqhn+3foLVyy8XSmldLRj14ChJgaRJcL31e8?=
 =?iso-8859-1?Q?kkKvOWEh3xzaeqWtvgMFgHg34ZKk4S2tkobK+a846gNJ6apzvZCRLQNQTI?=
 =?iso-8859-1?Q?wzCmpyNZqZRUU8JFsteZ0J166m2jXCMyqHmusbNkjUvDPOhmjeE9kAIpFe?=
 =?iso-8859-1?Q?UFFI3Jnro/SIKZLV3iFafqeSo1UeLvq0909SKG3p9D+rW4Tl1I/Q8XZ7Td?=
 =?iso-8859-1?Q?ECWiQscC+NKFylUtGcCb6r/FPmpW8bC6yKCKKHIFpqJS+jczkvNul5nK5H?=
 =?iso-8859-1?Q?bZwOyrvIycIaGBqdB1Iyce2aoDruDNAMjxp11VGw3ABJna71pI4IVvK6Z4?=
 =?iso-8859-1?Q?TxSFlJ4OyqeMuhLs5iRFhDfFWySuKL6pgmOUmVsUVWCuFyQN6YO2JHkY12?=
 =?iso-8859-1?Q?yeFMsADyIQrNSorrf0bkFn8aNHdh04SjZaK2VWWOhOhEioO3h8M6Ivy45e?=
 =?iso-8859-1?Q?TN2c=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37716A1C309791EBD9F813BCF57F0@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(105586002)(7736002)(53936002)(486006)(7416002)(97736004)(2616005)(66066001)(26005)(476003)(305945005)(71190400001)(106356001)(71200400001)(8936002)(81156014)(8676002)(2501003)(81166006)(36756003)(6506007)(386003)(50226002)(186003)(102836004)(2906002)(52116002)(6116002)(14454004)(6512007)(5660300002)(68736007)(2201001)(14444005)(110136005)(6486002)(316002)(86362001)(6436002)(99286004)(256004)(3846002)(4326008)(25786009)(478600001)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3771;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uryskZ0ctKZlKyhN5GutheaZPsWmJBySJGvvFoHVxmipoy3X9/4S3TaeTXSfoWoshr2rN2lt7l0yr4pGbWkwhe06y4AhtdeohHOZf5mmAEaRrK1D625DThEjWazOXNJP6aFyny0DD4BZUAlKil7M6hGD2woLmTs0qzMavi+PVCSm+WkN1UrMABdcb3YjV7qUkFWIdheky0Y9FbzeEtOfcrLaIMX23MnuZic16gARmFQBqJ8TfdgEeNpm6qzPFz8Rzy3JJ67wfb62JooXzmnBP85iVOK6MZoT8X4cQQNyJBRKSKJI07VWJFZoK6bhoPCxyNHBdRrqOBzu5nLsZVArTdn9OKD14jkW/wZJfHxrw0fbwrQ90vnPiIDN7ib/sxuxY5w+LZm8HbDeD5yCz9VFH6+UiCP8bDUbqcywfc9MWj8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4daa63-7ae0-41a7-494e-08d6986def47
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 02:32:00.6294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_183211_512293_99D8BA8C 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No changes.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..41bf0ce 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -34,6 +34,9 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_1: cpu@1 {
@@ -42,6 +45,9 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_2: cpu@2 {
@@ -50,6 +56,9 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_3: cpu@3 {
@@ -58,6 +67,9 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_L2: l2-cache0 {
@@ -65,6 +77,24 @@
 		};
 	};
 
+	a35_0_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
+		};
+	};
+
 	gic: interrupt-controller@51a00000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
