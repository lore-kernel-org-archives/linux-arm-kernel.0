Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C2B20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEwro64x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="klFXjV4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C2B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v9tKvdgy4YDi+U4k85W1btcUC/I4RnqrIpY5zhS8ucU=; b=IEwro64xOoIbSF
	6HISONz3/8aWyhGzZpoFT4aHoxZc+ldNJTeu3B8D0pDoGbwe+U1mtsfFqH+FZdoYII8CCft3SQN9m
	SKClSJV/QlfB0/DhQit0uYTNglbtHbZlKKXI7zMjuZM/z26NmnWqUYL9uepuyM4MdofSgCC6+Fzrn
	zhf5m9ZqGTREvnBJnpjaSdhqVPxE69bRrMei1vgh6wEkUBdAmQKDbJxybtzotShepGZCfJe45SyDB
	XMNQysfVHYKa7bpd5wMnPPnzHk2hk9M+lEvAwUeF7ESwwE9RVdLvrxIA+DYs1jqMWhU/1QIx9qjQG
	pazhp6MMBO2am9p44fhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwshj-0006q9-I7; Thu, 21 Feb 2019 18:04:15 +0000
Received: from mail-db5eur03on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::62e]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwshM-0006Mm-QC
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:03:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM3wyXK7QqRPXtL580t+z3chpoHQY+tfRE63KtpCF58=;
 b=klFXjV4XI4p9v/IBA3n6J/Vt35HH8TsFZYbk66z4pJRfPJJjyiUx0lr3qqRlkYsswKeGVZQYgNCf8YwT/SmPnZZN6oXR41ua/8bdCqIguD2/2zksmstnBcZybEPYpx3VfcgXDgPmd/DaMWyZ41r1Ff5ZcMxniLUAAJDwmmC3PTA=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB1663.eurprd04.prod.outlook.com (10.164.85.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 18:03:47 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:03:47 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: clock: imx-lpcg: add support to parse clocks
 from device tree
Thread-Topic: [PATCH 2/4] dt-bindings: clock: imx-lpcg: add support to parse
 clocks from device tree
Thread-Index: AQHUyg/Kxp1YOB0bxEaB6SXWVnNLZw==
Date: Thu, 21 Feb 2019 18:03:47 +0000
Message-ID: <1550771836-10014-3-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 44cc94d4-4b7e-48bb-334c-08d69826ed37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1663; 
x-ms-traffictypediagnostic: VI1PR04MB1663:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB1663;
 23:eAUKPt+NWkMkgkQVo903JBsXKcrHrlCReXti5XZ?=
 =?iso-8859-1?Q?j8dkUSrginDpPyTwRSM/tIMHKhfu4cHZHqJv+R/qSNJYDnHg7G+hoVeIng?=
 =?iso-8859-1?Q?dEps/xZaG4oUqq6GCkTfe64zVwcg3IGLHvcsSjc3whz0l0V5KqcZ+QWgcT?=
 =?iso-8859-1?Q?tgqbF93qd4QJsDAohVhfOghDTLVV4FLbTuaNeAdtwZRC1mNxzdh5rGD4XG?=
 =?iso-8859-1?Q?qump27EY4YvGuIFPKca2pdmgbZ4JGhRWuov4lVmAD5BRHOhNsEOfe4CLk5?=
 =?iso-8859-1?Q?tUW7rkqfb+euthXdREeRy9369cWaUcp9q9Idmx9qByjJI5MUmPH0y5GGwR?=
 =?iso-8859-1?Q?6XrDNGt13HbN88M04mOFpKN2gq7ZDEQjBSNgYpm9w5EICQ/iBiQaoDikL+?=
 =?iso-8859-1?Q?Mn+S4sOFbbT6U08XlMUHZFnVzJWJAajOkeLykh+8vAxZsC4xdLGHi0Bb40?=
 =?iso-8859-1?Q?hUa6fZuSTj0FaJD9dDgzwADQZRBH6My/VSPpJbqao1oXttmYeMuP4/AGsA?=
 =?iso-8859-1?Q?ZtrbIG5xBXbKJaAd8iamSdl2dMRlEk+LQdrRBGK0ExKJcSFga1HfIx1rNb?=
 =?iso-8859-1?Q?q1lPTCB6DUCmUVVClGdwgQoWUrn3HAZOYNqwwJ62jTpRiRcCDKu1wluxrY?=
 =?iso-8859-1?Q?iBw+6vLsIgDIRdn8lDPNjqkWpwz6Z6ZN0hikTQUPFXd4hy450NONg/ZArm?=
 =?iso-8859-1?Q?gk690InE+Ed2couCiHE5f2tOWjOr3HkEnAbvbGqfjKYQwItUygqFeVlosH?=
 =?iso-8859-1?Q?OLhFl93w2R60dOH0FE5MbYHkfh1ulgL1KaxoPJxD1smARkaKDVGwvLlPvT?=
 =?iso-8859-1?Q?+v4GKziKPnSiubbXUyFMzM8pFFjd4sFpWi8sIxwLMeltT6T/3XBoRJsgH1?=
 =?iso-8859-1?Q?7hMQ35Eca84paEBPxbsza/N/Iq8L9QaXsKamvIUt0PS71Xyg/92bFxBncR?=
 =?iso-8859-1?Q?6cEXkD9Dg3MoqaumSKxgmIxTqM7i8bhcz3QUCZT9fLwb5mJ8uXJIQR9Tez?=
 =?iso-8859-1?Q?6Z95y78PDL+fqS9BgldRFcf4GnRbRxLs16X6Vm27Lq1UyN/UJ/sITcHvTP?=
 =?iso-8859-1?Q?1xOa87p1Th2VzdWosfiH5PONATyn6ecbxJbV9xJAtZRlNoANKa+r8Li1qx?=
 =?iso-8859-1?Q?0DY8v2dpXlVY2D9o6NaKVrOVpSXBSNQQZs3H06YiaYIdwZ6s1TLS0YqxZ7?=
 =?iso-8859-1?Q?+oaWSgycsngdOVN5ArFcvTFuOGAiGUDkOXGvp0cmqo/P4f3g6hIsjdzRWa?=
 =?iso-8859-1?Q?1EkGqmhOdpbWSpPbhufPwSklrgb6Yp3qXWzapjPSYBVDNA1TaQDABvPG7a?=
 =?iso-8859-1?Q?fVqL+41FBv50j8L+VnEf7oehxf2Wm74Z4hZKODeotEibg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB16632EDFC93ECF528A4115F9807E0@VI1PR04MB1663.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(2906002)(8936002)(186003)(81156014)(4326008)(71200400001)(71190400001)(6506007)(97736004)(99286004)(102836004)(26005)(50226002)(2351001)(6512007)(68736007)(81166006)(386003)(3846002)(14454004)(6116002)(476003)(316002)(8676002)(5660300002)(478600001)(54906003)(2616005)(25786009)(44832011)(36756003)(305945005)(446003)(105586002)(106356001)(6486002)(486006)(76176011)(7736002)(14444005)(53936002)(66066001)(52116002)(256004)(2501003)(6436002)(5640700003)(11346002)(6916009)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1663;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2SDIjEQn5n27gb3O42sXGRCGE+YbaRzn65wJM/GiiP93Ct9S8MLXV6EMEt9UU/qgJje+WQySQiElHfJM8iIja0siAu+n31GArqMis5TX0QYHuFBYxZ6ZUI8Be9HVHy2mHrGK5fKsfvlYNQWp7+WJu4T0QQRAAsLD4TQQnVYefMQ5h6c4X+YCLARhvBpMVko0uZOo2icE7uBLOrcxz0NobU6g+KnvIAs5gNk65ukM9EoG3Bo0hI93lAWCKSsXsA7hN9DcUebvaQzk3cLgLojwVQEdpJXt9E4C7inQIpqgb4eaph7FsPRCkHNqY8Qe1CVfyFECe1E6ZgcJeCb+XyV6zTR6luACegaVaLvLD724NN5yFz+FqlfiJOqOnHoaqrvE+usiPjq8eu12T0OLGFZmmtG6npKdT3FmJZ/nfQfEQO8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cc94d4-4b7e-48bb-334c-08d69826ed37
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:03:44.1767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_100353_176487_A5F38C64 
X-CRM114-Status: GOOD (  12.59  )
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

MX8QM and MX8QXP LPCG Clocks are mostly the same except they may reside
in different subsystems across CPUs and also vary a bit on the availability.

Same as SCU clock, we want to move the clock definition into device tree
which can fully decouple the dependency of Clock ID definition from device
tree. And no frequent changes required in clock driver any more to handle
the difference.

We can use the existence of clock nodes in device tree to address the
device and clock availability differences across different SoCs.

Cc: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
index 965cfa4..a317844 100644
--- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
@@ -11,6 +11,20 @@ enabled by these control bits, it might still not be running based
 on the base resource.
 
 Required properties:
+- compatible:		Should be one of:
+			  "fsl,imx8qxp-lpcg"
+			  "fsl,imx8qm-lpcg" followed by "fsl,imx8qxp-lpcg".
+- reg:			Address and length of the register set.
+- #clock-cells:		Should be 1. One LPCG supports multiple clocks.
+- clocks:		Input parent clocks phandle array for each clock.
+- bit-offset:		An integer array indicating the bit offset for each clock.
+- hw-autogate:		Boolean array indicating whether supports HW autogate for
+			each clock.
+- clock-output-names:	Shall be the corresponding names of the outputs.
+			NOTE this property must be specified in the same order
+			as the clock bit-offset and hw-autogate property.
+
+Legacy binding (DEPRECATED):
 - compatible:	Should be one of:
 		  "fsl,imx8qxp-lpcg-adma",
 		  "fsl,imx8qxp-lpcg-conn",
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
