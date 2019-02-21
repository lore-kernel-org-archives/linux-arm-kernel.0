Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D60C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40A62083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TpJM5rCG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h029ylzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40A62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yiTtCx/ojHBjm5GO5Hm+NMVFDYsmlJQoZwSwBEzlRPs=; b=TpJM5rCGSHZn71
	Vl+Sux4hOES9+NcbBdaHT+K+jRdI1F6Cw+kHQVyHb5g7VNbsuS4X6ZK81mk1V59xPyyz8hHDFZ7xl
	VALOYboDcjUHNcXcKVKE2A5++KYk2ipUuGz72KkDpTUZG3pCQweAKYwfjZfio7RIE3T8PV6b0B/4i
	iDmx9cPLdOrLSocqH5Z9qgX96SfWCDpYE8mmmEVrIv6rVofT/5Fzu+q9Vn5e2MVI+CUmMJ5DDtPdB
	8u+/P7qWQDv0BLUwnOjRyR0PiRQxhEF7aAISnHcucYXIG+MmuBzjLmlvh4SXNdcTm9B5sJMe5OhhD
	A2AegHv5nZGhdA+egpng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt3B-0001WE-KS; Thu, 21 Feb 2019 18:26:25 +0000
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2C-0000Km-4k
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEzyPOJ8Im0LBtnFZrjVUjtFX9wEVzh/5G0YWPfFkTg=;
 b=h029ylzhdlIDNdh3SlQ4YNvXv8wzpZE/ChTK3DmJqiVQnd8EHavJ4cwA9C15dud0fTYYaAbhCHjpEFj8+QddNrnPCzdMfkT2ijYgUE1L1bpcXOPfp/yUzUxuGIc+wqlEIOmW+o7NO30CKIvVbJ7VN0euINxXsRF2wUEnS2hOyCU=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5599.eurprd04.prod.outlook.com (20.178.125.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 18:25:20 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:20 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 07/14] arm64: dts: imx8: add adma lpcg clocks
