Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF030C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:37:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98266217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p722Sd5R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i5Br2AVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98266217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3I9wN0l5pmcQqgYsNEj7czLN71qWvxbl8TwfPRwcMfc=; b=p722Sd5Rvs5/8t
	rFOLCTr2zn61gYB0f2hMwkYYiN43tVtZ+mW+GZ4VgCfwGfMCv1Injl6MTWeQldiHUalSxrhmGIcNC
	W8O5ghX99sGv/o8Wb08Kt3qNpJDuUGW2WZ7xIV91hjEeYV+cZYd4vWG0iHbUeXmnyIluTuGoJZUx1
	cHiQs7ZMOdynctYHkP2XN9USUiuwU9MUyviPGQKNSblHSOB1QxBlGluonXvQ3UYKIJEqDr0dvORQl
	QWH6RmwCvqNYpzDVnX3Ib1jZcO18A2bfbNgCrOw/yrRvqPMg14Y15/Syzy0FWCy7SusQbAnIIa+to
	5zzR1KbW1xCmrlSKTkfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmdKI-0005Bk-7r; Thu, 24 Jan 2019 11:37:42 +0000
Received: from mail-bl2nam02on0620.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::620]
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmdKE-0005B1-GE
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWo/JpDfLERoTEvy07CLEshKybOBtvoS1BSz04ddzDI=;
 b=i5Br2AVXNfQ1tQ7Yjg/IxJnQ0N/4n1DsKN+0+F7TBHwQGaQ1yQvixw0hqlYffUJPS5fe+NbHTdOrZEqhx+y+IntR0AYgAvOXkmdy2MjOer5gVB1ruoyxGbmdyo4vHGuK4hvyzokwO+wqqH6USXqyWIoB1kJ/EYvd0H+ggY8SwOo=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1226.namprd12.prod.outlook.com (10.168.237.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 24 Jan 2019 11:37:33 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 11:37:33 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Topic: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gAgAAA64CAAASOgIAAA/WAgAAXlACAAAC8AIAAAx8A
Date: Thu, 24 Jan 2019 11:37:32 +0000
Message-ID: <40ad3ae7-9970-0cb9-d35c-05e128f83820@amd.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
 <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
 <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
 <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::37) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR12MB1226;
 20:f+wIn9Ei8lOGm1Oxo4Pa3vI7YEwb6qg85ndIICENvENW3JTmutyN/HjH7fblm53jT4riFL+5EQJw+v6KAlmDBz9u88Pm6Hiw/I3LJQTP+tMvbXp4dS6a5oGQFxevIrs16AHzP4ssaRb1TTkCb6VyiyXzfKTFW204v8L8xjI4vYdhQ+gWPNnbMTu8BVq58wUER07O03wOU56UyvKllh9xJ7NQmd46G+yXc1HDLqLHaVde0SMxrLsa7GDBsshEDCto
x-ms-office365-filtering-correlation-id: 29a80888-f77e-4623-55a2-08d681f0544b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR12MB1226; 
x-ms-traffictypediagnostic: DM5PR12MB1226:
x-microsoft-antispam-prvs: <DM5PR12MB12262CAD31D6E92555997D67839A0@DM5PR12MB1226.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(6116002)(93886005)(76176011)(71200400001)(52116002)(65956001)(46003)(65806001)(71190400001)(6916009)(476003)(58126008)(316002)(2616005)(65826007)(386003)(6506007)(186003)(102836004)(54906003)(446003)(11346002)(97736004)(14454004)(68736007)(105586002)(7416002)(106356001)(486006)(31686004)(99286004)(81166006)(25786009)(6436002)(86362001)(81156014)(8676002)(229853002)(6246003)(6486002)(72206003)(64126003)(2906002)(31696002)(14444005)(256004)(8936002)(478600001)(53936002)(7736002)(305945005)(4326008)(39060400002)(36756003)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1226;
 H:DM5PR12MB1546.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3K5FuE9rdkB/GQIImsDNnVQpMZNb0Kjm/dwcfzEol0BeHrq8yU5sM5p0E4YS9vAlQ1O1ed1XUXk+uYu0Voambh3NnR9Tmf1bUBZ2h0xheb9NUPthfJuOMMeG08iMvx3XA+htWCeszRQjFVdHId2sydfCrICLktL1FvBWAMpNLH86dmCRV0ukp+W4MU7TgNTARQ4+Hfy6Ul0rUh+wgZHgtGQbw1nD/LoqonrluEvF9amFgfUHmH0OBZUdG/lfMufBu/uZovVZT+KNCtEriwo8cr2m1QZQNpAOgRpTK8e70G+bAc45qe58X+Mx1tX7AHDA6mwfsGlQEkJM/qHWwKuHfheT1avo1dFx8sVdAzlHXs3/8vT1pieEByD82ug9PhudwMkbWH0kjxsdKablP/KcX7OXj0v5IheI8xzgJYkeDM4=
Content-ID: <59400AED9633BA419EDBE63373A4A150@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a80888-f77e-4623-55a2-08d681f0544b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 11:37:28.7058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1226
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_033738_549004_52D92490 
X-CRM114-Status: GOOD (  18.58  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>,
 David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am 24.01.19 um 12:26 schrieb Ard Biesheuvel:
> On Thu, 24 Jan 2019 at 12:23, Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
>> Am 24.01.19 um 10:59 schrieb Ard Biesheuvel:
>>> [SNIP]
>>> This is *exactly* my point the whole time.
>>>
>>> The current code has
>>>
>>> static inline bool drm_arch_can_wc_memory(void)
>>> {
>>> #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
>>>      return false;
>>>
>>> which means the optimization is disabled *unless the system is
>>> non-cache coherent*
>>>
>>> So if you have reports that the optimization works on some PowerPC, it
>>> must be non-cache coherent PowerPC, because that is the only place
>>> where it is enabled in the first place.
>>>
>>>> The only problematic here actually seems to be ARM, so you should
>>>> probably just add an "#ifdef .._ARM return false;".
>>>>
>>> ARM/arm64 does not have a Kconfig symbol like
>>> CONFIG_NOT_COHERENT_CACHE, so we can only disable it everywhere. If
>>> there are non-coherent ARM systems that are currently working in the
>>> same way as those non-coherent PowerPC systems, we will break them by
>>> doing this.
>> Summing the things I've read so far for ARM up I actually think it
>> depends on a runtime configuration and not on compile time one.
>>
>> So the whole idea of providing the device to the drm_*_can_wc_memory()
>> function isn't so far fetched.
>>
> Thank you.
>
>> But for now I do prefer working and slightly slower system over broken
>> one, so I think we should just disable this on ARM for now.
>>
> Again, this is not about non-cache coherent being slower without the
> optimization, it is about non-cache coherent likely not working *at
> all* unless the optimization is enabled.

As Michel tried to explain this CAN'T happen. The optimization is a 
purely optional request from userspace.

> Otherwise, the driver will vmap() DMA pages with cacheable attributes,
> while the non-cache coherent device uses uncached attributes, breaking
> coherency.

Again this is mandated by the userspace APIs anyway. E.g. we can't 
vmap() pages in any other way or our userspace APIs would break.

Regards,
Christian.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
