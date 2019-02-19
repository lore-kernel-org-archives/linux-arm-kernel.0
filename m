Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334AFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:10:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB35217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PixQQxGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB35217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qn2s9siFnDMllCWIIVh3iVErfGF38bU6BfxxOSp/z3c=; b=PixQQxGlBImWjz
	g0jv0w1fUUTbf6aHC6AZMTXTa0XtyBqQX9NmoCzMStiZTNa9YxJ0wagL/PfdC2Nyc3FSWXCXJfsBI
	1QscF32+tJZCerDbGG0ULcCFJqv/JaBuXszcOdaIyOm02MHSltl8g05RDeYETZdT58OrfdVWu5mml
	Yh4TnHJDPvlNyV+SlnZapeTXWye+7JpPT0u4EF8h8g+/6i1DxwSM02OE0bpEy4nytDW0QrpANmOsp
	6IZ/6mUP0+HsZsKJmBIlQF9TxUHy0yXMn7Gkyz7IM4gxGZ8qjqP6fRdpzn+p6iXOd3wTZLkPz+6L3
	ZRhOfriegz/6/tRLPKGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvwjU-00062W-TL; Tue, 19 Feb 2019 04:10:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvwjR-0005OI-6c
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 04:10:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E469EBD;
 Mon, 18 Feb 2019 20:10:01 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5C51B3F675; Mon, 18 Feb 2019 20:09:56 -0800 (PST)
Subject: Re: [PATCH] arm64: mm: enable per pmd page table lock
To: Yu Zhao <yuzhao@google.com>, Will Deacon <will.deacon@arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218151223.GB16091@fuggles.cambridge.arm.com>
 <20190218194938.GA184109@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <885bcfa8-1085-d454-540d-4511f5f3886e@arm.com>
Date: Tue, 19 Feb 2019 09:39:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190218194938.GA184109@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_201009_260155_640FA947 
X-CRM114-Status: GOOD (  25.06  )
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
Cc: linux-arch@vger.kernel.org, mark.rutland@arm.com,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Nick Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/19/2019 01:19 AM, Yu Zhao wrote:
> On Mon, Feb 18, 2019 at 03:12:23PM +0000, Will Deacon wrote:
>> [+Mark]
>>
>> On Thu, Feb 14, 2019 at 02:16:42PM -0700, Yu Zhao wrote:
>>> Switch from per mm_struct to per pmd page table lock by enabling
>>> ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
>>> large system.
>>>
>>> I'm not sure if there is contention on mm->page_table_lock. Given
>>> the option comes at no cost (apart from initializing more spin
>>> locks), why not enable it now.
>>>
>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>> ---
>>>  arch/arm64/Kconfig               |  3 +++
>>>  arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
>>>  arch/arm64/include/asm/tlb.h     |  5 ++++-
>>>  3 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index a4168d366127..104325a1ffc3 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
>>>  config ARCH_HAS_CACHE_LINE_SIZE
>>>  	def_bool y
>>>  
>>> +config ARCH_ENABLE_SPLIT_PMD_PTLOCK
>>> +	def_bool y
>>> +
>>>  config SECCOMP
>>>  	bool "Enable seccomp to safely compute untrusted bytecode"
>>>  	---help---
>>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>>> index 52fa47c73bf0..dabba4b2c61f 100644
>>> --- a/arch/arm64/include/asm/pgalloc.h
>>> +++ b/arch/arm64/include/asm/pgalloc.h
>>> @@ -33,12 +33,22 @@
>>>  
>>>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>>>  {
>>> -	return (pmd_t *)__get_free_page(PGALLOC_GFP);
>>> +	struct page *page;
>>> +
>>> +	page = alloc_page(PGALLOC_GFP);
>>> +	if (!page)
>>> +		return NULL;
>>> +	if (!pgtable_pmd_page_ctor(page)) {
>>> +		__free_page(page);
>>> +		return NULL;
>>> +	}
>>> +	return page_address(page);
>>
>> I'm a bit worried as to how this interacts with the page-table code in
>> arch/arm64/mm/mmu.c when pgd_pgtable_alloc is used as the allocator. It
>> looks like that currently always calls pgtable_page_ctor(), regardless of
>> level. Do we now need a separate allocator function for the PMD level?> 
> Thanks for reminding me, I never noticed this. The short answer is
> no.
> 
> I guess pgtable_page_ctor() is used on all pud/pmd/pte entries
> there because it's also compatible with pud, and pmd too without
> this patch. So your concern is valid. Thanks again.

pgtable_page_ctor() acts on a given page used as page table at any level
which sets appropriate page type (page flag PG_table) and increments the
zone stat for NR_PAGETABLE. pgtable_page_dtor() exactly does the inverse.

These two complimentary operations are required for every level page table
pages for their proper initialization, identification in buddy and zone
statistics. Hence these need to be called for all level page table pages.

pgtable_pmd_page_ctor()/pgtable_pmd_page_dtor() on the other hand just
init/free page table lock on the page for !THP cases and additionally
init page->pmd_huge_pte (deposited page table page) for THP cases.
Some archs seem to be calling pgtable_pmd_page_ctor() in place of
pgtable_page_ctor(). Wondering would not that approach skip page flag
and accounting requirements.

> 
> Why my answer is no? Because I don't think the ctor matters for
> pgd_pgtable_alloc(). The ctor is only required for userspace page
> tables, and that's why we don't have it in pte_alloc_one_kernel().

At present on arm64 certain kernel page table page allocations call
pgtable_pmd_page_ctor() and some dont. The series which I had posted
make sure that all kernel and user page table page allocations go through
pgtable_page_ctor()/dtor(). These constructs are required for kernel
page table pages as well for accurate init and accounting not just for
user space. The series just skips vmemmap struct page mapping from this
as that would require generic sparse vmemmap allocation/free functions
which I believe should also be changed going forward as well.

> AFAICT, none of the pgds (efi_mm.pgd, tramp_pg_dir and init_mm.pgd)
> pre-populated by pgd_pgtable_alloc() is. (I doubt we pre-populate
> userspace page tables in any other arch).
> 
> So to avoid future confusion, we might just remove the ctor from
> pgd_pgtable_alloc().

No. Instead we should just make sure the that those pages go through
dtor() destructor path when getting freed and the clean up series
does that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
