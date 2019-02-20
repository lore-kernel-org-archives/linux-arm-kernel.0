Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38911C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB94206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jf4v3wqe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zziY0zpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB94206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6B1AsPvJrvjFEdCyCueXwrSia+QLMa5ZH+AvCWkltIk=; b=Jf4v3wqe1VWM61
	5DVT/z0zWPcGGOxSiE3l4v14e5OhhZ335/RyeDlHs3yqJdAvML7EVcEcdXc6T36YNtAdOS4clisou
	KT4K56GFqiqhzK1U1s8NoN/9P5/6n1EGaFXKz3UmiIWpd6uL4pTAfRoqQabH5rrMeuWHpRej4uZOU
	Kt0M8v25Q50M3MEl32sJ/dsKHSpZ5SdYVxL4Eayhcu8qzJDsCgsuVZi8C4w3rOausybqniNZ/j/ae
	w+R0wTtfTs8bGiJjyXlAzfMXqIazPYqtRk3wmoDmvEXzVHEqzgQncyiZLzWnKVqrqXVo9Cvr7SjKv
	3OuYfDiGWzTTLe4qx70A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ2s-0007OH-DW; Wed, 20 Feb 2019 11:28:10 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ2D-0006cN-OL
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:27:32 +0000
X-IronPort-AV: E=Sophos;i="5.58,390,1544511600"; d="scan'208";a="26588978"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 20 Feb 2019 04:27:29 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 04:27:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoaR730PGE2hRUUO+BgMjbxk+CSEy+gPuN8FlFdBo7c=;
 b=zziY0zpH+mjgbmcq7koUCEMxk9/y/g/iusaO+hJxKCP739a/rUl+qzF2oH14FW7kExXAU3lj8xJdEoHCjuqdN8efI1DdLkmBP1Za1Iuc952qFsn283HMcbUCdD7pi0KT3+ZXD8HbgzDvjE7ZbQWA1WWkzFTPw73W2Rq6iD+gKo8=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1808.namprd11.prod.outlook.com (10.175.53.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 11:27:25 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 11:27:25 +0000
From: <Nicolas.Ferre@microchip.com>
To: <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: fix masterck name
Thread-Topic: [PATCH] clk: at91: fix masterck name
Thread-Index: AQHUv7x/dAWxQXybc0i6K8XkGPakkqXWDXGAgBKRjwA=
Date: Wed, 20 Feb 2019 11:27:25 +0000
Message-ID: <93c2e981-f32e-7d21-d094-786b36eccc70@microchip.com>
References: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
 <db6b542f-add1-af4c-e3f1-ce293042f375@microchip.com>
In-Reply-To: <db6b542f-add1-af4c-e3f1-ce293042f375@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::21) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e91334c8-07b3-4600-85f4-08d697266387
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1808; 
x-ms-traffictypediagnostic: MWHPR11MB1808:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxODA4OzIzOmVZVU5zV1lTU2FQUlZNdjFIK3orRVhNUkh3?=
 =?utf-8?B?cWtWSHhabFhBVFVNMHA2cW41NUVkamhHN2gyU0lqMDZ3Tlp5aEJkdlk1SUwx?=
 =?utf-8?B?WnNPMEJzM2ZIMUNuOXZGYlhveTlpdUluZVJkRVRCRFFGdkR5ZEs2bUZEQ3Vp?=
 =?utf-8?B?c0ppTVIvQWtYdTFpdG9EaCsxV0FTS0FxcEZjUitNeW9nRCtFVUpKM0NvVlov?=
 =?utf-8?B?RllCeGZKZko5Nm9KVkhuc1ZNZFEwR2RtNUo1NG9UdzVKcTlMQ3ZJU0tLcW1R?=
 =?utf-8?B?NDJXY1NRcGM0R2NNT2EzVnFFZWJiVWpxS2xYL3FhZjd5S3FXbzJ4bzRuV1FY?=
 =?utf-8?B?Ujk0T2p4VmlKWDdaNTBLd0VTdzU0anBjTXZUV3AySEJEZWRMRlVTK3hrTEtu?=
 =?utf-8?B?UlNwS3FyU1poMThQZ1VhSWtOQWZTVzZJVWIxUzZtaDBwb0hrZFgwcXlXdUhl?=
 =?utf-8?B?YXdSZ3JENFFGUFF5dkVzRVBmWXdNSGNKQVMxTVRsakdyUmp3TEl2My8zb1Vs?=
 =?utf-8?B?TXVyWWsvMWtXdmRLeTl2NmQ3em5qSDlDcC93VnJ2Z0NsRFRmVGFBcVlvZjNF?=
 =?utf-8?B?dTlxazZoUHdtTVByVUNJV2JzempjYm5PNFpIbThYQ21vdHNJOUN2d0Z0aDNR?=
 =?utf-8?B?cTFOblNMc1ZCd0RKVnN5QmxsbTVLRDBab2ZQejNvbEk3azMyRVhFSHYrTkty?=
 =?utf-8?B?eFhXdmsrTHV5OE9wL0wxMVdlalgwMXFlb1ZNRmxhaFpaOUZRb3IvaFdxK2cv?=
 =?utf-8?B?L05QZWhvWnd6RXI3N0FCNVJmUVpzNnpVT3hSS1JSNTZUb0o1Uk9OK003UDI4?=
 =?utf-8?B?aDN6WmQySm93USt4Y2JXc2RPRnJuTHRwMS9hajVSeUlSYVVvM0h2MU5IMFIz?=
 =?utf-8?B?MnBrYWtuaStxZ3EwUmZEaXl5MmIvaUh3TUpURkhFTlZnTk5SZHhnazA4U0cx?=
 =?utf-8?B?MS81ejJidkJacmU5V1VYTWZTNktKZnpSNFF2Z01LMFFvTlR0SHE3NHRhcVB6?=
 =?utf-8?B?MGIwS1pNQVRybUovTm90SDlKakdpS2hmVXFpc1FzYStmM1dxbmNTZElueFd0?=
 =?utf-8?B?YjVXdHVIY2RWUWZ4Y3NGOGR4VHo0VHArV3RkNGRVeTYvQ2l0SGI5V2sycW4r?=
 =?utf-8?B?dktjcWw1b05GTzNUR0tVMHJCMWZaV2FTWFliWHFhTnozSFhpRUloWHhvNDVC?=
 =?utf-8?B?aEF6ckZ3MWthcjg0VnZVamNFaStlaWIyV0tvS25RK1Q0WTAzYlN2Q21UUGRL?=
 =?utf-8?B?Y1RFYWtHUmtSeDJIaGduOTkrZXZnNkxjdGpKemZkeTRlOWVjRU56ZDV3S3U2?=
 =?utf-8?B?S0wwTG5LYzBTMDE1ckwvSE9vU3czSHcyUmRoL2JTaFBGTVVmNFJWU0xldW1M?=
 =?utf-8?B?bDA0ZDljRHYzSnZNZmJrSjdoVG9YZVJoR2IxV0M1NHBtTllLRUQ1Z0VlOVJH?=
 =?utf-8?B?VEVweUhmSXV2QjF1ZVZxMFNxT2JKY2hBY0YrYTkxRXRsQzkxT0h1aFp1Vml5?=
 =?utf-8?B?Z0gyTFp2MnJDb2NqTGVYV0REQ1U5aVZCM25IVlN0cXJKU2cvbnBzZFI1ZENy?=
 =?utf-8?B?REczakovd0NvWmJSZWp1UEVLdXYwcDVEQk5IT2VocGNPZEpsTCtZWEhsT2VW?=
 =?utf-8?B?bjJRbmxvMkU4Sy9sb1c1K2VBMjBIdUhJUnNNNURwSkxydVZaUk5SN09QV0Rm?=
 =?utf-8?B?VzZTOEhUUVhpSTBwMzA0eStiTHFpR0VOMkQzNjBwZUFjZjFNb1N4TmYwSWd5?=
 =?utf-8?B?YVRNdStzUmluYlZQdjVOanZRcGZGQTdTaVpFTHFjd0MzMnNpQWFVNWZNd3RM?=
 =?utf-8?Q?6jFGnGhdjL9Zd?=
