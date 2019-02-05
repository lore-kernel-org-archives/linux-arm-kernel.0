Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CDAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7DC20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V1s59xXZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rFk316r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7DC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2gO4hvWy3Xce+W82r+/iFajZJz/dAV75zo7WG78fJwg=; b=V1s59xXZjHGaufhFjDnbWGxro
	IxEuh97+0B8buhft9GA6jhEgCchEnxuzGJjnGib79X9GSvHbnV7Y9B95WKjYktMPvL47fvIuODI4Q
	HbE1E1jf7f1U33ipottB8RyF4CbUdMHyq0B9km0B6tsJZN31XLkIBrUOUtw1jED43laLFuSE6dOQA
	Q0frnmD2AinBTqPGNE1u9XBSGpMky6QyEKq+dcnILRuUPxTGer5o1MHB6M9VVbVfoVVGsEtbYQJuY
	kZHjiz9Ve7wCYiozbNZhylZArTfSGpUDc9Q0sKbRKWNy+SYzDLhxkW0pv5J5+gDFbvqvpvUUntkkJ
	uHMimc5bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqz18-0003GZ-5n; Tue, 05 Feb 2019 11:35:54 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqz14-0003Fz-UY; Tue, 05 Feb 2019 11:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pkkGhMRdQDRsaReuwmMyl5ch0/LAI5yjj7THI5EynAs=; b=rFk316r7iogP2sTmtjIr9rs2fq
 mzm+bdHHxOJUH6b7f2rDabc+fIflYO/gfVGgWwPZTsF6pFRhswEEc42BurdizP0Dj0dy7xLxyGXMH
 PG3XE++zvpdHxqZypFlKmMSkt/oHfvyJbaey52FluiN1WjCG0g8UwWoqk95bX3NOoyNvM5fYOor1j
 xy7Q8K1QgSnJwulVM8a6xWD243AvhasSlu6lwd4w4TSMqev2Q5SQsoQzESEOgdAUnUEkl5IAjYmr0
 KHdRxx8pt20SeEOtjA8+b0ncUrUX4caTo6pIghFYg1qNjNzFwITI6qHdJ+Tr43nAAXlPQeNC8n1wa
 yMG4ItcQ==;
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqz11-0003ZB-HU; Tue, 05 Feb 2019 11:35:48 +0000
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
 (Authenticated sender: alex@ghiti.fr)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id E36D9200006;
 Tue,  5 Feb 2019 11:35:05 +0000 (UTC)
From: Alex Ghiti <alex@ghiti.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] hugetlb: allow to free gigantic pages regardless of the
 configuration
References: <20190117183953.5990-1-aghiti@upmem.com>
 <87ef8mmqbc.fsf@concordia.ellerman.id.au>
Message-ID: <a695bdd3-bd63-b0d8-b56d-f13dea0a8764@ghiti.fr>
Date: Tue, 5 Feb 2019 06:35:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87ef8mmqbc.fsf@concordia.ellerman.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_063547_799322_BD135CC1 
X-CRM114-Status: GOOD (  26.87  )
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
Cc: linux-s390@vger.kernel.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Catalin Marinas <catalin.marinas@arm.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 hch@infradead.org, linux-fsdevel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Borislav Petkov <bp@alien8.de>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/5/19 6:23 AM, Michael Ellerman wrote:
> Alexandre Ghiti <aghiti@upmem.com> writes:
>
>> From: Alexandre Ghiti <alex@ghiti.fr>
>>
>> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
>> that support gigantic pages, boottime reserved gigantic pages can not be
>> freed at all. This patchs simply enables the possibility to hand back
>> those pages to memory allocator.
>>
>> This commit then renames gigantic_page_supported and
>> ARCH_HAS_GIGANTIC_PAGE to make them more accurate. Indeed, those values
>> being false does not mean that the system cannot use gigantic pages: it
>> just means that runtime allocation of gigantic pages is not supported,
>> one can still allocate boottime gigantic pages if the architecture supports
>> it.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>
>> - Compiled on all architectures
>> - Tested on riscv architecture
>>
>>   arch/arm64/Kconfig                           |  2 +-
>>   arch/arm64/include/asm/hugetlb.h             |  7 +++--
>>   arch/powerpc/include/asm/book3s/64/hugetlb.h |  4 +--
>>   arch/powerpc/platforms/Kconfig.cputype       |  2 +-
> The powerpc parts look fine.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thank you Michael,

Alex

