Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:10:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5FC2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UE2NnRCG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cxn5BooC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5FC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uvxp4BsVn/+KDbL+kNAHplHdlWUb7huOKheaCbGJZjU=; b=UE2NnRCGj0jJ5I
	kbmeKIN9Gd34SIboyZUN2eUYiNn90DRgrG00InruzKQkLCKzG/dl45jciUpvTEVk/jPjtRnlWnAWC
	PcVhD3WP2+//0jbSY7CtioRPwkpckYggTsd3XxOJ7ZqG7B7hylq7r+yq88SXqqmPibOXTvQq9b3AB
	k7n0JZfm2luaiiw80HeY6P69N8yGTFPkNl2LbQpwNynD4H55hQQNsy1P9V0c/2TtOKm6ucuXuUPYg
	e9XHS5faM/mpz2qaILROSh2tuNu1ZKhbg3+BkSP2z3WquyI8DE+uLXPFAT8N4RaP3JMbeBsQFlXBf
	R7prrPPNKrOgTQ2Wwmxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwp39-0007ft-4Y; Thu, 21 Feb 2019 14:10:07 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwp35-0006th-Ce
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 14:10:04 +0000
X-IronPort-AV: E=Sophos;i="5.58,395,1544511600"; d="scan'208";a="24226512"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Feb 2019 07:10:02 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 21 Feb 2019 07:10:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PBlad3HwjgaxXFTRcgVTWxlkGiUuVJ71eatm/tl+Hs=;
 b=cxn5BooCVKb/j/GI+KPvutABfILdXQXZzuKOH097e62wjuns5oAwF3SQyESdZEdbnTEV84pdE2kSx+FvIGumXBiO6dNmyt6a4UqzEER1xpIjdJ6tBH8QK310Q97yh4eAevuUKy02l2CT2dLfZ3Gn4zpSH9Q5Esl63ktFxum/96Q=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB2030.namprd11.prod.outlook.com (10.169.236.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 14:09:57 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 14:09:57 +0000
From: <Nicolas.Ferre@microchip.com>
To: <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Topic: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUyevGQg3OphZfLEu2uH5tbWx1E6XqSl0A
Date: Thu, 21 Feb 2019 14:09:57 +0000
Message-ID: <4d728bb8-cada-6656-204f-2ae766211f5e@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
 <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::28) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b8c97f9-2091-4307-aa2d-08d698064241
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB2030; 
x-ms-traffictypediagnostic: MWHPR11MB2030:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIyMDMwOzIzOkFUVzRBVm5HQm13dURwZWw1WlRZR2VJWE5D?=
 =?utf-8?B?ZUZ5Yi8xbFZiMmllNHdLRllNeUdtamR0OXZVeDZvQmZWZThPU1NMZnFFczIw?=
 =?utf-8?B?ZGNEYlI2SDY2eXRTTWVNYm9lWmh0RGQ5VGMrTDNnNUJ4c2I3bkRzVENxRm15?=
 =?utf-8?B?eTd2Q3NBR0hrTjYvalloWGNFbXp1b0FDaGRvYUxQaWNFUWZiNGZKZE50bjV2?=
 =?utf-8?B?QkIrZkFNZkc2Qm9NMmNibTBOdWtQMlhWNjNEL3FEbkFNaExFdXpjRFhZU2pT?=
 =?utf-8?B?cWt4ekZodDF6bmptZmQ4K21WZ0hwcUtVZE9SUWF0NzhUMmVkMDAwRlpnUndJ?=
 =?utf-8?B?L3YrbkRBazRsdDBpNFpOZ0VEMDRlU3VINlBzSnVaVzlKVkVhd0RENkJ0bDE0?=
 =?utf-8?B?ZnVobTUyam40K0gwSFFTZHNmWDFURnZQM0VvNEpiNTIzTUFxWE5oVVRIcFRH?=
 =?utf-8?B?ZklQcXQxWFVZOXJvQWM2aS9ReFI3Zlp3b3dWR1UxWHdYQ2JEbGVlQVc5dHFD?=
 =?utf-8?B?aE43NzJHZHI0U1l6ejBhUlQ5MHE2bWlKSzZMUEJwaytBQVV6N1IweDJhbUds?=
 =?utf-8?B?OWdmR2RROW5vU3dzWUdYQmlSajJSRHBGUVdEUHZvdzdyU0J4MnpZRG1NSUM1?=
 =?utf-8?B?VW1LQVhUZ09KS2hJWldGejdCd3ZjZkxBazc0a3VFVjFSYmRRMmk2RlFUYnVh?=
 =?utf-8?B?SFZZOHJaQ0JBMjQ5Mm5tLzdvMHd0TDFmc3FqSnRDQmhPL1lUMTRwZkg4QS9O?=
 =?utf-8?B?UW4vV1ozMGhxRHpqd3h6V3U5L3FwZW5zQnNYRzFDNjRWeWVHVk9HMWgxd1M1?=
 =?utf-8?B?UHdFOEI4QVhRQ0Nwd3NhKy9FejRzYk8xUVhlV2d3RWw5TjdNZm96Q0YwZEpN?=
 =?utf-8?B?djlLZGtDQVo4NFM4dTVwZVpnMUkvMUtHc0lTZTRPMDVNV1czZExVaVFHN3VZ?=
 =?utf-8?B?b0JXSi9YNkRjZHZVRkUwUnBCdjRqNlpzcExVeE9RQVRhRGZDN2dlQStPS09r?=
 =?utf-8?B?ajJxQUNTdzdiR21KekN4NFRwem5oSUZKQ1NKeVlKVVc0ZXpFZEhjNHVqL2VE?=
 =?utf-8?B?STZhVmV1TGtpdTNJUG9ITDRwZ09kQjB4WEtRZFVtUlZNSUZ0VE40MGtZdElJ?=
 =?utf-8?B?a0hGbDIwc0VaR0JkVnZxam5ab0J1N0xLZTY2OFN2UUhhbGY3OFVGTnU1bEZh?=
 =?utf-8?B?dGlva1lVdHNoYmRSK1hhTUJMUU9pWFdKR1NYb0xDMWExNUdrRGQ5dS9aVnJP?=
 =?utf-8?B?TExlUGdpVkZpUlVBeE5ZUUFxZkhXNXFud3pyMzlQc3hUbzh1VXNwOWNUdVpu?=
 =?utf-8?B?RHllb1hJdWQvVURqeGczTFdoVm0xWUQrTTVlVE1uWG9odWxmSCtLZDBMWENG?=
 =?utf-8?B?d2RVdGJWQ0I2MVNZUi8rOXdkek84REo3RzZqTVExaE1zNDhTMlVDNWNNa05a?=
 =?utf-8?B?cHpwQTk0ZmNxTGVYOC9GWGNmelBWQXI3ZGx4NTRidkNyRDNaVHVqS0dFcnVL?=
 =?utf-8?B?MUIzTHVlMXNNaCtZeFY1NnRwbEl3b2JCMWFmV1ZxOVhZV1dvbFl5MTg3N0JK?=
 =?utf-8?B?Z25XNjhlNnlzaFN6eC9ZeTBvUlA0WEVjT1NkdmF0WmNyaTRHQjZZUSsxWWRu?=
 =?utf-8?B?MGJEQ0NWY1ZBREdEUWFNL2psTlYxWG5TK3B3cVIxZWJ2V0pvRi9oYWtML2wv?=
 =?utf-8?B?ZjVYek1OYUNoYW1FS1g5bWdlaVhEV1VPdktsbFVlRzlxWFlUNkFMbXcvcS91?=
 =?utf-8?B?UFBtNXp4L2hLbzlsNDVNY0xRcURmbWZtcE0xYkZGbm04NUp5T1RDbis5L3hn?=
 =?utf-8?Q?FupZLEOVNhMJk?=