x-microsoft-antispam-prvs: <MWHPR11MB180804D75948C0DCC31E1A5CE07D0@MWHPR11MB1808.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(71200400001)(8936002)(86362001)(6512007)(54906003)(7736002)(316002)(305945005)(25786009)(99286004)(72206003)(478600001)(68736007)(53936002)(110136005)(81156014)(81166006)(8676002)(5660300002)(71190400001)(76176011)(66066001)(52116002)(6486002)(6436002)(4326008)(256004)(476003)(102836004)(229853002)(26005)(186003)(14444005)(3846002)(2906002)(6116002)(31696002)(6246003)(6506007)(446003)(386003)(486006)(36756003)(31686004)(11346002)(14454004)(105586002)(106356001)(53546011)(97736004)(2616005)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1808;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BEETu+ORMjfFaTpmEOf7vlmbms8ly/bIV2f21VquHQ7EdERCbf4Z4/9jXBFIDvuS58vhZg1Ok5SxAiqg4XHsKyFC2SwO26mGZAXxFGGRTF+23FwWFZn+cKC4SN3iAgQfpm0M7lWkZh4Kqbv+MRdCy0Gq6hY9R9fpsT6x9gSu5RDd2v2pg9Fc6qbP65bTk3EWd9WV3CF6+mmbmxoDoZsZSd4dZI7h/ADeSi1vNaMhbCbh78YLAz1tzNkyEmTyvnK8vS+9bYfpvVLapei2eEdIxigD5cvv1rdwAgbdmKySb2c+SDPpAxORi6UNQCHfYaYl5foDvbKFX2MI9bJLlzrR1HdP/9gqEIN41X5J2ejXzz8+kwirA4VkXXguhVw8D9d5PoJQSx+9r+62c1U8ykeAXB75Je+Mj40ugOPZL1CYiqk=
Content-ID: <119F4639F6E5B543B98F047024A54316@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e91334c8-07b3-4600-85f4-08d697266387
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:27:23.6256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1808
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_032729_962857_E6C12A6C 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/02/2019 at 16:53, Nicolas.Ferre@microchip.com wrote:
> On 08/02/2019 at 15:40, Alexandre Belloni wrote:
>> The master clock is actually named masterck earlier in the driver. Having
>> "mck" in the parent list means that it can never be selected.
>>
>> Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
>> Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
>> Fixes: 084b696bb509 ("clk: at91: add sama5d4 pmc driver")
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

