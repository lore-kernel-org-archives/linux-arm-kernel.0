Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE832C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2EF2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/ITZVMb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eRFyywDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2EF2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nc7g6l3APemdDRI7S5QYjFDnKwcavhSsvt93u1C7XVM=; b=Q/ITZVMbOPbLRq
	EsayyE3WW5X5nB3/9+FkSBPXhG6YoFdsxAvGAa8Dbo65t+/ZGK8Ft0iCzXOjlE88akuVUSDD20gdW
	HoaGCSsv0bdvpVrh6a1o+CNDk8jCRW0XW3aThheZ84fuTRZsi99tY9mBS+ouf0uLOMLtUKwJihikN
	YQcDEXzVGvethATcGnzRRlabkZF8zRT5tXHTmvKfQNiQTGPOyRnqxVdC3b8WiymMcjTi8XMGexiAN
	JZG4+sMk+5ViSj2KbKkU+1/VSRqzyYjgDjuoH83aTK7smoS0YqOw/5cL7S0pjaVseyR0JBNXv61uJ
	/UwYw80hdjvHZs1sB6QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxaA-00009Z-TQ; Fri, 11 Jan 2019 14:14:46 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxa7-00008k-0R
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:14:45 +0000
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; d="scan'208";a="25369090"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Jan 2019 07:14:41 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 11 Jan 2019 07:14:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvL+no0KxpoNZpfGiVu0S73UvSSkwTMrQ1idRz+sY9k=;
 b=eRFyywDM6rQptLtqGlsOHMs85dGydszATsyTw+MaKFz+mZ59NkW16lM509vP8SNS/RfzQjkwUINmTMPpGq+b9IoClW8xhB910VbmMgFKcJ+aN8nOwuX5vbttXjGeDt4TrOwZAi7XgpB9LPAMC+RN+OTcvh6WHe3oL+b+rnaHN0U=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1888.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 14:14:39 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:14:39 +0000
From: <Nicolas.Ferre@microchip.com>
To: <peda@axentia.se>, <bbrezillon@kernel.org>
Subject: Re: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Topic: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Index: AQHUqPal2z9iTYzgb0+a4YlOuMR4jaWox3GAgAFJ8YCAAAyhgA==
Date: Fri, 11 Jan 2019 14:14:39 +0000
Message-ID: <e80fe1f1-afcb-9f81-8d08-d9774bacf123@microchip.com>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-3-peda@axentia.se> <20190110184816.63350396@bbrezillon>
 <23d60fbc-42c4-a2b2-5616-d21eabfd0a3f@axentia.se>
In-Reply-To: <23d60fbc-42c4-a2b2-5616-d21eabfd0a3f@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::34) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1888;
 6:BEIdp3raQd1UTIbmgdCK6ZJa1b9/8X9uZ+2zl5kZtRm0z4z1ytcOCgTlFZkdu5ANA0LNKJDVMQR2l3aiGuAkXfVWdpAEgh5J8+J4fe1pmebygn4KCAQte8r1YrqK4X/gJrY/hganZiuMAPzx3C//djK9k9v6TqHd7eh6Xx9OYvIPKOb9sXZnJ0c+ymFpnHD31yRMeko+5iZwIhh0iNAjaEjM6y3SK6gLDgxrCXh/EWMrLl1fQS8PL4YvSzm+yspYK+r4QI3M0ahj58X5o+RbKJSUyLpmoqGIfIOuQC+s1Am+vEkTSi05IqJWF63daOI91/7fd7d3JfWxe1zdDWJ44ro5Cxn91VYGCKWaujCwDYjxdbStEohjauX9CnlFFxuaVhs3PsoEofPbej7Sfzesfv58CMcWAmsQdmAPRuEJDQJaqRUmx8TLQH/pwGoW8CFs64I7arhYHMozN130qsMVlw==;
 5:cUx7ZMnOBdeKR/wWcjERyB/sjVq4HdLrTBCFgFXZQNGmdW6YXOzwCITLdx0kf0Uxs1gj4yMVD1pKdMUwVb+qQCxjeg+iyQwT+9YuSWXZvzCjmW/53FNrIQ5M4s+qBJdRH8u/CF0J5wG/ENAkCdKfzny+jaEXd8vcjPzx+ep0Ne18leDKQQIU4zWXd2BZf+LAjT2DSyPwD9G1geUsX48Mxg==;
 7:KWHIKV4zw9v4alY/JZHEcYSx1conpaQXsPr7/khq7eDuzciq2nEzON92i/cJXpm4bkIgG22kn/ZoaO0W1bM5P5kfFcISPuAlwnzY2QKDebBVh/S9MZO1OWK0IV6cWJmuQDAtSoEONZcDkmmfDRzDsw==
