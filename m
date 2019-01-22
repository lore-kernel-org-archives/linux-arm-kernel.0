Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D8C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53612085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AXDtKNqh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EpWyED9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53612085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ngqli/WHcU5aHYSBQjQIISRwTK8fSGjp2gtRMgbdn8=; b=AXDtKNqh3l+Zke
	4hCKV0PSKh5YyRkVwu2MyWE8ulvfg774M9IhDl3I+qYbIkgQrcY8kjlmMyjzjh9wrv6FjGSmPq3Bo
	7jyIoO8qTRjYgIuvxBUWOed+Hs9QHsBUZzLdhU53pCYZWC22aNW4qsZkazwsFPS+NnKwjDpWNeYtw
	dbqbopgMhK1uJy4+CH5EN9mz4E5hLR6gN53J/war2K67H7pPb/+6kl5Pye9Yaa9ujcFbYOKVJq0NH
	jIUVcVQEv2K3gjmZQEGFW7EdN0fwTPmXP0+a0nvlalmuudi816hTtGy41RCeaThNm/MbzabfSU58g
	BM9D+pQgWZIY2pdNHRwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gls3M-0002Ao-Ue; Tue, 22 Jan 2019 09:09:04 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gls3J-0002AJ-44
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 09:09:02 +0000
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; d="scan'208";a="23703829"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 22 Jan 2019 02:08:59 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 22 Jan 2019 02:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZbOEJCR06h7cKqZvXPdQxdlVl2O/rI9c+J+8Zz0obY=;
 b=EpWyED9FJ6QZt0BoZtitbWVuYNyLFwrcGbFNQgTPGhdsL3ysVNs7noKJAb/bMCXq7Pa0buR44508MJYxIaeER949ZQ0HuU4uGJDTbNuomjLQ4BaBJSj3r4bdX4xWpvBqK4jkYG9m5q+ASwTzgbPaQ3qPCmKDzV3tRKxxeXAOQpI=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB2032.namprd11.prod.outlook.com (10.169.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 09:08:54 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:08:54 +0000
From: <Nicolas.Ferre@microchip.com>
To: <robh@kernel.org>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation for
 sama5d3 10/100 interface
Thread-Topic: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation
 for sama5d3 10/100 interface
Thread-Index: AQHUse9Xo4ahb2kgZ0mEDyKh+XWVpqW7AEoA
Date: Tue, 22 Jan 2019 09:08:54 +0000
Message-ID: <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
 <20190122011014.GA25211@bogus>
In-Reply-To: <20190122011014.GA25211@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0447.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::27) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB2032;
 6:58v2eftVXKlO3Uy+iiFjkLExRUKyDnVVEFKng/ksKjaRiC8Rc/zLKhh1qlLZDsLCs8x8nG629UUXSeekiVkLcXqqw4s+2QLJRr+daQWaUTcBFYEHTm+HsiiZ9Q6iC9DSAFPdhmqXinH6aR++fOtss0GDhSQQqwwcfuXnUqLnHdsuW5pY9TAu3mRHuHbRg9IOFaZvx2wo+XZILw8K2/SGbFTQ0U7vTboajYAM7OaEsGS1Ej2BLtwLauGUHy8Y9rOH44iuzXrMpGvfP1lvOXg2sL+EHLTQdSIA64UbfjquEaxmh+Anlr+Pw6NiBeUeTKjx3suMfxZscJjhvvzUcm60we6yxue2VxoLTJUIk44sdLIR2b7U2EqQvpm7N1fvHFh0Sbj3RIAn5MCSdmGu0q2QmtwBliqoN0QqBd3PpVTSz+Paf25//l738y4gn84xAb8OkSCgWsWHRlhIB16oIQY49g==;
 5:5YqIyLPiq3qEQ/1JXSgj+M+L5pSlQb4zs+mpGBBN6QsJxg/LgqcPqBCxABx5ImJD2Fe6EuAvGFWF39drNHRuD1IuzKuOJwSrqXQk93xBk3SidnGyL5TLsjnn7QJP8ujObg59m0n9Mz8jCejNReu1c67ZfHVZuDVjy/gWHi2BhRkE2lDMH84YyIC7jUl98J/tAqnFxlPc07CqzPLsWv2+IA==;
 7:hRR16sZ21YEVSflwLVrSnz4rxuILwkS/5ai1NmxKTCtcKlLqCGnAxv1vs8kawMEvmRb6299yGR0weVGwRcbfYaF+fpJ32iNAeST8lMeRG4jiUUka+5nJEcAH9JJmQKMaKEvkcLXwrW2CDGMal0u3Bw==