Thread-Topic: [PATCH 07/14] arm64: dts: imx8: add adma lpcg clocks
Thread-Index: AQHUyhLLxJLRRM/F8kSNs7GWqsRDCw==
Date: Thu, 21 Feb 2019 18:25:17 +0000
Message-ID: <1550773093-13349-8-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 95fe7990-0911-414d-18a4-08d69829ee0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5599; 
x-ms-traffictypediagnostic: VI1PR04MB5599:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5599;
 23:NKAKzqPqzzZyXlxJgxJ8QpCrq8TYrnnljPTK4L9?=
 =?iso-8859-1?Q?EOKxA+ySAgfqR0LCFdm2uB/aZZWt0VG+5TneucST8nqVq1jC0zURDlnHPr?=
 =?iso-8859-1?Q?skLEzkoc6QjMOOhL6dlIQG9TB/SaLKByocasFti0QJAzhzCYrP66bol8C4?=
 =?iso-8859-1?Q?0mhn2/Ppxcg35vUwGrNV8YOFsXFN/4qYMaBHlF8djKeBQ4yRtZMmsrtM35?=
 =?iso-8859-1?Q?BMG++KAbVCHV900wLOGnzy/o5sAdU/suGQ8bmjgz3Zb6WUAEul7bXFU1HN?=
 =?iso-8859-1?Q?8TVZ2iNJhVY/H1tICENDk4Nw5W3M4EfYirvUgzclo8YbuF8guBNia5+GQO?=
 =?iso-8859-1?Q?dmXiB1PCFO2fb8qNdBKdtp+gjfhMHRP9C+K+fZ3gMAy3qvcmqQqk2AQIdg?=
 =?iso-8859-1?Q?7jqFCc99Mr0u1IpXlk5RACxC2JiJNm9VTOnd/KOOp9ynGLFRsR8n1NrfYF?=
 =?iso-8859-1?Q?86ak7f05z/W1iGY5bagRdF0Gqz7scv7UYu/qLZxTesdqLQlSpjg9CIBJOY?=
 =?iso-8859-1?Q?DXxd6UUDDmrtKGAp8SHcHCNNhgRuCPsz6EhFG+ws5yG7wG35lq1eYmLuKx?=
 =?iso-8859-1?Q?z6limLAelbks1Wm1z7hWIywaCBNKEDSl3tzrPBBIP5rTgv/R8sHbYZfTP+?=
 =?iso-8859-1?Q?VruiCOxGl8+SkTG5zZVXA8sQ7192su3r5ag5Owxa8AaSo6bNg3tHGnCYq6?=
 =?iso-8859-1?Q?pYairQw8jbBuoR3HhgyyjPvBu8hpW0ijx6GKrHAXtp158UzjxrG/OoPONS?=
 =?iso-8859-1?Q?8llHJtqM4GORWfIncBBaPxiPF5z+nFwWutGz4+4DVk4OfWf9AREjhFOqvh?=
 =?iso-8859-1?Q?HLMu+ni3Cx2pL+AcZM59/IvvkA8ZDF3JPpshuNklMcRX3rCODPERVQEZdt?=
 =?iso-8859-1?Q?GjPREZW+lo0e74clvPL6n/WlB1ZsLUSjYj2YI+lw0tIJ3u8Fj/oVCXyi3K?=
 =?iso-8859-1?Q?tXNfqshjjVpHiiG5KrqwpCZcCTyxcgQZ64SdaHFeQTfF7hljSLHW8u2FTT?=
 =?iso-8859-1?Q?c5HdQCaLEPrje7MncM+B6jg03FX849NrGXmF/zbrzyTgT+0cFzFPfWof+n?=
 =?iso-8859-1?Q?tcejNO6nnLGX3lnyUQ7pk/x/r413OOTP4XKy+x3oNHUdtgobT1ASYTHcVd?=
 =?iso-8859-1?Q?8w1PzCKJomOCsY9r94bvErdklu72gmEXMCjgRRjcGJ8Um1sfaaNAvzq3Rk?=
 =?iso-8859-1?Q?RY4FuqSxii36+Ufu9Z2TVz4NbUkSUc4lwONN3wh82JugUrH58RTamLQstb?=
 =?iso-8859-1?Q?7OqBZ/kTbn6aLdOIT0ieqx274Bz0P1RkBntXS1zZKj1DDR5UzzYEZj28UX?=
 =?iso-8859-1?Q?Lpjnhcz4CkonKRJe7O4y/2doWg0ewsiAzRKXltQbDttzg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5599CFE7CA3376666825E6A5807E0@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(256004)(53936002)(106356001)(71200400001)(71190400001)(81166006)(2351001)(2906002)(6916009)(446003)(105586002)(81156014)(44832011)(316002)(305945005)(97736004)(6666004)(2616005)(8676002)(54906003)(6512007)(7736002)(2501003)(68736007)(76176011)(386003)(6506007)(3846002)(486006)(14454004)(5640700003)(86362001)(6486002)(52116002)(6436002)(4326008)(8936002)(102836004)(5660300002)(476003)(26005)(99286004)(478600001)(11346002)(6116002)(25786009)(50226002)(186003)(36756003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5599;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eUklMTLgDeicV6lCC9g6lDrD00JzF03mhFNeaVzF+guOdXxcxmWjEYxAChhLhFXVKG1/cu+LpjqBaJw0iFnU1A99a65hyNf2iYE8ozVPnvDU342ph4W+x4l2006EgG7CFhuU+pv6prIr8V/DA1gqTRomg5/GjqSfRFXrZ2MWdNOY4VAcn/BnwtJwGUoUj0rOER6TTpKSSGvBxn8VGqJMZ1fl0oWYgsi3rBbUqzdk12VQZX7YFoSIhP4DLvZqc81Dt9yzfnnXuVFPifQ+RLJjT1Aq0jsHcvBWMrLrUDKjLu2nN56r1KF6PT4eAPpp7puRJxC/Wp90VCeYwt1CMlK0Alxk7VBIZIxmEGcVjs9PIoltP/O1mdbLBohScotco60MjKsxn7Ey5JmnEjfheog2RrK9egNkxPrCaQaTVQfaHEo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fe7990-0911-414d-18a4-08d69829ee0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:13.6779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102524_747629_8E300597 
X-CRM114-Status: GOOD (  11.03  )
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

Add adma lpcg clocks

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
index 5f0e9e3..c7adeba 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -146,6 +146,79 @@ adma_subsys: bus@59000000 {
 		clock-output-names = "uart3_clk";
 	};
 
+	/* LPCG clocks */
+	uart0_lpcg: clock-controller@5a460000 {
+		reg = <0x5a460000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart0_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart0_lpcg_baud_clk",
+				     "uart0_lpcg_ipg_clk";
+	};
+
+	uart1_lpcg: clock-controller@5a470000 {
+		reg = <0x5a470000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart1_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart1_lpcg_baud_clk",
+				     "uart1_lpcg_ipg_clk";
+	};
+
+	uart2_lpcg: clock-controller@5a480000 {
+		reg = <0x5a480000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart2_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart2_lpcg_baud_clk",
+				     "uart2_lpcg_ipg_clk";
+	};
+
+	uart3_lpcg: clock-controller@5a490000 {
+		reg = <0x5a490000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&uart3_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "uart3_lpcg_baud_clk",
+				     "uart3_lpcg_ipg_clk";
+	};
+
+	i2c0_lpcg: clock-controller@5ac00000 {
+		reg = <0x5ac00000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c0_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c0_lpcg_clk",
+				     "i2c0_lpcg_ipg_clk";
+	};
+
+	i2c1_lpcg: clock-controller@5ac10000 {
+		reg = <0x5ac10000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c1_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c1_lpcg_clk",
+				     "i2c1_lpcg_ipg_clk";
+	};
+
+	i2c2_lpcg: clock-controller@5ac20000 {
+		reg = <0x5ac20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c2_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c2_lpcg_clk",
+				     "i2c2_lpcg_ipg_clk";
+	};
+
+	i2c3_lpcg: clock-controller@5ac30000 {
+		reg = <0x5ac30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&i2c3_clk>, <&adma_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "i2c3_lpcg_clk",
+				     "i2c3_lpcg_ipg_clk";
+	};
+
 	adma_lpcg: clock-controller@59000000 {
 		reg = <0x59000000 0x2000000>;
 		#clock-cells = <1>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
