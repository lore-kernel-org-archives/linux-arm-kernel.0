Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDDF213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvEihGIb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qxz2gqdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDDF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x4+VQNu3HJJlnS8NGl58SP/QIau66hOFF61NOwQx7r4=; b=QvEihGIby6dDix
	bvT61MWca/wYSigbfjXrzYRrc0g8/xBlxvqtXxaIDsgRPK7wfOT5jea/EN3/K3jG5HSjcDi7wds5y
	poMQ9ZJmPnA25kgP227ij0hH88U8O/bzzSdqGY3x8i0t1F55l4Bv8/lee8HPqW0JyN/jBPfb4QXD9
	ax6DookPGYDCoLEentR7goyDm8I/dDhOQPIBJQpeb4GkgZcSLyFSFW8t5B5uGyfngmyeWD0wtCLvv
	R5ge4VV6uJ8q9qFuoV6UzqJ2yHtUKrys1bwJ5XSdwiz6BsZi+ntrJVzjMOzHPZucXThr40ia21SJq
	3lAE/UUOz3KbNCRKzZMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGHt-0004fc-9a; Mon, 25 Feb 2019 13:27:17 +0000
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGHL-00040W-At
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:26:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWftcf8SrJsOU5X4AznxrONSgEEntkz25eTzgABEEhY=;
 b=Qxz2gqdjQ8p1jL5S0x2xmUkRA2Vpmxx6Df2HuhycQKbjU11vtZ32521TqBa51XITgGAbodcGbF56V33ZB6Wq0U8oCgXOpscud+JEtWLWxfsBBi5hAM3xycJVuZODMtPA/fCFe7oue03nkFTggaB8YVzlUEmm3P/nIIo+rvXqwAI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:26:37 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:37 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 2/5 v2] arm64: dts: imx8mq: Add SAI2 node
