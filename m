Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3510DC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:45:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037E020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tXOYQTds";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uJBStDlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037E020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fM8ixNaDFSatiD62rjgYhmmv7kQ3z35RV7/fXsv9+/A=; b=tXOYQTdsumvNrp
	M6cOwWaLLszVj9A0H2QwiqCvRPkyijKI9FMRk+CEASNj5yE9kYj1+CybkCAhxLGxDS9P9ca7XBszg
	EdCiGKlRoUSV3dkFbmqfGvyfQ8rT/hW5TMpsJCVDkMFVSv0XPEYl69Sf10qCqGZWBQFV81bVnaKz7
	lP6D2D2aVucmHU8B79FxBx6gtBOeHYLWLFiSwyQ4K8tAYFyfKgGCSHfeMrNRNVyQocijmYV078ChC
	Ne4aeZCJIehcMnPjKMZSRs0qVnYTWQDydDFqnRxFn5O7wrHLd5Y5kYLas0Olv5pjKSIHdoaxiKvII
	1+GPKy3ox8p5RzL8Jwjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbZW-0005wi-Ss; Thu, 24 Jan 2019 09:45:18 +0000
Received: from mail-eopbgr810047.outbound.protection.outlook.com
 ([40.107.81.47] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbZS-0005wC-9b
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/pDJhRUGys9jUMusQi6I+O68rG3wkkWFHyUrdqnFko=;
 b=uJBStDltMkdnXL7uIGk02yXm1C9VxA29DhXCTiykwDa0Q5cOc0siIKqt5tVALrJ5PwRM2Az4EjZevWEAG/p+ROu0Z2eZTPPKce1sl8C/8HLJWij+qGnFhb21Dgao7VGzBX6zDLBa1WnmiILHKGOVgywCbo0Q5i+RXWieZFM7bx0=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1771.namprd12.prod.outlook.com (10.175.91.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Thu, 24 Jan 2019 09:45:12 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 09:45:12 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Topic: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gAgAAA64CAAASOgA==
Date: Thu, 24 Jan 2019 09:45:12 +0000
Message-ID: <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
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
In-Reply-To: <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P191CA0064.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::41) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR12MB1771;
 20:ZG62PIr/YAZ2OWgRdWcBHyQ9aRo3/84WQKgBeCFgYK1R/VK/t11844sh8G4gMM09/IXiyz3cklL32SIe2j6bZcti/weSfzIPinYJnlNeG/N7JzM481dSXHweE0/PqcriJ0Gk9yHDaXza7q/ArdKDA4PR1lm4ehw5g5f7N0s79WjCKrP1ZK9R+QhLm8Mt+PgLCTW3r/Tb41G96GI/HQOm/nbZWg3isgiqRXUsdSxI2VY9tzrWw8OsLPq9fLtvH7W/
x-ms-office365-filtering-correlation-id: 86194bc8-b296-4240-6f36-08d681e0a2a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR12MB1771; 
x-ms-traffictypediagnostic: DM5PR12MB1771:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1771B066F606C45D5725107A839A0@DM5PR12MB1771.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(6506007)(76176011)(386003)(102836004)(52116002)(6116002)(316002)(6486002)(31696002)(6436002)(105586002)(14444005)(65956001)(256004)(65806001)(65826007)(71200400001)(186003)(31686004)(7416002)(71190400001)(446003)(11346002)(36756003)(106356001)(476003)(46003)(2616005)(2906002)(478600001)(68736007)(72206003)(99286004)(6512007)(486006)(93886005)(6916009)(25786009)(229853002)(97736004)(39060400002)(305945005)(81156014)(81166006)(54906003)(86362001)(8676002)(7736002)(53936002)(4326008)(58126008)(8936002)(64126003)(14454004)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1771;
 H:DM5PR12MB1546.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 22q6HlGiVBLZw36aIidVkGTPCxowaOwbfjnq6T1PACcE6qqaY2T1WjhQh6h3I3ooxSMyS7j+tLQ4xM6KRENHqcdF5WJ0e4M2ASOkyH7Lf+fHhUUzxmiUj/ssL/ab61CaG2RGgB31NAfq9OmJDIkGNBzpDaWuLOUJTZswityM9Cst3IzcnkV/gU1u7sFyepNwz4AuVTyIN1dh3s3icIs9zLeU+oCMDGstWMPh/FjlMZDa2pwrmw0NiIoREIm4ulY2FOaa+QPJILMlpZXVuybz6RC774LuVPtQn+oOIvWYeGSnOspoGsXz8zAcMthQ59jzW9XngMgZSkcwn0LXYnCdlEeXdL53nRtFwmSiWxlQiAegMj+MRW8rw1d/5A/5Ygd6l/PDVnF45ktweCMpv8JbW3+wQjkDcesp7dEmYdT/s10=
Content-ID: <4FACB70F4502C74F892D9E8CBB9DBD2D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86194bc8-b296-4240-6f36-08d681e0a2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 09:45:07.8527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_014514_338650_D912A072 
X-CRM114-Status: GOOD (  18.21  )
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

Am 24.01.19 um 10:28 schrieb Ard Biesheuvel:
> On Thu, 24 Jan 2019 at 10:25, Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
>> Am 24.01.19 um 10:13 schrieb Christoph Hellwig:
>>> On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
>>>> But my concern is that it seems likely that non-cache coherent
>>>> implementations are relying on this hack as well. There must be a
>>>> reason that this hack is only disabled for PowerPC platforms if they
>>>> are cache coherent, for instance, and I suspect that that reason is
>>>> that the hack is the only thing ensuring that the CPU mapping
>>>> attributes match the device ones used for these buffers (the vmap()ed
>>>> ones), whereas the rings and other consistent data structures are
>>>> using the DMA API as intended, and thus getting uncached attributes in
>>>> the correct way.
>>> Dave, who added that commit is on Cc together with just about everyone
>>> involved in the review chain.  Based on the previous explanation
>>> that idea what we might want an uncached mapping for some non-coherent
>>> architectures for this to work at all makes sense, but then again
>>> the way to create those mappings is entirely architecture specific,
>>> and also need a cache flushing before creating the mapping to work
>>> properly.  So my working theory is that this code never properly
>>> worked on architectures without DMA coherent for PCIe at all, but
>>> I'd love to be corrected by concrete examples including an explanation
>>> of how it actually ends up working.
>> Cache coherency is mandatory for modern GPU operation.
>>
>> Otherwise you can't implement a bunch of the requirements of the
>> userspace APIs.
>>
>> In other words the applications doesn't inform the driver that the GPU
>> or the CPU is accessing data, it just does it and assumes that it works.
>>
> Wonderful!
>
> In that case, do you have any objections to the patch proposed by
> Christoph above?

Yeah, the patch of Christoph actually goes way to far cause we have 
reports that this works on a bunch of other architectures.

E.g. X86 64bit, PowerPC (under some conditions) and some MIPS.

The only problematic here actually seems to be ARM, so you should 
probably just add an "#ifdef .._ARM return false;".

Regards,
Christian.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
