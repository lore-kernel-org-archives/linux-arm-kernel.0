Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35824C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:15:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F272A206B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CsZsg29i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F272A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kC+X6VJ7uwqzbNdHdA8WtPcyc7LXKciGKFxDQz7aspI=; b=CsZsg29iJ4lu4D
	1laSn2YlLXTy0ciqjQkB8GV05vzz3XDLOqTVoISTvbw28/vvjB8JcI2YJIKrCvybmPG9Stm3+TxeW
	gQLIL/PT5BYhADhIPc+rm655ZLb1EMQiDVqkuZPY2nEJ8lorreAfr3/gD5RYaTKiWxD8lrUvH2awO
	/3U1maxFotEoDMwsJcCXIdx9SF5RkOMjjOWiyYAvEkEAqAzhI3HDdqNISdf4AKBJcZyEgnQAnYQ1N
	pT9YMa6zyxcIAoU0VAuhXlRZPkovndnTGqwNmj680rTcD2ZiJCbs5uCWhRqOF1yUfuHk+bEXUHg3M
	k6fku2W8JoPvv61N3zuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyU9B-0003xy-DY; Tue, 26 Feb 2019 04:15:13 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyU97-0002wc-Hc
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 04:15:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3A17A78;
 Mon, 25 Feb 2019 20:15:02 -0800 (PST)
Received: from [10.162.40.137] (p8cg001049571a15.blr.arm.com [10.162.40.137])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 EEEEC3F71D; Mon, 25 Feb 2019 20:14:59 -0800 (PST)
Subject: Re: [PATCH V2 1/6] KVM: ARM: Remove pgtable standard functions from
 stage-2 page tables
To: Mark Rutland <mark.rutland@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-2-git-send-email-anshuman.khandual@arm.com>
 <20190225110014.GB26236@lakrids.cambridge.arm.com>
 <7bf0d18e-9714-4da9-a340-10aae5fa9f38@arm.com>
 <20190225154922.GJ26236@lakrids.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d5ccc1ae-b97a-5e01-78c7-a2f377b3024f@arm.com>
Date: Tue, 26 Feb 2019 09:45:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225154922.GJ26236@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_201509_595936_7F18FCE0 
X-CRM114-Status: GOOD (  26.15  )
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



On 02/25/2019 09:19 PM, Mark Rutland wrote:
> On Mon, Feb 25, 2019 at 07:50:27PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 02/25/2019 04:30 PM, Mark Rutland wrote:
>>> Hi Anshuman,
>>>
>>> On Mon, Feb 25, 2019 at 10:33:54AM +0530, Anshuman Khandual wrote:
>>>> ARM64 standard pgtable functions are going to use pgtable_page_[ctor|dtor]
>>>> constructs. Certain stage-2 page table allocations are multi order which
>>>> cannot be allocated through a generic pgtable function as it does not exist
>>>> right now. This prevents all pgtable allocations including multi order ones
>>>> in stage-2 from moving into new ARM64 (pgtable_page_[ctor|dtor]) pgtable
>>>> functions. Hence remove all generic pgtable allocation function dependency
>>>> from stage-2 page tables till there is one multi-order allocation function
>>>> available.
>>>
>>> I'm a bit confused by this. Which allocations are multi-order?
>>>
>>
>> Stage-2 PGD.
>>
>> kvm_alloc_stage2_pgd -> alloc_pages_exact
>> kvm_free_stage2_pgd -> free_pages_exact
>>  
>>> Why does that prevent other allcoations from using the regular routines?
>>
>> At present both stage-2 PGD (kvm_alloc_stage2_pgd -> alloc_pages_exact), PUD|PMD
>> (mmu_memory_cache_alloc) allocates directly from buddy allocator but then while
>> freeing back stage-2 PGD directly calls buddy allocator via free_pages_exact but
>> PUD|PMD get freed with stage2_[pud|pmd]_free which calls pud|pmd_free instead
>> of calling free_pages() directly.
> 
> If we allocate/free the stage-2 PGD with {alloc,free}_pages_exact(),
> then the PGD level is balanced today.
> 
> I don't see what that has to do with the other levels of table.

The idea is either all page table levels pages go through ctor/dtor constructs
or none of them do. Not only this makes sense logically but also prevents getting
into bad page state errors when freeing without calling dtor. For other non-KVM
use cases like kernel linear or vmmap it helps while tearing down the page table
for memory hot-remove cases.

> 
>> All of these worked fine because pud|pmd_free called free_pages() directly with
>> out going through pgtable_page_dtor(). But now we are changing pud|pmd_free to
>> use pgtable_page_dtor() both for user and host kernel page tables. This will
>> break stage2 page table (bad page state errors) because the new free path which
>> would call pgtable_page_dtor() where as alloc patch never called pgtable_page_ctor().
> 
> I'm lost as to how that relates to the alloc/free of the PGD. AFAICT,
> that's unrelated to the problem at hand.

As mentioned above either all page table use ctor/dtor based allocation/free or
none of them do.

> 
> What subtlety am I missing?

pmd|pud_free() will call dtor() after the series hence they cannot be used by
stage2_pmd|pud_free because stage2_pud|pmd get allocated from pre-allocated
mmu_memory_cache_alloc which builds with __get_free_page(PGALLOC_GFP). Is not
that right ? 

> 
>> To fix this situation either we move all stage-2 page table to use pte_alloc_one()
>> and pte_free() which goes through pgtable_page_ctor/dtor cycle or just keep the
>> virtualization page tables out of it (stage2/hyp) and remove the only dependency
>> which breaks because of these changes. This series went with the second option. 
> 
> It sounds to me like this is just a mismatch between the alloc/free
> paths for the PUD and PMD levels of table.
> 
> IIUC, we allocate those with {pmd,pud}_alloc_one(), and free them with
> stage2_{pud,pmd}_free(), which call {pud,pmd}_free().

AFAICS they get allocated from mmu_memory_cache_alloc instead. pud|pmd_alloc_one()
get used only for the _hyp_ mappings not for the stage2 table.

kvm_handle_guest_abort
	user_mem_abort
		stage2_set_pud_huge -> stage2_get_pud -> mmu_memory_cache_alloc
		stage2_set_pmd_huge -> stage2_get_pmd -> mmu_memory_cache_alloc
		stage2_set_pte -> mmu_memory_cache_alloc

Am I missing something here.

> 
> I would naively expect p?d_alloc_one() to pair with p?d_free(), so that
> being a problem is surprising to me.

They work absolutely fine. But thats not the case here. stage2_pud|pmd_free()
calls pud|pmd_free() for pages not allocated with pud|pmd_alloc_one().

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