x-microsoft-antispam-prvs: <MWHPR11MB20303280238CB4C42C642459E07E0@MWHPR11MB2030.namprd11.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(53546011)(386003)(99286004)(2501003)(68736007)(2906002)(26005)(25786009)(476003)(2616005)(486006)(76176011)(11346002)(446003)(97736004)(102836004)(6506007)(52116002)(186003)(66066001)(86362001)(31696002)(6246003)(4326008)(6116002)(3846002)(72206003)(36756003)(478600001)(14454004)(105586002)(54906003)(305945005)(110136005)(229853002)(7736002)(8936002)(6486002)(71190400001)(256004)(106356001)(31686004)(6512007)(53936002)(81156014)(81166006)(14444005)(8676002)(316002)(5660300002)(6436002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB2030;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NyS5PQDPZ3p6wjEdlrdE74agVISK1opQKurdY6kGY6t5kGPWoNS1UVmjgVtez7ymZdSYuRTzcXRTMnX129THe1xswpCoArOWFKFpYpwWCpSMmeEIfWQpVPfGXzHEPxwqghdWRn2DKk8BAdxvKlLNddxAUYi0siMGVg512RFp/8aYSYJZ/P4j9ZCEGa7MFw6+OOAmaPQ0AATONUOZgq0PmVG3sXWij+2daicHIIbnytEtQR/LgfTRn3DyDrBAyKyBoGcu5jug69Cp1KDZzd0eoytA8HTGu72iYsU5psSiEz5Kw3oxZkYTpYS86hoth58tRSguvOuDt7eXTwpoZzn/ms1BLFPl76A/tW9qZq6T/bajW13h9Xio4bx+mPOm5gJR1PyPEBYz8CbxmYOYgZ8tMXEFngVXnPJCodywzshevqg=
Content-ID: <14B759396FBAD44AB926956191F84D69@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8c97f9-2091-4307-aa2d-08d698064241
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 14:09:54.1926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2030
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_061003_487305_BDF8F34A 
X-CRM114-Status: GOOD (  14.26  )
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

On 21/02/2019 at 14:45, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add documentation for SAM9X60 shutdown controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu. Regards,
   Nicolas

> ---
>   Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 14f319f694b7..50f282ccbcb7 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -83,7 +83,7 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
>   1) shdwc node
>   
>   required properties:
> -- compatible: should be "atmel,sama5d2-shdwc".
> +- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc".
>   - reg: should contain registers location and length
>   - clocks: phandle to input clock.
>   - #address-cells: should be one. The cell is the wake-up input index.
> @@ -95,6 +95,9 @@ optional properties:
>     microseconds. It's usually a board-related property.
>   - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
>   
> +optional microchip,sam9x60-shdwc properties:
> +- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
> +
>   The node contains child nodes for each wake-up input that the platform uses.
>   
>   2) input nodes
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
