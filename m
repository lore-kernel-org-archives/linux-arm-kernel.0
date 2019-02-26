Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE433C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:35:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8162173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bFgEXHy6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="X5qneY4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8162173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Or9t7fr2SG5Cd3nNjMXMrGOJG70kB4JCoEhmlj6W+S0=; b=bFgEXHy6OmN0Ed
	5/NcscgliCVbWfB6L1HHwkPbbSlX/GcyGlZcri3xHJp+yDeNKO7Abh3gAGekn7etHbc5YzK4WqvhP
	lCFVGtH20IXeWJC/6rWDiwpj8qZ783MjJ5tcKo8VnkcxQWezbPIIicLLA2FjBqUMF1+MqYEcHVuQw
	sz9+GQso+cpw9gFe/vF7450xkUIkEJU+S7PBtNIkimOBRWZr8R3AZeuizuRN71GS8G00GnxFDKRrk
	7EXzNHaRhnlKvnP6J0Qj+/6WLPTwj5/LjNOsv2U01DHvuT9DR1PzEd1d4H1tLU68q9Zunhvzu3S39
	TTavu6/aasOY221f52zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyelG-0006XD-T8; Tue, 26 Feb 2019 15:35:14 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyelD-0006WS-BH
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:35:13 +0000
X-IronPort-AV: E=Sophos;i="5.58,416,1544511600"; d="scan'208";a="27300043"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 26 Feb 2019 08:35:06 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 26 Feb 2019 08:35:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHQpaNM2kvPVnk6hhJgvs5k6Iu2hoel+5jEri3rSmhk=;
 b=X5qneY4INUfiOaXEDS0m7C7iHe7LuiY45F4LX9gxj6cdOuK5XVOZv7cPcBBdAdS1sH6nPe9iR6OjnhZkLU7qQv/B6Qo2RxCDosBFIvwbscVWJToXyg1ecKW7UZBF1YgP+TOgvVdvyHJK08g9HlGY22tKDeXm76lpWmFTg8WJ4jg=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1678.namprd11.prod.outlook.com (10.172.55.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 15:35:03 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 15:35:03 +0000
From: <Nicolas.Ferre@microchip.com>
To: <alexandre.belloni@bootlin.com>, <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data
 support
Thread-Topic: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data
 support
Thread-Index: AQHUzejX6yx8KGhkR06beat/0UNjKg==
Date: Tue, 26 Feb 2019 15:35:03 +0000
Message-ID: <1e2f49a6-f966-16ad-e212-c785ed93df00@microchip.com>
References: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::27) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff8c0a6f-9f31-460e-2827-08d69bfff9ef
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1678; 
x-ms-traffictypediagnostic: MWHPR11MB1678:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNjc4OzIzOlBiUjJHa3QwamgyRGU5eFArbkFVc3U2TE9R?=
 =?utf-8?B?S0h4eEZlUUFtS3ZISllHQ3dKb1pmNXNNN1hhKzJBL1pGUjZtajBXcmhoZ21U?=
 =?utf-8?B?Ny8yM3dDRkpTRE5KVlRPSnNpWWExdWVmL0NhdjZWSFgvU0tNa29tQkpheTlJ?=
 =?utf-8?B?V2Z1QkRvSlozSW9XN2tkcGVTMStOMzdkbkljekVMWkpPMG10WXFha0tiK3RM?=
 =?utf-8?B?Q1VsUHpsRWtwYUt4NjZqd0J4anh1eEtBSllOeHBvZDZ0RnM0cWtNOXZkS3Bj?=
 =?utf-8?B?NEdaL05EVW8xM2t1WGJBdUM4RjhweEFGLzVkRVRjV203WkhjeUxVSWdPUjJ3?=
 =?utf-8?B?SVZiS3RNZGc2bC8yYVA5YjU0RDVYTnlYazNzMWZ0bEt2dXZKR0hjdmtSUElr?=
 =?utf-8?B?cU1zSklacmRmczhLbDhyRWc2SDlYdmkzZVI3N3FNVzNyN3VqNGM5Z0xLL1Qx?=
 =?utf-8?B?WkJJQTMzRExtVEg0SDluWE45S3Y3a3JQZlJPTGZzRndidUZkSmp5Q0ZxL0Jx?=
 =?utf-8?B?cTRaUkpwSEJxcWNTYjdnS2RZUXg5dUZoYUgrOHVMSFBKOElWeHo0NWVSUGd4?=
 =?utf-8?B?VldMUnVyZW16dGh4STVuU3VvK05iWU5UaTZtRWFTUXJVR1dUejI2Q3hpbVF4?=
 =?utf-8?B?SHBDazJUMTF1Q0hpRzF0cEdGcmN0NnlUbytZdjBjbVBaeGE0bHgvdEh0eHU3?=
 =?utf-8?B?T0VmcEVWRlltMFF3V1grQXBSckZ1ZExKNzRYdEIzcmZaejB0ZEZqWDJ3NVhk?=
 =?utf-8?B?eFYzN3VldWk4OGMya0ViMVBnbDM3VDhjN3ljNENYNnN3bmtoR3JGYnBtK0pH?=
 =?utf-8?B?QVVLOXFpOEhRcUJRV3dMS2RzOENGOUNCdG9UZ2FRLzdyRlc5VFYrT3F5SnBJ?=
 =?utf-8?B?YVlDZ3NEakx6ZFJmVGlGYUt1ZDVZSHRNaWo5ZUwyWlNsQ3JTQ0hibHhRbmt6?=
 =?utf-8?B?TG5mbjZiVHpDS1RXY0pHbXlZRTZKTEtaOXRQRVkvb3FnVDkvem1LMXBJWTM5?=
 =?utf-8?B?QisvR2xpTkhFbjVnSk9xYkZhdTgyTEhRVzJyclhpOFdsSTNqOGJ5RStxYXZm?=
 =?utf-8?B?M2paOEN5YXFUNzVrTGJLWXBRMDFveGV6V0t3OGxlUWlGNEtBWTNnd0MwcWxx?=
 =?utf-8?B?V1VRS0tIV3VRZURFOWFvbG5ESVRKMVg2a0FWVHh3WmhrNDNjendmV2FTaDJU?=
 =?utf-8?B?QXlmMWRYdStFUlY1ODdTc09md2lTRjJMdXhRZzVyR3NxYXdMZDRoNTk1SkRY?=
 =?utf-8?B?VzhKOEE5bVJBd1IzTWlNakJFa0tCY1owYXNvVGptZFFaWTNMVEtBekhPbzdn?=
 =?utf-8?B?TkM0bTl2K0VWaGhlZG1vQ25jOVhIZkJPNzVWK2g2UTJCS254dTU5UnVGV044?=
 =?utf-8?B?UlorMmM4NDNCeFdiWGh6RFltOFlBcC9lNDFIQ0VqN3hQRmI5dHZUblgrM1Vw?=
 =?utf-8?B?c1pjczJCQ1FzWnY2ZHZWMEluZzllNENaQjhCUlFCQXpDV3ptR0Uva1RGSFZJ?=
 =?utf-8?B?M1JSWkhyVGV1ODVJWVp6dzdtQXVtclByKzlvTUl3dTREWXc1dm84SDhPUC9Y?=
 =?utf-8?B?WFBsZU5YLzk4MThBRVRBTXV1RmZWeWU2L1Y2RkJTdHR2UXgzc0lIa2lCcVBk?=
 =?utf-8?B?ajg3RmJEN0lzWDVjaFJ0NHpzanlhdExNcHZBdGFocGFDUnhtckxNVmRNQmNQ?=
 =?utf-8?B?bVowSXpFMnpxRHlBWGxtV1o1Tk9Cd1BXMCtVY2diT3MxM1JlYzh5d3NuK3R2?=
 =?utf-8?B?NXhBdFROQnJ3M3hjWWl3Z054S1paWTF0dDdHdkc3ZnMxaHBlQ0RXYTRLcFVz?=
 =?utf-8?Q?AvRdaaadvI3RJ?=
