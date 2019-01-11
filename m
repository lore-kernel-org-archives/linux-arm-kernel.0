Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701B121783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EWxJH45t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0L//b2Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701B121783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tze9HHANId9ZvISBVbLHa2kvxmw0dQo08AC37lD51Jc=; b=EWxJH45thxo9Pv
	6Z/tlRFZl3XqiuqbdmkSjmAT58bFMt8fz0Ka+uH/urgbfEJ9o1aYclSZScgRVlvo5T2NYDHlLZ28C
	EvMP2rg/Bpon6V4BeAZBva3DrtbIsnvWQmm4bpyJ8+odUjrpG/iv5wfvwoR9tyswkUSK4vabaQatn
	i01gdk5ftCyJHuiflDc0vTCzE4HmveBQCrm/IHoLoWIw3cxx6fZehSTkW2ESHgmOXNOQBoz/XySsQ
	CtTR32OlRk6g0L3HZANtzhRVxUC7bnXygCAFvoagN0qosbnSqi6991je9IO/ifalS/8BKbFK4ZM2t
	R0dBsmJfsDBWIj8T7y9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxeG-0002e3-Oe; Fri, 11 Jan 2019 14:19:00 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxeD-0002dG-FG
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:18:58 +0000
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; d="scan'208";a="25369365"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Jan 2019 07:18:37 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 11 Jan 2019 07:18:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOdCH4rio62Tu9aQaHAy51ldI11moR/S69dG9CFyQJg=;
 b=0L//b2UyAIg3k/5GAwite7bBPtW1HEP0ETynN9EGGewh+WzbkhPsIss19MyfSPTC4rHcytVXaIH3bxZpXZ8Dot1gCJr62aTHQr4blOY1uWGKzt6A72AwqLqd2DUdU4VA/mSNwJlbpmwaQ+bjAZhGwFWYLkN55IdHT2H64OGLz8k=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1664.namprd11.prod.outlook.com (10.172.55.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.17; Fri, 11 Jan 2019 14:18:35 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:18:35 +0000
From: <Nicolas.Ferre@microchip.com>
To: <bbrezillon@kernel.org>, <peda@axentia.se>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqbiJnoZpqps6wk2bx1LYfOfUCQ==
Date: Fri, 11 Jan 2019 14:18:34 +0000
Message-ID: <96578f9c-74f1-38ab-7993-460fd9bc42ee@microchip.com>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon>
In-Reply-To: <20190110184446.75b4350a@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::34) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1664;
 6:oeW9YYzNpBImqNhZcy7pTGWeCF1NGDCsrVAEfXym/f9I5QZW8rVQbabaQezwIHhKBfhrfq9MbxDWRv1rKQAO88ExxudHHVPzWa2ouQSSpDf92SRn442Y3Q97nZvbzAOz64oZsArYm9HKus4YjMHygyFokwhwCl2X/XgnQOPPT59S+pCkegn6VJOz29feaXO3N8hgJomMLwpAdCXIQ6gyLXiKHGjMBVbUDmgqDRXZcTkl9Ye9I8XvPoy57Z0cP/mDWcMpZaFDFTqDpO7KJGGNOUkeUKgtBmhHCg2ye5bWVtIsvs1qBX3/n+nhLq/C26I1MtjMBUN89B3xC+YAHorre/UnIThSazQKD8kAzLgU5qxAZCdYzkj8CRF3tVMQDky1RZxv5qXr1zbEM/8/MvErHoVnb3jrffneBhqI+vBcmD+bHJEiFjqi0DIZnHxdi9O768iGwZzW+lkMDt74Wqxrjw==;
 5:WRRyEekPSobdXLRAQwWxdfTqkcSuA1sdd8ZmWjSxF+YxkCMR3AHX4SHbSy4WRaKDi3Ht1Jsq9h/3nlRamiNBgNScNFz7ib0kj3ntSn+j0+k6f5aP5ZfnEfLQFaKH/5c1vyBmd1XcX2nt4Z+JV7lCemWqcWHa/hZ/m1Wea3cO3SAOwqcEsTaUVP+lznNjxi3V+slO+hIlGoCwhcl1BuSVgg==;
 7:ZcicWsq9t9KChY0M/YiheA4aNyIPTFggVBMTUDaIZhAbYIA4It+ilXlDFKWwjmg639GscvBmYZrUswiXPFyNykHHHMfnT0T+25MJUKxjc9ub77vDoTXlrbynhX7XwcNt0JBlF36l9f/7YAp5FLMTDg==
