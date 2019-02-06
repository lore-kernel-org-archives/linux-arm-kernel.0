Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D702175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HpOZRgFz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HyHHAZUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D702175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wRxUdUK7wLgv+c0FKQX+pzjqRlI6XbemhAbr7l6OiCg=; b=HpOZRgFzUghQTJ
	HbFmTDVj0g4ngFpaLlCgekSCbaWrCYcgxCxOrZZkN1+8ZJ50JtpPp+mnEREZB/dNEBGSnOFz/5Cyz
	gaSpsMwzqlA7mjX660P2Ap0eZtlTE5HhFQ7+SCQc1PHuUN7txZOg/jWx1ZvR+6ERvg0eE+L6jdZHt
	adNkQhizCwTBlLwQ9i1Swqfsb+LZO2GpYFveFEpi1MOmC8Z1tz30p8Bp+BCLfP9MdJXdIxLjDTaiP
	gfQ0GkAj8mX0+qyIFhBkIN1R3CFYDmcaybukWta8M3l1MHCiZNn0sglCT/wSqwD4kG3EkQDBZ1+FT
	HVC0s7fWW7clHfgcvwFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNWn-0001rb-Ao; Wed, 06 Feb 2019 13:46:13 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNWj-0001fu-C1
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 13:46:11 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="24289027"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 06 Feb 2019 06:46:05 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 6 Feb 2019 06:46:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxttacHnw5X/Qf2S6wJ69U3uxwPkIq8GDEQYTDMB/H0=;
 b=HyHHAZUlTOUhcMY4SWWejFACwpZTI7mPLir53IfI7zUEHqTRxHcsGGwf8d83ffh1G9Jx5On4LJWkGMtT1adxzgYAri4jrsJ3pEB7oyEI5PBQBzP/tvDkGsATsJrMbSZNxt0hcgxSWC0uBmh9JA1LJ+fcl+0SrGg7MQ2ImXkDQeY=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1982.namprd11.prod.outlook.com (10.175.54.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 6 Feb 2019 13:46:01 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Wed, 6 Feb 2019
 13:46:01 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Topic: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Index: AQHUuYCLA9fU9IUpL0SQqk5ieOzKJqXSdJAAgAAaDACAAAqQAIAAOF6A
Date: Wed, 6 Feb 2019 13:46:01 +0000
Message-ID: <8880dfa2-4bbd-d3c8-b692-180555636926@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
 <1548951466-26297-2-git-send-email-claudiu.beznea@microchip.com>
 <20190206081304.cv344rjzvz7wzih5@M43218.corp.atmel.com>
 <f0022bfc-6deb-de77-857c-c70d41f4fc78@microchip.com>
 <20190206102406.r45rb5bfjk2j45dr@M43218.corp.atmel.com>
In-Reply-To: <20190206102406.r45rb5bfjk2j45dr@M43218.corp.atmel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0224.eurprd07.prod.outlook.com
 (2603:10a6:802:58::27) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190206154551761
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1982;
 6:Hq6JoyCEzUcPu13eAnIKYhwRYFrnZXUyHMXALKw31NcqZSHsxSHjDm1MI8KWOdE8f1wju1ERdHY9bQ7Aj10eMNhP0alqk+XlT4QRRlF9+wW6RVNp+oqObGLpCPGZuh90q9PxuUoI48Pwi7+X0/DzYFkYa8mxGBJhpvLUjj/IX1csJSzICdR4W/kGwBbWySqWzCCyL7CV1QvXPsp0QXlSd/6v1CrUx6DT4dXIwkGeWkGWqfVa0tll8vYNKrZoea0wOviaI+LoFGzX/ZlVBY2jvjJggbuX6pBjl5jsLhF+NYKq0RhzgUNR2fQxKUfXtRmxTB42TKasros/rnz7s6xczRResiWMOM0y6rhbYZulKgVI1/Rx5RO9jdCz7lKYQNKXptcNL/tRGbHyT2Jg98/6+s95AgBzwxY7SsUATUoTE50NEble8+EFRHF8HRBQxbege15NH1LQYh5v2I8geRm/Rw==;
 5:GHgB/8GkBTW2067i/pWEkeoHUb8aVupeBigDAHknlTMVV5g75YrK8M6gn54YbFpxPnCBqJucKlMp8deYC9LN/Y52w1PtzamCNmaHTUF7TirEH941zVyF3wCwLkbupsDvCcj7/Tv3TdanQLrYPD6IyQXWyc3VPH0GKyS5jQhQ/v/oxih7c3PdKVn8hAAtjLQ0+yG041ZyNw/DQZt9ls5fzw==;
 7:kKlfewkKq5hdhVJmLe6slDFKI3bHu+Ju1xqK3GO0lW/KRJoiQa8Km7Kz4bYBs7A5xltbNCgg6QrOb61D8ZGUoHqtkzfXayIgXyjVrAR+y+Y4PKj/SWKRaOvL+rSoJnr+JTakCI8DlpfUl5VCQfmX7A==
x-ms-office365-filtering-correlation-id: ade7bc4c-e357-4d4c-4f32-08d68c396e36
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1982; 
x-ms-traffictypediagnostic: MWHPR11MB1982:
x-microsoft-antispam-prvs: <MWHPR11MB1982735AED30D6AAB0A27D54876F0@MWHPR11MB1982.namprd11.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(72206003)(36756003)(486006)(6436002)(6306002)(6512007)(256004)(76176011)(53936002)(31696002)(52116002)(86362001)(2201001)(11346002)(305945005)(105586002)(6246003)(26005)(6506007)(6116002)(229853002)(106356001)(446003)(476003)(6486002)(53546011)(186003)(386003)(31686004)(2616005)(102836004)(66066001)(7736002)(316002)(2501003)(110136005)(2906002)(8676002)(71200400001)(71190400001)(478600001)(68736007)(8936002)(3846002)(81166006)(81156014)(966005)(93886005)(99286004)(97736004)(14454004)(25786009)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1982;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0igF9Gho+VVLJZ6VTbv9XWyYMd9a+eEM0s0RVL5D+IMa5kHC6kwYGbIj13Jwi/OsFQKZFrEc3WEI8+f3bzJfp8yk6WiZ/g4TSd2CFmqSKt/xc8L33/sQmf+VUDwTF0aYGsYJA+cXzjRnzj+bG+6ap/iiWrD5PYyjEeAtE9SjmuHqREK4lnQl7pMiU9gPYOXhhohnkrmj7Ek4oUhnowZKCc9tshpxbB3cD3ajT3Fjj0a8t8kvgsYCweqXGkpsZCSaFWskxmKpo/4QLf1rty7+raC+g0m85MXyiu51Dyx0MyacRs9y2pbt0KvS/SSLBYud0OVHz7HaRUVDYbbU9NdvlowHOPwKDF1S8K9oNUFlRgMiqrxsZ9Asv+39fbCdlEgQHUwpzdoWWwZj3WUq3k//UwFbW1hzGxAzEmfvXkREwIc=
Content-ID: <85B05BE69312EF4B81D66117CB99F4F1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ade7bc4c-e357-4d4c-4f32-08d68c396e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:45:57.4782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1982
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_054609_563350_CAD2489E 
X-CRM114-Status: GOOD (  17.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 06.02.2019 12:24, Ludovic Desroches wrote:
> On Wed, Feb 06, 2019 at 09:46:28AM +0000, Claudiu.Beznea@microchip.com wrote:
>>
>>
>> On 06.02.2019 10:13, Ludovic Desroches wrote:
>>> On Thu, Jan 31, 2019 at 05:18:04PM +0100, Claudiu Beznea - M18063 wrote:
>>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>>
>>>> SAM9X60 uses high and low drive strengths. To implement this, in
>>>> at91_pinctrl_mux_ops::set_drivestrength and
>>>> at91_pinctrl_mux_ops::get_drivestrength we need bit numbers of
>>>> drive strengths (1 for low, 2 for high), thus change the code to
>>>> allow the usage of drive strength bit numbers.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>> ---
>>>>  drivers/pinctrl/pinctrl-at91.c | 32 ++++++++++++++++++++------------
>>>>  1 file changed, 20 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
>>>> index 3d49bbbcdbc7..31f06dafca2e 100644
>>>> --- a/drivers/pinctrl/pinctrl-at91.c
>>>> +++ b/drivers/pinctrl/pinctrl-at91.c
>>>> @@ -72,10 +72,15 @@ static int gpio_banks;
>>>>   * DRIVE_STRENGTH_DEFAULT is just a placeholder to avoid changing the drive
>>>>   * strength when there is no dt config for it.
>>>>   */
>>>> -#define DRIVE_STRENGTH_DEFAULT		(0 << DRIVE_STRENGTH_SHIFT)
>>>> -#define DRIVE_STRENGTH_LOW          (1 << DRIVE_STRENGTH_SHIFT)
>>>> -#define DRIVE_STRENGTH_MED          (2 << DRIVE_STRENGTH_SHIFT)
>>>> -#define DRIVE_STRENGTH_HI           (3 << DRIVE_STRENGTH_SHIFT)
>>>> +enum drive_strength_bit {
>>>> +	DRIVE_STRENGTH_BIT_DEF,
>>>> +	DRIVE_STRENGTH_BIT_LOW,
>>>> +	DRIVE_STRENGTH_BIT_MED,
>>>> +	DRIVE_STRENGTH_BIT_HI,
>>>> +};
>>>> +
>>>> +#define DRIVE_STRENGTH_BIT_MSK(name)	(DRIVE_STRENGTH_BIT_##name << \
>>>> +					 DRIVE_STRENGTH_SHIFT)
>>>>  
>>>>  /**
>>>>   * struct at91_pmx_func - describes AT91 pinmux functions
>>>> @@ -551,7 +556,7 @@ static unsigned at91_mux_sama5d3_get_drivestrength(void __iomem *pio,
>>>>  	/* SAMA5 strength is 1:1 with our defines,
>>>>  	 * except 0 is equivalent to low per datasheet */
>>>>  	if (!tmp)
>>>> -		tmp = DRIVE_STRENGTH_LOW;
>>>> +		tmp = DRIVE_STRENGTH_BIT_MSK(LOW);
>>>>  
>>>>  	return tmp;
>>>>  }
>>>> @@ -564,7 +569,7 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio,
>>>>  
>>>>  	/* strength is inverse in SAM9x5s hardware with the pinctrl defines
>>>>  	 * hardware: 0 = hi, 1 = med, 2 = low, 3 = rsvd */
>>>> -	tmp = DRIVE_STRENGTH_HI - tmp;
>>>> +	tmp = DRIVE_STRENGTH_BIT_MSK(HI) - tmp;
>>>>  
>>>>  	return tmp;
>>>>  }
>>>> @@ -600,7 +605,7 @@ static void at91_mux_sam9x5_set_drivestrength(void __iomem *pio, unsigned pin,
>>>>  
>>>>  	/* strength is inverse on SAM9x5s with our defines
>>>>  	 * 0 = hi, 1 = med, 2 = low, 3 = rsvd */
>>>> -	setting = DRIVE_STRENGTH_HI - setting;
>>>> +	setting = DRIVE_STRENGTH_BIT_MSK(HI) - setting;
>>>>  
>>>>  	set_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin,
>>>>  				setting);
>>>> @@ -959,11 +964,11 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
>>>>  	}					\
>>>>  } while (0)
>>>>  
>>>> -#define DBG_SHOW_FLAG_MASKED(mask,flag) do {	\
>>>> +#define DBG_SHOW_FLAG_MASKED(mask,flag,name) do {	\
>>>
>>> checkpatch error: space required
>>
>> I'm aware of that but I added it in the way it was previously (were the
>> checkpatch error was still present). Please let me know if you want me to
>> send a new version fixing this.
> 
> I think it's the opportunity to fix it. If you can resend a new version
> including my ack.

