Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F165C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:25:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D93E2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NGCo26SR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HM8cQ3iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D93E2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K3vlFHFxPcStyF554ImcAD4Y9oBVqh8oO8fUnm8eyzQ=; b=NGCo26SRQBuaKr
	fi+ViYCljvzLG/oHrfeqA/Z9M//Y8rpt78a/Xe/88Nx3ThedbZ/jozh1Rr5OrVDkEa1iKytMlg5Wc
	ZaWDREbVacLPFtttRNwuE5ZycMiNeV7fWID8fXLVxh3d+N9S+DlNtY80UsUr2cuaursvz6r68x9Nq
	GKG7G8DqJHCW7esWZLXywMizsFt/A0G+EhEcVUJgBhmkyYdU8eZA1a8THsTppnzml3Zkmg9RjU1Fp
	IrJA/DILN7FyAS1M+WJKaPNwaYVCMekFvA9AOzhPdxW2j++5O+7gVwvXQ2clqxJU24sBt3kx2Gw1p
	AfNiooNO28vOlTzuCvCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbGZ-0005hw-VW; Thu, 24 Jan 2019 09:25:43 +0000
Received: from mail-eopbgr700044.outbound.protection.outlook.com
 ([40.107.70.44] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbGW-0005hM-EO
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:25:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/UDPKzli20McYRNipqvsucEBKx+BsCxVSEDm6NSZxo=;
 b=HM8cQ3iq+mDSMBKnwEDXTCo+Q41MQQt37wqNPOUziFPRosb4492RE2RiMWT+XwDgY7+X8c0J3Bu1QSOCtxz6TjayZl1z65gE2liII09HQRe3YFxZqyFZDP6swQP68qdjkfiyHDKtE3RAeetJv2GcwiKnVDsIMym31Dm283Nd4q4=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2453.namprd12.prod.outlook.com (52.132.141.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 09:25:35 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 09:25:35 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Christoph Hellwig <hch@infradead.org>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Topic: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gA
Date: Thu, 24 Jan 2019 09:25:35 +0000
Message-ID: <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
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
In-Reply-To: <20190124091316.GA22796@infradead.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::39) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR12MB2453;
 20:zyMb8abFgMnzaXjaQP9Kc2TKuvKJxqijB/XwV6X3dewWVNpSFWBwvn0SoxY40KDpn+MX+rGMHfdfIuujkpI5gyXParC3HgFnfWfhnyRLEwGahlmKSNhvwUc5LcXzzgk7zScwLILOggQR0jhBhKOCsRmIR1lXVctHMJbuoWIa38xzDT5jySluKpjKs9D03HdiGahas0ci8ql/mq1iPlhHHBnmwgkoNDmbti+Ry7HrOou3scO3gXJqlAylBQCw6P+a
x-ms-office365-filtering-correlation-id: 21aa0c3f-4bf1-46cb-7608-08d681dde540
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR12MB2453; 
x-ms-traffictypediagnostic: DM5PR12MB2453:
x-microsoft-antispam-prvs: <DM5PR12MB24535115A21FB525EB5C522C839A0@DM5PR12MB2453.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(186003)(386003)(6506007)(81166006)(8936002)(102836004)(81156014)(2906002)(52116002)(93886005)(76176011)(4326008)(6246003)(256004)(14444005)(39060400002)(25786009)(486006)(106356001)(31686004)(105586002)(53936002)(6512007)(6436002)(86362001)(6486002)(7736002)(476003)(64126003)(8676002)(2616005)(446003)(31696002)(11346002)(46003)(110136005)(54906003)(58126008)(99286004)(305945005)(316002)(478600001)(229853002)(72206003)(6116002)(65806001)(65956001)(14454004)(97736004)(71200400001)(71190400001)(7416002)(65826007)(36756003)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2453;
 H:DM5PR12MB1546.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J8HiUFXKZIjdPxPqOOqVvRa11E/WdmTGqycNKDmoUjNG4RNMeGHcNIzgxDDTsxKPpOyzBPZzrJD6XmW8at9yfdyOqlTMMp33lsBr/3VSIRCI726NaLlV54wu77PGPCquDF64fAK+AW96AAAMKKaqd+TzD+s847CGHMUHbyThlImRhxlmroSHJnUEEFIH7USpszKvYUhoUWNW4gwn/EOv7P8J/Jg2smFTDGDFkSbR9/8UOEYp6kQT26VlbpI2ohoBvYLBuZbQMYMw+bSpQUe8b+eCTyk9QOa8K3GKaF7UI3SbjNGANFvNmbsOVBRKMOO/yMY+uYW5CKQnlDGpGEstGf7MtusfyFDUZv+xqVNMrdtVnYwzTK31fRMIHq95NHM3cOAGN1EptBju2BzCvBh76QhJ/fbOMYh8gG0sp3pe4hY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <AF3B4EBF3CBDD3479AB379D417D317C6@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aa0c3f-4bf1-46cb-7608-08d681dde540
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 09:25:32.7644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2453
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_012540_539150_6F487757 
X-CRM114-Status: GOOD (  19.16  )
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
 Jerry" <Jerry.Zhang@amd.com>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am 24.01.19 um 10:13 schrieb Christoph Hellwig:
> On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
>> But my concern is that it seems likely that non-cache coherent
>> implementations are relying on this hack as well. There must be a
>> reason that this hack is only disabled for PowerPC platforms if they
>> are cache coherent, for instance, and I suspect that that reason is
>> that the hack is the only thing ensuring that the CPU mapping
>> attributes match the device ones used for these buffers (the vmap()ed
>> ones), whereas the rings and other consistent data structures are
>> using the DMA API as intended, and thus getting uncached attributes in
>> the correct way.
> Dave, who added that commit is on Cc together with just about everyone
> involved in the review chain.  Based on the previous explanation
> that idea what we might want an uncached mapping for some non-coherent
> architectures for this to work at all makes sense, but then again
> the way to create those mappings is entirely architecture specific,
> and also need a cache flushing before creating the mapping to work
> properly.  So my working theory is that this code never properly
> worked on architectures without DMA coherent for PCIe at all, but
> I'd love to be corrected by concrete examples including an explanation
> of how it actually ends up working.

Cache coherency is mandatory for modern GPU operation.

Otherwise you can't implement a bunch of the requirements of the 
userspace APIs.

In other words the applications doesn't inform the driver that the GPU 
or the CPU is accessing data, it just does it and assumes that it works.

Regards,
Christian.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
