Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3901520652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HLmtrRzL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TsQdB731"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3901520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4gw/cfm1sPI+rzG/6rlfgGt+6oPlmnM7UyJLMOntFwM=; b=HLmtrRzLoN/hFH
	ASfhUq7Rr6voVy2CjDwoq+PQ8S26R+oCfGoPGYwaldF9NpfidhFa06GnKSPCIit3c+GxKpi76dd9Q
	qaHmhyPomKpWAp5LFovo32QC07nfdsfji/bT+PQSuVdoyd7j8hNKsp7uaP8jqlpjZWoJgyVtg/boa
	QwZvMk5c9aT3mN9jGpH6y6/Lhlt7r2DYJVWGaAV+e/EXGfUPGIZOrlU4z6+0+lUnHWczij2Dv/Q94
	ISxbeFShES6bASn6eurCPE6/NGPsfraogc8/JvIXDdz51msxDyJHPOFeHtMDXLyqi9NgIOwCT1/im
	mfLLofiEO96Ckau29snA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyG9R-0008Qr-FI; Mon, 25 Feb 2019 13:18:33 +0000
Received: from mail-he1eur04on0625.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::625]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyG8v-0007j5-Lg
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX6q6lc+tbP1OZ3w/LXO0CGKRYLxDEuL2tCmm+8URqk=;
 b=TsQdB731nsW2TlRIk0dccCE5t0QTg1Wi5kCvObYYG8yvU3116NXrPYGTOoGerpG8nvvJhXKelvpazHVFjyfjV9a+Kvb4TiexURsMCo3mwZ+3FopaMSIGmFRMo/UpbKZbbymlxm/+OGHN2gvdg1NmjjUmhJqONyIz0BSTeUCiFf8=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:17:49 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:17:49 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 4/5] arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
Thread-Topic: [PATCH 4/5] arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
Thread-Index: AQHUzQyBzEGOEHUWikCrHaOsHwuZKg==
Date: Mon, 25 Feb 2019 13:17:49 +0000
Message-ID: <20190225131722.10253-4-daniel.baluta@nxp.com>
References: <20190225131722.10253-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225131722.10253-1-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: cf41c4e1-6539-4ffd-40b3-08d69b23a394
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2895; 
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2895;
 23:0SzUT/fPm/+mNDOR7F+nQ3AMzk4pSOKrRwT9S?=
 =?iso-8859-1?Q?czUf2qTKc+MSdVStNvBBT217ur4tGHJv7m6pK9bxoU2DSD6ug22kpSlb2N?=
 =?iso-8859-1?Q?OiNgDXHWnfpfMjmAp4EsOyw/s6bNlwpzz2DDiS3an/zW2qarqHQZvVeFjy?=
 =?iso-8859-1?Q?5Cm5sqTZY+oDUdnbQRJU2GWR19vvzb11h7RnMzcCp9kO1nP3MPsBjEA5Z+?=
 =?iso-8859-1?Q?QUEuPly6fweuDgXYb+kqtoyBlwJtrcrhYppODVngeJaBq8t9rW2qBUoJZm?=
 =?iso-8859-1?Q?1TujU0J9CyX6pltQvUPaCNqvJgeGOqU19r01eJrb6gavtpRMKR4UTaQN5D?=
 =?iso-8859-1?Q?uz8kaAE8vGLnFTsC+ye5JB8t5MhL2vGs0LQac+7UFUMrVs0/47SyyFghix?=
 =?iso-8859-1?Q?7tJEOoYyD7GB3h1/wl/p4ER6La2A47BJ675wwouP4KYe7sPHPGEZ1yxyby?=
 =?iso-8859-1?Q?irE0VpdpgVmFLrXSIKavmWMjjqu71lj4Y7VYyjfkLQ2n0OGrSdvOnrFhKh?=
 =?iso-8859-1?Q?pwdlzBF04NEkfmuWzNd1ALm20FIs7/ztvRBDoO8wRukWMeAa9vlB8B72/9?=
 =?iso-8859-1?Q?MiwO2mvd+pIC8vFKHrcIG3JooVhSF/ifquHWHa/hQ1G9XRRW8mdR7dmbXi?=
 =?iso-8859-1?Q?A/RUi/n2EnjoYolm+jH9DnCMTQaWN0uasq1xf+Z659vkUadZKbqRRieJmf?=
 =?iso-8859-1?Q?9UuI953QTqsXseJU5JZ+OSFBCP+QMPYvcE1Rofuaww6cnY7wgtYDMHb4gk?=
 =?iso-8859-1?Q?MGcDmmhqnh/69BSgoINzv1d9Zsev4sKBmsJG+UWdS+i4XhOkWofryRSYRF?=
 =?iso-8859-1?Q?OiU4FoJsrYYX5LmbGOw0ks3tePvfowObxl6MLu5dx9VoCGUgE+mZWuTwyA?=
 =?iso-8859-1?Q?D7j7Z+y2GnTxh0+0EMOSPCGEMGh3dABFItzFvv5HZVfj5pNJVsLYylDA6z?=
 =?iso-8859-1?Q?7GF7bLckzQf5cttFtU1UOBZSCDeG00zj6B16Bl0dC9re0rzx5dl5lQMxfD?=
 =?iso-8859-1?Q?ZfHEoiQHwmdvr7wSkCveIpkNoNfPOXPo8zM6FqFlGnymmPQkGPPJgY0Lz4?=
 =?iso-8859-1?Q?jcvkVtcnhHfn0bVguPngHsOkiuIed2VxrkD7AmW0P25E0gPPZR9QifQwaL?=
 =?iso-8859-1?Q?vzexXO5x0vnS6XrMfUix2+yOW8a1eY9TUJB/b0IctWm4BCyxf992lTxmCl?=
 =?iso-8859-1?Q?/GEoHot4MeJVxeg/FK626caOAIhOmnDJzvba4bt31ivvTOVOHCU3EgL9B+?=
 =?iso-8859-1?Q?unGYn2t8BN1tm9s17AXbEeEv7/odoLm4Vu/S6Uut0cDMuci467K/IYQY/8?=
 =?iso-8859-1?Q?TczwuSmeQk1l7i/p5yyIc/pEGqKzYWkd5SzVa7alY8ciLozurui5BXkUWj?=
 =?iso-8859-1?Q?woXBhIlXgKtOJICPJRpeCSahALHbvMIKumUyOyTsWyEjy4m6e4JzcsbSK3?=
 =?iso-8859-1?Q?z7NSXANeWZFW9a1ldEYfCbpPI89VPOeVl/SlD?=
