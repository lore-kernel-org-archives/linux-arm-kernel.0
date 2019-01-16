Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:36:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BCC20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H7hY6VD5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5PuWk8RX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BCC20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GBTm2cAzrcjv992A7jwLS7nNcZ1SkuxkDDA6bz7FW24=; b=H7hY6VD5n+dqxl
	qV5R/c5sDyHiHqg0llPe/qqUlxv2VV50mHkg8G8cp0p5WbE9aMj7lHJS6e9OcwGHJ55i1jFyxTnfY
	3Xcc4pW+sV02JCSqfYvgpMSWhinQbdSpVij40bHYWT5Krih8PuI804H0W6BfApwZPTrUucvg6J0If
	HfyTXPXxdqZpliehrx022UIb8WmMpKwW3Aw8dc91Tv3abRel5BJQYocRXzDb/vPO6VwqfdNgJq0oz
	FTNEb0nASgKMgHBtxgEZjniEPnExPHtFqEDemiixYE8GUWoqKYMTTjHWRhgpEedDO3ucNK+hDQlMD
	5ciNogxuPT83e5vOGMGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjfk5-0007tp-BV; Wed, 16 Jan 2019 07:36:05 +0000
Received: from mail-eopbgr820058.outbound.protection.outlook.com
 ([40.107.82.58] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjfk2-0007tQ-1F
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 07:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuOxI1mfPcE718ss50c6wYtffm3KloGil4Sop5UUca4=;
 b=5PuWk8RXM+n3iYNo7K6lFqMSBINJA5GQvuF3okEIe2SZmuvhvCBRypJ93wnpAsG1GTVijt8I1edOiIKKZ+kkRSOKCPa3kUydb/lMXfEGtFusrd50MdcxnjTWr5FhrmZ4LBYGTE1jJ4Luv8bt5QyaDsaAzcqpoqxCA/KllOBhrU4=
Received: from CY4PR12MB1717.namprd12.prod.outlook.com (10.175.62.139) by
 CY4PR12MB1751.namprd12.prod.outlook.com (10.175.62.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Wed, 16 Jan 2019 07:35:58 +0000
Received: from CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::7dec:669a:ec18:7f0f]) by CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::7dec:669a:ec18:7f0f%7]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 07:35:58 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Topic: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Index: AQHUqLYqeBA87jEBLUOvwyi3in13KaWoPfAAgAZfVICAAAyHgIAAYvAAgAAasQCAAAG3AIAAAgEAgAAEIgCAAQsEgIAA2mIAgAB2HYA=
Date: Wed, 16 Jan 2019 07:35:58 +0000
Message-ID: <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
 <20190114193548.GB29600@fuggles.cambridge.arm.com>
 <87a7k2yx66.fsf@concordia.ellerman.id.au>
 <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
