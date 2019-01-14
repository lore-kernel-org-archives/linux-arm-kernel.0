Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3A32064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GjT9XpT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3A32064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Nw+GoOwEocRt/Mpbei4D2L0N27uIAuEeUDmUZAhGHg=; b=GjT9XpT+KYE/dw
	4bhGzQa8ACe3S/GS49xsot3b7xwQLc0SqrlHnrQULw1zXv4zwyATTjxcSv5MgDB00kSVbW0WCAl/n
	V7aUnqkC7DEZZ0jVr0R3uaOsqPbbL1X/F+pbRDf/T51LlCUOqDPoRweQE4GChC64BrpxnDFhPL3pg
	/UbUxWuFwTAXkh+z2oS/CUnC/B5DqNaus4FV4LpM+9mDOTmZ8MXfvxfrM3aOhTRcSgVtC2AZ/w2Lb
	z2DJlfPStuek/G9Vynd5EQufZCKgxDkd/KTRkeQApt2BHNMzuEGM7Ul2xOiuyPWTkjXCJc84X1Hwm
	cK65YN6tnVHJcPWZ/Bhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj81e-0002hS-S3; Mon, 14 Jan 2019 19:35:58 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj81a-0002gz-KL
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 19:35:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89390A78;
 Mon, 14 Jan 2019 11:35:53 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 517133F5BD;
 Mon, 14 Jan 2019 11:35:51 -0800 (PST)
Date: Mon, 14 Jan 2019 19:35:48 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Message-ID: <20190114193548.GB29600@fuggles.cambridge.arm.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_113554_678205_598A5FD2 
X-CRM114-Status: GOOD (  31.58  )
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
 mpe@ellerman.id.au, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>,
 benh@kernel.crashing.org, "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+ BenH and MPE]

On Mon, Jan 14, 2019 at 07:21:08PM +0000, Koenig, Christian wrote:
> Am 14.01.19 um 20:13 schrieb Will Deacon:
> > On Mon, Jan 14, 2019 at 07:07:54PM +0000, Koenig, Christian wrote:
> >> Am 14.01.19 um 18:32 schrieb Ard Biesheuvel:
> >>              - The reason remapping the CPU side as cacheable does work (which I
> >>              did test) is because the GPU's uncacheable accesses (which I assume
> >>              are made using the NoSnoop PCIe transaction attribute) are actually
> >>              emitted as cacheable in some cases.
> >>                 . On my AMD Seattle, with or without SMMU (which is stage 2 only), I
> >>              must use cacheable accesses from the CPU side or things are broken.
> >>              This might be a h/w flaw, though.
> >>                 . On systems with stage 1+2 SMMUs, the driver uses stage 1
> >>              translations which always override the memory attributes to cacheable
> >>              for DMA coherent devices. This is what is affecting the Cavium
> >>              ThunderX2 (although it appears the attributes emitted by the RC may be
> >>              incorrect as well.)
> >>
> >>              The latter issue is a shortcoming in the SMMU driver that we have to
> >>              fix, i.e., it should take care not to modify the incoming attributes
> >>              of DMA coherent PCIe devices for NoSnoop to be able to work.
> >>
> >>              So in summary, the mismatch appears to be between the CPU accessing
> >>              the vmap region with non-cacheable attributes and the GPU accessing
> >>              the same memory with cacheable attributes, resulting in a loss of
> >>              coherency and lots of visible corruption.
> >>
> >>          Actually it is the other way around. The CPU thinks some data is in the
> >>          cache and the GPU only updates the system memory version because the
> >>          snoop flag is not set.
> >>
> >>
> >>      That doesn't seem to be what is happening. As far as we can tell from
> >>      our experiments, all inbound transactions are always cacheable, and so
> >>      the only way to make things work is to ensure that the CPU uses the
> >>      same attributes.
> >>
> >>
> >> Ok that doesn't make any sense. If inbound transactions are cacheable or not is
> >> irrelevant when the CPU always uses uncached accesses.
> >>
> >> See on the PCIe side you have the snoop bit in the read/write transactions
> >> which tells the root hub if the device wants to snoop caches or not.
> >>
> >> When the CPU accesses some memory as cached then devices need to snoop the
> >> cache for coherent accesses.
> >>
> >> When the CPU accesses some memory as uncached then devices can disable snooping
> >> to improve performance, but when they don't do this it is mandated by the spec
> >> that this still works.
> > Which spec?
> 
> The PCIe spec. The snoop bit (or rather the NoSnoop) in the transaction 
> is perfectly optional IIRC.

Thanks for the clarification. I suspect the devil is in the details, so I'll
try to dig up the spec.

> > The Arm architecture (and others including Power afaiu) doesn't
> > guarantee coherency when memory is accessed using mismatched cacheability
> > attributes.
> 
> Well what exactly goes wrong on ARM?

Coherency (and any ordering guarantees) can be lost, so the device may see a
stale copy of the memory it is accessing. The architecture requires cache
maintenance to restore coherency between the mismatched aliases.

> As far as I know Power doesn't really supports un-cached memory at all, 
> except for a very very old and odd configuration with AGP.

Hopefully Michael/Ben can elaborate here, but I was under the (possibly
mistaken) impression that mismatched attributes could cause a machine-check
on Power.

> I mean in theory I agree that devices should use matching cacheability 
> attributes, but in practice I know of quite a bunch of devices/engines 
> which fails to do this correctly.

Given that the experiences of Ard and I so far has been that the system
ends up making everything cacheable after the RC, perhaps that's an attempt
by system designers to correct for these devices. Unfortunately, it doesn't
help if the CPU carefully goes ahead and establishes a non-cacheable mapping
for itself!

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
