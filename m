Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A0CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:59:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679DE20578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OyEy36sB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ol8+pg/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679DE20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s1JmH3EVvK6VwbO+4c5DokC+6PT+ogeXMB7h5ikKVyg=; b=OyEy36sB0LIryE
	Jwr51kihI0HvRsn3NYMqG67xh+Xkpk8iDhgXMb/BLyS1a5qofBSe5jV6DdZTh9mYA8v2LzXg/Foc2
	LoDhjFQg/1AIyZ/jK+8BEdCXkfvxOUOnOqxBXZ9WV9VeEzGLLwTvmEr/qNXB+8KphCGOHYoNj9AMt
	uOUTbx0pO/+M/+vOVa4IeEl0Kba8EfaEOAuYKFUa5ym1qg8r/q6Lh+HpMnlAhiuBWLjZVX3CBweV1
	tQTwFBII6STbEwNkugXQ0fhDuui3sjHg64E0K4GmDA8kFt+scnwaVfc1UUbDrkk5kdjJEmLubS0ZM
	V5/n9x/lDox6aUukN59Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjIh2-0002Tv-J9; Tue, 15 Jan 2019 06:59:24 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjIgy-0002T0-8n; Tue, 15 Jan 2019 06:59:22 +0000
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; d="scan'208";a="25331489"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Jan 2019 23:59:15 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 14 Jan 2019 23:59:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng09PLkUUz6SwL5ErtLGvezUyzNihuqbnkRE1FoEN6U=;
 b=Ol8+pg/MkmQxfA2vmQI0bvLzMiShNrB8HIKaZsRk+TOpG3zgTmrAy7fN9k4PHCAOnXIDaBxpjrswwti5ptjOnE1swD9dRfxdWG5A+LbhFDnvWKJfqROWe+SD8zdFURovpvjHJ1nlJpeJuPe+7b3fsIX/yxQZBoFeb6YlqAr4yro=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1810.namprd11.prod.outlook.com (10.175.99.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Tue, 15 Jan 2019 06:59:11 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 06:59:11 +0000
From: <Tudor.Ambarus@microchip.com>
To: <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
 <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v1 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ
 for capcity setting
Thread-Topic: [PATCH v1 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ
 for capcity setting
Thread-Index: AQHUq8fHRd5pPA6AkEygQ7ztmaoqW6Wv6AUA
Date: Tue, 15 Jan 2019 06:59:11 +0000
Message-ID: <8afdb25c-894b-0a89-b7a8-b754fb4ba905@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
 <54bb8a9d517e2ee35018d78457c6aa6a4970e644.1547442452.git.ryder.lee@mediatek.com>
In-Reply-To: <54bb8a9d517e2ee35018d78457c6aa6a4970e644.1547442452.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0113.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::42) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1810;
 6:X9zYaK+mJxOhgM9+QvC2j5C71cJdvflghpzgYt+Ve9ythaTVVRBUizTtV6VdbFfKaB7cCFeQ07N/ohTVuG+lLBtyFKP11WXVtux/a9qwO9Ay6K05ahpFrK+EQpUvPEMYAiYCt/oWbAdBWbMIJ7r7IICN4qxnRZ6be1o8bRvo++g30oWsOSffq+zNuAT5bJuPXHKzb0HgavWNGf0UXw20Ny2RP3Ss6sDuTTNZSRfGddcoEt6IJN4VilpXnHn9CmZ9nbYtSPhKdN8dFm41/ETXWwkc3juoakVVYdM11G3LfpP6Gn+fLtGQVRzcsm89qlMg1n8SnprzoFZ/oMPE3L+0L6POvxfdL1DTHTlSPZJCiXmvudYilVYHFxFiuNevH48c+HMOBW8uO7ej5qSTR1cG6dM6tJsK3yw0yOOUvyJvmTKv1ffjjUNDGyS12WB0ocbDrJOBNeGd2S6ALkkDrO9iNg==;
 5:7cPZPjZXFMkxQwqOJSZ36FZmqeGxmz7dW+cuJmtxkguui/sjmZGLX2sx/aIlJ34PITPy2xcr3Ju8X5q07rQDiDZTILA5qeVFgqFoO5qoXc+cUF3QY++1pIauVWP6D2ufP9SHZfiqqFyX7+6G+d31de/0ck9UkXEBe1EJJiTficD+nZKQvnyQIXdfq5pz9kcUXL+qDXFdrue1KHvX+VHTGA==;
 7:v4FSSrcByTqXotMtXd2hgdPHtt8KKDeFMPPChUU7Z56XX5vcdJSiMaB1TWJ2NxaUkTlUX5sN2DpueF7stjEyP6fdHtZmcFCakiuBqwx+DeK6xpBOH2F27ePPgjWNOC5XAsHBjvEmVOVyiJwYEs6duw==
x-ms-office365-filtering-correlation-id: c0ae81f6-7c32-4a72-0443-08d67ab6f3ad
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1810; 
x-ms-traffictypediagnostic: BN6PR11MB1810:
x-microsoft-antispam-prvs: <BN6PR11MB18101A80E40248E5A20A8CB4F0810@BN6PR11MB1810.namprd11.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(199004)(4326008)(2906002)(8676002)(97736004)(14444005)(25786009)(256004)(6512007)(53936002)(39060400002)(6246003)(305945005)(7736002)(86362001)(31696002)(99286004)(6116002)(3846002)(81166006)(8936002)(68736007)(81156014)(54906003)(110136005)(5660300001)(316002)(2616005)(6436002)(7416002)(11346002)(66066001)(446003)(36756003)(486006)(229853002)(6486002)(476003)(478600001)(386003)(6506007)(106356001)(53546011)(102836004)(105586002)(71200400001)(72206003)(71190400001)(52116002)(26005)(31686004)(14454004)(76176011)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1810;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pOVdjxwW2oYkoCd+DLaCy9VhjUbmNvXs9FobANrSoXSjF0lVzfSd1hbqHWTXeyPOoTUSieglXPoYso2h7kzWMV+CvMzTLL/Jx8ADQ9WMMeaFpqhSxNLmmFeT79KSU7QVX+3nTFYPI26CrP63ZQlU//iuCzE0mXhFzgg//GfdaPs5lvLOGnCCS6ow7S+MjFNQDZp/XelxbjFfOLdzfMjOa+EY82jB2a4x1Tbp14xsvxYMjPbD2o9bk0HWv4eYg2iyZL2jO9xAzPWIs0l7rMQLSgMjsZ4/x40AcvB7u4ULPGB5LeTtBaXsx2xj0VnerAy1CFigGncHZmX8RaCQARvJM5SDZeQFgEdT8+eD84T9N8yjPEhjlgk1yZ08mSvyqzwtDRaXmQeX+URKMg1uazq0Xwr2wVsOr/mReRDMsEdJmMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <A3F225B418569B4D909CFCF3A5EB32D1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ae81f6-7c32-4a72-0443-08d67ab6f3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 06:59:09.1286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1810
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_225920_349661_A060AD2C 
X-CRM114-Status: GOOD (  18.98  )
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
Cc: devicetree@vger.kernel.org, guochun.mao@mediatek.com,
 weijie.gao@mediatek.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Ryder,

On 01/14/2019 07:12 AM, Ryder Lee wrote:
> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> SNOR_HWCAPS_READ is a basic read mode for both flash and controller,
> it should be supported, so add the capcity for mtk-quadspi.

Since I couldn't find a datasheet for mt8173, I tend to share your assumption -
SNOR_HWCAPS_READ should be supported by this controller. However, it's always
better to test it and not rely on assumptions. You can test it by forcing the
mask to have just SNOR_HWCAPS_READ | SNOR_HWCAPS_PP set. Or you already tested it?

You have a typo in capcity. Maybe substitute it with capability or "add this
flag to spi_nor_hwcaps mask"

> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>

You should add your SoB tag, because you are sending a patch that is not yours.

Cheers,
ta

> ---
> Changes since v1: none. 
> ---
>  drivers/mtd/spi-nor/mtk-quadspi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
> index 5442993..d9eed68 100644
> --- a/drivers/mtd/spi-nor/mtk-quadspi.c
> +++ b/drivers/mtd/spi-nor/mtk-quadspi.c
> @@ -431,7 +431,8 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
>  			struct device_node *flash_node)
>  {
>  	const struct spi_nor_hwcaps hwcaps = {
> -		.mask = SNOR_HWCAPS_READ_FAST |
> +		.mask = SNOR_HWCAPS_READ |
> +			SNOR_HWCAPS_READ_FAST |
>  			SNOR_HWCAPS_READ_1_1_2 |
>  			SNOR_HWCAPS_PP,
>  	};
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
