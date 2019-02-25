Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F0EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9244620652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ixiBk6d6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JruCMLC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9244620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7Su0V5ZFR7fpsWNzA0NoQPPIsIXdnZJpWI6FiWLErI0=; b=ixiBk6d6kzdb9P
	QoDh4olKFlZOo9JGdM7+QVjg8KZTuSwhEzulry5DsRc7QqJc/y/Y73Z4/9/CcxsJ/B2cZAn/TZiJ5
	SPp2dzEXIcNUpteC/GbMcmk2Ra0OK8vPFF5Xk80h53ThuzewYU+sx7glgvKuAB4qhnJ19n2BdQ4nj
	rdfr0DrWBW+Wq9LrvYvZSNE8xe5yJjwIoLc/ig531q/Wf2h4rzh+MKAqx7X/2UrZex+vm4uQTYOZ9
	jDWJ9Tqtf5d/MBxGRU6SWSz5mzjG/Frty4VdzRhHmGvRSKADmeFpuXQkF4qqBEwcG6rBw8tH3/xE/
	16ArmWTTadVy/vu3M0og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyG8t-0007kZ-36; Mon, 25 Feb 2019 13:17:59 +0000
Received: from mail-he1eur04on0625.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::625]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyG8o-0007j5-Ek
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/GJuXHT4XIx7pCYJY1Ujgy9cwKmpB+ZMhe29Tbs/Y4=;
 b=JruCMLC4KNXoHXGAHSfekelsNC3G+qldf+Nb+5u048fi/qCUvpyq2/Jh3e/7sZzTfyChT7FoaWGRd28k6HiE7Sy0bHcxouCymQ9ZvryDGYN62IjioCALfjhDsl6dIXPc5n6y8Bg28iRk/9fzb160R0iBJjXCXzzaNpI4ZrbFDHU=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:17:46 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:17:46 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUzQx/QeEbizeFI0O2BFE6xP8gsg==
