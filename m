Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EC72083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ev3ydJtd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pG6RW35r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EC72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kW4GHLkbo/cNLRFEO9dqtOcfTyx+FfPWUaiAAhm+i/I=; b=ev3ydJtdLQQ3fn
	g+wGDn6hkN4ZdDckp4hxyuJbT80IwKnxoHNg5WOOBuRfPX5m0P/8hSpyh9zwqJj4+DtWixWDPbx8a
	l36lQjuH8VoSWIx/YHUp5yyiChcGSbERXa7qz5e5okZ1Vyk39atQXxc0VEoWSBwHdHSjprwXbLenf
	CEuNXsdb3IbHsH+pLiW7uIWyOS/0wzHmi8hqc6+GPGrWggzTwOSYMwKOMupB6F843RQIe99bUGO6N
	jsUzkCZODY0s7CW177dcZhU1AT5wkiJ3+HtS+r6fKh/3RJ+NMFmyRK9eLwbdwN3Ngnee1YDO0Nytb
	sc/Ns6ww1EWaeXvnDUOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt2E-0000QH-RR; Thu, 21 Feb 2019 18:25:26 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt1u-0007AG-Q3
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fql3sunvF6+59n0EBkGB+dhM4lkD+JsCzm54wXgReaM=;
 b=pG6RW35rnY3FYtvUdtwmXTTVfqRr1ZkGCIR+qa5aBQSid5bBjavjF+Zp2yfwhSYHtUANKUr0Ngs66RIsz+ILrhQKu4xfifAE6E07qCmlGekGiHWC04ob5mS/KS2zxKZdtCnEj93lt8PYrVHWiYGRjyClPDj/rBhaOUdwgjtadM8=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:24:56 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:24:56 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 02/14] arm64: dts: imx8: add lsio scu clocks
Thread-Topic: [PATCH 02/14] arm64: dts: imx8: add lsio scu clocks
Thread-Index: AQHUyhK+E717Y1+vT0iGHzMoJNdm+Q==
Date: Thu, 21 Feb 2019 18:24:56 +0000
Message-ID: <1550773093-13349-3-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 36ce17f0-86d8-4ee6-d588-08d69829e145
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:z/5Dj+TlEMmxf2d8umEzOIs9F7YljpHfkfNpQIy?=
 =?iso-8859-1?Q?VR9b8vZO2LnNUJEOxaa7nwK/17s1vi07rmV5neppNEnRLdGA/wysml5qQa?=
 =?iso-8859-1?Q?F810t5V3cXA8JXmtYy6a0BX+Vc8izuAeezVxvP7mRkSUzWPVaEuVAfAB3d?=
 =?iso-8859-1?Q?+n7+nR0LEf/KWZwCFAg0UsDQ7A2W/e06JUmrJ3tolMIsrZUSWWP1zDWyw6?=
 =?iso-8859-1?Q?yzMMlqqnmVjn4dvYHmH1g+se5pqogdJNgIvQNbR2tV9daSMZWvvmuwIAuG?=
 =?iso-8859-1?Q?eJviz+HbKMUPXro0Wja2HNX6zOrtLJup0ukhYZf17CKis++HVT9RKxqCk0?=
 =?iso-8859-1?Q?grVRc583NbFEWWUINaCnI4owAATIj/dtQtbOpA9ErOMoetRuZubMBivcwx?=
 =?iso-8859-1?Q?qthyEeqvAFtyN4M3mjwwLutbVjMZmTrRNIbQVqPvBtYiCdgCt8mS1ppXQp?=
 =?iso-8859-1?Q?OVNARF3tWSiQLfhXXsBeIAcKXfCSH4VV65SBycZ7cirZ5Y25x9YKHVdmqs?=
 =?iso-8859-1?Q?80kmZUupfRoqvahTwYIYJvn6ze6kDQ9Iitd17zCEoYJJa+tWu5GibaRVgK?=
 =?iso-8859-1?Q?aG1SCkZ57xYM631aMFhREjVhZY4/ZJJO1ZanOwcqhkgtU66P4dla0Fx12Z?=
 =?iso-8859-1?Q?IZR4yzAi4sqA31bP2vH7ZLRJRKl3T7+ZRCFHbABLCjrWmccCwBRnrd7GZy?=
 =?iso-8859-1?Q?NXMtRTgQhxWsGVlIDdDsiXkFps+MCoR9gAQ05gvNiCprC9mVZLZC1bZ6Fv?=
 =?iso-8859-1?Q?0BPsIcyKnhIpZWBhE9K1gHqCW//t9TM9F2mIjjhzvyCcX/9ARt4mOEOOUU?=
 =?iso-8859-1?Q?ezLj/p5hzK/rShP2Gf4wWI6OtLofUYhjbMhCa/HtdFtFnzneJU7LuGns3H?=
 =?iso-8859-1?Q?dfQGCInkUxmYtuSUnffOrr2NP02AVU6ErCbx6t0HHa3StnJy0HWSaoCNPY?=
 =?iso-8859-1?Q?p70ldOlxb3fJQdL9fVnjwSW9QaOSp1FwOiKqkOgOgHqfEDQouprdczikno?=
 =?iso-8859-1?Q?pGcvsmRJRruAtB0b0RH5teJnpXy2CrjKHXKpy5l0ucgt+UxuOHC1QIqg8B?=
 =?iso-8859-1?Q?R3hWqtr/cjqvU8wsM+zbatIiDFk0Rc9oQ/z7iNUuQ2jeULWAFXaIAv+ea/?=
 =?iso-8859-1?Q?eT1tDFNuiG6tipnDgWnQwjlkbh7YJfznSqdlwcw+od7c6SEAGySn0FYEQP?=
 =?iso-8859-1?Q?er739bietTyDMwlDFy77b974Wv3yDVICzZWzy1hC1gofpvnkr69RlvkxwD?=
 =?iso-8859-1?Q?0WyG/ONEsW0CYpe7b/AeucJZ1Rk03cyHgsBh/ecNOx325F5eut4jkzrNUF?=
 =?iso-8859-1?Q?koYCG/Ua1G1pGltIoCZQ10B?=