Thread-Topic: [PATCH 2/5 v2] arm64: dts: imx8mq: Add SAI2 node
Thread-Index: AQHUzQ27PdTDp/7b7EyAA+4Bj+dPfQ==
Date: Mon, 25 Feb 2019 13:26:37 +0000
Message-ID: <20190225132617.10987-3-daniel.baluta@nxp.com>
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1a1c1b-be6e-4ed2-dfbe-08d69b24de4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3485; 
x-ms-traffictypediagnostic: VI1PR0402MB3485:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3485;
 23:fOPq/8CFFpANXlPYabPjqXGEHFg/BUMCYhBwq?=
 =?iso-8859-1?Q?riLlz7/dTYqO82T7EgQAFDKd8bf9enW9JqRDKcMqf06PVY9YcnZAoQaZ9/?=
 =?iso-8859-1?Q?I+FKlNaFVA06Wu6PkFT4ptEbC2jimOK6ybD0Z0q9WbBgNTuPLoGUT3M8R4?=
 =?iso-8859-1?Q?2dWibcR+ejfon4IK/PNIo4XHGA1Aw0uhoUbGrtdwBDKCt0GUaStmuGsC1g?=
 =?iso-8859-1?Q?yQb6QObva8nWHaEFGXpm7a2wYnFJ7asuMC0HDUQ63T9IPpgtPpI3idYe3L?=
 =?iso-8859-1?Q?Bsq4jVp454J0u0YJfv5IaSv7K4xjxDGCVKBRjRl6I6JTeBDIFbffQWSxAi?=
 =?iso-8859-1?Q?ezOOEQ6GUiMuI8LLMNiqrWEjaSh0DVOqiBKpbZkBQ1Shw9ozdBhXOKPsza?=
 =?iso-8859-1?Q?j9UDFzeDKF2SCBebEXy1e9fi1IKay/KtSSeU7a3uNi31LrgLsZAgIABpdK?=
 =?iso-8859-1?Q?72xQhAGYVpesPgHPvZtra1Tb9mnCA/ejNVMeq7oXz2Zl09tF5rooVlmqBp?=
 =?iso-8859-1?Q?t45ieTqsJUvS4N9d3c6KZMvzoqdA0HTc5O0hSEH5SCvKKj08RTz/M5IZu5?=
 =?iso-8859-1?Q?kL6gV8y1xmLbYkvKAqjSVEDg+FYdbHNjrfvF+ICBAz9UDfygmVtx2vmFc4?=
 =?iso-8859-1?Q?CeqLfbLKRanIYO2aFkVwYhCvhph9Bge30sfJXVT84C30QLv+1DmueELdsl?=
 =?iso-8859-1?Q?2aXHBPrFCaxIMPFOQ0PvCnB70sGzx+gU6ym7TaQuEMIn7nO0CRegnOQDG3?=
 =?iso-8859-1?Q?tiGdJAWZypnPDbWbb5tn+ZOrDze1BNBT9xWaP4q8o0kDLnro+iCN6+OBYd?=
 =?iso-8859-1?Q?x0NyKf8HqjQDFXonN8preDTFiJYUSnVWVPPNzSjWpw8vdQgWd8P0NZ1jDN?=
 =?iso-8859-1?Q?v/IZFwUlHLMvUaanfWlb0RL6pJHcczhbqUHnwZ6l0UwqKxldR9Y8iwXvI5?=
 =?iso-8859-1?Q?LQlo4CaG68dm17DjBLAgFpmrm0Yw/9hw0d69Dp4tNrCAp5+/7e7u/fWxj9?=
 =?iso-8859-1?Q?NbpyGmoHgje4gxcjTq40HoXmxljUXu4/48PNsfdIfYu2CQ87pwDtyUMmSi?=
 =?iso-8859-1?Q?HTyaPaD19VZYH14dtItzE4EAyhDkcoKBYAIXG4JdC9uIT5r2xznGgZbIgF?=
 =?iso-8859-1?Q?FbJuEhoPqbguSsbP6ZO2Rfp+88+iJRm0d5Jka1oVNkaHUR66Jdvul8qaUM?=
 =?iso-8859-1?Q?OqG+rcblQwSysqFsystgH2BGiSrOOGt4uPuGhqGnt/uHgweXJ688Z0/nPM?=
 =?iso-8859-1?Q?f/WsaA2ZfocifKwiXs9GjoALS+R037/q3LKzNon5UnCosz4pZyKplaRwvr?=
 =?iso-8859-1?Q?pgxkN8ilkFhDIkw1HdkeoMlpZsSqDUs9dCrY0BTwXCdp9p1Ux7NeFfllDC?=
 =?iso-8859-1?Q?d2ObYLnWASOWQ2Z7aXFCC95ucz2mnjFf1dkuAlx+EacE1ZeY5KFmkq794f?=
 =?iso-8859-1?Q?F3Z99u+rUaF2vk78=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB34858EDFD566AE80013AFA5FF97A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6116002)(105586002)(106356001)(5660300002)(81166006)(71190400001)(81156014)(2351001)(97736004)(1730700003)(71200400001)(66066001)(478600001)(8676002)(14444005)(2906002)(3846002)(305945005)(86362001)(14454004)(7416002)(7736002)(6486002)(6436002)(316002)(5640700003)(6916009)(6512007)(36756003)(256004)(26005)(476003)(54906003)(4326008)(486006)(2501003)(50226002)(446003)(68736007)(11346002)(44832011)(99286004)(52116002)(76176011)(2616005)(1076003)(8936002)(53936002)(102836004)(386003)(6506007)(186003)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3485;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iqTxSechP18UD6N5eB4mY3kTA8uc5fQsQyEKkMMRPA7nkHRp1s/ZmMwEKSG+kFrX9iB3J3l0iMD/4JU3cPqQJX1wOynlwIpi81MZuzXUYebPdbpsFC7uumhbJZ3RAvFxa9NcA+n/cM7bswvxE2NcPP7K0BpQdguPL/sjgDdjZSupZOmUSfojlCJL9AK9rHv+f3EYmEyADf1nM96sQ55xY4xBkCx15YJzBpfEclOhtDOAHptmOEqexDdzCKSJAvJssO6Ehos/7cnPiVHNsx08i7UtIwbphAK/LUR7P7SDiVfplha8+npME9xOvOfllV5/ehp5J3cnK1Ej8zEyav+0F7GIdQO2UE5ri/1CgowN6QybpGI8zNdfo/RJSL6n9AdCHu4Sux1yM73U/HeVDr6jsOi0tac0+AiHwIkKOp3Phx0=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1a1c1b-be6e-4ed2-dfbe-08d69b24de4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:36.2621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_052643_570861_3E0E173E 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SAI2 is part of AIPS-3 memory region and it's the DAI through
which the wm8524 codec gets its data.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 8cafec17726b..6fe5798afd2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -489,6 +489,22 @@
 				status = "disabled";
 			};
 
+			sai2: sai@308b0000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx8mq-sai",
+					     "fsl,imx6sx-sai";
+				reg = <0x308b0000 0x10000>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
+					 <&clk IMX8MQ_CLK_DUMMY>,
+					 <&clk IMX8MQ_CLK_SAI2_ROOT>,
+					 <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&sdma1 10 24 0>, <&sdma1 11 24 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			i2c1: i2c@30a20000 {
 				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg = <0x30a20000 0x10000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
