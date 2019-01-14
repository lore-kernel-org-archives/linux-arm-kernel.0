Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79845C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DA920651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Csv6rpx0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GzUv+X01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DA920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AJ0VyyY4GpGNg1hBH6aZ25JFXXId9zxD6W/TPVFbBKY=; b=Csv6rpx0RQollT
	WLgfM4LSxbzK77eucs5HJ54c6lxa8g2CvDy5XO2/qAfpDGTCurd9d1QcRWfr7N5eZKeSgt21Uq7P7
	3Mes9HJ7ABfs1OstSRv0P0IJxVms58wFnW+tVd7htRg/hstEtMpDDDUW2tZ590Fc+RL619FHjK3RJ
	uOTKuTlu4jwj4qhH/e13wwCnso6texajJMgoe/1Leph5nFIeLksCdDSwWMftpZR9tVKuKhWWKRs/e
	K0jIwd+adoB0T9xqQjwstTIvvvQbKOrzU95DMTkAi7oqn3pRvcAH4ZbmS7tY9gqPZymwhfc72CkDp
	dy5kJ5EFZ14wI48Gm/Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj7nP-0001oF-2d; Mon, 14 Jan 2019 19:21:15 +0000
Received: from mail-eopbgr740052.outbound.protection.outlook.com
 ([40.107.74.52] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj7nK-0001nX-QA
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 19:21:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50t7m6tlXiQ8OasY1KpdEa6t4TyMuFrjMCV3hR2pUjk=;
 b=GzUv+X01bjzhV1qgOt5e4zuNde3Ax7Y+6KOazDbKyvGFn4eqUykG2spZGjkwR40hPkYDVhN/EjorkFbrF7lJEnA6/+vn3Xz0ZfiYFQ1w+86BYxGH1zDKSHFhWcP9dOw1AatZZ8dFVQabPIeoRa+laRoo5ZsKDzBLbOe/clqgfgQ=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1828.namprd12.prod.outlook.com (10.175.102.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Mon, 14 Jan 2019 19:21:08 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090%11]) with mapi id 15.20.1516.019; Mon, 14 Jan
 2019 19:21:08 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Topic: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Index: AQHUqLYqeBA87jEBLUOvwyi3in13KaWoPfAAgAZfVICAAAyHgIAAYvAAgAAasQCAAAG3AIAAAgEA
Date: Mon, 14 Jan 2019 19:21:08 +0000
Message-ID: <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
In-Reply-To: <20190114191350.GA29600@fuggles.cambridge.arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM5PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:206:1::44) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR12MB1828;
 20:n+EGYNSi/hzTgA+NK7om5IliMCKjJ5ncpOMXEk+UxqR7jrQv45KTZT5yDyK/H8sQMA9lOaxGdOBnfnOwmlox9GkSg+jxF6V7BBIlZX7vW0aP6XqpGE/0ixiYp2aMRKWqJxAbqTSnni4gF/NnzBPkLvTa7GhrH7AFaIW6xon/ea0mkXMsCaXydPi8/SsXl3/WWkHMyTVdxHxWCN3Q7uzEd4zq+B0PnHb16XRcOn22T+B9XA7kcGY7lW4h+T6S9UcQ
