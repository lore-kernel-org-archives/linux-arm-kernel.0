Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B86C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0F8213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XXAoS8D3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6l+Kmti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0F8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hfzjJGlzGA88Ny7wMmFpwA/msKsqvjELi1ZJjEWzOjg=; b=XXAoS8D3uEreMs
	omEJA+9Zv91vu5W55qL1FLbXv/Ocp5jolmiT0DgeTR82BHI6CuxwCkBsz0haDDDX87mvme8NUm9jM
	xNgSDGRyRYWOePYeOaKxNLPii3hvpe3PEZG76jZOMxEEXZrlW+OlmeWNzzkltkj9gYAeuvuUs60MA
	/avbJTdACKuFAy0OdX/gAChJCthbidt8MnoyLs4Z+9j5iP3OtbyqXgHPPrtf9CIeQg3ToeO5h5qBH
	YPsuPTUvy7X215a6imYPgya2OvtkotWwROpYRkAc0pu7Zr7AcyJRCFOEh+y8w1auo70zT8gaDfYIu
	E4YR1bPPXBSpeIc0OzwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGHh-0004Q8-AQ; Mon, 25 Feb 2019 13:27:05 +0000
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGHJ-00040i-Qh
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NVjQ5W4YBNYBcdkZZgEi3CaQg9mWST4R9OGsHO+J9I=;
 b=G6l+KmtizOMm6Zv1/48peT8QnHZTmZSLRa7Z4KMs9BSDN5kweDs1d5s4syUIhcvNZZ1EdDR5CyJJRX9v1tgrZdgIWf5olNIZDFlLm5hLbKwiGslKxxvCZyE2Bb1R2F9J280fiwMycq0osEFCvMJXHHYRqyfkyIMX5lDqvI3J4vI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2848.eurprd04.prod.outlook.com (10.175.23.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:26:38 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:38 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 3/5 v2] arm64: dts: imx8qm: Add SAI pinctrl configuration
Thread-Topic: [PATCH 3/5 v2] arm64: dts: imx8qm: Add SAI pinctrl configuration
Thread-Index: AQHUzQ28wXrAHNk/4Uyx2h+Q8brW8w==
Date: Mon, 25 Feb 2019 13:26:38 +0000
Message-ID: <20190225132617.10987-4-daniel.baluta@nxp.com>
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8694eaa0-7251-4f2b-3a24-08d69b24def5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2848; 
x-ms-traffictypediagnostic: VI1PR0402MB2848:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2848;
 23:8sJyYBJS3nd6fvl7RuDJEm17hSBzNq89cpYth?=
 =?iso-8859-1?Q?zVsvPaHgBcZcws05Vek8HfbgcCLM0QPG6Ytvcyt8KSKtCiDmQO3EolTUME?=
 =?iso-8859-1?Q?CMMJAXjXUJ110V5nL6rDO/L4lewYwBrf6tXg/CB7feZhiRLQspkk6+VpRj?=
 =?iso-8859-1?Q?iu/1WDv6AmuERZedr38HmDCftDzned4gjUjuA8J+rm91wOTCBr4mmFu4e/?=
 =?iso-8859-1?Q?sv5dzhelY4WasbSQkobPESJHo8BlAbCO/G06DqDMt33ti7roPAaHt6Q3La?=
 =?iso-8859-1?Q?iyIXhUd5dCpP4u0C/EwkXVSTw0HH0lB7F7KZnQpUdfQcIVYwZHq3o9pLjT?=
 =?iso-8859-1?Q?JkZL8s/b7KNMr4VhZYtSo/jQBO6el6YFEZBIQg3Gps/VDpY59ZOVuLcr+p?=
 =?iso-8859-1?Q?MrDF69Djy4SW20g3RvQIUtvGakQEgcEgnp9bBZspw+Xw8i1Rinfsntipqp?=
 =?iso-8859-1?Q?pH/RQrsVj9C/yCuLwpdFZ/4x0V5DFDu1vdjepM11rqlZNPDabqQhMlq0EG?=
 =?iso-8859-1?Q?NJxK3ZvhHznZ+AZTZmrxK6WogZHK15WGoqxJLWlfzvaOFLDTVuS982n5De?=
 =?iso-8859-1?Q?IvCnjHhnIjOlOeMnzRiJKYWE7IkIFtLJz9wrgfVO+MTG2GgSBWYxLGTj/r?=
 =?iso-8859-1?Q?wzk/UHc4ViDfrzvcbolp3SAgb3I3pTYo/6p3JeyJa/eCI+LkYpzZDKxW02?=
 =?iso-8859-1?Q?LHSnzqXMbwmMPyj1cpS4MWLK9yKacuTdER61CEtYVBvuyOLlS1VDP+bwtR?=
 =?iso-8859-1?Q?hv7QCR4wITwhqgyysaQdno28mx2taVuNLbXieU6jCMt2McwwfdfFy2McEq?=
 =?iso-8859-1?Q?IMJp+rFlsXTchrbpM6Mf4x7pzPJMzmIggVas5S1iCJGsyUVHQC4wlAMtC1?=
 =?iso-8859-1?Q?DBvibEi5eWJjgtUGrXWKoWL+yTj6OfvzR2HjhfCAId7SRaD5y8QDajdQza?=
 =?iso-8859-1?Q?5Hz3vIKVD9BAJWt6cdO9Ww53aUO1uEXEVcO/ScW2F49PZ6vdnFpCGIJasv?=
 =?iso-8859-1?Q?DFq/vnWJqZN0S7gZCz6Sp8WsmwBJw+lQ6UW7J9GOaVcb5uAPC94I1jGcUn?=
 =?iso-8859-1?Q?ELOcTb36w7g7JtaBF1iqQZpWmu75OzeMvP/JPtQ+5lTEZ0IKZ8m43qxSaR?=
 =?iso-8859-1?Q?vfExHGgbygnew6ed4a3CKu7IvQSB2E0vSZXYGmi/dFAkdVGe2iJSBcEa1z?=
 =?iso-8859-1?Q?toa9Wc32yqadbq5JWwuk3ujfcnnOKhTae1hTqt+l7JDfuEwQL8VlBccPKM?=
 =?iso-8859-1?Q?Zt+YlCvl/4hL8G/2U9ktXBGlYXghzRrI8HyJj7ld6j2szGNAa9iIUqM+od?=
 =?iso-8859-1?Q?hUK535pJPUCwQkX4cKpOkg/ZBGfUFwj4QLNcRAQWL8Ryt/yShLb3RbXk07?=
 =?iso-8859-1?Q?NdbHXcGdaD6KA/eBpw2UxgvTUe97DuQOoop/w5F9XzokKWqBcuQzJMz5vS?=
 =?iso-8859-1?Q?pcyMBYCEMforW7v9EN2w3lHRRHyM2ayiXwSfq?=
