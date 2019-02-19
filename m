Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB53C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8301421848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FAYFkW2X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yr2v2g1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8301421848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nbtBxJ65sKk/b9fLrMK0+lwLYHh+2niJ6v6zuBOX8fU=; b=FAYFkW2XSuM4hd
	QPUv9QqKeLwDMTRy/gDt8mXV3xbN3YfpQtQ1TonDe2e67qVa6uVODYwvda62CTDfxZ96VpAeYhdAc
	nnxwU8DC8hxl2Z01uLsvbNmbi323GiJMzvK417fHBxh3ssyMgozbPX0c+UYFiclw8CgQl+X19HrmQ
	urY8hvZoTeVgkEADgGncPP8LNoBak0hQAU0+LmgaGNCm94h5QuttosZs1hfB5QSb+269LP8MXrKy6
	ndJL1WWHGf91r+bIs+AqJYLfYV/W+kGf02ST8VwwQMi0LWtPIn1Nl/tjaZXFFapiCLpqlKbXMgiyR
	Xc4di8iMO2LLc7WpJT+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1ZY-0002DO-5A; Tue, 19 Feb 2019 09:20:16 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1ZU-00022g-1q
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:20:14 +0000
X-IronPort-AV: E=Sophos;i="5.58,387,1544511600"; d="scan'208";a="27946709"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 19 Feb 2019 02:17:54 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 19 Feb 2019 02:17:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SBnqfZUIymmrJamqW5HmyNyoNvwoE139funGjwq1Vg=;
 b=yr2v2g1sfZ5nzJC+YGNd4OCjkuTA1ZiTvx1FguiPsp+D93+HYIi1zOBR7SLgDQIu1xrXnrNWG6Yd8sp76pU8uJgtcF4W4NMb68Bp1ZV27W155g1gDgQLS0JTe6pdhODYYJcHk5ADOwA6nc+vCDGDOhwy4+oztbm4389r0wXj51k=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1352.namprd11.prod.outlook.com (10.169.254.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 09:17:52 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 09:17:52 +0000
From: <Claudiu.Beznea@microchip.com>
To: <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Topic: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Index: AQHUxF7V9nqwlEcieUmVG7K88z/Dx6XmE16AgADL1QA=
Date: Tue, 19 Feb 2019 09:17:52 +0000
Message-ID: <8af47d4c-667f-bee1-e710-4f3276a944af@microchip.com>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-2-git-send-email-claudiu.beznea@microchip.com>
 <20190218210811.GV10129@piout.net>
In-Reply-To: <20190218210811.GV10129@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0328.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::28) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190219111744757
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 682295d0-6695-42ef-91a7-08d6964b1fd4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR11MB1352; 
x-ms-traffictypediagnostic: CY4PR11MB1352:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjExTUIxMzUyOzIzOmtmaFNsRENwTHBqNlJndkQ2UDBBejBMVDJL?=
 =?utf-8?B?MDFVaThwTmdBV2VQbVl3WFFLbWV5UUppVFRGS2djcnhxdFgySThodFc1VjVR?=
 =?utf-8?B?ZVJCY2haVndaRERUVkZqajNPTW5FM2JmVWV0N05XOEYva2RVNy9hUGZ5SnNr?=
 =?utf-8?B?N2paYW9WSy90NGFINUNUbzBMbnBzUk9RTWlQbzZWekFPY0w1MlBpYThuOVhN?=
 =?utf-8?B?aHBteGRYUmIxd1dFWnpQajBYM0gwTU5mTFRESzFvMkJqaXZUN2RjS0dmWERD?=
 =?utf-8?B?ZHp4eUtEY09YclgxZUhpNGlQb3M2SnhLYmNPSWNEMHVtOTU0azE3VUw4R0o5?=
 =?utf-8?B?eXNTZkpJd3FNUHdJeGVhMU5DbHpXQU9kUzl3RThNNHJWNlU1Q2lRcm96WFNx?=
 =?utf-8?B?TDdXckF6MVZyWHRtN04vbTNTRzQvOExjQmJDa1VEV0tZcW1YL0tqRG5WMzdU?=
 =?utf-8?B?R2ttNVpKdzBSeE1JbGFXUHdtcEdqSndVMHZZenQ5YWNYdW8wZ1RFUVd5T3M0?=
 =?utf-8?B?TS9FUnJKN1NnUlpFMi9PTVVUYmRKeE81MTF5cWw2c21FV1c0cDVKcVBZTTE2?=
 =?utf-8?B?MDMzaXFCZy9oZTF2dFpOMjlFcDZmYzJ1M1FFRkFtcWpaTTNHYzNaTjBkRWdM?=
 =?utf-8?B?dDYzM1JMN1A1NThhblZjUTRERlVBWmI2YmxCdnpmd1k2dlZuVEdua1ZHSGhR?=
 =?utf-8?B?ckNkSWt2Sk90OVZtUEFUZUt2bTg3NkkwUEY5TTZPdG1Ueks1L09ESWxsNWx1?=
 =?utf-8?B?WFdnUWo3NGpVRG5NWitHanV1MGZVbTZSNWhFeTdpblVsOUxlb1lUZk5WeWVP?=
 =?utf-8?B?WkJZNzlGS1d1M0g0ZDNvZnpuKzJiTXVQNnJiNWJqNG1LOGxlRmoyZFhDYjZH?=
 =?utf-8?B?RW9TTElwOVA2d2p0TmpBVjNrWExjOWJZeEtpbE9EVUJWc2dvZElCY3VnelZr?=
 =?utf-8?B?ZjJ3SEcwdVQ4ZlFLS1pHT1NXNXV3Y054LysrOXhQNEdJNnlxOS94OGlpaUEx?=
 =?utf-8?B?RVg3K2VRRFJqdVhwNkRndTB1ZHk4RTVQZVFLaHA2aTBjWGttVFkxTm9oeGRI?=
 =?utf-8?B?TE1yeWcvMjYvMDB6d3hkQ1U1RjJCbWl6MG9XMWd4cVJGRWZ5NEg4SUZUMC9w?=
 =?utf-8?B?VnI5NW9Ocnd4cFNCNXNyU0VOM21zUG8wMzAxRjBVOWlxQnpZL1NrLzNzMjNF?=
 =?utf-8?B?UUlWZzVlUWNtcHhNdkQrQTZhQXlDQWliUy9LS2t0VjFoK1V0dUtTa0p4TXYz?=
 =?utf-8?B?QmRpdFdMK0p2bHdENHRONnRhdWRDTE5aS3hnWmdEY0NDSU5JTzkzR0x6YUlN?=
 =?utf-8?B?ZWo5LzJzUUQrSGFFWnFtQVg0T0t4RDM4MFc4Qm5rbWIwUm5ucTkyUUM2NnEz?=
 =?utf-8?B?NDd1cUpDK0xCaElMMzJKbkwyRVN4ZUJYdllTM3dpNFUvODJKYXJFckZzWk5T?=
 =?utf-8?B?UkcrNVpaYWowMFFTYVVNbkhkcGdOaTl1OXJoZHZLYmw3Zlh1NVRERWlMaERn?=
 =?utf-8?B?UmhjZWZ1NmxOQWZZdERyZFY2RmczcnlvUGRNYUF6TmZvSVpXVysvSjBZM0Zt?=
 =?utf-8?B?Sk80WVR1UzZzRG9yRzhkbHkzd29VVFNhU3JybXZOeXFEcmJ3RzUrczJxU0pF?=
 =?utf-8?B?K1RvaG5KemJuNFU5R0Jxb2NYN1BGTGpUNkN2ZUZaQkk2RzNOSm5kRlRZcERh?=
 =?utf-8?B?Vm1YYnNDVTNucGJjVi96SnhJZGl5bEpCN25PQURlTEhGR2tGRitpL29uUjlO?=
 =?utf-8?B?QVdZaG5VcGNwTHJ0b1ZCZFVGWmxPTVJWdENKUVR1aFJQaVEvVnVKYmVrcUpJ?=
 =?utf-8?Q?RGCqVECogN6qj?=
