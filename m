Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6DDC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D92F2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZzlwPRA1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="g30sn5Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D92F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qImbMVC20m7+mM19XYWDmLMd7sVc6jJ59gqTYaErruU=; b=ZzlwPRA1mSI1SG
	wzVBNzbmaDaBYYL5NjV+Cfrj1n26YXeQuf+mWpDsznFJC3uoTp8KocgfH6p7uw5rHc5Fl8G3xXZD2
	oioFeMzt06IjJP11oXRgkSde9mHt1mTXuujeCtSJLIiuUcURQjro/xilQByK/uQcLFjlhX00xOagd
	8kccWdb1tiswk97Wi3rdbUE8Rh5hWYTuFd3kKpXPR74RybMTE1jmsDQBXSRQ7AZv7681NVsJMh7G8
	iZbgHMvs8lPkMW0ZAFS4NEs/kwyjRYpN4YPUj1dVf/L9vzAMHx3JDzD5Q0LNrAGT4WtNVNWqqHKyp
	ieWS/0XY8Nmpxq20rvvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF4m-0008SZ-J6; Thu, 31 Jan 2019 16:20:28 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF1S-0004HU-Au
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:18:15 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="23261674"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:16:58 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 09:16:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBGq+zsGdOaszg0yHR++8U7etUaPSN+Gqvg6/jv1m/0=;
 b=g30sn5Ovwv/CegZnZ6SpLfKXUoHHVeXhK2xnN0clDz1mweV2324e8HVEWzgpBBCLkM6Y+tw2xf0eh4vgn0ucLRtvi0nKts7WukDjULwMGWoiaKOfFZNOslNwAhw8B1dSm2xG/sOyVhuIJTBMLxQIJc67hpuey7jB6JeDLtJXnS8=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB0014.namprd11.prod.outlook.com (10.164.204.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:16:19 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:16:19 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Topic: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Index: AQHUuWCeSP4bG3gsKk+RqaWqwuohGKXJT34AgAA+TYA=
Date: Thu, 31 Jan 2019 16:16:18 +0000
Message-ID: <e23b96ad-b920-4caf-d774-2c5c43d7cea8@microchip.com>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
 <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
 <20190131123310.wwikkuiniqlcg445@M43218.corp.atmel.com>
In-Reply-To: <20190131123310.wwikkuiniqlcg445@M43218.corp.atmel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0153.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::46) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190131181609549
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB0014;
 6:omJWTxoehvq9rQpgxkuhtHv0ern/X2+euoVxzpsBeehBXM099eVdXdlbAQhZCX3imZEVqGWTYmss+88q4Tzm9WHm9M3TKDMKf2OInNdWPNfC3VKEpY5Q/QKNqy919Raj0vhB40s9Niwh/p8LShwiGEBnnVCt7zr2/tUdi0oNPBSZc4rrjIFD4qmxWUUjKNXFLNb4vMi7BGIJWP2QuSIYq84vsXLimCIr0kJoipHqt/ISRgg58gUaHomfrdEKJu6s0vFsuztQrv4wnHpw5wGD95xI+TMOpnOK05blApLe3ZzFesX4Egt0py5lTpPzikcGZp6+U+vuXlWURL4JByNNQ3Z4WOFTiBv4O4kc3r9H32/Vd1VHwH9kAIWaqqdvxFvonh7Vvo/kCq4/76h/lDWGKZjs2QwcZU2SROnV19fxXG8/6+vtB8ekWc2uiQcgO4qP9OC1FAMbA+Qu9MXJxOFP9A==;
 5:t08d3Rql5ao4wNlz+j7Q0Ujb0KSjnW0WY22K/dK/eDMYqELmYcAs+jynISZbBJqlI+5351e3ZWTE8RGiqaQm80MTGicDWBesBoA5X0IMJDBPIsk/J9iqgV00zI2INw4lkm9cbxuOXm6xiviXEkTud5jqQGlhJevanhQmJHD5BXol66BkaAk6a/R+hmAGR/n7lshia+mjW/87F1DfyQXiOA==;
 7:A7kVjNiS+ixlJQSTbvEpuoEz9vRJ4FHo7hOBCR2Scce3o+RqB/rL2pIuN1DAd9+rDkEqJGIZZv1jOsy+B8nAwuG+1KrnaRB2PzKKoU3UZvOXvQvQ5dlAeqZMXhwIsE9OLNSo5gVLuLme6HsMts/Vug==