+
Cc: <stable@vger.kernel.org> # v4.20+

Stephen (ping),

This patch together with the one sent today "[PATCH] clk: at91: fix 
at91sam9x5 peripheral clock number" make a good set for 5.0-final as 
they basically are real regressions.
This is true even if they apply on 4.20 as we were using an older biding 
definition until 5.0-rc...

Do what you can... As it's really late, I know...

Best regards,
   Nicolas


>> ---
>>    drivers/clk/at91/at91sam9x5.c | 2 +-
>>    drivers/clk/at91/sama5d2.c    | 4 ++--
>>    drivers/clk/at91/sama5d4.c    | 2 +-
>>    3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
>> index 2fe225a697df..d55a151cb7f5 100644
>> --- a/drivers/clk/at91/at91sam9x5.c
>> +++ b/drivers/clk/at91/at91sam9x5.c
>> @@ -210,7 +210,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>>    	parent_names[1] = "mainck";
>>    	parent_names[2] = "plladivck";
>>    	parent_names[3] = "utmick";
>> -	parent_names[4] = "mck";
>> +	parent_names[4] = "masterck";
>>    	for (i = 0; i < 2; i++) {
>>    		char name[6];
>>    
>> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
>> index d69ad96fe988..cd0ef7274fdb 100644
>> --- a/drivers/clk/at91/sama5d2.c
>> +++ b/drivers/clk/at91/sama5d2.c
>> @@ -240,7 +240,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>>    	parent_names[1] = "mainck";
>>    	parent_names[2] = "plladivck";
>>    	parent_names[3] = "utmick";
>> -	parent_names[4] = "mck";
>> +	parent_names[4] = "masterck";
>>    	for (i = 0; i < 3; i++) {
>>    		char name[6];
>>    
>> @@ -291,7 +291,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>>    	parent_names[1] = "mainck";
>>    	parent_names[2] = "plladivck";
>>    	parent_names[3] = "utmick";
>> -	parent_names[4] = "mck";
>> +	parent_names[4] = "masterck";
>>    	parent_names[5] = "audiopll_pmcck";
>>    	for (i = 0; i < ARRAY_SIZE(sama5d2_gck); i++) {
>>    		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
>> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
>> index e358be7f6c8d..b645a9d59cdb 100644
>> --- a/drivers/clk/at91/sama5d4.c
>> +++ b/drivers/clk/at91/sama5d4.c
>> @@ -207,7 +207,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>>    	parent_names[1] = "mainck";
>>    	parent_names[2] = "plladivck";
>>    	parent_names[3] = "utmick";
>> -	parent_names[4] = "mck";
>> +	parent_names[4] = "masterck";
>>    	for (i = 0; i < 3; i++) {
>>    		char name[6];
>>    
>>
> 
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
