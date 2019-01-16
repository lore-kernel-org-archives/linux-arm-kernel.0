Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0B1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:07:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF71420859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CRqa6W3B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="W61Glb75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF71420859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6NT/UzRz0LDkYhIx+P5ZpZcu49q+UdcqcwuzjvVQpSQ=; b=CRqa6W3BZaWPdq
	4LQo6V80E/hmVRgDIzjKXf79UBAGO/+AwuFhTpO8Khu3x6lyzJHTcqE5RDayuDN8vXbujBwzTBBkB
	EPA49EAU7csa76cAZL5ud2V596h3rk8BGzF9V5kRCtbZboKE904qfh47EdROL8ahIEZNg83I9xfA0
	gBQwib+9GZMsk7vLII3awoGiTzXSXj25N+ebJIVgzMUuw3NEQggrKQ0FWFd17o7RFG0T/0i2TV8Ud
	yiw5ai0Dw0cbVwxEzyybuax66u8caBR0hZioZkL+7EB7TjRfzl1704V0JMca5C5ztLav1ihmay6Nf
	SSKSwFgCNgSyIEeZRKEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjeLo-0001Sz-9R; Wed, 16 Jan 2019 06:06:56 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjeLl-0001SL-Av; Wed, 16 Jan 2019 06:06:54 +0000
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; d="scan'208";a="25544313"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 15 Jan 2019 23:06:50 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 15 Jan 2019 23:06:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJxMPfEE19kOVW/Ar6s9o1BMkK3qlVGQFN6Z2ayIDeA=;
 b=W61Glb754+pEy8g2tBu8RELKB6TP1J1P2KzOWhYpghnYK5Kn6iRotvucC7WztaGkrniPeZVVqV+G+0kTA5wdrP8LnK2baOi1oClncFf1nyZlozEHfrwDZmpeDPkTeEO2CEmn5yNDED+8vn1XEI3f4HD80RhYXnmzQvzs4VWVKUw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB2036.namprd11.prod.outlook.com (10.173.26.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Wed, 16 Jan 2019 06:06:47 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 06:06:47 +0000
From: <Tudor.Ambarus@microchip.com>
To: <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
 <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Topic: [PATCH v2 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Index: AQHUrUDt92IZyy9gw0SVGsdcSg853qWxaMkA
Date: Wed, 16 Jan 2019 06:06:47 +0000
Message-ID: <28cd6980-6697-e9f2-2e7a-226a507b5467@microchip.com>
References: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
 <761c9a0a482795dbc48949e982ab46987b737e08.1547538621.git.ryder.lee@mediatek.com>
In-Reply-To: <761c9a0a482795dbc48949e982ab46987b737e08.1547538621.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0016.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::26) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB2036;
 6:uXjxmQ/P6qgH57Uobi/OFPQ1ozxj9y7+RwHWIvc0uvsRIyroesNRF8kbiA6MzZaOFWPYF3PBFTeAJGBiXCJH1mqwLhAT4G586NbeCb2/iqV2mJ/4iQ8Prs6is8vLNskORqp6kJ41gUr0CD6eO0/6ctUoHxBKx5lK5yN9Cch+NgTgU17eLJMjpvQYxAdMk1Src6+QdsD70CEPHmL7FHXuKwe+b5yL/sycMrexwxleGylXMdlklpXm+a1Zxem7aILJSAf1ajZlimdF/VAuT9GDVvntppuQuxS8HoyzwdjIluB0BHy8LhmfwmqPbY3oWCcgE8DKUzyKvbJ5PMdXAVAH422+4rPWiiaTyDXMsJomEG4gkXwh4goK/hiGo1w6xDKh3Vb3/6q869zoSnCW2c0Xtx5ex3OyrDpoRI7HhLGGs/QnpJbGXVoj5pBqjgNVXruOggt9A3EfR6WMbCpfZlxBcA==;
 5:337Zpo8p9U4QipPrfsx1TZCLqeyiiVNHUIEoG/43PfccK/DJk/13AbtvQKk6XeGausBzkL4fmOWWD0woFZ0kmScm1nYRIQioarj3Dt3dnEZLJUrcvRY7zxRBjd7GhVcuWILtr/e1ZAoepmD9OoZ1mIuAucBglG1ywlsYVApG4DqDaFbnD4R1UFPcOYOyHMKidFpliXZAtPGYs0FXfgM0fw==;
 7:fHheuVTvy1iuce+dItqB4bINjNRlVJzRy+qlE4J+1NwDa1jbzS+Hy5026MqsBWMt4Qfi+3AXr5/OWkCC744ZM6CMbYhxNtFrM9lBfdggk8zGlguBFVgO3V0TJ88WZZXuTYHevZM3VMMOSUTNJHvViw==
x-ms-office365-filtering-correlation-id: 2ba887cf-c4e4-4039-eff7-08d67b78cc31
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB2036; 
x-ms-traffictypediagnostic: BN6PR11MB2036:
x-microsoft-antispam-prvs: <BN6PR11MB2036B46B0BD132E49F59F481F0820@BN6PR11MB2036.namprd11.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(6436002)(31686004)(52116002)(6246003)(66066001)(478600001)(26005)(6486002)(305945005)(106356001)(7736002)(316002)(105586002)(486006)(72206003)(99286004)(446003)(11346002)(54906003)(110136005)(2616005)(186003)(102836004)(76176011)(7416002)(6346003)(6506007)(476003)(386003)(53546011)(68736007)(8676002)(4326008)(3846002)(2906002)(6116002)(53936002)(71200400001)(71190400001)(256004)(8936002)(229853002)(36756003)(81156014)(81166006)(5660300001)(97736004)(6512007)(14444005)(39060400002)(14454004)(86362001)(25786009)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB2036;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NctawnhfXs2OedmftVBptxak16tKHf9ViHKCfFLiIQrNNxz1e4OhH3UMlBcXdZQlWVrlT+64v+28xwONZmGa3cn8Qq9agwCP1Uwr+O+3/GtX0USPszl2paG3P9AT+AU6f1EW/IgmXYACzX8wFAGkdrAEehbKgdAHmBX2oa+bkuRyFyb8yOyS+x4RSUuUoO0aeRZCtPQbTk4z/hW3k74Z2VO+Fd9fbLWzS7pf+BWPh/RZUq3899atmzCiN2MzaUts7mBNVqDam/f67tgL6QXY9JLpzL7LzY4eWffKJmlGMZ+Chbd6d/GGT6WVyiXTHajoCex5wpBtW3Wksybz+kxKZYPY47mlgSXV/Oj3e6YbiC34R68sN3YpGEGEg8o0U0v3GWtbgh2xYVmIbUT11KVe+WgQHALrbVRJerk1rGUE9hI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3ADEA60ACD9CF04F906056C3E46099F5@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba887cf-c4e4-4039-eff7-08d67b78cc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:06:45.3855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2036
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_220653_486563_859A5112 
X-CRM114-Status: GOOD (  17.63  )
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
Cc: devicetree@vger.kernel.org, weijie.gao@mediatek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/16/2019 04:12 AM, Ryder Lee wrote:
> The quadspi is a generic communication interface which could be shared
> with other MediaTek SoCs. Hence rename it to a common one.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
> Changes since v2:
> -rebase to v5.0-rc1.
> -sort the config in an alphabetical order.
> 
> Changes since v1: none. 
> ---
>  drivers/mtd/spi-nor/Kconfig  | 16 ++++++++--------
>  drivers/mtd/spi-nor/Makefile |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index 44fe801..414e887 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -7,14 +7,6 @@ menuconfig MTD_SPI_NOR
>  
>  if MTD_SPI_NOR
>  
> -config MTD_MT81xx_NOR
> -	tristate "Mediatek MT81xx SPI NOR flash controller"
> -	depends on HAS_IOMEM
> -	help
> -	  This enables access to SPI NOR flash, using MT81xx SPI NOR flash
> -	  controller. This controller does not support generic SPI BUS, it only
> -	  supports SPI NOR Flash.
> -
>  config MTD_SPI_NOR_USE_4K_SECTORS
>  	bool "Use small 4096 B erase sectors"
>  	default y
> @@ -66,6 +58,14 @@ config SPI_HISI_SFC
>  	help
>  	  This enables support for hisilicon SPI-NOR flash controller.
>  
> +config SPI_MTK_QUADSPI
> +	tristate "MediaTek Quad SPI controller"
> +	depends on HAS_IOMEM
> +	help
> +	  This enables support for the Quad SPI controller in master mode.
> +	  This controller does not support generic SPI. It only supports
> +	  SPI NOR.
> +
>  config SPI_NXP_SPIFI
>  	tristate "NXP SPI Flash Interface (SPIFI)"
>  	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index a552efd..4e4d400 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
>  obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
>  obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
>  obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
> -obj-$(CONFIG_MTD_MT81xx_NOR)    += mtk-quadspi.o
> +obj-$(CONFIG_SPI_MTK_QUADSPI)    += mtk-quadspi.o
>  obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
>  obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
>  obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