x-microsoft-antispam-prvs: <CY4PR11MB1352D860F2CAF9EE9D6F3042877C0@CY4PR11MB1352.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(43544003)(11346002)(446003)(2616005)(7736002)(476003)(102836004)(52116002)(486006)(76176011)(99286004)(26005)(6506007)(53546011)(186003)(305945005)(386003)(6916009)(2906002)(81166006)(81156014)(31686004)(105586002)(8676002)(36756003)(8936002)(106356001)(86362001)(31696002)(256004)(6436002)(6486002)(30864003)(25786009)(6246003)(71190400001)(4326008)(72206003)(71200400001)(6512007)(5660300002)(316002)(53936002)(6116002)(14454004)(478600001)(3846002)(97736004)(68736007)(66066001)(54906003)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR11MB1352;
 H:CY4PR11MB1909.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3mo5wk7T1Tg9yDyJbs8/jX7tmZ+6JXz6XAAdKbmgVILS4dXGpgcJxqpeoGchISTtWMtC+IcDJvlDZ14i7XNddQCnHiem2cppc4xdlw/NQomCuOJZWRnGGe4eaSxU5gl+FslfPWIR4NxAQ0SFnK4OK6BUQ7ckWpEwqSYsJnDm+RZU2p+Omq0NiAXQlHwJ78L0NcZIDfLbK7mk5fwdtHb8iHbzQnRSTrmx3WnxF91kvxr2ROMBpW4uRKaQxnROTBuNlvy1H1FcMH9JSHPDzw9NDUq00uQv/25UHG3+4bbR14GoYk0ITXo3J+pqgjgZdhdGmGW6UkTEQxTWEfBtDsSjh8lXasa2cqElz+qsSCnJgpj2/+sXNin+K2jebEb1B6qXYbxsqM3BeVJE/4egyvzwSQi/YPTQtDomurdGhVynD24=