x-ms-office365-filtering-correlation-id: c5f96ed9-1303-4fa7-75aa-08d677cf1f6b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1888; 
x-ms-traffictypediagnostic: MWHPR11MB1888:
x-microsoft-antispam-prvs: <MWHPR11MB1888183726A2BB64D173F916E0850@MWHPR11MB1888.namprd11.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6512007)(2906002)(71200400001)(8676002)(6506007)(386003)(186003)(6116002)(3846002)(6436002)(81166006)(102836004)(26005)(71190400001)(81156014)(7736002)(72206003)(305945005)(316002)(86362001)(446003)(107886003)(575784001)(66066001)(8936002)(6246003)(6486002)(31696002)(5660300001)(478600001)(53546011)(4326008)(966005)(11346002)(54906003)(110136005)(76176011)(486006)(256004)(2616005)(53936002)(106356001)(105586002)(14444005)(97736004)(476003)(52116002)(229853002)(68736007)(36756003)(14454004)(93886005)(31686004)(6306002)(99286004)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1888;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ufCxkAuw9/zN48MUwg/O5VseVrpSyzYn/doeGWxpAFSloul5ti4I0oFRRdcxFWR52i0jaOqYpJJr7ceIefJg8Xe+4mFoUqL+GYxvV9gYUcRUmyETgFRdvkiRz7NvzhfjNmM/gcNC3Ch8G7RwBGL7RYFVpcBV415Q+5ca09OhtcWp7b2m7k5GgMBRP1p36xji7E/kr2cnfzsqbGTawCIx3vZu7cmD4SlNFSSj9zAhdlDb6W2ce0g+gSDxa9V/BbpbcMYFwYzSnsAYY8znFMGIi+6XtT8/P9/dNzeVuw65WZmzJy8PF/kp0k3tF+9KjkJ2TVDcSGVWptAcnf8j2F8kfl4PFzkIRZ6zd5o1EFaaSRrAE0O15rT4rFW9WqSLPPNjPZoKgNEbfoLqXLXY7dIUXCHWWEQCsXSF/5gCsUxWloU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <90F372EEF003F0469F01431B958359F6@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f96ed9-1303-4fa7-75aa-08d677cf1f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:14:39.1938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1888
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_061443_168892_0DC353A4 
X-CRM114-Status: GOOD (  23.19  )
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

On 11/01/2019 at 14:29, Peter Rosin wrote:
> On 2019-01-10 18:48, Boris Brezillon wrote:
>> On Thu, 10 Jan 2019 15:10:39 +0000
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> The destination crtc rectangle is independent of source plane rotation.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>>> index ea8fc0deb814..d6f93f029020 100644
>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>>> @@ -642,9 +642,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>>>   	 * Swap width and size in case of 90 or 270 degrees rotation
>>>   	 */
>>>   	if (drm_rotation_90_or_270(state->base.rotation)) {
>>> -		tmp = state->crtc_w;
>>> -		state->crtc_w = state->crtc_h;
>>> -		state->crtc_h = tmp;
>>
>> Again, I guess I assumed ->crtc_h/w were the width and height before
>> rotation when I initially added rotation support.
> 
> And I thought so too, possibly since I have only been doing drm-stuff
> with this driver, but I also suspect that the incompleteness of the
> libdrm modetest program is to blame. I don't think it's possible to
> specify individual src and dst rectangles with it, and that seems
> rather limiting when dealing with rotated planes. I can easily see
> why someone using modetest thinks the crtc rect should be rotated by
> the driver...
> 
>> This change might break users too.
> 
> Right you are, and the same impossible scenario. Fix things to do the
> right thing and risk breaking users, or don't and preserve the buggy
> non-portable issues of the driver making it unusable for others.

I understand that we are the only ones to be different here. My 
colleague Josh also helped me grasp the implications of this issue.

I would say that we mustn't be different. So please consider fixing 
this. Some users might have started something with rotations but we'll 
make sure to help them with the issue encountered and our additional DRM 
libraries (like libplanes) can be fixed easily to make this change 
transparent.

> I don't care either way, because rotating planes with this stride-
> method is practically useless here. It simply requires to much
> memory bandwidth. I might work ok for smaller panels with lower
> pixel clock frequencies though?

Rotation works for our use cases.

> I think the LCDC might read the same
> data more than once when data is not in the "natural" order? (no,
> I do not need an answer to this question, and I do not have time to
> dig in this area at the moment...)
> 
> However, if you can't do both patch 1 and 2 (because users regress),
> then patch 3 is no good either. The reason is that
> drm_atomic_helper_check_plane_state assumes the rotational
> properties fixed by patch 1 and 2, and the behavior is "odd" if you
> have that wrong.

Thanks for continuing the discussion Boris and thanks to Peter for this 
work. You have my opinion: please go-on with the fix.

Best regards,
   Nicolas

>>>   		tmp = state->src_w;
>>>   		state->src_w = state->src_h;
>>>   		state->src_h = tmp;
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