Date: Mon, 25 Feb 2019 13:17:45 +0000
Message-ID: <20190225131722.10253-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0202.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::32) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcff3d63-4afa-420f-6ef1-08d69b23a1a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2895; 
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2895;
 23:WEuoqekieaqWlJHKS0y6BH0CFvFhcy+IpF8oL?=
 =?iso-8859-1?Q?sJpqAGiMrJGo71ZTcmZPOZb4PIqzOo1pMfyumKOVu92hAuEaQzrvferEPC?=
 =?iso-8859-1?Q?BKa00vPAi96E2c1Sk1iJkn9WZ/IR6WhxQFU4cr61LCVm2jOCISv93rJGNy?=
 =?iso-8859-1?Q?QlcVEnRK7ximCodABaQcHQ9xpcRDIOkpamRuSmA2JMlghqFtmWq3ojcFva?=
 =?iso-8859-1?Q?BB6msLkTN4ocF4PIl08EpmWGu56Hq2GEDFyU1/KxADThP/Ppvh3hBoLa6s?=
 =?iso-8859-1?Q?ijdlJijqj3l+iUki1YNIVMgogtPDdZSy3mU5R7WjVVzetUuqf2DRZny/do?=
 =?iso-8859-1?Q?bui0wWM1ncHYJnVHd+d/q7gjjdpOsWtTQJCTdzG3KI10MY2+Mgjz1e3q2Z?=
 =?iso-8859-1?Q?W+qICbzMxvuSyRYzOXvXkjiDTZbjbZyOW1NCvgYLzy+f5WR2ewYIvo0SLh?=
 =?iso-8859-1?Q?9UzuC7KesPZrkvr9KqdO+Yxnt0UWG/UzT+mEBavLGYvHR2OY7ra0xKrnco?=
 =?iso-8859-1?Q?90bpxoj8HhlDUER51BUfk2AnhZ8qdDykl+IeX8VcbvZHQlJV5oDHUY9rqi?=
 =?iso-8859-1?Q?nPcP2T0onyQvTV8kt2PBcYWOQhLCbiibbEdKel5wNPgTGfqFsgPStyjT+B?=
 =?iso-8859-1?Q?/kOKxuCAZj5Wi+DCmpyb7jFSfaCfEubrph4zwGJA82tExf9ygFTm7I49xD?=
 =?iso-8859-1?Q?Pve1OP7EENNa8HY6W/Aqsqc1GDEZwyNAb8Q82xurTv5BiiJk2TI+vQzeA6?=
 =?iso-8859-1?Q?JrMbmHr63auoSTjo/ZF6q28guBs6qyx8zERSeTjjGLMVg5ufpiD+rwnpz3?=
 =?iso-8859-1?Q?0mq/ygMyxqaRPW8t/j5A2xvejgEr3wqknM19HZL/Ram0N6MW5yCwZ3rYFj?=
 =?iso-8859-1?Q?AaNifeibxg8+BM7ZIhQ0pu/ZtXY80E3EzboE73uHy6OHVtfwinVw0k+hRk?=
 =?iso-8859-1?Q?y2TiKp95WKGr3+bGqUV04Pc6QYoKMjyX17ADHoqBTwnGFn9+RlR7OS+4LJ?=
 =?iso-8859-1?Q?+0zLi+hCndJ4KkGJfOQz+3xcSuSiEFEaff3nVusp93GAOmk6kkyKgWPVo3?=
 =?iso-8859-1?Q?P0TScVIANfoPKYj1uRbw+phSKurP6fli9A12m1Jrd2NTvT8DP+sKGBvsbB?=
 =?iso-8859-1?Q?ZHQY/S5P83XBVXdEq7rhITDzeyhs2hsFnuLDscwidjuqeJMH7lqaPEIP/e?=
 =?iso-8859-1?Q?dcDf/9oSKVm2XCp5ccJqrGliBatIJLPfs/lmI0g5APERlWrQmC5LaFr36d?=
 =?iso-8859-1?Q?rzyef0h0873ChqpJuJj3G79C8PMyMst8AysNu0CVtMYG+fBaFVnj6ZVqyV?=
 =?iso-8859-1?Q?JX0+U2i5vkoDND7BMwZAULyNLLmVvpYvLEYURPxiA9Ck1SZWUKSs3IS0Kb?=
 =?iso-8859-1?Q?anqIWFxw0Q=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2895DB597A02895DA5223497F97A0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(8676002)(81166006)(1730700003)(2351001)(81156014)(6486002)(6116002)(3846002)(2616005)(476003)(186003)(44832011)(36756003)(305945005)(486006)(7736002)(7416002)(106356001)(26005)(105586002)(14454004)(5640700003)(4326008)(6916009)(25786009)(256004)(14444005)(6512007)(97736004)(50226002)(2906002)(478600001)(386003)(8936002)(54906003)(102836004)(66066001)(71190400001)(71200400001)(316002)(1076003)(68736007)(6436002)(86362001)(99286004)(6506007)(5660300002)(52116002)(53936002)(2501003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2895;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BYcFVVdl2ISW3T2hEpbHt/fu7RjniXDpVuUDVVljaV+j2GuMyN56O4uerHP2ksJp2gOE9Mf/2h4L17crLPEKbbBBmmXsv8TKCmR0tcmQpo2TDmF+VLCw2f6d8V3sYG8QdCDD3fPnhh7i2mo0Vkdy1gZNHrjLURSKeLY85mzY2B4YDV32TZvnI392eJFzmv/ZDY7vD+4ZFqAgLsvObtFQG/6F8XVKiOK2VFphQMjScmy0M+7vdjFRb01H/xmk4T3JUfyJaAEeL+zIkFPLvWefITKIeoFOx1gaVcR3y+tONiMJViEZxRMmrh9YaIz3yZf3izOANESije8lhI700CeZ55tdc3OPBDhuQZm7sKj+Ax56sL70R2MHO6MxcqT8vKIjC1x4+wUoo+1GfGiwGU+yYD4ioH96evWznJkfV9xvJ10=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcff3d63-4afa-420f-6ef1-08d69b23a1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:17:44.9779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_051754_845407_B19E6652 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
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

SDMA1 is part of AIPS-3 region and SDMA2 is part
of AIPS-1 region.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
[initial submit in i.MX internal tree]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[adaptation for linux-next]
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4784eb..87839c5c8a7f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,17 @@
 				status = "disabled";
 			};
 
+			sdma2: sdma@302c0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x302c0000 0x10000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible = "fsl,imx8mq-iomuxc";
 				reg = <0x30330000 0x10000>;
@@ -575,6 +586,17 @@
 				status = "disabled";
 			};
 
+			sdma1: sdma@30bd0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x30bd0000 0x10000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