In-Reply-To: <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To CY4PR12MB1717.namprd12.prod.outlook.com
 (2603:10b6:903:121::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR12MB1751;
 20:frZSrrkJOxoKWoHmJrtm3Ty33j0bCo6wgswe5gw4q93pDthP5gQJpE6m86Ty8I+IzdprITYW43qeEOpKsjSnhSqgmkVjWPRugqXBxehIiaXf0JeCDaCNqptwGP84FJTLzltZkDUG2BMgl84t/rNctlS5h62KVgeoSpvYAw1cKBVC+GJdOa4wb0WJq9wX+PYcb3S2RAJ5xuipYhI5nfoKuy8QxfRwzS6NwwwjbRiVDwm68KT9g7UHpaR6CcxDy4/R
x-ms-office365-filtering-correlation-id: 24c14c0d-d4d9-431a-0ec2-08d67b85418f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR12MB1751; 
x-ms-traffictypediagnostic: CY4PR12MB1751:
x-microsoft-antispam-prvs: <CY4PR12MB1751ABBCC6C5D74863F4842083820@CY4PR12MB1751.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(71190400001)(71200400001)(11346002)(97736004)(25786009)(229853002)(4326008)(53936002)(6246003)(7416002)(6512007)(446003)(6116002)(86362001)(6486002)(31696002)(486006)(476003)(46003)(64126003)(68736007)(2906002)(6436002)(2616005)(7736002)(31686004)(305945005)(105586002)(106356001)(8676002)(81156014)(8936002)(316002)(99286004)(186003)(478600001)(52116002)(36756003)(102836004)(386003)(72206003)(110136005)(54906003)(65826007)(65806001)(14444005)(256004)(65956001)(5660300001)(58126008)(81166006)(93886005)(14454004)(76176011)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1751;
 H:CY4PR12MB1717.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sPiZ0r48goOCDcE+Ocz9Ik/Qw2jt9QKb5KbJtK/w6wYPWRZd5H1hwpkzA+mhO6EEibnoiazt0rTTgFAjjfowY7XlmTaGZRhXkPM5nBmABS2W2QzSp/bTlk1KMsM2Xc7baPcrYZOj+7HCY7ZWOIQw0zh1LdYz4guGGPwgRwX99aFDzk5Up0sDI75d0aZZhwazJovCD3GzAJL/ZauUbAWhmf7udjD0KtieDJwe0LltUNDOEff9WjtyLOOmpaYwcn5udx/2go51FuH3Zxpzm3LK8NEvFDK+4tmV9I+L4w7XYm191eA5v+7tRu1+DVCf1/T9LY82pjuvLTH5okfE6xTaR3NputKVpum9NkfVIcLN6q7+jILDRG22i9lGjGqtVje7Io0GVCVJpzuoUjmJh/6YptJrVVWktCU7hRBmes5QcR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <4A8E14009A14C34A840EDD336B706F9B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c14c0d-d4d9-431a-0ec2-08d67b85418f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 07:35:55.6747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_233602_076746_C09B32EE 
X-CRM114-Status: GOOD (  17.44  )
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
Cc: Carsten Haitzler <Carsten.Haitzler@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Airlie <airlied@linux.ie>,
 =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?QmVybmhhcmQgUm9zZW5rcsOkbnplcg==?=
 <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am 16.01.19 um 01:33 schrieb Benjamin Herrenschmidt:
> On Tue, 2019-01-15 at 22:31 +1100, Michael Ellerman wrote:
>>>> As far as I know Power doesn't really supports un-cached memory at all,
>>>> except for a very very old and odd configuration with AGP.
>>> Hopefully Michael/Ben can elaborate here, but I was under the (possibly
>>> mistaken) impression that mismatched attributes could cause a machine-check
>>> on Power.
>> That's what I've always been told, but I can't actually find where it's
>> documented, I'll keep searching.
>>
>> But you're right that mixing cached / uncached is not really supported,
>> and probably results in a machine check or worse.
>   .. or worse :) It could checkstop.

Not sure if that would be so bad, it would at least give us a clear 
indicator that something is wrong instead of silently corrupting data.

> It's also my understanding that on ARM v7 and above, it's technically
> forbidden to map the same physical page with both cached and non-cached
> mappings, since the cached one could prefetch (or speculatively load),
> thus creating collisions and inconsistencies. Am I wrong here ?

No, but you answer the wrong question.

See we don't want to have different mappings of cached and non-cached on 
the CPU, but rather want to know if a snooped DMA from the PCIe counts 
as cached access as well.

As far as I know on x86 it doesn't, so when you have an un-cached page 
you can still access it with a snooping DMA read/write operation and 
don't cause trouble.

> The old hack of using non-cached mapping to avoid snoop cost in AGP and
> others is just that ... an ugly and horrible hacks that should have
> never eventuated, when the search for performance pushes HW people into
> utter insanity :)

Well I agree that un-cached system memory makes things much more 
complicated for a questionable gain.

But fact is we now have to deal with the mess, so no point in 
complaining about it to much :)

Cheers,
Christian.

>
> Cheers,
> Ben.
>
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
