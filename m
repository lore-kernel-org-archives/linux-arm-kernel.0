Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F89C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:18:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7E120818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nov6pf53";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="krsRwCIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7E120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tltgBzOZM2gidfa1uLYeKXSkDmwVZc1y9ulVLCGDZs8=; b=nov6pf53fwasp7
	fhC8KYNy9OFSVX0vKyMvlRJFBfRXGqJVPBmE3mA1utiGHftH3cx9gO4Gj1GxAaPV9fx1InSAZ6cJ2
	PPU9ZvAHAPH/kXYlzRpbKWGOolZOpampbkPJq1eTsTGYIk4K0TxZ40PMW3q/Ia7OrtA96RlSwx7/z
	QQXRuWKwDUeSSx3Wr74i3ZaGS7Qljcom5Qf/Is1y0cXlNGZDgiWmlZfNKN3wRemi0Ih4B5f0P1CBi
	BDysuy7MSRJPL4tk0Jk5GRWYRms0WULG/p71gCLPJOKs2s1DOAh1vHNdMF08nWE2PMww7RidRhqIL
	T2sBaNbzMKlXr74/IINA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1YE-0008P8-1O; Tue, 19 Feb 2019 09:18:54 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1YA-0008Oc-Mz
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:18:52 +0000
X-IronPort-AV: E=Sophos;i="5.58,387,1544511600"; d="scan'208";a="24881806"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 19 Feb 2019 02:17:46 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 19 Feb 2019 02:17:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF/cZJA+noV/VgOqQqn7GVYxuPexDJ0GlRMK0UQ8gGo=;
 b=krsRwCIj1Uk6qNLEWkhSbDRW4MpBBkMSIZdnEs1av5tjUuODzERF6ZFYZiGGuopA5uXeckY4ERH0lsuhiNk/BR0vyP3HDJjFzmWo1A/EgiWCtI11Gw5NflB5r/Eyl0+8qr+YASRUhMfmIF9mMFtPsFdWwkYXPKZG9QQftnG70cM=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1352.namprd11.prod.outlook.com (10.169.254.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 09:17:43 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 09:17:43 +0000
From: <Claudiu.Beznea@microchip.com>
To: <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Thread-Topic: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Thread-Index: AQHUxF7XgscBW81rJUmiAtq1msPxS6XmFrOAgADIdYA=
Date: Tue, 19 Feb 2019 09:17:43 +0000
Message-ID: <c00fb195-1688-6ac4-a606-5e08509a2c39@microchip.com>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
 <20190218212007.GW10129@piout.net>
In-Reply-To: <20190218212007.GW10129@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0322.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::22) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190219111735557
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e4f86d-2b75-47f5-eac8-08d6964b1a93
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR11MB1352; 
x-ms-traffictypediagnostic: CY4PR11MB1352:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjExTUIxMzUyOzIzOnBsa09SR1Q5OGZTT1JudGNyZkRIOFk4MDV1?=
 =?utf-8?B?NEJxQUg2Ulh2akFFN2UyWWxvSjZNWVBlbWNVN3FRTmc5ODArR2NhUHBWYWxT?=
 =?utf-8?B?VkpQbW0xYVJ6N1ZER3BqU3pXT1FCYVFVL2FCcXZObDRIWXpQa01DL0tEZU9p?=
 =?utf-8?B?S0tWZk5wVXEwSDdCUkI2eXhKYTdjT2FaT0tVSFlmdkNMVEM2L3djM2pveTlw?=
 =?utf-8?B?NFRYUUFVelZmUWhHTG9GbG85T0lVVWt1OWJPVHp6K1A1Q05TSDY3WUJIUTFv?=
 =?utf-8?B?OHRxYlFJZi9ZeTYzQjFNclpYeVlUazFHSHhnVWdXTXV3QmJrWmN5ellyYmtz?=
 =?utf-8?B?RHlYakdjRkVwSktnRDZNeVNvZ3BUSXpjSU9vMFgzVVFvMmNvQk0wTHRldm9N?=
 =?utf-8?B?UFJLczVuQjM5UTgra0hnNzE2SHhGWjhMeGkycDhTZTNRSW1KYjdjcy93a2ds?=
 =?utf-8?B?LzRpd28zZmRXdHE4V3ZNaVNPT3JaYWZJODFYaUo1aWRwYWNBeGxlajc3M0JP?=
 =?utf-8?B?NVhwNmJ0dTlYK2V2aVFrdGg1K2dzSTdlejU5bVBldVV1TGRKMmIxa2VBQjNW?=
 =?utf-8?B?NmxmMkhkZzRtYXQ4VlppVEJBcXBGV0FWV0h6amlqWkMzbTNBdnhjVkxBdGF1?=
 =?utf-8?B?MEpETzVNRDA4SUVYckpMejdFbjVoRWMwNjZXSUhmRm9YdnFxeFQzaS95bWNi?=
 =?utf-8?B?S1l0UWx0TGVuQVlZSkFIbmw5MU1iZzVkNlQ5WEdIZEhMUm50dy93NnVPQmtI?=
 =?utf-8?B?S0xFUjRSOXd6TTA2bC8zQ0ZTdTV3TFN5SjgvQ3Q0a3RveUJ6eklCbGYyWW5l?=
 =?utf-8?B?clFZbWlUOEhLM1FKeGx5c21zWTBWMDZEcm15QVhvQm11bkprNDdxaGoxNmhX?=
 =?utf-8?B?VktxaVVKbHpGWlQ5N2ZlVlFEaExtcndhL0k3aVJJYS9Ram9GUWlHcHBQMGlS?=
 =?utf-8?B?ZzUxemlab3BkZUlFS3ZDRDJjOU5UcEhGZWtqYlZIQVlyWUc4bSsyeG1pU0Ji?=
 =?utf-8?B?YVdjVVhnMG9tb25UUGlRNUoxL1REbjgyYWx1dytaUXZZV1FUdWlwSXJCalVW?=
 =?utf-8?B?YU0yTndpWDhqWGNIWEV4OEttUFVWdE5rRDBKQ2pDbTZEN3orclpQVzdBd1VX?=
 =?utf-8?B?QVVBdkVQWXgwUmxIWTdqWjJxdEJtWjMxcUsvc3hXNVhOaGxCQUsrUVpWZ2lX?=
 =?utf-8?B?N3l0YmRJU29raWREdXZIQ2RZZ3J2QU9JMk9PTFRodUlxYTlLN2ZjbDdhb214?=
 =?utf-8?B?cHJDRXZBQmRqeHFhVnZ4WTdURTR0Q3NtWkF2N1VUa2I1dnBSbWVVdTRRMlVw?=
 =?utf-8?B?b2hsWnZhNjlqZFB4SnRGQU1jdk9nSXpZSVJOM0NDYkg1aTQ3ZXphT1pyeGU4?=
 =?utf-8?B?NTgrN3diWWhYZVdlRUFpY2xnckN3dnhac0JxRzRERTBzVTkzTnVzQkNNczV1?=
 =?utf-8?B?TzBEcU1ybjNoNk5TN1plM3FKT01TdFJHODhQeGhrbDdNNGVDZnpHcE9qUjgv?=
 =?utf-8?B?SWtqcUdHWWRiQmxXOVY5Q3BaalllS1poc1hOUEE3QWc5V3hDTlJMNEJBM2dE?=
 =?utf-8?B?dTJnb2RiK2Q5VVpRVTdrR3g4azlnK09rekx4WDB5OFEvVXNrbHR5Ni9ydWc2?=
 =?utf-8?B?dnF6bk5hRjRmNkwycWJIMDg4aXU3bzNlQUxKWG52VGh1Um1WQjkrTTZRa0ZC?=
 =?utf-8?B?OW1tWDNHcFJmY2NDNlV0eE1DcjcyMldNNkZHYm9XSlVnbzYyRXJORmM5QWFV?=
 =?utf-8?B?djdkN29CbUxvdWZzL3pDdz09?=