>
> cheers
>
>>   arch/s390/Kconfig                            |  2 +-
>>   arch/s390/include/asm/hugetlb.h              |  7 +++--
>>   arch/x86/Kconfig                             |  2 +-
>>   arch/x86/include/asm/hugetlb.h               |  7 +++--
>>   fs/Kconfig                                   |  2 +-
>>   include/linux/gfp.h                          |  2 +-
>>   mm/hugetlb.c                                 | 43 +++++++++++++++-------------
>>   mm/page_alloc.c                              |  4 +--
>>   12 files changed, 48 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a4168d366127..18239cbd7fcd 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -18,7 +18,7 @@ config ARM64
>>   	select ARCH_HAS_FAST_MULTIPLIER
>>   	select ARCH_HAS_FORTIFY_SOURCE
>>   	select ARCH_HAS_GCOV_PROFILE_ALL
>> -	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
>> +	select ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION if (MEMORY_ISOLATION && COMPACTION) || CMA
>>   	select ARCH_HAS_KCOV
>>   	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>   	select ARCH_HAS_PTE_SPECIAL
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index fb6609875455..797fc77eabcd 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -65,8 +65,11 @@ extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>>   
>>   #include <asm-generic/hugetlb.h>
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -static inline bool gigantic_page_supported(void) { return true; }
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION
>> +static inline bool gigantic_page_runtime_allocation_supported(void)
>> +{
>> +	return true;
>> +}
>>   #endif
>>   
>>   #endif /* __ASM_HUGETLB_H */
>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> index 5b0177733994..7711f0e2c7e5 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> @@ -32,8 +32,8 @@ static inline int hstate_get_psize(struct hstate *hstate)
>>   	}
>>   }
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -static inline bool gigantic_page_supported(void)
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION
>> +static inline bool gigantic_page_runtime_allocation_supported(void)
>>   {
>>   	return true;
>>   }
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>> index 8c7464c3f27f..779e06bac697 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -319,7 +319,7 @@ config ARCH_ENABLE_SPLIT_PMD_PTLOCK
>>   config PPC_RADIX_MMU
>>   	bool "Radix MMU Support"
>>   	depends on PPC_BOOK3S_64
>> -	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
>> +	select ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION if (MEMORY_ISOLATION && COMPACTION) || CMA
>>   	default y
>>   	help
>>   	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index ed554b09eb3f..6776eef6a9ae 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -69,7 +69,7 @@ config S390
>>   	select ARCH_HAS_ELF_RANDOMIZE
>>   	select ARCH_HAS_FORTIFY_SOURCE
>>   	select ARCH_HAS_GCOV_PROFILE_ALL
>> -	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
>> +	select ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION if (MEMORY_ISOLATION && COMPACTION) || CMA
>>   	select ARCH_HAS_KCOV
>>   	select ARCH_HAS_PTE_SPECIAL
>>   	select ARCH_HAS_SET_MEMORY
>> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
>> index 2d1afa58a4b6..57c952f5388e 100644
>> --- a/arch/s390/include/asm/hugetlb.h
>> +++ b/arch/s390/include/asm/hugetlb.h
>> @@ -116,7 +116,10 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
>>   	return pte_modify(pte, newprot);
>>   }
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -static inline bool gigantic_page_supported(void) { return true; }
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION
>> +static inline bool gigantic_page_runtime_allocation_supported(void)
>> +{
>> +	return true;
>> +}
>>   #endif
>>   #endif /* _ASM_S390_HUGETLB_H */
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 6185d4f33296..a88f5a4311c9 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -23,7 +23,7 @@ config X86_64
>>   	def_bool y
>>   	depends on 64BIT
>>   	# Options that are inherently 64-bit kernel only:
>> -	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
>> +	select ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION if (MEMORY_ISOLATION && COMPACTION) || CMA
>>   	select ARCH_SUPPORTS_INT128
>>   	select ARCH_USE_CMPXCHG_LOCKREF
>>   	select HAVE_ARCH_SOFT_DIRTY
>> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
>> index 7469d321f072..5a5e7119ced4 100644
>> --- a/arch/x86/include/asm/hugetlb.h
>> +++ b/arch/x86/include/asm/hugetlb.h
>> @@ -17,8 +17,11 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>>   {
>>   }
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -static inline bool gigantic_page_supported(void) { return true; }
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION
>> +static inline bool gigantic_page_runtime_allocation_supported(void)
>> +{
>> +	return true;
>> +}
>>   #endif
>>   
>>   #endif /* _ASM_X86_HUGETLB_H */
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index ac474a61be37..4192d1fde0f0 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -207,7 +207,7 @@ config HUGETLB_PAGE
>>   config MEMFD_CREATE
>>   	def_bool TMPFS || HUGETLBFS
>>   
>> -config ARCH_HAS_GIGANTIC_PAGE
>> +config ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION
>>   	bool
>>   
>>   source "fs/configfs/Kconfig"
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 5f5e25fd6149..79ff86fabd42 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -589,8 +589,8 @@ static inline bool pm_suspended_storage(void)
>>   /* The below functions must be run on a range from a single zone. */
>>   extern int alloc_contig_range(unsigned long start, unsigned long end,
>>   			      unsigned migratetype, gfp_t gfp_mask);
>> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
>>   #endif
>> +extern void free_contig_range(unsigned long pfn, unsigned int nr_pages);
>>   
>>   #ifdef CONFIG_CMA
>>   /* CMA stuff */
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 745088810965..9893ba26b3b8 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1035,7 +1035,6 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>>   		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
>>   		nr_nodes--)
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>>   static void destroy_compound_gigantic_page(struct page *page,
>>   					unsigned int order)
>>   {
>> @@ -1058,6 +1057,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>>   	free_contig_range(page_to_pfn(page), 1 << order);
>>   }
>>   
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION
>>   static int __alloc_gigantic_page(unsigned long start_pfn,
>>   				unsigned long nr_pages, gfp_t gfp_mask)
>>   {
>> @@ -1143,22 +1143,19 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>>   static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
>>   static void prep_compound_gigantic_page(struct page *page, unsigned int order);
>>   
>> -#else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
>> -static inline bool gigantic_page_supported(void) { return false; }
>> +#else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE_RUNTIME_ALLOCATION */
>> +static inline bool gigantic_page_runtime_allocation_supported(void)
>> +{
>> +	return false;
>> +}
>>   static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>>   		int nid, nodemask_t *nodemask) { return NULL; }
>> -static inline void free_gigantic_page(struct page *page, unsigned int order) { }
>> -static inline void destroy_compound_gigantic_page(struct page *page,
>> -						unsigned int order) { }
>>   #endif
>>   
>>   static void update_and_free_page(struct hstate *h, struct page *page)
>>   {
>>   	int i;
>>   
>> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> -		return;
>> -
>>   	h->nr_huge_pages--;
>>   	h->nr_huge_pages_node[page_to_nid(page)]--;
>>   	for (i = 0; i < pages_per_huge_page(h); i++) {
>> @@ -2276,13 +2273,20 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>>   }
>>   
>>   #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
>> -static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
>> +static int set_max_huge_pages(struct hstate *h, unsigned long count,
>>   						nodemask_t *nodes_allowed)
>>   {
>>   	unsigned long min_count, ret;
>>   
>> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> -		return h->max_huge_pages;
>> +	if (hstate_is_gigantic(h) &&
>> +		!gigantic_page_runtime_allocation_supported()) {
>> +		spin_lock(&hugetlb_lock);
>> +		if (count > persistent_huge_pages(h)) {
>> +			spin_unlock(&hugetlb_lock);
>> +			return -EINVAL;
>> +		}
>> +		goto decrease_pool;
>> +	}
>>   
>>   	/*
>>   	 * Increase the pool size
>> @@ -2322,6 +2326,7 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
>>   			goto out;
>>   	}
>>   
>> +decrease_pool:
>>   	/*
>>   	 * Decrease the pool size
>>   	 * First return free pages to the buddy allocator (being careful
>> @@ -2350,9 +2355,10 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
>>   			break;
>>   	}
>>   out:
>> -	ret = persistent_huge_pages(h);
>> +	h->max_huge_pages = persistent_huge_pages(h);
>>   	spin_unlock(&hugetlb_lock);
>> -	return ret;
>> +
>> +	return 0;
>>   }
>>   
>>   #define HSTATE_ATTR_RO(_name) \
>> @@ -2404,11 +2410,6 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>   	int err;
>>   	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
>>   
>> -	if (hstate_is_gigantic(h) && !gigantic_page_supported()) {
>> -		err = -EINVAL;
>> -		goto out;
>> -	}
>> -
>>   	if (nid == NUMA_NO_NODE) {
>>   		/*
>>   		 * global hstate attribute
>> @@ -2428,7 +2429,9 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>   	} else
>>   		nodes_allowed = &node_states[N_MEMORY];
>>   
>> -	h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
>> +	err = set_max_huge_pages(h, count, nodes_allowed);
>> +	if (err)
>> +		goto out;
>>   
>>   	if (nodes_allowed != &node_states[N_MEMORY])
>>   		NODEMASK_FREE(nodes_allowed);
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cde5dac6229a..81b931db85a1 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8241,8 +8241,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>   				pfn_max_align_up(end), migratetype);
>>   	return ret;
>>   }
>> +#endif
>>   
>> -void free_contig_range(unsigned long pfn, unsigned nr_pages)
>> +void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>>   {
>>   	unsigned int count = 0;
>>   
>> @@ -8254,7 +8255,6 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
>>   	}
>>   	WARN(count != 0, "%d pages are still in use!\n", count);
>>   }
>> -#endif
>>   
>>   #ifdef CONFIG_MEMORY_HOTPLUG
>>   /*
>> -- 
>> 2.16.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
