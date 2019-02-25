Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:49:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FEE20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ln53/Mdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FEE20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jEMMPjkVEhqTiqWBz3WrBcHiqDbA2/AU5qhmK9k7GUc=; b=Ln53/MdbTEzIE1
	fym3I5JdF5MQ9vHmxWK3Z+zE/9JpTSwI8yFdUOsWrU3Qs79pfB256Hub1bAAnJkVh7q8loPMuk+7j
	nWGcLX3/XcJzjqqEBvyb3cezf/f/eg0BoVLGUnIrGSTv4voTVplbW2luHswDCJWUr3g9Mpi4bZ3/3
	C75J1UYDZreJ1AGCBPc8ua1cZzq/rCYK2wfGdKFIpcM25xx7dX3vg3/8VYHYmqjf5RQPGqLVbLU2E
	BWRWZe7xr3LA2b40pToqoijNzb2Jnvx+X39S2gY2kJmd1rOoFRpb5nNmrCpoonqvNrjx4fjbl/XW5
	tMiB9dEiO/onsbWS0Bjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIVW-00010R-Fl; Mon, 25 Feb 2019 15:49:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIVT-0000zo-3f
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 15:49:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABBE380D;
 Mon, 25 Feb 2019 07:49:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5CD3F703;
 Mon, 25 Feb 2019 07:49:24 -0800 (PST)
Date: Mon, 25 Feb 2019 15:49:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 1/6] KVM: ARM: Remove pgtable standard functions from
 stage-2 page tables
Message-ID: <20190225154922.GJ26236@lakrids.cambridge.arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-2-git-send-email-anshuman.khandual@arm.com>
 <20190225110014.GB26236@lakrids.cambridge.arm.com>
 <7bf0d18e-9714-4da9-a340-10aae5fa9f38@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7bf0d18e-9714-4da9-a340-10aae5fa9f38@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_074927_156678_817823FB 
X-CRM114-Status: GOOD (  18.57  )
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
Cc: yuzhao@google.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 07:50:27PM +0530, Anshuman Khandual wrote:
> 
> 
> On 02/25/2019 04:30 PM, Mark Rutland wrote:
> > Hi Anshuman,
> > 
> > On Mon, Feb 25, 2019 at 10:33:54AM +0530, Anshuman Khandual wrote:
> >> ARM64 standard pgtable functions are going to use pgtable_page_[ctor|dtor]
> >> constructs. Certain stage-2 page table allocations are multi order which
> >> cannot be allocated through a generic pgtable function as it does not exist
> >> right now. This prevents all pgtable allocations including multi order ones
> >> in stage-2 from moving into new ARM64 (pgtable_page_[ctor|dtor]) pgtable
> >> functions. Hence remove all generic pgtable allocation function dependency
> >> from stage-2 page tables till there is one multi-order allocation function
> >> available.
> > 
> > I'm a bit confused by this. Which allocations are multi-order?
> > 
> 
> Stage-2 PGD.
> 
> kvm_alloc_stage2_pgd -> alloc_pages_exact
> kvm_free_stage2_pgd -> free_pages_exact
>  
> > Why does that prevent other allcoations from using the regular routines?
> 
> At present both stage-2 PGD (kvm_alloc_stage2_pgd -> alloc_pages_exact), PUD|PMD
> (mmu_memory_cache_alloc) allocates directly from buddy allocator but then while
> freeing back stage-2 PGD directly calls buddy allocator via free_pages_exact but
> PUD|PMD get freed with stage2_[pud|pmd]_free which calls pud|pmd_free instead
> of calling free_pages() directly.

If we allocate/free the stage-2 PGD with {alloc,free}_pages_exact(),
then the PGD level is balanced today.

I don't see what that has to do with the other levels of table.

> All of these worked fine because pud|pmd_free called free_pages() directly with
> out going through pgtable_page_dtor(). But now we are changing pud|pmd_free to
> use pgtable_page_dtor() both for user and host kernel page tables. This will
> break stage2 page table (bad page state errors) because the new free path which
> would call pgtable_page_dtor() where as alloc patch never called pgtable_page_ctor().

I'm lost as to how that relates to the alloc/free of the PGD. AFAICT,
that's unrelated to the problem at hand.

What subtlety am I missing?

> To fix this situation either we move all stage-2 page table to use pte_alloc_one()
> and pte_free() which goes through pgtable_page_ctor/dtor cycle or just keep the
> virtualization page tables out of it (stage2/hyp) and remove the only dependency
> which breaks because of these changes. This series went with the second option. 

It sounds to me like this is just a mismatch between the alloc/free
paths for the PUD and PMD levels of table.

IIUC, we allocate those with {pmd,pud}_alloc_one(), and free them with
stage2_{pud,pmd}_free(), which call {pud,pmd}_free().

I would naively expect p?d_alloc_one() to pair with p?d_free(), so that
being a problem is surprising to me.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
