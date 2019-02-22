Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:43:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4722077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sKCTUcK1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VuqyhVUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4722077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WTvmLmJWYIC+wQPfI44mS84koxIl+PLgaltZNhx6btM=; b=sKCTUcK1cNNwDK
	slnKx6Ivn2bovcgoZl1ClC4wdlw91BXpczNzJXFoN6VFtopG3Z+z3/OUVHu+Ik4eqE/bfm9ZTX486
	+G+tcUJip7MztSQpD7+BKy7vAnG3tYXmgwlyATjXrgJZ/g+Fe0Ajj/A+8B8RDYku3ACfPiYp820Pd
	WsoWtMqO1JZB/Vt+0AoAvNBcBY6tYnSJsBUUUTB4H1RXuK5wcw5WRMBUV3wE89lMxq2jQFcXLZbs0
	J/kTTB7iqVcx6RyQ9e2qezDVyWS+O3tlvLW9AZpeDyfI8PoJPnStfCkMVC1wBgpT/gMCQLCczuzcJ
	Zl5VXCKagWw+B/jiwIBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7MJ-0004Jr-Mq; Fri, 22 Feb 2019 09:43:07 +0000
Received: from mail-db3eur04on0623.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::623]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7Lk-0003YU-14
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cH7PE7QtuTTLuMljKopNiYK+I7Lb/pD6UTzww/AMtw=;
 b=VuqyhVUaoovBcDO/kQ0xHN8RHSbiRFnVmqGDD8BEOGuiDzjtI2HLNBG6bLFpIHK9ozQ9DKJBEnebSrMDzbD0olHywghgLI3r8xCMqTGbi7e5PPgYdXUqUbRmNgkof9m44nxdNzXRQWeTFU+GL2NaYsEjNxd4/1fV8PKUXG4Ip6Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 09:42:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 09:42:28 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, Abel
 Vesa <abel.vesa@nxp.com>, "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "agx@sigxcpu.org" <agx@sigxcpu.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: [PATCH 2/3] clk: imx8mq: add GPIO clocks to clock tree
Thread-Topic: [PATCH 2/3] clk: imx8mq: add GPIO clocks to clock tree
Thread-Index: AQHUypLsJex6bU8gwEKPZwhGnr6caA==
Date: Fri, 22 Feb 2019 09:42:28 +0000
Message-ID: <1550828264-9962-2-git-send-email-Anson.Huang@nxp.com>
References: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f96210c4-1307-4199-519a-08d698aa0ea9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3756; 
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3756;
 23:F3aRxOrJEtnzawMD2z1LtS3HwWNyMKp1/9Hou?=
 =?iso-8859-1?Q?I4Jmkho66/LEKAONbwdN2HkXkkfuleAdAKcuaOcKIMNTylg8JNdETvtSug?=
 =?iso-8859-1?Q?g6+YJJwonRKbc9FoVit18NJaqMr0yvwVRJSBOI8kFRnQqadXWCwARa8je5?=
 =?iso-8859-1?Q?frhOMPddlIEVHUQbYxHmlWd0eSbykOAfdMTYLDSeQfQ2InLbBbtzaQO6VM?=
 =?iso-8859-1?Q?UjYk0mHYJBui0GU55CcETYTOdJHAx47f2oHyGlM5UYzplZFP2HO7SO7xuN?=
 =?iso-8859-1?Q?lmjj2cw5wLuAhqyugmp8+qSJeMCXZ3mlJ2DqCRl9GlRMX+G7dmhs1OwjLd?=
 =?iso-8859-1?Q?N53TvJDUvU67/6AA85VcTt1vJIkXxynl4PDgXGqLT2exas3Td/iSuGNL/o?=
 =?iso-8859-1?Q?Q3hIcgxK8ieJ73QsTj2j/TsfQ9AeQwpuRGG7XsG03Psoq3M0CTRiuQDpKk?=
 =?iso-8859-1?Q?ZsXhWtVqFoSb+bipD5csjWXbFg5L0OccCMyZk+jetPKJ4eKsz6NQTvY1L1?=
 =?iso-8859-1?Q?2hjUUuK3zx7q9oTYLgl2j4vqAjdcWYFAJJsV1KJ4A9fgcdZnB9CLVqKjTZ?=
 =?iso-8859-1?Q?P8xgt+CBzt+CxRgSlkRUj4bs0K56UVBQlUVZOIxtnWVMK7zwDejbiqj2l6?=
 =?iso-8859-1?Q?ydUlh8POyHyHFhHVB3h9/qhWTw3oTZdeeo7fnc3gNysOU/RBB4n0QulZf2?=
 =?iso-8859-1?Q?EmGgg/ZkCwyGS18q3qLJOHyPzWy/e2KZit9tGGDI3DI+vvvRQa8IzFzob4?=
 =?iso-8859-1?Q?2hsYeTRxuVzyEjb1gmq8vLZK4X+EdwhzXBzecH5krhGHHiZ118/1E8CgdY?=
 =?iso-8859-1?Q?5CDymPX03/16o7jS9wYs3tnqdytlFx4s/7L1r3QdMtIdFYnjxxWz8AOsn9?=
 =?iso-8859-1?Q?aICRQsuvmU4MBxtS9uZiOFgUsiV/NZAJB43LCXkEMQDyHg69bzVNFm2nn4?=
 =?iso-8859-1?Q?aaie7AKxbNU1/BXhohzqqbq8um6Ks4c7uyQCowcAbQqSeTs6BkQvu8DTdq?=
 =?iso-8859-1?Q?/4paE5phgevkgxJr8H0uIhdheYOIVn4kUjOhTE5xGgVULjq/CZ77VmYrqG?=
 =?iso-8859-1?Q?tBonMdwr+O94vh8ZzdekIRLaUOX9DnuHoFrslUCS7hqsg9jiprLfatGqD9?=
 =?iso-8859-1?Q?f5dyN9B/wcuGEtx4TxkETTnmhgpc/xDP9yIe1vQRQtR7tix/AkUPCaeFul?=
 =?iso-8859-1?Q?yW9cZdOLmb72oQgupIm2kQmIsYqAd2E8KK2mPuWtStXm2zU9/su4tAo+T0?=
 =?iso-8859-1?Q?1t8qifwC4gO6jUgFvHn7RBSC9X6Uef3fvCjIEUI5kpBsRCISvoqoXRkeHs?=
 =?iso-8859-1?Q?a+cYMlGUPvwvASACPeL+XruzA47qIaMAcTsLTO6p4IDHh+g=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37569BE5496F17C130B4C714F57F0@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(189003)(476003)(14454004)(102836004)(106356001)(478600001)(486006)(186003)(316002)(2616005)(446003)(99286004)(386003)(105586002)(76176011)(6506007)(52116002)(26005)(2501003)(66066001)(2906002)(110136005)(68736007)(97736004)(36756003)(11346002)(7416002)(5660300002)(8936002)(256004)(14444005)(50226002)(25786009)(6486002)(71190400001)(71200400001)(86362001)(6116002)(53936002)(3846002)(305945005)(6436002)(81166006)(81156014)(8676002)(7736002)(6512007)(4326008)(2201001)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3756;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IxXjISnSiGn0e4ul6nALQeYUvGozhT65yStYxioZPQzroB5PyZRvZEUUMz79QS9nam0d9LinNtCx2OZdyPpLo2Q9WAL4OHfe5NjkjZ1Q1LTYgShqOStzJ43/Yh4UBaGtYQBC1CYuS46NNep6piqRyxx+EKTovpL4Qms0sWv4p78NWtG/0uQ7tggtpvrFtHYk1poQ2SdNPGirHQNadZJ4eDaC7jnmvCdDbDbWWvsQB1TgOapqxolS2wZgjjoVr0apPxIu/l2hZQDVDsrvr0RBMTfKRagUCyeC0A9JilKdMka6D3zbWirMP58kcceygHWnzXwkZE4C6q+hrVSQ23YcsqEI6UvKPlsIUkRCmRDBtFWDpLAfRfkOpozZzbrYsq1AtWWJhfXq+sYBeb5rWPffgQZDOCkHgXrnZbp1yWF9meU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96210c4-1307-4199-519a-08d698aa0ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 09:42:22.5837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_014232_069038_27DC2ECC 