Content-ID: <2CC93EF21D409C4DA9A2C46CE4B5A8C8@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 682295d0-6695-42ef-91a7-08d6964b1fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 09:17:49.5731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1352
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_012012_287281_BDEB85A8 
X-CRM114-Status: GOOD (  16.99  )
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

Hi,

On 18.02.2019 23:08, Alexandre Belloni wrote:
> Hi,
> 
> On 14/02/2019 12:14:28+0000, Claudiu.Beznea@microchip.com wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Different IPs uses different offsets in registers for the same
>> functionality, thus adapt the driver to support this.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/clk/at91/sckc.c | 112 +++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 77 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
>> index ab6ecefc49ad..b7163d3a2269 100644
>> --- a/drivers/clk/at91/sckc.c
>> +++ b/drivers/clk/at91/sckc.c
>> @@ -22,15 +22,25 @@
>>  #define SLOWCK_SW_TIME_USEC	((SLOWCK_SW_CYCLES * USEC_PER_SEC) / \
>>  				 SLOW_CLOCK_FREQ)
>>  
>> -#define	AT91_SCKC_CR			0x00
>> -#define		AT91_SCKC_RCEN		(1 << 0)
>> -#define		AT91_SCKC_OSC32EN	(1 << 1)
>> -#define		AT91_SCKC_OSC32BYP	(1 << 2)
>> -#define		AT91_SCKC_OSCSEL	(1 << 3)
>> +#define	AT91_SCKC_CR		0x00
>> +#define		AT91_SCKC_RCEN(off)	(1 << (off)->cr_rcen)
>> +#define		AT91_SCKC_OSC32EN(off)	(1 << (off)->cr_osc32en)
>> +#define		AT91_SCKC_OSC32BYP(off)	(1 << (off)->cr_osc32byp)
>> +#define		AT91_SCKC_OSCSEL(off)	(1 << (off)->cr_oscsel)
> 
> You don't need those macros if you store BIT(off) instead of off in the
> members of clk_slow_offsets.

Ok, I'll take care of it.

> 
>> +
>> +#define AT91_SCKC_OFFSET_INVALID        (32)
>> +
> 
> This would also remove the need for that define as 0 would mean that the
> bit doesn't exist.

Agree.