x-microsoft-antispam-prvs: <MWHPR11MB167856C99901D50E701A537EE07B0@MWHPR11MB1678.namprd11.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(39860400002)(366004)(376002)(346002)(189003)(199004)(68736007)(97736004)(5660300002)(105586002)(106356001)(36756003)(14444005)(256004)(110136005)(54906003)(99286004)(31696002)(52116002)(316002)(86362001)(76176011)(66066001)(446003)(2616005)(476003)(53546011)(6512007)(6506007)(11346002)(72206003)(31686004)(229853002)(14454004)(6116002)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(3846002)(386003)(6486002)(6306002)(305945005)(6436002)(71200400001)(71190400001)(25786009)(102836004)(186003)(4326008)(26005)(6246003)(7736002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1678;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fxWQwKOAigcDr4/3EWEdrEq25eqmDaQgwIEAaTI1tFy/mYCXwAxZ//z85GZ48t3nHpJAjMCrOjMvXrUbKQIc1Lru2X1V5phjjcYwFyEuVBG5Yv1f44c7W+B5Zi3a/kqjhfTSWLVj6rT55ok2V3IJ0ObEdcvHHwZCVz381ozUb0rSDO84oPorKZsQv7BqG8+KyQ3UBsXO1rgmbfuQNMdry4ztT/N0yBhn2lTOBwMMdpAbyqDJV5hJUKHcM79SyIvE9lBDcxVXzugmWToTxqaC4IJ+i33KNJW1NMBN0E94NrSGOjWX0WVgQndxYpIcWyYq4U3jsFQVeumz1e6OLlZCAvO6KjtsNmx2fcsZOKWBPKNlVVh/9JGg8/Vj+S1127/VyM6UhYOWnX82XX8b7jBH+SiBXOrL/xx8j16tRnkkfdY=
Content-ID: <AA74AA90104B674EBF33E5F961367DAA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8c0a6f-9f31-460e-2827-08d69bfff9ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 15:35:01.3054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1678
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_073511_592123_930E033B 
X-CRM114-Status: GOOD (  18.04  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
 sam@ravnborg.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/02/2019 at 22:25, Alexandre Belloni wrote:
> Make the driver OF only as since AVR32 has been removed from the kernel,
> there are only OF enabled platform using it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

It looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Alexandre.
Best regards,
   Nicolas

> ---
>   drivers/video/fbdev/Kconfig       |   6 +-
>   drivers/video/fbdev/atmel_lcdfb.c | 114 ++----------------------------
>   2 files changed, 7 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index ae7712c9687a..f0f07d02af88 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -866,8 +866,8 @@ config FB_S1D13XXX
>   	  <http://vdc.epson.com/>
>   
>   config FB_ATMEL
> -	tristate "AT91/AT32 LCD Controller support"
> -	depends on FB && HAVE_FB_ATMEL
> +	tristate "AT91 LCD Controller support"
> +	depends on FB && OF && HAVE_FB_ATMEL
>   	select FB_BACKLIGHT
>   	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
> @@ -875,7 +875,7 @@ config FB_ATMEL
>   	select FB_MODE_HELPERS
>   	select VIDEOMODE_HELPERS
>   	help
> -	  This enables support for the AT91/AT32 LCD Controller.
> +	  This enables support for the AT91 LCD Controller.
>   
>   config FB_NVIDIA
>   	tristate "nVidia Framebuffer Support"
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 4ed55e6bbb84..b8786ff62b87 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1,5 +1,5 @@
>   /*
> - *  Driver for AT91/AT32 LCD Controller
> + *  Driver for AT91 LCD Controller
>    *
>    *  Copyright (C) 2007 Atmel Corporation
>    *
> @@ -99,86 +99,6 @@ static struct atmel_lcdfb_config at91sam9rl_config = {
>   	.have_intensity_bit	= true,
>   };
>   
> -static struct atmel_lcdfb_config at32ap_config = {
> -	.have_hozval		= true,
> -};
> -
> -static const struct platform_device_id atmel_lcdfb_devtypes[] = {
> -	{
> -		.name = "at91sam9261-lcdfb",
> -		.driver_data = (unsigned long)&at91sam9261_config,
> -	}, {
> -		.name = "at91sam9263-lcdfb",
> -		.driver_data = (unsigned long)&at91sam9263_config,
> -	}, {
> -		.name = "at91sam9g10-lcdfb",
> -		.driver_data = (unsigned long)&at91sam9g10_config,
> -	}, {
> -		.name = "at91sam9g45-lcdfb",
> -		.driver_data = (unsigned long)&at91sam9g45_config,
> -	}, {
> -		.name = "at91sam9g45es-lcdfb",
> -		.driver_data = (unsigned long)&at91sam9g45es_config,
> -	}, {
> -		.name = "at91sam9rl-lcdfb",
> -		.driver_data = (unsigned long)&at91sam9rl_config,
> -	}, {
> -		.name = "at32ap-lcdfb",
> -		.driver_data = (unsigned long)&at32ap_config,
> -	}, {
> -		/* terminator */
> -	}
> -};
> -MODULE_DEVICE_TABLE(platform, atmel_lcdfb_devtypes);
> -
> -static struct atmel_lcdfb_config *
> -atmel_lcdfb_get_config(struct platform_device *pdev)
> -{
> -	unsigned long data;
> -
> -	data = platform_get_device_id(pdev)->driver_data;
> -
> -	return (struct atmel_lcdfb_config *)data;
> -}
> -
> -#if defined(CONFIG_ARCH_AT91)
> -#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
> -					 | FBINFO_PARTIAL_PAN_OK \
> -					 | FBINFO_HWACCEL_YPAN)
> -
> -static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
> -					struct fb_var_screeninfo *var,
> -					struct fb_info *info)
> -{
> -
> -}
> -#elif defined(CONFIG_AVR32)
> -#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
> -					| FBINFO_PARTIAL_PAN_OK \
> -					| FBINFO_HWACCEL_XPAN \
> -					| FBINFO_HWACCEL_YPAN)
> -
> -static void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
> -				     struct fb_var_screeninfo *var,
> -				     struct fb_info *info)
> -{
> -	u32 dma2dcfg;
> -	u32 pixeloff;
> -
> -	pixeloff = (var->xoffset * info->var.bits_per_pixel) & 0x1f;
> -
> -	dma2dcfg = (info->var.xres_virtual - info->var.xres)
> -		 * info->var.bits_per_pixel / 8;
> -	dma2dcfg |= pixeloff << ATMEL_LCDC_PIXELOFF_OFFSET;
> -	lcdc_writel(sinfo, ATMEL_LCDC_DMA2DCFG, dma2dcfg);
> -
> -	/* Update configuration */
> -	lcdc_writel(sinfo, ATMEL_LCDC_DMACON,
> -		    lcdc_readl(sinfo, ATMEL_LCDC_DMACON)
> -		    | ATMEL_LCDC_DMAUPDT);
> -}
> -#endif
> -
>   static u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
>   		| ATMEL_LCDC_POL_POSITIVE
>   		| ATMEL_LCDC_ENA_PWMENABLE;
> @@ -404,8 +324,6 @@ static void atmel_lcdfb_update_dma(struct fb_info *info,
>   
>   	/* Set framebuffer DMA base address and pixel offset */
>   	lcdc_writel(sinfo, ATMEL_LCDC_DMABADDR1, dma_addr);
> -
> -	atmel_lcdfb_update_dma2d(sinfo, var, info);
>   }
>   
>   static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info *sinfo)
> @@ -978,7 +896,6 @@ static void atmel_lcdfb_stop_clock(struct atmel_lcdfb_info *sinfo)
>   	clk_disable_unprepare(sinfo->lcdc_clk);
>   }
>   
> -#ifdef CONFIG_OF
>   static const struct of_device_id atmel_lcdfb_dt_ids[] = {
>   	{ .compatible = "atmel,at91sam9261-lcdc" , .data = &at91sam9261_config, },
>   	{ .compatible = "atmel,at91sam9263-lcdc" , .data = &at91sam9263_config, },
> @@ -986,7 +903,6 @@ static const struct of_device_id atmel_lcdfb_dt_ids[] = {
>   	{ .compatible = "atmel,at91sam9g45-lcdc" , .data = &at91sam9g45_config, },
>   	{ .compatible = "atmel,at91sam9g45es-lcdc" , .data = &at91sam9g45es_config, },
>   	{ .compatible = "atmel,at91sam9rl-lcdc" , .data = &at91sam9rl_config, },
> -	{ .compatible = "atmel,at32ap-lcdc" , .data = &at32ap_config, },
>   	{ /* sentinel */ }
>   };
>   
> @@ -1122,19 +1038,12 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>   	of_node_put(display_np);
>   	return ret;
>   }
> -#else
> -static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
> -{
> -	return 0;
> -}
> -#endif
>   
>   static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct fb_info *info;
>   	struct atmel_lcdfb_info *sinfo;
> -	struct atmel_lcdfb_pdata *pdata = NULL;
>   	struct resource *regs = NULL;
>   	struct resource *map = NULL;
>   	struct fb_modelist *modelist;
> @@ -1159,21 +1068,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>   		ret = atmel_lcdfb_of_init(sinfo);
>   		if (ret)
>   			goto free_info;
> -	} else if (dev_get_platdata(dev)) {
> -		struct fb_monspecs *monspecs;
> -		int i;
> -
> -		pdata = dev_get_platdata(dev);
> -		monspecs = pdata->default_monspecs;
> -		sinfo->pdata = *pdata;
> -
> -		for (i = 0; i < monspecs->modedb_len; i++)
> -			fb_add_videomode(&monspecs->modedb[i], &info->modelist);
> -
> -		sinfo->config = atmel_lcdfb_get_config(pdev);
> -
> -		info->var.bits_per_pixel = pdata->default_bpp ? pdata->default_bpp : 16;
> -		memcpy(&info->monspecs, pdata->default_monspecs, sizeof(info->monspecs));
>   	} else {
>   		dev_err(dev, "cannot get default configuration\n");
>   		goto free_info;
> @@ -1186,7 +1080,8 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>   	if (IS_ERR(sinfo->reg_lcd))
>   		sinfo->reg_lcd = NULL;
>   
> -	info->flags = ATMEL_LCDFB_FBINFO_DEFAULT;
> +	info->flags = FBINFO_DEFAULT | FBINFO_PARTIAL_PAN_OK |
> +		      FBINFO_HWACCEL_YPAN;
>   	info->pseudo_palette = sinfo->pseudo_palette;
>   	info->fbops = &atmel_lcdfb_ops;
>   
> @@ -1435,7 +1330,6 @@ static struct platform_driver atmel_lcdfb_driver = {
>   	.remove		= __exit_p(atmel_lcdfb_remove),
>   	.suspend	= atmel_lcdfb_suspend,
>   	.resume		= atmel_lcdfb_resume,
> -	.id_table	= atmel_lcdfb_devtypes,
>   	.driver		= {
>   		.name	= "atmel_lcdfb",
>   		.of_match_table	= of_match_ptr(atmel_lcdfb_dt_ids),
> @@ -1444,6 +1338,6 @@ static struct platform_driver atmel_lcdfb_driver = {
>   
>   module_platform_driver_probe(atmel_lcdfb_driver, atmel_lcdfb_probe);
>   
> -MODULE_DESCRIPTION("AT91/AT32 LCD Controller framebuffer driver");
> +MODULE_DESCRIPTION("AT91 LCD Controller framebuffer driver");
>   MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
>   MODULE_LICENSE("GPL");
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