X-CRM114-Status: GOOD (  12.08  )
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

i.MX8MQ has clock gate for each GPIO bank, add them
into clock tree for GPIO driver to manage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c             | 5 +++++
 include/dt-bindings/clock/imx8mq-clock.h | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 2df1575..5839e45 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -498,6 +498,11 @@ static void __init imx8mq_clocks_init(struct device_node *np)
 	clks[IMX8MQ_CLK_ECSPI2_ROOT] = imx_clk_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0);
 	clks[IMX8MQ_CLK_ECSPI3_ROOT] = imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0);
 	clks[IMX8MQ_CLK_ENET1_ROOT] = imx_clk_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0);
+	clks[IMX8MQ_CLK_GPIO1_ROOT] = imx_clk_gate4("gpio1_root_clk", "ipg_root", base + 0x40b0, 0);
+	clks[IMX8MQ_CLK_GPIO2_ROOT] = imx_clk_gate4("gpio2_root_clk", "ipg_root", base + 0x40c0, 0);
+	clks[IMX8MQ_CLK_GPIO3_ROOT] = imx_clk_gate4("gpio3_root_clk", "ipg_root", base + 0x40d0, 0);
+	clks[IMX8MQ_CLK_GPIO4_ROOT] = imx_clk_gate4("gpio4_root_clk", "ipg_root", base + 0x40e0, 0);
+	clks[IMX8MQ_CLK_GPIO5_ROOT] = imx_clk_gate4("gpio5_root_clk", "ipg_root", base + 0x40f0, 0);
 	clks[IMX8MQ_CLK_GPT1_ROOT] = imx_clk_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
 	clks[IMX8MQ_CLK_I2C1_ROOT] = imx_clk_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0);
 	clks[IMX8MQ_CLK_I2C2_ROOT] = imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0);
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
index 04f7ac3..aff3335 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -391,5 +391,11 @@
 
 #define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	267
 
-#define IMX8MQ_CLK_END				268
+#define IMX8MQ_CLK_GPIO1_ROOT			268
+#define IMX8MQ_CLK_GPIO2_ROOT			269
+#define IMX8MQ_CLK_GPIO3_ROOT			270
+#define IMX8MQ_CLK_GPIO4_ROOT			271
+#define IMX8MQ_CLK_GPIO5_ROOT			272
+
+#define IMX8MQ_CLK_END				273
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
