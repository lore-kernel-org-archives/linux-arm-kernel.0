Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C5AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:46:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114CB218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uRmduZbQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TPn/Y8UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114CB218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qC82UycWocDvEn+i+tpuxqyk+6GQqxwabzsh22dAO4g=; b=uRmduZbQeijJWl
	+yghGOOgSutvYIwnVN7PoTqIQYiiOdQCvxp2nMy0c3zxim/lZKAueZ0313m+i8xcBR56Mv4qwpCvx
	bLrst/X3CDO4Eb2kZFqtpKS+Ddv1XDPd7ZXK78Whzf/I/r+rt2Vcqla2Y/cSjVwxlLkkaBze2RqMp
	3AF4QM74IdrdPrvl/Ec8kZjk3PyxYLqSK7guryaDVe7NdMGS8u0tzB39nWv8Ep7x6fPclhDrdPC1u
	C00OcyWLw2EZwP5kYKDDY9RZqY8SGmqwd6XhMCNFWDk5dNlBYIyzahgaHdmPoxUB5VXdiUtXqDodi
	/uyoDeXMzNLPrTa/jWFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJmw-0005nY-S8; Wed, 06 Feb 2019 09:46:38 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJmr-0005mn-N4
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:46:37 +0000
X-IronPort-AV: E=Sophos;i="5.58,339,1544511600"; d="scan'208";a="25905709"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 06 Feb 2019 02:46:31 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 6 Feb 2019 02:46:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4EO6iRQYmYFszQtcqFjJxO8U4by9QSUMfqSkX/THpo=;
 b=TPn/Y8UUSDLbX4C2x9r9KSIsymJ7pZC/ovJsfTKsUOGr2bcZgvg2zuYeLJ3AW3cp4My4P8eQK+3WuHiN5QqCJDaxMN20qv5onCYxFFJk8Ii1A+aog7+TV3SJy+AOCVCB5ZOsjK5W//ZJFQ43yghs6rEnyYsuGhdeo7iCOuObSXQ=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1310.namprd11.prod.outlook.com (10.169.237.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 09:46:28 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Wed, 6 Feb 2019
 09:46:28 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Topic: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Index: AQHUuYCLA9fU9IUpL0SQqk5ieOzKJqXSdJAAgAAaDAA=
Date: Wed, 6 Feb 2019 09:46:28 +0000
Message-ID: <f0022bfc-6deb-de77-857c-c70d41f4fc78@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
 <1548951466-26297-2-git-send-email-claudiu.beznea@microchip.com>
 <20190206081304.cv344rjzvz7wzih5@M43218.corp.atmel.com>
In-Reply-To: <20190206081304.cv344rjzvz7wzih5@M43218.corp.atmel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:803:14::32) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190206114618544
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1310;
 6:ewJyLSB6+U9/6DmF9FgP8Zwa3USTM7FJv4X5YqpXYrLv5KyznhR9Piclw321PypAuP8Ig/qAQ3sDYySrlpU2P2TiOvtkwmvOB4ux8R/qItNYk7JTMI9eoTsI5r5LTVI51zdweZ7TwxmzogSJoSTZk3qatTrxjtXlkItxIwSRCX+jZuO7MDHMxNPsHDX7mm/4mX1Qcj139BmZ7PFA5DWm3dodNEGzgLd8Wfty5P1kve3v+MPb30eeEGYLFvKdbMENajCj6wiVl8HFZdFI4uR5kCPOV6CPwuuxfs9apcv3eRv7wm1JLT4v9/4/FtGKeDjenTM3yYHZtfRdGZk/h0HjV08x6CyTImM2bZBQJjrnT6vFh28fXjekQfULGUqt6Mcr2S0WcFwzY3X0zNPaKPb+JqMZRG/7EnIz4Rb1Bcg3SG5HKyN1IUo7yyb1VhurSGG0ACRR/ZQWhRgKxs9VAZVIXw==;
 5:UNMXwIPgHYrscCZjotru5R+UzTTS3C61rarsiACdPtkD0zQfFewibePK8luWZwBYUmi77gIC5pGCgEHyJUU4+KUaA8/Eh9mHtT5kcl+iqUu9IJw1BVt0+aJBI2iMqSBFtycJ6AaEo4U0DFOwOOFZ1++cXlWIUUffKxF/jcHlRZdXlBWYdWkgsgnzBPM22mS8VMbMwf3tw7poX8lRcn/7QA==;
 7:cHFvdQE3BmP87BM0/ZIRlcw4bPeFtNhspP3ECtKzFo8mjqjsBcqE5qr1iIezxUfra0/N6xr2Ajd66Xt0+iB7TGuvHkUOfVF0lxLgzoz4OAnBKIwVkFH8p46r+wBq6Z0eq5wFaOvgKjXlpTw/k14hUQ==