x-microsoft-antispam-prvs: <VI1PR04MB4846D704DFCEEDBEC889CE09807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xXH5+QEETUuA0pLM6uTcxtK5z1r/W6lJFzLud72Ra6Ir0hNjABvuPZ84+TdPjw/8bYtPJDP59X3a2o6tIPlo0HtAesLv+KzmJzDEhlTcrR2PgTAHLIXy9TRPwwMAgjRJgjrLFMPVZs+NxFRjXgb+HVmwPw7ffc/u8fKTWhjGWWHUvahVNQTxFISIEaFFbHahWDox3mMQhb+OdTtBiQKZqDqyEXR9kyhkmM8hDJF1j2hoQH/sL6fXSA9C0c40UmsG3Icw11Yd11tA4iWY1X+vwLBkkmEaZBngc5Wezfta1JkRD2J5LyDo/yjMmhdpTjlO0FMg7h4+0Hpafky2MRsABBJ32i2SVfuTXeQMW3VhdkAn1gxnOJZJ8g+MMi5aeLGzab/l8c9ivStnH2iVLuNK+7X1JqfW9hVABFaKZfFG7c4=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ce17f0-86d8-4ee6-d588-08d69829e145
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:24:52.1968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102507_195761_66D765EE 
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

Add lsio scu clocks

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 122 ++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 1c6ba8d..5c4c2fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -4,12 +4,134 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
+
 lsio_subsys: bus@5d000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
 
+	/* SCU clocks */
+	lsio_mem_clk: clock-lsio-mem {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		clock-output-names = "lsio_mem_clk";
+	};
+
+	lsio_bus_clk: clock-lsio-bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "lsio_bus_clk";
+	};
+
+	fspi0_clk: clock-fspi0{
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_FSPI_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "fspi0_clk";
+	};
+
+	fspi1_clk: clock-fspi1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_FSPI_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "fspi1_clk";
+	};
+
+	gpt0_clk: clock-gpt0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_GPT_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "gpt0_clk";
+	};
+
+	gpt1_clk: clock-gpt1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_GPT_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "gpt1_clk";
+	};
+
+	gpt2_clk: clock-gpt2 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_GPT_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "gpt2_clk";
+	};
+
+	gpt3_clk: clock-gpt3 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_GPT_3>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "gpt3_clk";
+	};
+
+	gpt4_clk: clock-gpt4 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_GPT_4>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "gpt4_clk";
+	};
+
+	pwm0_clk: clock-pwm0 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_0>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm0_clk";
+	};
+
+	pwm1_clk: clock-pwm1 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_1>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm1_clk";
+	};
+
+	pwm2_clk: clock-pwm2 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_2>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm2_clk";
+	};
+
+	pwm3_clk: clock-pwm3 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_3>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm3_clk";
+	};
+
+	pwm4_clk: clock-pwm4 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_4>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm4_clk";
+	};
+
+	pwm5_clk: clock-pwm5 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_5>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm5_clk";
+	};
+
+	pwm6_clk: clock-pwm6 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_6>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm6_clk";
+	};
+
+	pwm7_clk: clock-pwm7 {
+		#clock-cells = <0>;
+		rsrc-id = <IMX_SC_R_PWM_7>;
+		clk-type = <IMX_SC_PM_CLK_PER>;
+		clock-output-names = "pwm7_clk";
+	};
+
 	lsio_lpcg: clock-controller@5d400000 {
 		reg = <0x5d400000 0x400000>;
 		#clock-cells = <1>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
