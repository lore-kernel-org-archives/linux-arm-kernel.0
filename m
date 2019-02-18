Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A922CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:48:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4C021736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nzE30SCB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Q1R6pmfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4C021736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7XxyOqF9vo5r+WwjauxHAitaG4UAyXAeNeH0e0f6Ju8=; b=nzE30SCBJyEcr0
	K9rkPEOtAaOzQ4XOl+xAzYW6hY06rcgGwepakW3VpyD+azoIBH0H58oCU/DgV9Hn8wP7kOLOOYZGq
	2W8NeFHZgxwXbkeU5nWOCdlgr+lOfvUwrMsbzkYVNeWeydt45bma9YZvboQ2puT6OP7uf5gny8S1f
	kd6QU3YKPYUAdkMlEL82WwMc/JYRUaS/45pcrQRjvoM3+pJ+FB5TiesrtBVFBRtArHEfNfto/s1uZ
	mzNqcla/UdXmAAD/pcJDnFBjrjeNbV1Qwz89CEWcGiI41pXuDOr5ryV+afzixJbE8qk4UUsNkPKsd
	uqE96VDQEOAI8SumvSkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkDu-0006pL-Dm; Mon, 18 Feb 2019 14:48:46 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkDr-0006os-Eu
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:48:45 +0000
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; d="scan'208";a="27900392"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 18 Feb 2019 07:47:25 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 18 Feb 2019 07:47:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrS1BzI/uXbq8mnpiqXBCfSVul7ViDQ4wQnZERBlesY=;
 b=Q1R6pmfwBp8WRUbfgfGLyCeWk2IDcZsitENcJkTjG42lPk4Gr0v/eveUDGNELyJF1xJNBoDpOgXY4hAO9ndniRADKRy5coi7MTqZHG+KftHvM7iOxocFuhbFW7t1h5W6bQLUHxkYE3MUJTJ2+WeysatUqs4GYSGmi4ZlwOiPrUI=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1694.namprd11.prod.outlook.com (10.169.232.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 14:47:23 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 14:47:22 +0000
From: <Claudiu.Beznea@microchip.com>
To: <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Topic: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUxFfTL1CYZiysKUi13XXnc4JnEKXlafyAgAA+/IA=
Date: Mon, 18 Feb 2019 14:47:22 +0000
Message-ID: <44adcef4-a3df-f906-2d69-f357af1ebfaf@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
 <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
In-Reply-To: <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0081.eurprd09.prod.outlook.com
 (2603:10a6:802:29::25) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190218164711766
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b5e8e01-4c48-46cf-b3b3-08d695affd56
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1694; 
x-ms-traffictypediagnostic: MWHPR11MB1694:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNjk0OzIzOmc0Qk03Q3lxR2M0VFlyczB2MmxHRFF2anNH?=
 =?utf-8?B?ODlGTWVEdWg0NzcxTm5pL21Gc2lWNUU4YlRnRmkxaTFCZjQvdjNuVXh1blJ1?=
 =?utf-8?B?L1BJV1FBOFJiUk5ZaXBTZUFLQ3pPMnFxSG94b0I1MStOanNwU2hrcjNycmhk?=
 =?utf-8?B?Wk1hSG5kWlViUWR6YjZoTDBsRTNiL3drcURLRThHT2FVV2NYc0ZwNzVnQWdD?=
 =?utf-8?B?dW5IcW5Bd3Z2MnBPRnBpSm9XclMxR0NYcGY1cTFMejlsNGw5TWlsc2pSVU95?=
 =?utf-8?B?SzhycEZuUzhVQ1hrRlFxTzRId09vMVNwZ3Y2bmdFTnErNWZ0T2pxMjRzUFdS?=
 =?utf-8?B?b3VkUVg4MEV2aGtnQjBVMEFBQ1NkL2JqNHhXTkQ0cWVlVHVtakVlY3JoWURl?=
 =?utf-8?B?UlZkdzlrY3RaeDBKVUFMSCtlTTliSitXV3RWYldiYk1RYVFMdW11eHZJT1lj?=
 =?utf-8?B?bkpRVit2MGRvb3NGcFVGVktYTGlyT2QzMS82Lzh1Rk9zUTNKU1FKWVY4QjVU?=
 =?utf-8?B?bGtnRmE4U2VDdzVjUkN3cWNqVVZmT1dIVUh3ZW5OcVJVNTBGNWxzOGsxaDVS?=
 =?utf-8?B?b05WV2NmdGQ4QWcrazNIcDg4SVBaZWRNK0pnQzVwbVlhVFd6R2F2cXFwM1dZ?=
 =?utf-8?B?bmlZVHNlUUUrS25WeXFXOVhYdTJCVU5TaXZMR0M3SThLN3RRTCs5b0VVU0Mw?=
 =?utf-8?B?a0RJK2pQM1Z0T3dueVJiaU1NR0NKNURHbE04ai84dklrQkRSVTBzLzZwQkJk?=
 =?utf-8?B?cUpiZkNEdXVJQVFlV1lpRS9ma1VBY0Y3cFQxLzJOTndVSHJsODhFenVheDVY?=
 =?utf-8?B?cHNMQk1BSklnVGZxZGRRblZHRWxPMWdCTHhQMm8xbkQ4eHF0ZFNEY2dwTHNu?=
 =?utf-8?B?dk83VDAweGJIdmhQdStUQVU2VFNVZDBIcVM0V0hlSjZuYW1ONCtvSncxQmRE?=
 =?utf-8?B?Z3crUTg1NVNUT0FmZitmQyt5VlRmRmQzR3RYZkorcmN3a2RxUXlhU1p3N0JS?=
 =?utf-8?B?KzBSaGtpTUhvTW03WjZSVjBGcnVXSzY4WTBFOTdOakNYQkV0STZZdWJJNWlj?=
 =?utf-8?B?QkRuTWxaOUJOVllLUnNUckF2ZmUxQUFJS1E5T0tFQk41SHBNNXpTMWtESUhR?=
 =?utf-8?B?enJtZXJtZDd2MW10WEZucndmdERIVU01c1dUd2RtV3lpWC9PNm1iTHRuV0ZG?=
 =?utf-8?B?enZTa1RDQzJrTDhubWFNVkhTY3VaeEdiaGZXVTZWbmdOSnN2KzUyMnJkNGpj?=
 =?utf-8?B?VTVBQllrcGVvci80Tnp1NlFnUjhPaThIRFF3OTBPYm1MOEVjVWgxaGlpVDhS?=
 =?utf-8?B?M1M4MWNLTThpaDQvTXpnYjJuTURpdHBMRmcrNEEwTGxPT3hRZnB3cGg1Ykhy?=
 =?utf-8?B?aHRZUVhXYUpUVjRlWnE2WWFjUVlON0ZqRks4MWsrbGdhZ2VCdmhjZzhjdHFh?=
 =?utf-8?B?R3MxWi81ZU0xY3Z2U2JOOFBVOTN5ZE5NU2hMWmptU2RtcUlFUU8wRXJZN0Ev?=
 =?utf-8?B?MGVwZTgrWUVQdU10NUFOb2RJRWpBamxoSUwyRnN4cW51WkFZNEtoZmVnc20v?=
 =?utf-8?B?c3NGTkJCT05NdkhwVEEyZjhkamgwMHh1c0NMelRUK3VTcnY0eERkQ1JtNlVo?=
 =?utf-8?B?SDhTL3pmU0poazdmSHBMeUxTSGZya3l2UytsM0poeFdyUEZ0MHVpZVkrTTBR?=
 =?utf-8?B?OSs4RHhTYkdISUh4N1dLQVZNREl6M01lMU1mS2dXSjZOb0Y2Q1BLTllkNjVj?=
 =?utf-8?B?aFd2MUpoZXpQckhXTHJVa1p1ZHJTMDJXZ3NXOC91NVRRUVNkb21hNmVYd000?=
 =?utf-8?B?a1U0Ri9EMEFLTUg3cUFJMjl6cGJ6alhGWXAwcGNnUUtKU1E9PQ==?=
x-microsoft-antispam-prvs: <MWHPR11MB169476ACA80FDCFE7F6A8A0487630@MWHPR11MB1694.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(136003)(39860400002)(346002)(43544003)(189003)(199004)(31686004)(66066001)(186003)(110136005)(6246003)(316002)(8936002)(105586002)(106356001)(26005)(81156014)(71190400001)(2501003)(81166006)(31696002)(6486002)(7736002)(446003)(11346002)(86362001)(53936002)(478600001)(54906003)(14454004)(305945005)(2616005)(476003)(6512007)(6436002)(71200400001)(486006)(229853002)(25786009)(14444005)(256004)(99286004)(2906002)(8676002)(53546011)(5660300002)(386003)(6506007)(52116002)(76176011)(3846002)(6116002)(102836004)(68736007)(72206003)(36756003)(4326008)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1694;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5GhrlRRNkDXvY51igtBPt2yyjs+6HAgdCaQMT+b4yJKmpWTFI3TV6mDGzMnWR/QMnOhFs3k2iOO255KeayKvUYQsbcUF/2KNExKVeq2y3JmhSR7FCyswN5o7w80sIqye+XNudYWiPERthkBm9lI3IpdRHNGtuFQvScGuRT3fPf5fuSZz+CFRHi7XEvAF1aFFrfDgiiFOGmjnTLiyHcShgigTJMyM52S0vc3C/zWotWKQovsNTxc+7ipW3ywQztIHOcP1cUhC+xm4eaFEJSnLsbP3uHNvniFIhEoBikR7kokFkk7M2tIuAu+6fC6Sr+3Whj8p3YHmiQp7T4Jpm2HMKoF1JW8Qc8KGtmOuS+7rZtKVhi9ljTN4ebL2n2unnRD+gux3U/8UktY7YjLAwXfNAuQaeBH9xCJTLnsfl30zz1o=
Content-ID: <B7B81ABD4F21E44BA0081B373E7CD1CA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5e8e01-4c48-46cf-b3b3-08d695affd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 14:47:18.7769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1694
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_064843_653169_F5BFC5B1 
X-CRM114-Status: GOOD (  14.98  )
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



On 18.02.2019 13:01, Nicolas Ferre - M43238 wrote:
> On 14/02/2019 at 12:24, Claudiu Beznea - M18063 wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Add documentation for SAM9X60 shutdown controller.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>   Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
>> index 14f319f694b7..9711052c5800 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
>> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
>> @@ -83,7 +83,7 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
>>   1) shdwc node
>>   
>>   required properties:
>> -- compatible: should be "atmel,sama5d2-shdwc".
>> +- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc".
>>   - reg: should contain registers location and length
>>   - clocks: phandle to input clock.
>>   - #address-cells: should be one. The cell is the wake-up input index.
>> @@ -95,6 +95,10 @@ optional properties:
>>     microseconds. It's usually a board-related property.
>>   - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
>>   
>> +optional properties for microchip,sam9x60-shdwc:
> 
> is it for sam9x60 only or is the optional property "debounce-delay-us" 
> applicable to this SoC?

No, I meant only to RTC and RTT.

> 
>> +- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
>> +- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
> 
> Well, I would make clear that the only additional optional property is 
> "atmel,wakeup-rtt-timer" while the 2 other optional properties still 
> apply...

Ok, I will take care of this in next version.

Thank you,
Claudiu Beznea

> 
> 
>>   The node contains child nodes for each wake-up input that the platform uses.
>>   
>>   2) input nodes
>>
> 
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