x-ms-office365-filtering-correlation-id: fa0a0820-9705-4b64-e0fc-08d68c17f73f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1310; 
x-ms-traffictypediagnostic: MWHPR11MB1310:
x-microsoft-antispam-prvs: <MWHPR11MB1310676546170F4858C6D604876F0@MWHPR11MB1310.namprd11.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(6486002)(71200400001)(229853002)(99286004)(52116002)(2201001)(71190400001)(6436002)(106356001)(305945005)(68736007)(66066001)(316002)(76176011)(31696002)(2906002)(110136005)(86362001)(2501003)(256004)(97736004)(36756003)(26005)(186003)(7736002)(14454004)(3846002)(6116002)(102836004)(53546011)(386003)(6506007)(31686004)(486006)(476003)(2616005)(11346002)(6512007)(105586002)(446003)(81156014)(81166006)(25786009)(8676002)(53936002)(6246003)(72206003)(8936002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1310;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pMQyPMNYsx0KazrG4wKVu/P7GZ9Z5qTOjw0zyugJ90SaTIg9VofRmDEc3t6GoAR2/izG5BrFNdoStUpbq8+9kyoMpKfe25gSLY/Gya25pZShqhE1po7l7r38IZ56aYJqsZrwZj9anYQL/TTXjJ9Kum86n90o/FW6awuZ4qhwmKURhr1eGCT2nX28fqja9fHwvnvxxpKqaIuJmNR206Arl5Vuu0czIRn1+e2Uvs9eRLIeFEhDXNKogmKns7BBV2+O8WqDjbtDDjT3SZKLNTHZmGj0+c9LkZ64ptRWRZUxcUWKn9Vbm1KwKalw77ZQR4LAIu5CN4FCGJmX6WN2jeymsVpUl7HsTbdiV6f6Y/x3hc+0upx2uVU+QV0MkKgp9KA89CVS0wlHUN3NWap7FRuu7mcDPZ25If7C/KsnRwd4vHU=
Content-ID: <4C770342E8E3C249B19C195ADB94C3BA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a0820-9705-4b64-e0fc-08d68c17f73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 09:46:24.5501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1310
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_014633_785653_A2858C40 
X-CRM114-Status: GOOD (  14.92  )
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



On 06.02.2019 10:13, Ludovic Desroches wrote:
> On Thu, Jan 31, 2019 at 05:18:04PM +0100, Claudiu Beznea - M18063 wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> SAM9X60 uses high and low drive strengths. To implement this, in
>> at91_pinctrl_mux_ops::set_drivestrength and
>> at91_pinctrl_mux_ops::get_drivestrength we need bit numbers of
>> drive strengths (1 for low, 2 for high), thus change the code to
>> allow the usage of drive strength bit numbers.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/pinctrl/pinctrl-at91.c | 32 ++++++++++++++++++++------------
>>  1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
>> index 3d49bbbcdbc7..31f06dafca2e 100644
>> --- a/drivers/pinctrl/pinctrl-at91.c
>> +++ b/drivers/pinctrl/pinctrl-at91.c
>> @@ -72,10 +72,15 @@ static int gpio_banks;
>>   * DRIVE_STRENGTH_DEFAULT is just a placeholder to avoid changing the drive
>>   * strength when there is no dt config for it.
>>   */
>> -#define DRIVE_STRENGTH_DEFAULT		(0 << DRIVE_STRENGTH_SHIFT)
>> -#define DRIVE_STRENGTH_LOW          (1 << DRIVE_STRENGTH_SHIFT)
>> -#define DRIVE_STRENGTH_MED          (2 << DRIVE_STRENGTH_SHIFT)
>> -#define DRIVE_STRENGTH_HI           (3 << DRIVE_STRENGTH_SHIFT)
>> +enum drive_strength_bit {
>> +	DRIVE_STRENGTH_BIT_DEF,
>> +	DRIVE_STRENGTH_BIT_LOW,
>> +	DRIVE_STRENGTH_BIT_MED,
>> +	DRIVE_STRENGTH_BIT_HI,
>> +};
>> +
>> +#define DRIVE_STRENGTH_BIT_MSK(name)	(DRIVE_STRENGTH_BIT_##name << \
>> +					 DRIVE_STRENGTH_SHIFT)
>>  
>>  /**
>>   * struct at91_pmx_func - describes AT91 pinmux functions
>> @@ -551,7 +556,7 @@ static unsigned at91_mux_sama5d3_get_drivestrength(void __iomem *pio,
>>  	/* SAMA5 strength is 1:1 with our defines,
>>  	 * except 0 is equivalent to low per datasheet */
>>  	if (!tmp)
>> -		tmp = DRIVE_STRENGTH_LOW;
>> +		tmp = DRIVE_STRENGTH_BIT_MSK(LOW);
>>  
>>  	return tmp;
>>  }
>> @@ -564,7 +569,7 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio,
>>  
>>  	/* strength is inverse in SAM9x5s hardware with the pinctrl defines
>>  	 * hardware: 0 = hi, 1 = med, 2 = low, 3 = rsvd */
>> -	tmp = DRIVE_STRENGTH_HI - tmp;
>> +	tmp = DRIVE_STRENGTH_BIT_MSK(HI) - tmp;
>>  
>>  	return tmp;
>>  }
>> @@ -600,7 +605,7 @@ static void at91_mux_sam9x5_set_drivestrength(void __iomem *pio, unsigned pin,
>>  
>>  	/* strength is inverse on SAM9x5s with our defines
>>  	 * 0 = hi, 1 = med, 2 = low, 3 = rsvd */
>> -	setting = DRIVE_STRENGTH_HI - setting;
>> +	setting = DRIVE_STRENGTH_BIT_MSK(HI) - setting;
>>  
>>  	set_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin,
>>  				setting);
>> @@ -959,11 +964,11 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
>>  	}					\
>>  } while (0)
>>  
>> -#define DBG_SHOW_FLAG_MASKED(mask,flag) do {	\
>> +#define DBG_SHOW_FLAG_MASKED(mask,flag,name) do {	\
> 
> checkpatch error: space required

I'm aware of that but I added it in the way it was previously (were the
checkpatch error was still present). Please let me know if you want me to
send a new version fixing this.

Thank you,
Claudiu Beznea

> 
>>  	if ((config & mask) == flag) {		\
>>  		if (num_conf)			\
>>  			seq_puts(s, "|");	\
>> -		seq_puts(s, #flag);		\
>> +		seq_puts(s, #name);		\
>>  		num_conf++;			\
>>  	}					\
>>  } while (0)
>> @@ -981,9 +986,12 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
>>  	DBG_SHOW_FLAG(PULL_DOWN);
>>  	DBG_SHOW_FLAG(DIS_SCHMIT);
>>  	DBG_SHOW_FLAG(DEGLITCH);
>> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_LOW);
>> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_MED);
>> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_HI);
>> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(LOW),
>> +			     DRIVE_STRENGTH_LOW);
>> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(MED),
>> +			     DRIVE_STRENGTH_MED);
>> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(HI),
>> +			     DRIVE_STRENGTH_HI);
>>  	DBG_SHOW_FLAG(DEBOUNCE);
>>  	if (config & DEBOUNCE) {
>>  		val = config >> DEBOUNCE_VAL_SHIFT;
>> -- 
>> 2.7.4
>>
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