x-ms-office365-filtering-correlation-id: 577f9202-4fed-468d-6e41-08d680493b80
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB2032; 
x-ms-traffictypediagnostic: MWHPR11MB2032:
x-microsoft-antispam-prvs: <MWHPR11MB2032028A94534D6C8DCE4AC6E0980@MWHPR11MB2032.namprd11.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(72206003)(6512007)(6506007)(14454004)(36756003)(53936002)(99286004)(186003)(52116002)(478600001)(6246003)(26005)(386003)(76176011)(102836004)(53546011)(305945005)(7736002)(68736007)(4326008)(25786009)(31696002)(86362001)(66066001)(7416002)(8936002)(229853002)(81166006)(8676002)(81156014)(2906002)(97736004)(105586002)(106356001)(31686004)(316002)(486006)(6486002)(6116002)(476003)(2616005)(71200400001)(71190400001)(11346002)(446003)(54906003)(110136005)(256004)(3846002)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB2032;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N1Bp3r7xChXyTrBXT96otqp1Ry2AG7UpXGiEOIQCEbbg3etzGRLE7qxlLB0UVaW26XP4SAEoRtK847Ua4nmsDpemqxpvzNRzLWNZFDnIY0h+SBsM+Bf8UqUfkITH7drg0wmChRzle6Tq7kXfzVKuDMUTg+ztzETa2+1+Be2XwSuJ35xkvRvVFUv5aAXb1Sg3EDSVXbc743laZBkszJvngIIxRFhmxK8DpLFk6oYXpP2EtM3ALnLUrndeTWh4x/70YQ3HKb/DQ9k3Ldr2tZ8EOGLilvZFYdt0fwTQ6Ui8HnR42fV7RrYLXBA3NZCghWLzHRJHhBZKAYLLSK+Wc3k+SPHO8SWMNGuK7+sQwGIhr+sU6JTQmsvNwKje7zXnYYBnqU5fyH/ajMMmppPfP+vy0U9fyoJdnYkh//69YwU5T5Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <10FC06FC594F804F9A2F3040F5924E4F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 577f9202-4fed-468d-6e41-08d680493b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:08:51.2342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2032
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_010901_273336_60DAACB7 
X-CRM114-Status: GOOD (  17.03  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, sre@kernel.org, Ludovic.Desroches@microchip.com,
 stern@rowland.harvard.edu, gregkh@linuxfoundation.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On 22/01/2019 at 02:10, Rob Herring wrote:
> On Wed, Jan 16, 2019 at 10:57:40AM +0100, Nicolas Ferre wrote:
>> This removes a line left while adding the correct compatibility string for
>> sama5d3 10/100 interface. Now use the "atmel,sama5d3-macb" string.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> ---
>>   Documentation/devicetree/bindings/net/macb.txt | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
>> index 3e17ac1d5d58..f5c414b10e27 100644
>> --- a/Documentation/devicetree/bindings/net/macb.txt
>> +++ b/Documentation/devicetree/bindings/net/macb.txt
>> @@ -3,8 +3,7 @@
>>   Required properties:
>>   - compatible: Should be "cdns,[<chip>-]{macb|gem}"
>>     Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
>> -  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs or the 10/100Mbit IP
>> -  available on sama5d3 SoCs.
>> +  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
> 
> Where is "atmel,sama5d3-macb"?

It's actually a couple of line below: line 13 of the resulting macb.txt 
file. It was already in the file when I removed the leftovers.

Do you advice to try to better sort entries in this file? Is there a 
common pattern?

Best regards,
   Nicolas

>>     Use "cdns,np4-macb" for NP4 SoC devices.
>>     Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
>>     Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
>> -- 
>> 2.17.1
>>
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
