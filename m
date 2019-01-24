Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE8EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:23:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D12520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nrZil8nH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CEznkfB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D12520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BuPo3tWMTm1LrzJZUMvdrKq3tzMgGwhKdP+W7xnvXsE=; b=nrZil8nHsetQff
	azHBcBUebgH6a7fdBDiXQoOjohYNXc0uGI57qV/sqlITTNmxZ4oiG+XU97CT5jyRztj4o5HKBEnHN
	6OxaWdcrcuYxTZ2MfMTglz5Z9ZCSr/5FBp72o/MdgzeTgbHi2bswcQnvWmdx9iJaJ/BSpUI8mHn+K
	e+4ZNZU5t3HJoRYDMz6A4hZLFZVS77cxtqKEIRngdzhXoVCf3OdLRr1Sxd6Fngw8EFEXbAwTEazK5
	7H+hV6zszO3srsEETmgjuzJaoln6xvE84wVoBOElb3+1LrWYAJBEeg/e76GT8Dp6Pq2+rq8yyFMPZ
	kU7V8L4cMFdSPCFisL5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmd6v-000076-Pq; Thu, 24 Jan 2019 11:23:53 +0000
Received: from mail-eopbgr750074.outbound.protection.outlook.com
 ([40.107.75.74] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmd6s-000067-6Z
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxWNwSmmE55sTJyelMz8iE/HwWE5xzZ37IN9KuTrM0k=;
 b=CEznkfB6B4IcBokBPZYTrjNw3uDMUffyzHkAQkModP9RUZ1qP0KnCEsiOWSxmF/EVsXUhSXKGk/k9piqnipDgCtSoCHQ33CO/s3J84zMgRqBswznjpyy/7RDkRD83m3m9r7AECYMTAdNHWX1gCwTSRQ7rLuQd2Q/eLp4fVg4CeA=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2358.namprd12.prod.outlook.com (52.132.141.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 11:23:44 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 11:23:44 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Topic: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gAgAAA64CAAASOgIAAA/WAgAAXlAA=
Date: Thu, 24 Jan 2019 11:23:44 +0000
Message-ID: <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
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
In-Reply-To: <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P194CA0058.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::35) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR12MB2358;
 20:pidIhfitzqAf77YOc8041QHkVEampjBLxYnFFsOFtMxCW2FJ0udHu7DXPALdXO64fX8iN/1NyOjV23RVEvw6dGVXPatsivK2Go0HNl5aCa3zkPYa5eb0Zj2nyl/dTc/Cn7coLpgKjo0eo0qoFKJfnffvQj22L6a3ujsdxyeD4cT0O19wb1j4EHV18vpflo8P3rd1cq69r0KOcZMlQDn70pXeA8d/FdSp5seq9pSZz3GCbSujF/Z36YPRd7yFZZjv
x-ms-office365-filtering-correlation-id: 52663b9c-8925-49b1-a884-08d681ee6647
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR12MB2358; 
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-microsoft-antispam-prvs: <DM5PR12MB23580468F09993F81E2902BB839A0@DM5PR12MB2358.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(386003)(8936002)(6436002)(39060400002)(25786009)(6246003)(64126003)(2906002)(7416002)(71200400001)(71190400001)(316002)(6116002)(54906003)(4326008)(256004)(14444005)(99286004)(229853002)(6486002)(6506007)(476003)(2616005)(58126008)(6916009)(11346002)(31696002)(486006)(106356001)(7736002)(31686004)(446003)(65826007)(86362001)(105586002)(93886005)(76176011)(52116002)(97736004)(65806001)(186003)(14454004)(53936002)(81156014)(81166006)(478600001)(36756003)(65956001)(102836004)(72206003)(305945005)(68736007)(6512007)(46003)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2358;
 H:DM5PR12MB1546.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DAVEv5QzCck1Aoob2jDTbhZPF312BQk2V+MTy9mr66Mc5qOEdmTmvIsVoSVtR5bakLryVJA11FgVZAtwk/jho3KgRWsw9Uveg9laDwLjDW0LZaWOpg6dqRp0u4K3ET65aS+G6VFr7DxczwnWQLdE85RPgwS6DkU9rKTiNln4oCUoqUj7qip7F+NE+Hlem0aI+zgB9YTj9GZlmB0svezfwCxKti/xeqaNFZt0a3EYqGELevauS/SNO/ou7W+QG6H79Y9A5YBhJXkfDGf/1Ldrqv0SPSIfxH0H0WzO4hE8/RYtKrzm0+iM0zLvh/1bb2ludgyXj2vJDfDfHnQDZgEC8JMhg5ZbeqWO5Esbh0+w4JCBvav+lyYye0mK0UqMoOuu9p3tQQ2tLyRDEJvInCwGuVE7IyuBBxoJisEnaAE6/II=
Content-ID: <9F6D95F38827FC45AA3D1323D4075171@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52663b9c-8925-49b1-a884-08d681ee6647
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 11:23:41.0452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_032350_291285_626FA024 
X-CRM114-Status: GOOD (  18.51  )
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

Am 24.01.19 um 10:59 schrieb Ard Biesheuvel:
> [SNIP]
> This is *exactly* my point the whole time.
>
> The current code has
>
> static inline bool drm_arch_can_wc_memory(void)
> {
> #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
>     return false;
>
> which means the optimization is disabled *unless the system is
> non-cache coherent*
>
> So if you have reports that the optimization works on some PowerPC, it
> must be non-cache coherent PowerPC, because that is the only place
> where it is enabled in the first place.
>
>> The only problematic here actually seems to be ARM, so you should
>> probably just add an "#ifdef .._ARM return false;".
>>
> ARM/arm64 does not have a Kconfig symbol like
> CONFIG_NOT_COHERENT_CACHE, so we can only disable it everywhere. If
> there are non-coherent ARM systems that are currently working in the
> same way as those non-coherent PowerPC systems, we will break them by
> doing this.

Summing the things I've read so far for ARM up I actually think it 
depends on a runtime configuration and not on compile time one.

So the whole idea of providing the device to the drm_*_can_wc_memory() 
function isn't so far fetched.

But for now I do prefer working and slightly slower system over broken 
one, so I think we should just disable this on ARM for now.

Christian.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