x-ms-office365-filtering-correlation-id: e1c40280-40a5-45f5-e02e-08d677cfabf5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1664; 
x-ms-traffictypediagnostic: MWHPR11MB1664:
x-microsoft-antispam-prvs: <MWHPR11MB16646F8C8DA2DB35E336F734E0850@MWHPR11MB1664.namprd11.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(52314003)(52116002)(4326008)(54906003)(316002)(86362001)(229853002)(76176011)(31696002)(6436002)(6486002)(106356001)(14454004)(105586002)(6116002)(478600001)(6512007)(72206003)(53936002)(107886003)(6246003)(31686004)(486006)(5660300001)(7736002)(305945005)(3846002)(25786009)(97736004)(2906002)(99286004)(36756003)(186003)(14444005)(8676002)(6506007)(53546011)(102836004)(26005)(386003)(110136005)(68736007)(71200400001)(71190400001)(2616005)(66066001)(256004)(476003)(11346002)(8936002)(81156014)(81166006)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1664;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MYY6k8DEkGokQzAPFVCnHTNSdXV+LKWwjcapHR1ejud/L3lLLM+Zr59RaT9Jq/i4CPILlOYLbPPan0I3DP4+JULewU1R1Ujr+RV/UUOWNd4r7yRTlcaQ3mr4g5oFAEBCFtLVG2wFlTbsAAJ63qo6/M2mvFdpAVDveeC5/9kxUhy+TomwHftPp3b3paqc59TPDDDcOrqsdnUEeKWbZ/Ro2ghqnaG+5bjjdrEh90xQ24bFBlWRKwec/jHL1ry+UkGRZs/cQNxIikGh7eFdh0x75R3/5b/Y4Oy/Uwj1uPOcioHThjSY6GTuh5PKveUdmUjt0vkzvV3EHOfMU0niyjth8vhgYcBZ6UQe4uf+K8RLAyFnZtiTYLlBsvY7OrC0cF7dd/D6Vwa0jHlEqfA9KNmXPc+1Lw2tW+LAXHvhr+larIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <C6AF515EE756F04F910A90230508F347@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c40280-40a5-45f5-e02e-08d677cfabf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:18:34.9589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1664
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_061857_623534_69A490D8 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: alexandre.belloni@bootlin.com, airlied@linux.ie,
 Joshua.Henderson@microchip.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, boris.brezillon@bootlin.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/01/2019 at 18:45, Boris Brezillon wrote:
> On Thu, 10 Jan 2019 15:10:28 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi!
>>
>> I found an unfortunate issue while recoding plane handling to use
>> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
>> which is not correct. I simply fixed it (patch 1/4), but maybe that
>> will cause regressions for unsuspecting users who simply assumed
>> that the clockwise rotation was correct? I don't know what to do
>> about that? Adding an option to get the old broken behavior seems
>> useless, wouldn't it be just as easy to just fix whatever app to
>> rotate the other way instead of adding an option somewhere?
> 
> Hm, rotation support has been added before the standard rotation
> property was created, and at that time I assumed rotation was clockwise
> (which apparently was an unwise choice). Anyway, I don't have a
> solution for this problem, so I'll let Nicolas decide if it's
> acceptable to change the rotation behavior.

Yes, being consistent with standard DRM sub-system is far more important 
in my opinion.

Best regards,
   Nicolas

>> I have only tested this series on sama5d3, but I did check the docs
>> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
>> and sam9x35) supported by the driver (relevant to patch 4/4).
> 
> Thanks for addressing those problems.
> 
>>
>> Cheers,
>> Peter
>>
>> Peter Rosin (4):
>>    drm/atmel-hlcdc: rotate planes counterclockwise
>>    drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
>>    drm/atmel-hlcdc: fix clipping of planes
>>    drm/atmel-hlcdc: do not immediately disable planes, wait for next
>>      frame
>>
>>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 179 +++++++++---------------
>>   1 file changed, 67 insertions(+), 112 deletions(-)
>>
> 
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