> 
>> +struct clk_slow_offsets {
>> +	u8 cr_rcen;
>> +	u8 cr_osc32en;
>> +	u8 cr_osc32byp;
>> +	u8 cr_oscsel;
>> +};
>>  
>>  struct clk_slow_osc {
>>  	struct clk_hw hw;
>>  	void __iomem *sckcr;
>> +	const struct clk_slow_offsets *offsets;
>>  	unsigned long startup_usec;
>>  };
>>  
>> @@ -39,6 +49,7 @@ struct clk_slow_osc {
>>  struct clk_sama5d4_slow_osc {
>>  	struct clk_hw hw;
>>  	void __iomem *sckcr;
>> +	const struct clk_slow_offsets *offsets;
>>  	unsigned long startup_usec;
>>  	bool prepared;
>>  };
>> @@ -48,6 +59,7 @@ struct clk_sama5d4_slow_osc {
>>  struct clk_slow_rc_osc {
>>  	struct clk_hw hw;
>>  	void __iomem *sckcr;
>> +	const struct clk_slow_offsets *offsets;
>>  	unsigned long frequency;
>>  	unsigned long accuracy;
>>  	unsigned long startup_usec;
>> @@ -58,6 +70,7 @@ struct clk_slow_rc_osc {
>>  struct clk_sam9x5_slow {
>>  	struct clk_hw hw;
>>  	void __iomem *sckcr;
>> +	const struct clk_slow_offsets *offsets;
>>  	u8 parent;
>>  };
>>  
>> @@ -69,10 +82,11 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
>>  	void __iomem *sckcr = osc->sckcr;
>>  	u32 tmp = readl(sckcr);
>>  
>> -	if (tmp & (AT91_SCKC_OSC32BYP | AT91_SCKC_OSC32EN))
>> +	if (tmp & (AT91_SCKC_OSC32BYP(osc->offsets) |
>> +		   AT91_SCKC_OSC32EN(osc->offsets)))
>>  		return 0;
>>  
>> -	writel(tmp | AT91_SCKC_OSC32EN, sckcr);
>> +	writel(tmp | AT91_SCKC_OSC32EN(osc->offsets), sckcr);
>>  
>>  	usleep_range(osc->startup_usec, osc->startup_usec + 1);
>>  
>> @@ -85,10 +99,10 @@ static void clk_slow_osc_unprepare(struct clk_hw *hw)
>>  	void __iomem *sckcr = osc->sckcr;
>>  	u32 tmp = readl(sckcr);
>>  
>> -	if (tmp & AT91_SCKC_OSC32BYP)
>> +	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
>>  		return;
>>  
>> -	writel(tmp & ~AT91_SCKC_OSC32EN, sckcr);
>> +	writel(tmp & ~AT91_SCKC_OSC32EN(osc->offsets), sckcr);
>>  }
>>  
>>  static int clk_slow_osc_is_prepared(struct clk_hw *hw)
>> @@ -97,10 +111,10 @@ static int clk_slow_osc_is_prepared(struct clk_hw *hw)
>>  	void __iomem *sckcr = osc->sckcr;
>>  	u32 tmp = readl(sckcr);
>>  
>> -	if (tmp & AT91_SCKC_OSC32BYP)
>> +	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
>>  		return 1;
>>  
>> -	return !!(tmp & AT91_SCKC_OSC32EN);
>> +	return !!(tmp & AT91_SCKC_OSC32EN(osc->offsets));
>>  }
>>  
>>  static const struct clk_ops slow_osc_ops = {
>> @@ -114,7 +128,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>>  			   const char *name,
>>  			   const char *parent_name,
>>  			   unsigned long startup,
>> -			   bool bypass)
>> +			   bool bypass,
>> +			   const struct clk_slow_offsets *offsets)
>>  {
>>  	struct clk_slow_osc *osc;
>>  	struct clk_hw *hw;
>> @@ -137,9 +152,11 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>>  	osc->hw.init = &init;
>>  	osc->sckcr = sckcr;
>>  	osc->startup_usec = startup;
>> +	osc->offsets = offsets;
>>  
>>  	if (bypass)
>> -		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN) | AT91_SCKC_OSC32BYP,
>> +		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN(osc->offsets)) |
>> +					AT91_SCKC_OSC32BYP(osc->offsets),
>>  		       sckcr);
>>  
>>  	hw = &osc->hw;
>> @@ -153,7 +170,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>>  }
>>  
>>  static void __init
>> -of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
>> +of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr,
>> +				 const struct clk_slow_offsets *offsets)
>>  {
>>  	struct clk_hw *hw;
>>  	const char *parent_name;
>> @@ -167,7 +185,7 @@ of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
>>  	bypass = of_property_read_bool(np, "atmel,osc-bypass");
>>  
>>  	hw = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
>> -					 bypass);
>> +					bypass, offsets);
>>  	if (IS_ERR(hw))
>>  		return;
>>  
>> @@ -195,7 +213,7 @@ static int clk_slow_rc_osc_prepare(struct clk_hw *hw)
>>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>>  	void __iomem *sckcr = osc->sckcr;
>>  
>> -	writel(readl(sckcr) | AT91_SCKC_RCEN, sckcr);
>> +	writel(readl(sckcr) | AT91_SCKC_RCEN(osc->offsets), sckcr);
>>  
>>  	usleep_range(osc->startup_usec, osc->startup_usec + 1);
>>  
>> @@ -207,14 +225,14 @@ static void clk_slow_rc_osc_unprepare(struct clk_hw *hw)
>>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>>  	void __iomem *sckcr = osc->sckcr;
>>  
>> -	writel(readl(sckcr) & ~AT91_SCKC_RCEN, sckcr);
>> +	writel(readl(sckcr) & ~AT91_SCKC_RCEN(osc->offsets), sckcr);
>>  }
>>  
>>  static int clk_slow_rc_osc_is_prepared(struct clk_hw *hw)
>>  {
>>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>>  
>> -	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN);
>> +	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN(osc->offsets));
>>  }
>>  
>>  static const struct clk_ops slow_rc_osc_ops = {
>> @@ -230,7 +248,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>>  			      const char *name,
>>  			      unsigned long frequency,
>>  			      unsigned long accuracy,
>> -			      unsigned long startup)
>> +			      unsigned long startup,
>> +			      const struct clk_slow_offsets *offsets)
>>  {
>>  	struct clk_slow_rc_osc *osc;
>>  	struct clk_hw *hw;
>> @@ -252,6 +271,7 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>>  
>>  	osc->hw.init = &init;
>>  	osc->sckcr = sckcr;
>> +	osc->offsets = offsets;
>>  	osc->frequency = frequency;
>>  	osc->accuracy = accuracy;
>>  	osc->startup_usec = startup;
>> @@ -267,7 +287,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>>  }
>>  
>>  static void __init
>> -of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
>> +of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr,
>> +				    const struct clk_slow_offsets *offsets)
>>  {
>>  	struct clk_hw *hw;
>>  	u32 frequency = 0;
>> @@ -281,7 +302,7 @@ of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
>>  	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
>>  
>>  	hw = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
>> -					    startup);
>> +					   startup, offsets);
>>  	if (IS_ERR(hw))
>>  		return;
>>  
>> @@ -299,14 +320,14 @@ static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
>>  
>>  	tmp = readl(sckcr);
>>  
>> -	if ((!index && !(tmp & AT91_SCKC_OSCSEL)) ||
>> -	    (index && (tmp & AT91_SCKC_OSCSEL)))
>> +	if ((!index && !(tmp & AT91_SCKC_OSCSEL(slowck->offsets))) ||
>> +	    (index && (tmp & AT91_SCKC_OSCSEL(slowck->offsets))))
>>  		return 0;
>>  
>>  	if (index)
>> -		tmp |= AT91_SCKC_OSCSEL;
>> +		tmp |= AT91_SCKC_OSCSEL(slowck->offsets);
>>  	else
>> -		tmp &= ~AT91_SCKC_OSCSEL;
>> +		tmp &= ~AT91_SCKC_OSCSEL(slowck->offsets);
>>  
>>  	writel(tmp, sckcr);
>>  
>> @@ -319,7 +340,7 @@ static u8 clk_sam9x5_slow_get_parent(struct clk_hw *hw)
>>  {
>>  	struct clk_sam9x5_slow *slowck = to_clk_sam9x5_slow(hw);
>>  
>> -	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL);
>> +	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
>>  }
>>  
>>  static const struct clk_ops sam9x5_slow_ops = {
>> @@ -331,7 +352,8 @@ static struct clk_hw * __init
>>  at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>>  			      const char *name,
>>  			      const char **parent_names,
>> -			      int num_parents)
>> +			      int num_parents,
>> +			      const struct clk_slow_offsets *offsets)
>>  {
>>  	struct clk_sam9x5_slow *slowck;
>>  	struct clk_hw *hw;
>> @@ -353,7 +375,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>>  
>>  	slowck->hw.init = &init;
>>  	slowck->sckcr = sckcr;
>> -	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL);
>> +	slowck->offsets = offsets;
>> +	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
>>  
>>  	hw = &slowck->hw;
>>  	ret = clk_hw_register(NULL, &slowck->hw);
>> @@ -366,7 +389,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>>  }
>>  
>>  static void __init
>> -of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
>> +of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr,
>> +			     const struct clk_slow_offsets *offsets)
>>  {
>>  	struct clk_hw *hw;
>>  	const char *parent_names[2];
>> @@ -382,7 +406,7 @@ of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
>>  	of_property_read_string(np, "clock-output-names", &name);
>>  
>>  	hw = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
>> -					    num_parents);
>> +					   num_parents, offsets);
>>  	if (IS_ERR(hw))
>>  		return;
>>  
>> @@ -406,10 +430,18 @@ static const struct of_device_id sckc_clk_ids[] __initconst = {
>>  	{ /*sentinel*/ }
>>  };
>>  
>> +static const struct clk_slow_offsets at91sam9x5_offsets = {
>> +	.cr_rcen = 0,
>> +	.cr_osc32en = 1,
>> +	.cr_osc32byp = 2,
>> +	.cr_oscsel = 3,
>> +};
>> +
>>  static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>>  {
>>  	struct device_node *childnp;
>> -	void (*clk_setup)(struct device_node *, void __iomem *);
>> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
>> +			  const struct clk_slow_offsets *offsets);
>>  	const struct of_device_id *clk_id;
>>  	void __iomem *regbase = of_iomap(np, 0);
>>  
>> @@ -421,7 +453,7 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>>  		if (!clk_id)
>>  			continue;
>>  		clk_setup = clk_id->data;
>> -		clk_setup(childnp, regbase);
>> +		clk_setup(childnp, regbase, &at91sam9x5_offsets);
>>  	}
>>  }
>>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
>> @@ -438,7 +470,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
>>  	 * Assume that if it has already been selected (for example by the
>>  	 * bootloader), enough time has aready passed.
>>  	 */
>> -	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
>> +	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL(osc->offsets))) {
>>  		osc->prepared = true;
>>  		return 0;
>>  	}
>> @@ -461,6 +493,13 @@ static const struct clk_ops sama5d4_slow_osc_ops = {
>>  	.is_prepared = clk_sama5d4_slow_osc_is_prepared,
>>  };
>>  
>> +static const struct clk_slow_offsets at91sama5d4_offsets = {
>> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
>> +	.cr_osc32en = AT91_SCKC_OFFSET_INVALID,
>> +	.cr_osc32byp = AT91_SCKC_OFFSET_INVALID,
>> +	.cr_oscsel = 3,
>> +};
>> +
> 
> I don't think you need to change the sama5d4 part as it is not affected
> by any change in the sam9x5 part.

Ok.

> 
>>  static void __init of_sama5d4_sckc_setup(struct device_node *np)
>>  {
>>  	void __iomem *regbase = of_iomap(np, 0);
>> @@ -498,9 +537,11 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>>  	osc->hw.init = &init;
>>  	osc->sckcr = regbase;
>>  	osc->startup_usec = 1200000;
>> +	osc->offsets = &at91sama5d4_offsets;
>>  
>>  	if (bypass)
>> -		writel((readl(regbase) | AT91_SCKC_OSC32BYP), regbase);
>> +		writel((readl(regbase) | AT91_SCKC_OSC32BYP(osc->offsets)),
>> +		       regbase);
>>  
>>  	hw = &osc->hw;
>>  	ret = clk_hw_register(NULL, &osc->hw);
>> @@ -509,7 +550,8 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>>  		return;
>>  	}
>>  
>> -	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
>> +	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2,
>> +					   &at91sama5d4_offsets);
>>  	if (IS_ERR(hw))
>>  		return;
>>  
>> -- 
>> 2.7.4
>>
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