x-microsoft-antispam-prvs: <CY4PR11MB1352F0ACC91AB348496F0E49877C0@CY4PR11MB1352.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(11346002)(446003)(2616005)(7736002)(476003)(102836004)(52116002)(486006)(76176011)(99286004)(26005)(6506007)(53546011)(186003)(305945005)(386003)(6916009)(2906002)(81166006)(81156014)(31686004)(105586002)(8676002)(36756003)(8936002)(106356001)(86362001)(31696002)(256004)(6436002)(6486002)(25786009)(6246003)(71190400001)(4326008)(72206003)(71200400001)(6512007)(5660300002)(316002)(53936002)(6116002)(14454004)(478600001)(3846002)(97736004)(68736007)(66066001)(54906003)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR11MB1352;
 H:CY4PR11MB1909.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qoe2uhly3uFK6jbHFC9Vkehgeh8QE+MYrGhfStssOiyXpUIHMBJo6RSvfGvPUd36uDTy6QXZUYJ8+MiY6tFLTL0j24ekhU7iHDyDXxRS8WYayMI6kEU+pkfInCeoSyhCWfAOkkMkLT5Kk4Pv00xlOMBg0TxH2lpjmk1NP1pbVF7VGWt/5LzevEEqqno4pB7blVsC2EV2LKr6n1bKBf5mYn1eJMLjgZFvMZSwwNNFA/b/B8TJgZXvjtffFm6WE+mWF6q/S3gwxOQj0ApC7gdYxHEXhBOvo8supKd1cgKwTow4vRM0h6wtTT+P/tafztisvpGeOLx2+pYpUmPMgLrbyufFmenwKUFv+i1IQ1VbMS90BkzStOgrgT2JXOULKlJKKbwfwDLtsTzzbozeFhPNFXXFNTHOM+tEtxXL1wPmaCw=
