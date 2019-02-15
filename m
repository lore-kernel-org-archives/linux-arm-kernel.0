Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670DC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E58222D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QCYiOq55";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2LtPUQMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E58222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y3WHRc2tTrLO8txsBRubQo3biz3xw/GLvtUiNpWaRdI=; b=QCYiOq55GBQDpo
	hPbqlI6jEtqCnL9TiSRJ8EXMh/28do9yKMgjGVmqo0gqMh01QObZdRdKXuQ7Xw+3ZexoljHm+UuUP
	LUdZLkBHnZG/ySn9nfAPgfWjTA1f8lNQTQHPhh+0r7whBOHs7H5pc/pRcjGD02JORYRf28pPmI//t
	z/XbCLFXl1SyvGQJa/VkyV2blfVWmULCgsA+4fIEkej2pmvrl5tmbcgCjLcFfFQzRpyeM5e5qcK6U
	Y/PagG5KdIWrmK+J8e5aQVVSBIjRSK8q1ISYe+8XCrlGmzn2Lw5HI0DoWv5uK6W0p6aFPwcHXAcxx
	k7IcUsUTI8UmQC7aNvGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZiv-0003j1-MH; Fri, 15 Feb 2019 09:23:57 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZir-0003iX-Sy
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 09:23:55 +0000
X-IronPort-AV: E=Sophos;i="5.58,372,1544511600"; d="scan'208";a="24720509"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 15 Feb 2019 02:23:53 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 15 Feb 2019 02:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpxdEN3YGgGKcHG1o/1d5zs/GytzLqaE7VmPgIsVr6g=;
 b=2LtPUQMRuJS1NW1jwwykkFTE01JHmbzXE+cMvrMna052AgA34abwakMcTAyVwu5amzcBCuPV+wvnPoy21QsiakZcnidGuRdfgw/GCf9RsFXfFkkyIbn6GghiKqbtzersRjFAxZrRwnxz4HC9t5rd+2wPCjGu+BhaRSKabIStHFo=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1982.namprd11.prod.outlook.com (10.175.54.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 09:23:48 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 09:23:48 +0000
From: <Claudiu.Beznea@microchip.com>
To: <fabrice.gasnier@st.com>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
Thread-Topic: [PATCH v3 3/3] pwm: core: add consumer device link
Thread-Index: AQHUw4p14FSdsXXDYkmaFhQjivZ9oqXgmScA
Date: Fri, 15 Feb 2019 09:23:48 +0000
Message-ID: <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190215112332340
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ec0e93f-a1d7-40fe-e334-08d693274a01
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1982; 
x-ms-traffictypediagnostic: MWHPR11MB1982:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxOTgyOzIzOjhoRW4rVlVhMWN4ZTdSV3R1WEtFS29yNU1O?=
 =?utf-8?B?ZWl6TmVlaXRremdiMlhwbUVGalBWTHlxK2ZPMDdueVJiazk0VUdIdmlLdVRW?=
 =?utf-8?B?L2ppYWRPNkxFelNGeWQzeUVqY1IyTkF1V1ZlZGJIM05QMkFRbDZ2TjRiQkpn?=
 =?utf-8?B?VWNtTlk0NEtJYTVubVZXL0dGRWZyTlk5VjBiVDY4dnZTb2x4aU9JQWN6Smw1?=
 =?utf-8?B?Z0ZMTEp5Mkd5K2xhcnlKV0tPMjZqem9CaFNzTTRVK0U4Rk92VWI3ZzJqNjBT?=
 =?utf-8?B?UXFaN3BZUktXd1FGVzl4VjdFTkZRRUJGaDh6enBrcWlaVFVKRlg2UVZsNHA5?=
 =?utf-8?B?aXJWZG1vSDFkYkp4Z0JnNkg4WXYreU15K0gzUWFnbVcxUmowbUdrTGtoUGps?=
 =?utf-8?B?T2VjS285NXBrSzlQaWdzSnQ4UGZ4SE1PWkpHb0dybmJMUUpvUm9TZTNlYmUr?=
 =?utf-8?B?SjM2SnNIRjdxZlZlVVpSL1ZVMlMvTmJ3anZsdW1jb3RoQzJuenNhOVRxK3Bz?=
 =?utf-8?B?ZGxML1dDaWxDSXpJb0F1TmFFQ2dEY0VHMXRQQmxOcytUb1BsMnpDNElqSXlU?=
 =?utf-8?B?MDZGQTd5anFrbmV5Yk4wdU1zdFJlY3JZYjBCdmZYbThmditJZEQyVFRqbjJl?=
 =?utf-8?B?Ukc4SXM4SXlmYk9XU0FRTnd1M2hxTFNOSkE2bTVBclpibDVQcllTN1lxLzNF?=
 =?utf-8?B?Z1VhdCs5WWhqYjhZN3hvbUZtV21JTytGS0dBbVdxTlR0UkVOMUtteEJrWmVr?=
 =?utf-8?B?MzVDT2VWM2RCcmRNaWNOYVUrSWlaWG1BOEJmdStoL0JNUlVock4vSkNMdmlI?=
 =?utf-8?B?WGhXdzJXUXdXMDhTNm9pVjdJTmw1SC9haWVxek1DZWJzL3lEYzRkL3R2clJI?=
 =?utf-8?B?NkF4QmhoYkw3dzJnOUI5ME9SZkZ0aHJnclhZZHBMamNweGpjWUpOVUZiOHRH?=
 =?utf-8?B?TFRmdkZGUktGVWVlaGc4ZFUyTEY1OGRFSE9RdWZNMXhpZkwzU0FpOTVZZHZk?=
 =?utf-8?B?N1FSMFAyRUNRemVJQXkwZGw0WiszTkkzRFdwK2pmWVZMVDYydkJCZWZ5NGhU?=
 =?utf-8?B?cDNDSXFhbVg5aWJVenlKOGt6YUZDeFZoWjRTMmFrVG5JeEpBWGI4WFFOc3k5?=
 =?utf-8?B?YmdWdWh1bEN5a2p2Q3A1d09oOWNUbUh3WmY5YVh2VWZ0WE1kdXFrcE54WDht?=
 =?utf-8?B?c3FoUFpiTUJFNlhTMXZFRzMyRjUwMC9leWowOWNMbktKenFwQVFOek5XS1Ny?=
 =?utf-8?B?M29KSzVDcTdPbnhTVWdsL1VySVBYVnlEcU45Ujl2UFhDTU54cjNKSVE3SXNS?=
 =?utf-8?B?T1VuQjN4dDM5ODRJYjF1RTlUVlpBTnp6cDhUeVh1eUpTSmNBMkxrSW1UUm1m?=
 =?utf-8?B?NklCUUlZd3AxNXZqUzBRd3pYNWFUS0oyR3JLWDJ6Snd1bEhJVVRzM1hXaXgr?=
 =?utf-8?B?RDN6dHpWQWpCaDdvelhHQWdvUGoxUVFGTHNoRHJTNWNGRkhOdVZKYjhCbjJw?=
 =?utf-8?B?WTZNWVhpaHo4UmhDTmJMQkwya3V1YzFvTUIxM05zT3Rad1BieW9HRFhqRVNC?=
 =?utf-8?B?TUgxb2pYVGlacVg5WVQwOXhwZDF5ZHl0SFFVTXQ0bjhGSGhvZWtaZVlYdmgw?=
 =?utf-8?B?Q0RTWXYyZGFING52NUIwV09Fd1hGNG1TNEtlQWRoUjhTVjgwMVIwR3NjVERG?=
 =?utf-8?B?c2NoUXhqRWFZU29VWHdwWGZRaGE1NFNPS0hsR2FDWXJGS25PUHNsTW9qeW5P?=
 =?utf-8?B?WTRzUHFBRElrcTVWendFeVp4ZkswaEZ0NWs1bDF5azBETlVreU5pbHZ2bWtX?=
 =?utf-8?B?SlVSbjZCMWxFdW1yUjNiUEdoNmFHblNTbFNQQ0VwWGVNZ1E9PQ==?=
x-microsoft-antispam-prvs: <MWHPR11MB1982183F735B6992C6C6F7D087600@MWHPR11MB1982.namprd11.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(366004)(199004)(189003)(31686004)(76176011)(7416002)(106356001)(52116002)(2616005)(8676002)(105586002)(81166006)(81156014)(53546011)(476003)(31696002)(4326008)(386003)(6506007)(110136005)(54906003)(86362001)(486006)(25786009)(99286004)(6512007)(53936002)(66066001)(72206003)(7736002)(305945005)(966005)(14454004)(14444005)(256004)(26005)(6486002)(229853002)(11346002)(102836004)(478600001)(6306002)(446003)(6436002)(316002)(186003)(71190400001)(3846002)(6116002)(71200400001)(2906002)(2501003)(97736004)(8936002)(36756003)(68736007)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1982;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2TwKLEpYhHyGctN83cualIkpA/i3CTHsCSZoP8VXaoW/bKYUrWRCZizkEVsV0c9TPe9lp9HHtIrajwu26U1wylKkGvlSAytoSt6Iuvvye23pQu5d+ZvId8yins0oZSwa/5zFIa8QfAID/c+VSmCFC//e7MVc+uHav8am9KsXzvYdk4QTPIsV61zjflNvQT62bOH4JA/7zYbRRZ6q6oxcLvEhzhlYRFqBiBJ0Lcla7UnlnBqSKTdvtMwwM1xWCF22F2BqmJb9SIOJJipsCblCAbY1qD7S+rBfQmTf1ksaYsW4IcvenL0TJgbUO47Chl4+w5JWTH1xoF3AmloLiL37MqKHSoUx1q1294te41e1prEZtw2FY2L9t+q1JYUK699/TwSrCripNZguIq10Wjozqi0strDI6/LXGbohi4l/2Lc=
Content-ID: <3486EE3314710E4B81615517F5452058@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec0e93f-a1d7-40fe-e334-08d693274a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:23:43.6340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1982
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_012354_049314_62114183 
X-CRM114-Status: GOOD (  22.50  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 linux-pwm@vger.kernel.org, tduszyns@gmail.com, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 13.02.2019 12:50, Fabrice Gasnier wrote:
> Add a device link between the PWM consumer and the PWM provider. This
> enforces the PWM user to get suspended before the PWM provider. It
> allows proper synchronization of suspend/resume sequences: the PWM user
> is responsible for properly stopping PWM, before the provider gets
> suspended: see [1]. Add the device link in:
> - of_pwm_get()
> - pwm_get()
> - devm_ variants
> as it requires a reference to the device for the PWM consumer.
> 
> [1] https://lkml.org/lkml/2019/2/5/770
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v3:
> - add struct device to of_get_pwm() arguments to handle device link from
>   there.
> ---
>  drivers/pwm/core.c  | 14 +++++++++++---
>  include/linux/pwm.h |  6 ++++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..8cb5d4bc 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>  
>  /**
>   * of_pwm_get() - request a PWM via the PWM framework
> + * @dev: device for PWM consumer
>   * @np: device node to get the PWM from
>   * @con_id: consumer name
>   *
> @@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>   * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
>   * error code on failure.
>   */
> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
> +			      const char *con_id)
>  {
>  	struct pwm_device *pwm = NULL;
>  	struct of_phandle_args args;
> @@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>  	if (IS_ERR(pwm))
>  		goto put;
>  
> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> +		pr_debug("%s(): device link not added\n", __func__);
> +

Just asking... will this mechanism also be working for PWMs requested via
sysfs? At a first look it seems not.

Thank you,
Claudiu Beznea

>  	/*
>  	 * If a consumer name was not given, try to look it up from the
>  	 * "pwm-names" property if it exists. Otherwise use the name of
> @@ -771,7 +776,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  
>  	/* look up via DT first */
>  	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> -		return of_pwm_get(dev->of_node, con_id);
> +		return of_pwm_get(dev, dev->of_node, con_id);
>  
>  	/*
>  	 * We look up the provider in the static table typically provided by
> @@ -851,6 +856,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  	pwm->args.period = chosen->period;
>  	pwm->args.polarity = chosen->polarity;
>  
> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> +		pr_debug("%s(): device link not added\n", __func__);
> +
>  	return pwm;
>  }
>  EXPORT_SYMBOL_GPL(pwm_get);
> @@ -939,7 +947,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	pwm = of_pwm_get(np, con_id);
> +	pwm = of_pwm_get(dev, np, con_id);
>  	if (!IS_ERR(pwm)) {
>  		*ptr = pwm;
>  		devres_add(dev, ptr);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d5199b5..895e074 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -406,7 +406,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
>  		const struct of_phandle_args *args);
>  
>  struct pwm_device *pwm_get(struct device *dev, const char *con_id);
> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
> +			      const char *con_id);
>  void pwm_put(struct pwm_device *pwm);
>  
>  struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
> @@ -494,7 +495,8 @@ static inline struct pwm_device *pwm_get(struct device *dev,
>  	return ERR_PTR(-ENODEV);
>  }
>  
> -static inline struct pwm_device *of_pwm_get(struct device_node *np,
> +static inline struct pwm_device *of_pwm_get(struct device *dev,
> +					    struct device_node *np,
>  					    const char *con_id)
>  {
>  	return ERR_PTR(-ENODEV);
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