x-microsoft-antispam-prvs: <VI1PR0402MB2895B46D918679FEFF90A65CF97A0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(8676002)(81166006)(1730700003)(2351001)(81156014)(446003)(6486002)(6116002)(3846002)(2616005)(476003)(186003)(44832011)(36756003)(305945005)(11346002)(486006)(7736002)(7416002)(106356001)(26005)(105586002)(14454004)(5640700003)(4326008)(6916009)(25786009)(256004)(14444005)(6512007)(97736004)(50226002)(2906002)(478600001)(386003)(8936002)(54906003)(102836004)(66066001)(71190400001)(71200400001)(4744005)(316002)(1076003)(68736007)(6436002)(86362001)(99286004)(6506007)(5660300002)(76176011)(52116002)(53936002)(2501003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2895;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IJM+rPfGXnezR8T/aPo3/v8jHxNkSYh4yuv4mpXX788W4DP/LwpQo4olFTwnY2+eeSOR0Axxi6yvHNgrGRownT+eHrOovIps0TbInu5QTojIQktnrQ+QzQayXfhnt1iwa7HIzrDEbxDtS36L9FI0WvLTbYbSFJLTMV+oU08+PFaZnbBA+HKTQupuWpXhyMzmUtgRNZ/wWvLcX/anP9OKw4eaUq/+Kimj5J9GFrAZl6DOYDcOEyCCFX+wlYf/4I7UaUolH3u/wKx0khRY76uSlahlQBqKk2aSoti19L7hiZpdxMy63cX7/vYz6ivTUNP3qvYanVtmh96BPfUYDDIw4rEP85k+x2tj/ZiOX/mDySyryDiN5+VwfUAXCPVDFVDfRTW1X0zxWGp64pX+V+XEZXF0izY5zh4YlcIPaFwGULg=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf41c4e1-6539-4ffd-40b3-08d69b23a394
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:17:48.2291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_051802_058499_472C342D 
X-CRM114-Status: UNSURE (   9.93  )
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

This enables SAI2 digital audio interface to be used with
wm8524 codec.

wm8524 works only in slave mode, so we make sure that IMX8MQ_CLK_SAI2
has an appropriate frequency in order to easily derive rates divisible
with 8000.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d21ee2a5312c..58de4a3d6029 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -52,6 +52,15 @@
 	};
 };
 
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