x-ms-office365-filtering-correlation-id: b6357e5b-587c-4754-616b-08d687976ea5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB0014; 
x-ms-traffictypediagnostic: MWHPR11MB0014:
x-microsoft-antispam-prvs: <MWHPR11MB0014556E5D4EEA3C0EF89BD987910@MWHPR11MB0014.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(366004)(199004)(189003)(6436002)(36756003)(6512007)(305945005)(256004)(6486002)(446003)(99286004)(6116002)(3846002)(7736002)(2906002)(2501003)(316002)(476003)(110136005)(478600001)(72206003)(76176011)(102836004)(11346002)(6506007)(25786009)(53936002)(53546011)(68736007)(71200400001)(2616005)(6246003)(386003)(229853002)(106356001)(8936002)(71190400001)(186003)(31696002)(31686004)(486006)(86362001)(2201001)(81166006)(81156014)(14454004)(26005)(52116002)(105586002)(97736004)(66066001)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB0014;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oy9K1QzGKcRaUXpBwrZppLPi8iuvrxe75lQSvebwxJxgKzO1VqxXwlsvx1oJZky90wWlj2E7sIZt9KxU22SYWqlkHQroLD4CmabindrU+oyH1BgC7piK5beuxvs3CnV25Snv6Kkv1oD/+IMIMAyu9JXpSRjCHBsjLj3je2Ocn1+WC3tNvWIZQR3Wx4/v/UbH4l8vp3vPTDfxL3koL3adwr44/DTx/ELXk2HpcyZPm+ldW31wK9jIcWwmyUanUZPZp79cz6R36VIyQPE/Djh9M0RZ9zDg2NRBAUQL7Iq139okBbqXym6bm70TrpYXHszmWXYfrFt9A5Mp8drC8p4Q0DKA+Gjcvi7opyTKJ1NOXYf+BICZU6SXMAa6iPt9EWlZOcwu0goexyw/Srh+md4noDfNmDu3PyuEN0MfvdQXnro=
Content-ID: <F481A476EBBBAA4DBE1912293A56F57D@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6357e5b-587c-4754-616b-08d687976ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:16:15.2900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0014
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081702_843014_E2B8EF14 
X-CRM114-Status: GOOD (  11.34  )
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



On 31.01.2019 14:33, Ludovic Desroches wrote:
> On Thu, Jan 31, 2019 at 01:29:33PM +0100, Claudiu Beznea - M18063 wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Add compatibles for SAM9X60 pin controller.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/pinctrl/pinctrl-at91.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
>> index 46443b97d811..5456a2692b8c 100644
>> --- a/drivers/pinctrl/pinctrl-at91.c
>> +++ b/drivers/pinctrl/pinctrl-at91.c
>> @@ -1215,6 +1215,7 @@ static const struct of_device_id at91_pinctrl_of_match[] = {
>>  	{ .compatible = "atmel,sama5d3-pinctrl", .data = &sama5d3_ops },
>>  	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
>>  	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
>> +	{ .compatible = "microchip,sam9x60-pictrl", .data = &sam9x60_ops },
> 
> Typo s/microchip,sam9x60-pictrl/microchip,sam9x60-pinctrl

Thank you, Ludovic! I'll send a v2.

> 
>>  	{ /* sentinel */ }
>>  };
>>  
>> @@ -1757,6 +1758,7 @@ static const struct gpio_chip at91_gpio_template = {
>>  static const struct of_device_id at91_gpio_of_match[] = {
>>  	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
>>  	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
>> +	{ .compatible = "microchip,sam9x60-gpio", .data = &sam9x60_ops },
>>  	{ /* sentinel */ }
>>  };
>>  
>> -- 
>> 2.7.4
>>
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
