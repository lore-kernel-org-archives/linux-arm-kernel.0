Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:34:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BF620861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APX57dlQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="w6cfWpl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BF620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G42abQdO+UFfx3PKGF4hgqJqCzPciVaKcxL/i4STlBI=; b=APX57dlQ/YXX5K
	e/9HTKrCxhOliIW4QMhO4irssrDLKKbVh9ZDLpJUfGvECi0EEmxDuJFkP5tj1BSzws9c3r1MLh/WW
	YmzJ9tF+LxRQ/VA6ftZzRWB74UkFO7VB+QBflX160GbxJGYrO1eIRqDixEA+hn4DFVHEotFccQ2R9
	7RwiKwwaxeYAovGfjecMF8dL7+LQUFk+vOakfVNLrAP+/f4Tk1/FPkb2mlKBl4GSFHuR+63it+ZCB
	lFykhHOtcfm+MyMD3EQxW4fAMhEBrrem2opvtd8uOyr1TlfejQkJJ6NYf813qnkWV1QzkKIKZP6ro
	Esp7Kxpbjy/TbQQ+Sxng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjJFO-0004wY-Rd; Tue, 15 Jan 2019 07:34:54 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjJFK-0004vc-HM; Tue, 15 Jan 2019 07:34:53 +0000
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; d="scan'208";a="25047093"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 15 Jan 2019 00:34:45 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 15 Jan 2019 00:34:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F1N4KZNB3CQSGJQYTpYbatumyeMo1LOcPwy/rikmkw=;
 b=w6cfWpl7bIHsGKzOppnKwU4+Wh7FexRKgmQZ5X/Yg0OOKp4PAaWwmINsLTzoaDPKhXJ6P2WpHn8xydZcOXlCyeNjjCgvnnmEMTlKaiPNZu9/fvNzVawCqVlMR2jwv4hpCtL5472KskBtjfidrkd9KQMQgkoHL73mRXIuEDDoXX4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB0002.namprd11.prod.outlook.com (10.161.155.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 07:34:42 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 07:34:41 +0000
From: <Tudor.Ambarus@microchip.com>
To: <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
 <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v1 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Topic: [PATCH v1 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Index: AQHUq8fEBX41qj7/W0uliXm1OTJOFqWv8fKA
Date: Tue, 15 Jan 2019 07:34:41 +0000
Message-ID: <fc95a69a-6a2e-fc98-d047-b0c93843fc56@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
 <45dc2817e7f4baf5113de247b1a2cb30bf252d93.1547442452.git.ryder.lee@mediatek.com>
In-Reply-To: <45dc2817e7f4baf5113de247b1a2cb30bf252d93.1547442452.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::46) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB0002;
 6:T+sAsiP3nlkBMlbf50XzaHe/C1ZD/idyfggomyQ0knybjaA46+wfgHatp1dCbq5rKmcrM1MUMdHpafHV+H808ATCHunhwrWuPH/5vyf/75/aFnCqhhpiVgXGiSys50VgYRhaH8yESoobRygE/R0KUitxbHvrBesnmd+s2fizVjwi+Sj9lzmeiPmk5Rrc6/rr+meDOsXObkEjfLsL6pF6aalhR8YnKXWTuXMCLWyRX8708NozOtotrNqPG/TcChJfBHRlC3Dz09wmULkzxqT3uBfbbGIX2vqW3W9OqTiILtmDsIIDcU7mWPZM8P0gAyhIMirjIkgHvRd9IvMJsB94fJXAcj+rZZv/R4bd5hlhq7/URlh2GPjQg7o2St8JA1rK5XcmN/ucgiynvOqjxqolmLk/DyJZDrrQ3YBBWbp3tJ2s20wPkxK7deXsLIZIjyGfkuIXreSiJ4+LBcqUcNZRbw==;
 5:OPb538sdGVns5Tm0cldmgJ5vwRS6f38zfcixSmj144N3HmomDQ/FJjBEIp6pPIA0KYyiLeR85v48j1LNNvLzPsCQRvPwMWnHBfNi6EO2xF8Xw+BNc2+99vH24+AVPHBxITFioS4pxoB04lUoa0K6Y/Iwtorj2NYQKeG0+0rD8kp/rK1ber/HKU7alIQeEcjLSQSDyh7u09dQ/hxU23A2Ow==;
 7:iTAyVJtPk2DNmSOSbuTK6vjIu9nWM8843GpGF3Rg9rIO7FcOYBIotx8/nCMMkdfy27g5TTCrctIeO9lcdHq6lWsVHvn27mKWVstDg3XBuTx6BU8oeZfwrQUm/w1yo8VJ997/AkhoHGC9tXoemWzssw==
x-ms-office365-filtering-correlation-id: 1927283d-ff9f-4cbd-e995-08d67abbe981
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB0002; 
x-ms-traffictypediagnostic: BN6PR11MB0002:
x-microsoft-antispam-prvs: <BN6PR11MB000249CC6542B55E9B17CBF9F0810@BN6PR11MB0002.namprd11.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(105586002)(3846002)(486006)(25786009)(7736002)(2906002)(106356001)(446003)(476003)(86362001)(31686004)(11346002)(53936002)(31696002)(6116002)(6246003)(2616005)(6506007)(7416002)(53546011)(110136005)(186003)(6512007)(102836004)(39060400002)(26005)(305945005)(4326008)(54906003)(386003)(36756003)(76176011)(5660300001)(52116002)(99286004)(316002)(72206003)(14454004)(71190400001)(6436002)(71200400001)(68736007)(6486002)(66066001)(229853002)(8676002)(256004)(81166006)(81156014)(8936002)(14444005)(478600001)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB0002;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hrXj4Oxj6Dlu4yei0AOaBcF1X+Jn/31gg5tml5mj0JAU3smqV1uJPUOAw8hUI63IN8NSog2XJO6KohwJDfyNdjNpdGEdVd72pGE2b/SuVNT3G9DFTUNkBo9Y5rxOGfv1JwACuz1bHpc9qVA4tbFvgyj5oaktTYG2Of9Nr8VhO2/g09ZtiVU1kajzgIoYMQRUDNnaNWKv9314F2RG+QXswl1XZ6HB0QI68r37mojIHe3B5YSifn9SrNoh9b9WLahmeCjMy7XoUbEevrO6OXbRflKJNJDcZxcPj7ejeRiMrAZr4Hwvfr+ShQJyT8PWNB81hYlAwz5HbmcWLOVv0g0V6ZQgMMQCJgGt49p+YIBAxUEwo7SjEEpDn0Go81lRXB+tURIg7EY19ysxZPLBbrJ7kdfxfRODjV9E+jP6AE+wK/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <C85364684AEA374885282766A0730D1B@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1927283d-ff9f-4cbd-e995-08d67abbe981
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 07:34:39.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0002
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_233450_612812_3B7BAB66 
X-CRM114-Status: GOOD (  19.53  )
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

Hi, Ryder,

On 01/14/2019 07:12 AM, Ryder Lee wrote:
> The quadspi is a generic communication interface which could be shared
> with other MediaTek SoCs. Hence rename it to a common one.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v1: rebase to v5.0-rc1. 

The patch doesn't apply on v5.0-rc1 or rc2.

> ---
>  drivers/mtd/spi-nor/Kconfig  | 16 ++++++++--------
>  drivers/mtd/spi-nor/Makefile |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index b433e5f..99d9d53 100644
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
> @@ -68,6 +60,14 @@ config SPI_NXP_SPIFI
>  	  Flash. Enable this option if you have a device with a SPIFI
>  	  controller and want to access the Flash as a mtd device.
>  
> +config SPI_MTK_QUADSPI

Since you are moving the config into the file, would you mind to put your config
in an alphabetical order?

Thanks,
ta

> +	tristate "MediaTek Quad SPI controller"
> +	depends on HAS_IOMEM
> +	help
> +	  This enables support for the Quad SPI controller in master mode.
> +	  This controller does not support generic SPI. It only supports
> +	  SPI NOR.
> +
>  config SPI_INTEL_SPI
>  	tristate
>  
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 2adedbe..189a15c 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -3,7 +3,7 @@ obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
>  obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
>  obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
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
