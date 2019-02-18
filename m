Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189ACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:59:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD857217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bHNcBDXX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FnS2KU0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD857217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=frEzruoBpNPTc4vA+6PLpASERAjlsYb8Hz902H8Zlw0=; b=bHNcBDXX5Sif5A
	N6Sto9FZ3vjo8AU9osl1CxIjmXjEp2tNTrvebu5dXiZHNbXpLt/9VTVenLe4JVjAazPODocQhi+Rj
	spY2vFxKGpKBmWis2s3RAWxXDHtW19Ts/jqSpOjbfhwxqdzXdaleO3ps2EGj/asH+QQ2iHcHqRZzn
	w46eI5BJ3fEuCXM4JUQ9VkugM9mZiJbte2nDTWrqlU7dxot+ByH7uK+W6EWzuMCgOTDVUp/ABmfI4
	pGwWml29BTov8rTmWd+BE8CXLj6Of2xbD/R2B8XWf4ndHve1n/7NrjPGdnziMzf2mjiI6p5ggou6b
	rX1Kw/mLMyRVJSMTaEOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgeD-0004Dm-Qn; Mon, 18 Feb 2019 10:59:41 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvge6-0003yf-CD
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:59:39 +0000
X-IronPort-AV: E=Sophos;i="5.58,384,1544511600"; d="scan'208";a="26734933"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 18 Feb 2019 03:59:17 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 18 Feb 2019 03:59:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XoTRfBAYkpFXAXZIXo1/N6La3NR3Tjw8gEQnpLNolY=;
 b=FnS2KU0MzNKrKXTwtYDfEccbWIIBldk8BiFqiQj0jeec/s11wjdXXbNji5+gk6ukxHHfFqKYifzCvhei81LHT4SI3W0cYSP6qO+Lat/TvBeQAmzv4oYGBxVZX6Ak9/m99wnVUVqOi+Ll4E1KfHFywE6JLS3qdNYS/Ic8WUWb6Hg=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1279.namprd11.prod.outlook.com (10.169.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 10:59:15 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 10:59:15 +0000
From: <Nicolas.Ferre@microchip.com>
To: <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
Subject: Re: [PATCH 1/3] power: reset: at91-poweroff: add RTT wakeup capability
Thread-Topic: [PATCH 1/3] power: reset: at91-poweroff: add RTT wakeup
 capability
Thread-Index: AQHUx3j8EFNnbpKEtkS3tfjVpj7SUg==
Date: Mon, 18 Feb 2019 10:59:15 +0000
Message-ID: <10737217-cbf5-765c-7bad-2d9f4b038f28@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-2-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-2-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0377.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::29) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6d1a545-4e68-4200-6015-08d695901f03
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1279; 
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMjc5OzIzOkxOT0RScFU0ek1ITUk3VFdDd0FrOUxyY0lm?=
 =?utf-8?B?R0JGWnQ1RVJ3c241Mi93ZjBEaFlYQWFVaTR4cithc1pTa285QlhuczUrT1dh?=
 =?utf-8?B?d2szU2d6YnpJK0FHREJSYy9LdDBFMUVGaXhnZUt6bi9URWN4ZGVqZ0JBZE15?=
 =?utf-8?B?TXFZT2hGZWVnRkhIbFA5eHpRWFVPRmF3VzdPYUZYM3A3TWhzamtXMDhTZWNS?=
 =?utf-8?B?cnNzU1JEQ2JORHFJZE5yNDF5WHJvZE1LUzVvZ1VqS21kelcrZXF5NUpvZ2c0?=
 =?utf-8?B?TUdKRzlHOFRzZDRhREZBYTJUQkFDak9LNkN4QnNBeXNSV05zajJjTkI3Ukln?=
 =?utf-8?B?UVFuRm11VklqcituWVhKQm5UQjkra0dLR3ZpaWJOc1pwdEJoRkYxblJ1bzE0?=
 =?utf-8?B?NGRtRU9ScGpxdktRNlpsSWFLTDFDQ0JVd0IrSE1pd0dVRndoUUhwTlVBRUdi?=
 =?utf-8?B?aUNwWURrYnJ3OTdybnhVWTVTWFhsZ09nM3NDZkM5eFl2VVQ3dFJrblRkcnpn?=
 =?utf-8?B?elljdHIxNlRDRjc4dHZjQk41OFZnM2x2ZUYxYVZtV0NMUDFiUnU1bGZIaThD?=
 =?utf-8?B?OXRKYnJCWkZ3VmxiUEljck9UMGhML0VtNDR5Mm95Y0hWdStnT2ZSbG9oekwv?=
 =?utf-8?B?S3M4c1NOaXlnWjlPYVR3VGtUR1cvay90ZEJjQkxvUUtsa09hd0ZnY0pPYTJm?=
 =?utf-8?B?YnVFazRwN0pDLzBScVVCT1dTQjljNkZORzloa2I5NXBmd0FEQXdPS2x4ZFlT?=
 =?utf-8?B?ODNVL0k5aHAvbFhaOU5hWkJLYTlPaXU1RHZqQTcyVUpWOTB6RFdOekQ3dW8v?=
 =?utf-8?B?SVU3QUtodWlvRU5McGVqcWtKbmdaUDVSZFkrZXl4WktSMURCYm1ncExUbGZx?=
 =?utf-8?B?YmllUCsydjdiVStNUENWTzBIdWYwNUUrZ2JtcVNTVU55WUM3dGRuai9hN250?=
 =?utf-8?B?ajVSSGpkVDl4S25Oc3BqdjBnN2hyVnVERzk0QnN2cUFVbFRwNFo4QkJzQllC?=
 =?utf-8?B?d1Ezd0FLR2Z2dDFnZWpxb0dXSGwyY25kOC9pdUNFbDZWbE1zYm1Qa0RXWGpJ?=
 =?utf-8?B?M0M5NlBZcTgzUkpWNU04NEg5RWFWaE5sL1pxM0Z4QnIzM3ZpNW03cUdOR00r?=
 =?utf-8?B?WFFyVXpnNXAwRy8xeGZ4UG5mSGhUU3dycXZLTUdzejU4bElxSFUxMExBK0VO?=
 =?utf-8?B?K2pZUHRESkp1aTZLNlpVeEc2WWVuMHFYN3RFTnJEZTlsaEhGZFRqMG53SnNw?=
 =?utf-8?B?RS9XRUlpSnlSa1ZQSlluOHNleStUdTVjRXJ3OS9EQXV6dE1sMlBKUFlwSVhT?=
 =?utf-8?B?V1IvNTJObDFoNjA0VUJReExjMEZFWEpTWlNYUDhuR1k4b0hkQWVWbGdNVG0y?=
 =?utf-8?B?NzNUS0NGMkxrT053cGZaYkhzdFVCK3FwSFZvYUJwUWhlVVllZ1NGNGYzdjYx?=
 =?utf-8?B?QWt5S1VodzFqQmhxQnppMGFUaUxoODdNM3k0TWxxeVJZN2xJWUE4Y1AwaFJI?=
 =?utf-8?B?c3IyaUIxZTZjNStuT1V2SWZnZldQS2Vzd0drc21TQ2o4UHVYZGJLVmpKUzJu?=
 =?utf-8?B?cEhYV1dzK2h2eEpJclQ0Y2tQcEROQWY2ZFhheGFNNUZxYU10ODdJR3lpSUlT?=
 =?utf-8?B?RHdaQk9vdW9wb2hSK3FPNW1OdXk5K2kvRG4rOFYxaGlpLzZ0VFBnZEJPVEJi?=
 =?utf-8?B?VklkOTZDSnJjK0p4ZGlkVlpQZU5NMXhTbnVybW94eUs1VU5ackYrT2FLbUJN?=
 =?utf-8?Q?jHl6iUrvAP8Yq3W4XjsVz9Ehv+ILtA914XMR0=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB127986C04F8C34025473E316E0630@MWHPR11MB1279.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(14454004)(229853002)(6436002)(6486002)(186003)(478600001)(26005)(8936002)(81156014)(486006)(8676002)(72206003)(446003)(476003)(36756003)(2616005)(71190400001)(305945005)(5660300002)(81166006)(71200400001)(66066001)(256004)(4326008)(7736002)(11346002)(6246003)(25786009)(3846002)(6116002)(2906002)(52116002)(99286004)(76176011)(97736004)(102836004)(316002)(53546011)(386003)(6506007)(53936002)(54906003)(68736007)(2501003)(105586002)(110136005)(6512007)(106356001)(86362001)(31696002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1279;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bnlEThrmliBtto5kuIkhBnPyU2WZbxeH88atARO1aIKKcOUyA3G857FCLn91l73tJRGBxDFbh26jsoFzT49UxL0uNkHu/Wn0+ZwxPBakHuGdnURNPZRBQDpKTYjN9udtVUmJb8prwEwGc/GfGzroRi33nZZylMtUBjVN+5A8a8pVqYnTtv87SIi1xPQJluaTmSKxAMCgPQEHhlDSiWJjHNm3DRHP/F4ycWedgLcYyZ6Cpr2QNPAIAWDZzal5wbFjkJpJN7GFuPLrcsFnNuG09MSk+AchQm36jsRYkmJv/yvnBzhPnHfmj6DDz4wg7TIOw1Ebjdl2wuaDo9S6YYwIi0M85Y6gtkmKywx0BzmgMR/aH2oqoaqe98nWhX9Ggp2SiF9g7d09wrusKRpsuFUxo79Fsgl/mncDP3RD0GXoBG8=
Content-ID: <7F3E343DC83520438EF3A6C8A1D1E53B@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d1a545-4e68-4200-6015-08d695901f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 10:59:12.0655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_025934_746446_E204A989 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/2019 at 12:24, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add RTT wakeup capability.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/power/reset/at91-sama5d2_shdwc.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index 2b686c55b717..0747e0cdf350 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -57,15 +57,21 @@
>   
>   #define SHDW_WK_PIN(reg, cfg)	((reg) & AT91_SHDW_WKUPIS((cfg)->wkup_pin_input))
>   #define SHDW_RTCWK(reg, cfg)	(((reg) >> ((cfg)->sr_rtcwk_shift)) & 0x1)
> +#define SHDW_RTTWK(reg, cfg)	(((reg) >> ((cfg)->sr_rttwk_shift)) & 0x1)
>   #define SHDW_RTCWKEN(cfg)	(1 << ((cfg)->mr_rtcwk_shift))
> +#define SHDW_RTTWKEN(cfg)	(1 << ((cfg)->mr_rttwk_shift))
>   
>   #define DBC_PERIOD_US(x)	DIV_ROUND_UP_ULL((1000000 * (x)), \
>   							SLOW_CLOCK_FREQ)
>   
> +#define SHDW_CFG_NOT_USED	(32)
> +
>   struct shdwc_config {
>   	u8 wkup_pin_input;
>   	u8 mr_rtcwk_shift;
> +	u8 mr_rttwk_shift;
>   	u8 sr_rtcwk_shift;
> +	u8 sr_rttwk_shift;
>   };
>   
>   struct shdwc {
> @@ -104,6 +110,8 @@ static void __init at91_wakeup_status(struct platform_device *pdev)
>   		reason = "WKUP pin";
>   	else if (SHDW_RTCWK(reg, shdw->cfg))
>   		reason = "RTC";
> +	else if (SHDW_RTTWK(reg, shdw->cfg))
> +		reason = "RTT";
>   
>   	pr_info("AT91: Wake-Up source: %s\n", reason);
>   }
> @@ -221,6 +229,9 @@ static void at91_shdwc_dt_configure(struct platform_device *pdev)
>   	if (of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
>   		mode |= SHDW_RTCWKEN(shdw->cfg);
>   
> +	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
> +		mode |= SHDW_RTTWKEN(shdw->cfg);
> +
>   	dev_dbg(&pdev->dev, "%s: mode = %#x\n", __func__, mode);
>   	writel(mode, shdw->shdwc_base + AT91_SHDW_MR);
>   
> @@ -231,7 +242,10 @@ static void at91_shdwc_dt_configure(struct platform_device *pdev)
>   static const struct shdwc_config sama5d2_shdwc_config = {
>   	.wkup_pin_input = 0,
>   	.mr_rtcwk_shift = 17,
> +	.mr_rttwk_shift	= SHDW_CFG_NOT_USED,
>   	.sr_rtcwk_shift = 5,
> +	.sr_rttwk_shift = SHDW_CFG_NOT_USED,
> +};
>   };
>   
>   static const struct of_device_id at91_shdwc_of_match[] = {
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