Sure!

Thanks,
Claudiu

> 
> Regards
> 
> Ludovic
> 
>>
>> Thank you,
>> Claudiu Beznea
>>
>>>
>>>>  	if ((config & mask) == flag) {		\
>>>>  		if (num_conf)			\
>>>>  			seq_puts(s, "|");	\
>>>> -		seq_puts(s, #flag);		\
>>>> +		seq_puts(s, #name);		\
>>>>  		num_conf++;			\
>>>>  	}					\
>>>>  } while (0)
>>>> @@ -981,9 +986,12 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
>>>>  	DBG_SHOW_FLAG(PULL_DOWN);
>>>>  	DBG_SHOW_FLAG(DIS_SCHMIT);
>>>>  	DBG_SHOW_FLAG(DEGLITCH);
>>>> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_LOW);
>>>> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_MED);
>>>> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_HI);
>>>> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(LOW),
>>>> +			     DRIVE_STRENGTH_LOW);
>>>> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(MED),
>>>> +			     DRIVE_STRENGTH_MED);
>>>> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(HI),
>>>> +			     DRIVE_STRENGTH_HI);
>>>>  	DBG_SHOW_FLAG(DEBOUNCE);
>>>>  	if (config & DEBOUNCE) {
>>>>  		val = config >> DEBOUNCE_VAL_SHIFT;
>>>> -- 
>>>> 2.7.4
>>>>
>>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
