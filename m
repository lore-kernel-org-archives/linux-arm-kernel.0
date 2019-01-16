Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D000C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:05:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B7820859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZsYRTKH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3J5KJXlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B7820859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2EeHbig+9AZW0rA59siYFQ0WnRjxePQVEXei6r6KG+o=; b=KZsYRTKHbJT/Lb
	cIw8flXDZLhyJpvm8FoZOjkz4wXxmMKOlBEdff6TQ1nJ5ulRX3uCOCUfLeR12i9UtBtXVlHTiiTGy
	ugUq0VcxzFA2FfklMxQDtDExw2Joue380njzPHdcppa2xGxbHuvZqr+6RtQ/oac1OO1qDbC8s9dr7
	XfvMwmg4Yb815FjJNpYViusTP3m0DzePaKMPp8jwxhPVxAe9he4Hkm0ZwXqFg8Omkhk23EgCIADzb
	KzbgnS7tX+eMYPYVzQO3aSG22WBiFFZ0OTF6Lt353y//8Z3UTcCkBFWggZStFFFfZYOZAm/ynG8KD
	aybaJSI+CiU+nWv4OZ/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjeKT-00015X-Mt; Wed, 16 Jan 2019 06:05:33 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjeKD-0000th-E6; Wed, 16 Jan 2019 06:05:19 +0000
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; d="scan'208";a="26477618"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 15 Jan 2019 23:05:14 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 15 Jan 2019 23:05:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk//do112OuN/UcbnyLT/WWyFrOgW8BgHmIiIr/7KCg=;
 b=3J5KJXlDPdbISqmZoWNM8z6DrefizE4MSfxl25ysmCziPu7lOXgE5TA4x+Q8JPiK64MQ+AuKU9pxldPa96l2Z2f4WWtYivzHACIAqn/5YONZgM70cl4OoseUpMQ4TBoKhEsyReRR+wZbIDIuYhhWeEt2LUx31IjJLK2KNnoNrMk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1266.namprd11.prod.outlook.com (10.173.32.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 06:05:10 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 06:05:10 +0000
From: <Tudor.Ambarus@microchip.com>
To: <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
 <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ to
 spi_nor_hwcaps mask
Thread-Topic: [PATCH v2 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ
 to spi_nor_hwcaps mask
Thread-Index: AQHUrUD0SMMQZOTb1E+CWZoa37xBxqWxaFQA
Date: Wed, 16 Jan 2019 06:05:10 +0000
Message-ID: <9788fb78-7289-1c5d-51db-75aff997b5e0@microchip.com>
References: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
 <2afa18c0c898259fc244f15844c5319f71e811df.1547538621.git.ryder.lee@mediatek.com>
In-Reply-To: <2afa18c0c898259fc244f15844c5319f71e811df.1547538621.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0009.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1266;
 6:+S4DYe0sNEeeLoFDDV2/iYfqX8ZupIJ5wFEWemrgjibzxriUszX5rtnmX4tezHy6UU598IUHWTz6syE4tu5i/TNFZlcPUraFoq1V40WShjiCBSjMOzliBtDucyR6Hy0e20SJ3eEyv67MQ7bKfQVP6904F7FhABT0JbD3sAbddQTO0wR/vkynfop/5cSez5flD2fLT0sE/zFYhbsd/V3XTsPcUAZ3wtATYBZCDr9uwNPp6Fs3E2JbKG21ccLmDclZy88Zw5gvsgm5qMmqCAOKFOjuMpUS0a3qc2gWiDmZXpR+D230rLsEiyQ8IbbIg0kR/SWLDeWIH4uaRb9FGniMzGtQBQpnM0EJPiD5Oze5GjZbt/j2i/3MLN5idPV/Ie2tC7EUJx4qcQOGINDhXfh9Zl9yne7iXi8l75tRNsKyJDg6qUfoh+i4DqiUnxMX+31dddb3gQLhoJ9d/tYX35XhKA==;
 5:JMRKsxOVmbF6etjhhJvABgt46uathzI2RNNDwxod5m5ejL8Z+Po2uNFCaKj7+TyD8HFyTeEN0TAtUWYf+5dl5axc9kf5dAGGGITrWqNSf03irAES19DO36sFwziK/zk1H8IlmOIVWD6m+9JsF5UPnIi7hyppmF1+XvZrKh/G0bQNQMXrsekAPV6YHuzprLg18S2cD6svbUgYTMjVELwriQ==;
 7:p5fdWPKJiOxHDu1R7ggtPPWIIy2iyAQfIoNrbX7M22Weo9BwVIDKGvb9GbZIKxQWvS+mRpQ1ZJISUD/2B55Sy0XMnbk1srNh6211SFXr4lcbnaAgyQmXNzID/EZO4MNILRPwR5i4cWLv5rkudxoQJA==
x-ms-office365-filtering-correlation-id: 9d146e2e-b6bc-439f-0679-08d67b78926b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1266; 
x-ms-traffictypediagnostic: BN6PR11MB1266:
x-microsoft-antispam-prvs: <BN6PR11MB126600903F44E3BACE27052FF0820@BN6PR11MB1266.namprd11.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(486006)(11346002)(52116002)(102836004)(39060400002)(478600001)(53546011)(6506007)(110136005)(53936002)(54906003)(7736002)(106356001)(6246003)(229853002)(72206003)(305945005)(99286004)(31686004)(2616005)(7416002)(76176011)(386003)(105586002)(36756003)(476003)(97736004)(14454004)(25786009)(6436002)(186003)(68736007)(71200400001)(26005)(8936002)(3846002)(4744005)(6116002)(71190400001)(8676002)(81156014)(81166006)(6512007)(256004)(2906002)(316002)(86362001)(5660300001)(6486002)(446003)(66066001)(14444005)(31696002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1266;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mgiyMLlhRdoIYsgwEDa6FCzfHAfWIoIRspti4zptlsA//95eL1MBTMCctdGP6lmIAHXpe7nRe+GrExrfnvgd5JCQjCxedy/Rr3fDNQrY1QLDias15Y8oqTRxde+Yuxd7IEJejP2jQH8mvHpYGujlNUMKrFBKHUrZnFmPfaWOeAkzmI3eqXswIJDmXS9Zz7AC9TnrQ8a/JZdaQYmhc/PIIL3/9MPkaT+ZRcrU2TzrUX3JUOQTEIgCuYF+Q6UVjs/8u+gN0oDmR+PdKJZJQW6Tm3T6S6X/rMsaME+rccDesNu25ZYaJQzOHidNHBqmwCDQ5+ZC8cu+/mdDeUzN+mAK9o10r7wtiWqN6pXvASq60tM7wPDyvIC7x42p8aPeoZct14gEsoRJeby0Uy+kgAQrJlTXfUGSUaGtZ2sY90HLtA0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <33A36E50F9B6AB41B4C15449CD7065BA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d146e2e-b6bc-439f-0679-08d67b78926b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:05:08.3637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1266
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_220517_637508_B76CD0B0 
X-CRM114-Status: GOOD (  15.33  )
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



On 01/16/2019 04:12 AM, Ryder Lee wrote:
> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> SNOR_HWCAPS_READ should be supported by this controller, so add this
> flag to spi_nor_hwcaps mask.
> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
> Changes since v2: Revise commit msg. 
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