x-ms-office365-filtering-correlation-id: f02f0da5-87a6-4d7f-a633-08d67a556f88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR12MB1828; 
x-ms-traffictypediagnostic: BN6PR12MB1828:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-microsoft-antispam-prvs: <BN6PR12MB18289421122348CCFB2FAC0D83800@BN6PR12MB1828.namprd12.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(43544003)(199004)(189003)(551934003)(99286004)(72206003)(256004)(478600001)(31696002)(86362001)(71200400001)(71190400001)(2616005)(386003)(229853002)(6436002)(102836004)(6506007)(65806001)(6486002)(186003)(476003)(97736004)(46003)(486006)(93886005)(11346002)(76176011)(52116002)(65956001)(446003)(64126003)(25786009)(6512007)(53936002)(6246003)(14454004)(8676002)(4326008)(54906003)(6916009)(105586002)(81156014)(81166006)(58126008)(106356001)(305945005)(31686004)(68736007)(5660300001)(316002)(8936002)(7736002)(6116002)(65826007)(2906002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1828;
 H:BN6PR12MB1714.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S96glF9ERGVvJiXts7N06eFPPtEChEsbGTpXvNI5JSmMkLWAgUGEP713U+KcStJTtlEo20tcdQPHjNn+tPOZye9XogDJYNpr8z2rlrUsZ1XcLm8KPYB815tNnh59OzOIoU8m06QCMzRVCajqzAej9btVmRbcxezkYy7zjRg+Ss3uE8e65WiywhfQsQdExgJjoN5nmdVA3K8IuDcaJvUDkZClBLUzvDyUtGRK8VhL0MHWsxwsO0h3Qpy50f8iFo3x0av3GiHzz+h5uYkcrMJ1U0rnZ9UDc13qjD7TEcUIQKEb+NtujRY5ILZsHILaVwA6T3ar5ZfhiTk1ciI9APU+WSoX4d9r3tCvBHbEp+LLAEz7RCspXhEA4DAsPhyrbfU74qxboLz9wsf4fwG4o7APetvIZqf7H9u7lbLi79jI7UE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <E528CC0473A908438E9FB0E453C856E2@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02f0da5-87a6-4d7f-a633-08d67a556f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 19:21:08.4461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1828
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_112111_681445_8178A46B 
X-CRM114-Status: GOOD (  22.49  )
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

Am 14.01.19 um 20:13 schrieb Will Deacon:
> On Mon, Jan 14, 2019 at 07:07:54PM +0000, Koenig, Christian wrote:
>> Am 14.01.19 um 18:32 schrieb Ard Biesheuvel:
>>              - The reason remapping the CPU side as cacheable does work (which I
>>              did test) is because the GPU's uncacheable accesses (which I assume
>>              are made using the NoSnoop PCIe transaction attribute) are actually
>>              emitted as cacheable in some cases.
>>                 . On my AMD Seattle, with or without SMMU (which is stage 2 only), I
>>              must use cacheable accesses from the CPU side or things are broken.
>>              This might be a h/w flaw, though.
>>                 . On systems with stage 1+2 SMMUs, the driver uses stage 1
>>              translations which always override the memory attributes to cacheable
>>              for DMA coherent devices. This is what is affecting the Cavium
>>              ThunderX2 (although it appears the attributes emitted by the RC may be
>>              incorrect as well.)
>>
>>              The latter issue is a shortcoming in the SMMU driver that we have to
>>              fix, i.e., it should take care not to modify the incoming attributes
>>              of DMA coherent PCIe devices for NoSnoop to be able to work.
>>
>>              So in summary, the mismatch appears to be between the CPU accessing
>>              the vmap region with non-cacheable attributes and the GPU accessing
>>              the same memory with cacheable attributes, resulting in a loss of
>>              coherency and lots of visible corruption.
>>
>>          Actually it is the other way around. The CPU thinks some data is in the
>>          cache and the GPU only updates the system memory version because the
>>          snoop flag is not set.
>>
>>
>>      That doesn't seem to be what is happening. As far as we can tell from
>>      our experiments, all inbound transactions are always cacheable, and so
>>      the only way to make things work is to ensure that the CPU uses the
>>      same attributes.
>>
>>
>> Ok that doesn't make any sense. If inbound transactions are cacheable or not is
>> irrelevant when the CPU always uses uncached accesses.
>>
>> See on the PCIe side you have the snoop bit in the read/write transactions
>> which tells the root hub if the device wants to snoop caches or not.
>>
>> When the CPU accesses some memory as cached then devices need to snoop the
>> cache for coherent accesses.
>>
>> When the CPU accesses some memory as uncached then devices can disable snooping
>> to improve performance, but when they don't do this it is mandated by the spec
>> that this still works.
> Which spec?

The PCIe spec. The snoop bit (or rather the NoSnoop) in the transaction 
is perfectly optional IIRC.

> The Arm architecture (and others including Power afaiu) doesn't
> guarantee coherency when memory is accessed using mismatched cacheability
> attributes.

Well what exactly goes wrong on ARM?

As far as I know Power doesn't really supports un-cached memory at all, 
except for a very very old and odd configuration with AGP.

I mean in theory I agree that devices should use matching cacheability 
attributes, but in practice I know of quite a bunch of devices/engines 
which fails to do this correctly.

Regards,
Christian.

>
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
