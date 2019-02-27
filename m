Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7DC10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B511C20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AdUE9k//";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XBZ9cMt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B511C20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aHH8ExnHhMuY4y1FEBNRPWOeLglb1ZR7HusAn25HGyE=; b=AdUE9k//gQkhWt
	xInJXC+xsLrnLeSyg8XEbCUo5DzPhJK8/qr8jDt+L3XjFZLuj1Z1fpMXVYIrF9avp1iyGFzTNuUY5
	PYP/aFH9KZhgZhBfkiESNxwAdqu866r8ILplcW7RV+3pbanAsY4S+myRyiIPIqTqtkigPE7f+HIvh
	v7bMWmOiow7ogy7MRt8HckSJh992CwigNiFLfW3rwbt1yhz/Of0GHhv3CSmj8M8k8LW0e6qdLKf/p
	S2Tvi241vX543ORBR8m2eWPYMtAMiGwPQ22DVRaS16TqajOg3hq3LjwQ7pI5DCMSZ+M0oq044Saav
	TYi/fwrm2cfkml9spdtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz22F-0002QD-4q; Wed, 27 Feb 2019 16:26:19 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz20r-0008M8-AR
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:25:23 +0000
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; d="scan'208";a="24548773"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 27 Feb 2019 09:24:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Feb 2019 09:24:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+HE41CyiCB05c1+dpayBAnxqXSg/ka725qhPH7sep8=;
 b=XBZ9cMt5g6Lawo+G53d3KYNfd7mNYwnRfd3IYApI+qWAo0edEVujFpL+sGcYbDs5AWSJKHjn55WY/X4yWtwWdAq2MRrhupvystYpxZJZOs9nFmYZzkdYSdmttHqjCaKgEpuZJ12SbRTE1v69bL+MnZ2xFXw9T4/efD2kt4ciFpk=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:45 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:45 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lee.jones@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <airlied@linux.ie>, <daniel@ffwll.ch>, <thierry.reding@gmail.com>
Subject: [PATCH 7/7] drm: atmel-hlcdc: add sam9x60 LCD controller
Thread-Topic: [PATCH 7/7] drm: atmel-hlcdc: add sam9x60 LCD controller
Thread-Index: AQHUzrjzhXThqsOX3Eqi2hwybUgnVA==
Date: Wed, 27 Feb 2019 16:24:45 +0000
Message-ID: <1551284609-14594-8-git-send-email-claudiu.beznea@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0112.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::14) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8de43c5-d881-4205-9be7-08d69cd015cb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1806; 
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1806;
 23:9pIYsZNliCGrvRinfpfNAu0JwE9VeEt3FLtOHSp?=
 =?iso-8859-1?Q?IEaCatHGlXZaPy30J65QHHYzb+IRL4JYP/Mat1Ioa06SdsUFqbRzZ2ETbS?=
 =?iso-8859-1?Q?y8BiFY6Vovk5fnzCODsPvw4Hv7cYce2uwRRejN90K/HFucrHgSPI33i3ty?=
 =?iso-8859-1?Q?s0KxYL+mmy9XRhnNgSFfCiFy/0kpnAYhiXJJm1+M8zUZc3Rl3B8fovzSRE?=
 =?iso-8859-1?Q?Pm+A+Hs0u4f9iK3Qs6A1Nvef1TNjESvf2g++Ire1tIOsdxVcYGQRbUU9Hu?=
 =?iso-8859-1?Q?AhI7FJ2lhbef4mQnPIEhifct5hfihmbHD6cS9cdR4bB749VVeXtQyPA3hm?=
 =?iso-8859-1?Q?KXnjL02LMeXjDDuNxr6LM2MzMTViyz1n5ngB3Ue6RRhmRDKsNcuAtAqnkM?=
 =?iso-8859-1?Q?/spILjAD283hDRnOwfpQDopJZCxTEsrLoJww+qUPknLOnI0UEwrjpx3Tok?=
 =?iso-8859-1?Q?h9ndrVmbHDKOVPoTCGQctZUJ5/ObzOUN8sNc/q7xnmUN+zeDidXedOkBb2?=
 =?iso-8859-1?Q?6dw75TpnoCoBNmytYi1vzHIwcS8NTrBJkF9EObPApvWgg+cD0u7p/RRa8m?=
 =?iso-8859-1?Q?s/7HP2uYnkIkxT3iFGsZJ5yPPTLXr9YYzw60T1unno+cN+lUQHRaMUVULn?=
 =?iso-8859-1?Q?8ngx0LvxfJcox0ABzRCjoAebYucZUUZkyIUN00JQUNFzi8UZLbFtCNvrKj?=
 =?iso-8859-1?Q?uPl10ed8vsVWQIX+ayF/MYwxZKNq7lYFxIdpnD/h/qamwo4GA8TWvaq6nE?=
 =?iso-8859-1?Q?EZoTF4PKnYPOURHY0wmKcYT+FFoBdUM3ccoHfdpLQiqCM+7bLXgiZQfm4y?=
 =?iso-8859-1?Q?BVD17S56Zmb4AO+O5ziKc9hWPjx46/aEFtE5wor0yRU95TVDcXC1R1HI2h?=
 =?iso-8859-1?Q?M8IpswJvG5Qs3lngL00CXv6l0qC8gdN06Y44wc4mzYTjaJnVhVkvnbPaw7?=
 =?iso-8859-1?Q?ru4fsiHMOGlEhAMzReq1unVk5sgtD+L7PFdNveJ6W3RYOFqm0ntDZmFmlM?=
 =?iso-8859-1?Q?sLh+rQVLOot5s7aPmcIXjR0N8e1oQRhV/HeGsM5Xw5eC1DLjPfChzUG5Vn?=
 =?iso-8859-1?Q?H+JMRxZ1mCH4ycFRI7q65lCdvsi1bMpgFDsW5d/iS8Akmy2/B1X6vJjUb7?=
 =?iso-8859-1?Q?/zkSOiOpOQgAEUZmJkU7HW0ljgZP+ET5mssFL5mYXXzzYSceMGVQDdOEwj?=
 =?iso-8859-1?Q?VrLlo4q2eZbv5ZaPXsE1PXYUxdE4K4BjOsfs9AVDI5lFtc9KWF9l9Fd7Hk?=
 =?iso-8859-1?Q?q8dfoO/YTGUOdZwthAKKkRdYrtYnuWNJTNiWi7qnNCRWesrBUY6ev3S/Iv?=
 =?iso-8859-1?Q?QpMN9l3WDoRcc978J5k/McXsl3caSdEmwUoaQBW5rvtEpquSozCYgBJA4G?=
 =?iso-8859-1?Q?d8J3FJzw=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB1806346DC888FE795CCE304C87740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(11346002)(105586002)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(76176011)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(446003)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1806;
 H:MWHPR11MB1549.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1q5IbQuRI4j4LkZp6z3nGANPmILGqkxeiAXTGh/YHLTOSHNRutAdA+2XWphDdowpyH0SaOvCVvGBgfkbVAQTIUc9cLtoaGe5y0D4+nptNwH6ZEIDEARDQ+GSt1x691jtx2NaRx3wh5lJnMMQRzRXx1f1O8V4+iUfqbrO9cxpmE/9pEy6b5qWb/bwk9TvBBKcj4wzeEtT0EIZP/D4u6FomWJo1Tn5pIYWM7TilJ8XlkAw02yQk9wBKC4dOEST2DJesOHlO0lEWoI6vhRWxjZznNdNG4X453WTTAx2UouOlZOuqMbLasxGlr/5nvkrKP6GygBxRgqVTVKD0XKQHewC7iivpLmC80RLeQBf88WJ81UpPCYlLaC/he+Cwc9shae5RWaJTagWHgqYagwYBl0EcH1lsMSomdSzuIeZ4PGERPQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8de43c5-d881-4205-9be7-08d69cd015cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:40.7382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_082453_601867_69B4120D 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sandeep.Sheriker@microchip.com, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>