x-microsoft-antispam-prvs: <VI1PR0402MB28489CB0E1EB21FD85624BA0F97A0@VI1PR0402MB2848.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(6346003)(66066001)(4326008)(68736007)(76176011)(99286004)(6916009)(256004)(478600001)(7416002)(386003)(97736004)(25786009)(6486002)(2501003)(26005)(8936002)(6506007)(14454004)(52116002)(36756003)(186003)(4744005)(50226002)(102836004)(8676002)(81156014)(1730700003)(53936002)(2351001)(11346002)(106356001)(5660300002)(81166006)(316002)(86362001)(6512007)(7736002)(305945005)(71190400001)(2906002)(6116002)(5640700003)(3846002)(6436002)(54906003)(1076003)(44832011)(486006)(446003)(105586002)(2616005)(476003)(71200400001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2848;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OjPi85spDeL1Fth8iN/k35hMQ/sbq/WNK3kp2qaT5k4tuMiPDv2+ESRqM1LIOyVQ8BgvA4JAAvVZ3G5c2HOLwksMMsnUILZB7DmffvlkmmcM3HX0cEUiELu17JqTfHRtsLsbJb7X0MW7OGZOh1qeLYfUWa20aeEFjsv4eL/QctamVqCszS3pAUzws4/bBtrL1bOOEc+bOj7/beimkCnsKJVMrVNtY/slBg8pXD48TrV7dEYQMuUnQd+BRgqVXXfgSdU9kEyTj2BMz4TOmqvvEMc+xJ+PWmcDK0GuGZXDkrT8edsp3i/viKXab4T2P2I9hnO4tZrGVEIpM2eQ1PewX35PRkn0hB2Q8iz5vzq3oKUW2Pmjrccx8KFuK3pJ1QqUnDKh0+Md7ybgofES1fLffoq/3xt6uPXS6lKbQ83ERoU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8694eaa0-7251-4f2b-3a24-08d69b24def5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:37.3679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2848
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_052641_862622_0D300A0B 
X-CRM114-Status: GOOD (  11.47  )
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

This sets the pin configuration for SAI pins BLCK/MCLK/FSYNC/DATA.
GPIO_01 is used for mute.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 54737bf1772f..d21ee2a5312c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -223,6 +223,16 @@
 		>;
 	};
 
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK        0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
+			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