Content-ID: <295E9E7462964B43873190813069E9E3@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e4f86d-2b75-47f5-eac8-08d6964b1a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 09:17:40.6617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1352
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_011850_867482_B1112E35 
X-CRM114-Status: GOOD (  20.03  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18.02.2019 23:20, Alexandre Belloni wrote:
> On 14/02/2019 12:14:32+0000, Claudiu.Beznea@microchip.com wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Add support for SAM9X60.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/clk/at91/sckc.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
>> index b7163d3a2269..b3075c51d260 100644
>> --- a/drivers/clk/at91/sckc.c
>> +++ b/drivers/clk/at91/sckc.c
>> @@ -459,6 +459,36 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
>>  	       of_at91sam9x5_sckc_setup);
>>  
>> +static const struct clk_slow_offsets at91sam9x60_offsets = {
>> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
>> +	.cr_osc32en = 1,
>> +	.cr_osc32byp = 2,
>> +	.cr_oscsel = 24,
>> +};
>> +
>> +static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
>> +{
>> +	struct device_node *childnp;
>> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
>> +			  const struct clk_slow_offsets *offsets);
>> +	const struct of_device_id *clk_id;
>> +	void __iomem *regbase = of_iomap(np, 0);
>> +
>> +	if (!regbase)
>> +		return;
>> +
>> +	for_each_child_of_node(np, childnp) {
>> +		clk_id = of_match_node(sckc_clk_ids, childnp);
>> +		if (!clk_id)
>> +			continue;
>> +		clk_setup = clk_id->data;
>> +		clk_setup(childnp, regbase, &at91sam9x60_offsets);
>> +	}
> 
> You actually need to have new bindings. The sam9x60 registration should
> look more like the sama5d4 registration. I have a rework for the sam9x5
> sckc that I will send this week to have a proper binding (i.e: no
> children).

Does this means that this would also solve the problem I tried to address
with this patch?

> 
> However, there is a fundamental change in the sam9x60, previously, the
> sckc had only one output clock. the sam9x60 has both td_slck and
> md_slck. Both need to be accessible because they are input to the PMC.

I was guided by the fact that md_slck is generated by the always on slow RC
oscillator (part of slow clock controller) and since there is no control
for it on slow clock controller there is no need to be described by this
driver.

> 
> This means you will have to register the sckc with of_clk_hw_onecell_get
> as the get callback.

Ok, I'll look into it.

> 
> We could still decide to do the same with sam9x5 even if it has only one
> output clock.
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