Add the LCD controller for SAM9X60.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
[claudiu.beznea@microchip.com: add fixed_clksrc option to
 atmel_hlcdc_dc_sam9x60]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 101 +++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 8bf51f853721..fb2e7646daeb 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -364,6 +364,103 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d4 = {
 	.nlayers = ARRAY_SIZE(atmel_hlcdc_sama5d4_layers),
 	.layers = atmel_hlcdc_sama5d4_layers,
 };
+
+static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sam9x60_layers[] = {
+	{
+		.name = "base",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x60,
+		.id = 0,
+		.type = ATMEL_HLCDC_BASE_LAYER,
+		.cfgs_offset = 0x2c,
+		.layout = {
+			.xstride = { 2 },
+			.default_color = 3,
+			.general_config = 4,
+			.disc_pos = 5,
+			.disc_size = 6,
+		},
+		.clut_offset = 0x600,
+	},
+	{
+		.name = "overlay1",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x160,
+		.id = 1,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset = 0x2c,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.xstride = { 4 },
+			.pstride = { 5 },
+			.default_color = 6,
+			.chroma_key = 7,
+			.chroma_key_mask = 8,
+			.general_config = 9,
+		},
+		.clut_offset = 0xa00,
+	},
+	{
+		.name = "overlay2",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x260,
+		.id = 2,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset = 0x2c,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.xstride = { 4 },
+			.pstride = { 5 },
+			.default_color = 6,
+			.chroma_key = 7,
+			.chroma_key_mask = 8,
+			.general_config = 9,
+		},
+		.clut_offset = 0xe00,
+	},
+	{
+		.name = "high-end-overlay",
+		.formats = &atmel_hlcdc_plane_rgb_and_yuv_formats,
+		.regs_offset = 0x360,
+		.id = 3,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset = 0x4c,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.memsize = 4,
+			.xstride = { 5, 7 },
+			.pstride = { 6, 8 },
+			.default_color = 9,
+			.chroma_key = 10,
+			.chroma_key_mask = 11,
+			.general_config = 12,
+			.scaler_config = 13,
+			.phicoeffs = {
+				.x = 17,
+				.y = 33,
+			},
+			.csc = 14,
+		},
+		.clut_offset = 0x1200,
+	},
+};
+
+static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sam9x60 = {
+	.min_width = 0,
+	.min_height = 0,
+	.max_width = 2048,
+	.max_height = 2048,
+	.max_spw = 0xff,
+	.max_vpw = 0xff,
+	.max_hpw = 0x3ff,
+	.fixed_clksrc = true,
+	.nlayers = ARRAY_SIZE(atmel_hlcdc_sam9x60_layers),
+	.layers = atmel_hlcdc_sam9x60_layers,
+};
+
 static const struct of_device_id atmel_hlcdc_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9n12-hlcdc",
@@ -385,6 +482,10 @@ static const struct of_device_id atmel_hlcdc_of_match[] = {
 		.compatible = "atmel,sama5d4-hlcdc",
 		.data = &atmel_hlcdc_dc_sama5d4,
 	},
+	{
+		.compatible = "microchip,sam9x60-hlcdc",
+		.data = &atmel_hlcdc_dc_sam9x60,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_of_match);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
