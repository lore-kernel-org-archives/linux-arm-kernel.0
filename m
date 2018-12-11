Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A324DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7198220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R04E1Oq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7198220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LNm2P8V4nScY6emLPOeqmWZWKAvAwDfeDagJCeG4OY8=; b=R04E1Oq5/44+MfeyHs5bOhHKo
	HwTJQQ+LXaZDpCqxmPlfA1kXkij4l11+WhypqTP69IArwnPydgEKFqJz37lh0NYgbU1aDc/jrTut0
	YY7df6025CH9YzDdb4qkKWupTdtkwPrbnnutttgQKXe7F/0EDsZqVPjWQHB/Kazfc85sCtNw+mKtV
	hOo8+h0x/RjSqkJP7/dOXJvjwrDJw+k8pYjgHduVnLCBdYbq+k3bZt8t6WC1yQfJUNpYqo7jlRm/q
	wQL/rEUNhcRGP2wOr+0SNG3ssRSOMfia5jbj8bf9Tf89Jsd10YnLMsIjbor8r5NExNZwymy0qkLQj
	OVF3ynzug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlj5-0001LV-4m; Tue, 11 Dec 2018 17:21:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlj1-0001KI-5h
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:21:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 391B21596;
 Tue, 11 Dec 2018 09:21:27 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D46173F6A8;
 Tue, 11 Dec 2018 09:21:25 -0800 (PST)
Subject: Re: [PATCH] arm64: Add memory hotplug support
To: Will Deacon <will.deacon@arm.com>
References: <0a0c7d3b8fbe1b2b399eeb6889027031335d2af1.1544453739.git.robin.murphy@arm.com>
 <20181211163605.GC12597@edgewater-inn.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b6a21681-beee-4083-89ce-cdfdbb958cbf@arm.com>
Date: Tue, 11 Dec 2018 17:21:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211163605.GC12597@edgewater-inn.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_092139_372833_70578B1E 
X-CRM114-Status: GOOD (  25.44  )
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
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cyrilc@xilinx.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, jonathan.cameron@huawei.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/12/2018 16:36, Will Deacon wrote:
> On Mon, Dec 10, 2018 at 03:29:01PM +0000, Robin Murphy wrote:
>> Wire up the basic support for hot-adding memory. Since memory hotplug
>> is fairly tightly coupled to sparsemem, we tweak pfn_valid() to also
>> cross-check the presence of a section in the manner of the generic
>> implementation, before falling back to memblock to check for no-map
>> regions within a present section as before. By having arch_add_memory(()
>> create the linear mapping first, this then makes everything work in the
>> way that __add_section() expects.
>>
>> We expect hotplug to be ACPI-driven, so the swapper_pg_dir updates
>> should be safe from races by virtue of the global device hotplug lock.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Looks like I'm not going to have the whole pte_devmap story figured out
>> in time to land any ZONE_DEVICE support this cycle, but since this patch
>> also stands alone as a complete feature (and has ended up remarkably
>> simple and self-contained), I hope we might consider getting it merged
>> on its own merit.
>>
>> Robin.
>>
>>   arch/arm64/Kconfig   |  3 +++
>>   arch/arm64/mm/init.c |  8 ++++++++
>>   arch/arm64/mm/mmu.c  | 12 ++++++++++++
>>   arch/arm64/mm/numa.c | 10 ++++++++++
>>   4 files changed, 33 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6d2b25f51bb3..7b855ae45747 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -261,6 +261,9 @@ config ZONE_DMA32
>>   config HAVE_GENERIC_GUP
>>   	def_bool y
>>   
>> +config ARCH_ENABLE_MEMORY_HOTPLUG
>> +	def_bool y
>> +
>>   config SMP
>>   	def_bool y
>>   
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 2983e0fc1786..82e0b08f2e31 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -291,6 +291,14 @@ int pfn_valid(unsigned long pfn)
>>   
>>   	if ((addr >> PAGE_SHIFT) != pfn)
>>   		return 0;
>> +
>> +#ifdef CONFIG_SPARSEMEM
>> +	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>> +		return 0;
>> +
>> +	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
>> +		return 0;
> 
> I'm a bit nervous about the call to __nr_to_section() here. How do we
> ensure that the section number we're passing stays within the bounds of
> the mem_section array?

The same way every other sparsemem user (apart from arch/arm) does, I 
guess - this is literally a copy-paste of the generic pfn_valid() 
implementation :/

Given the implementation of __nr_to_section() respective of how 
memory_present() and sparse_index_init() set up mem_section in the first 
place, I can't see how there can be a problem. You did see the bit 4 
lines above, right?

>> +#endif
>>   	return memblock_is_map_memory(addr);
>>   }
>>   EXPORT_SYMBOL(pfn_valid);
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e1b2d58a311a..22379a74d289 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1044,3 +1044,15 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>   	pmd_free(NULL, table);
>>   	return 1;
>>   }
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>> +		    bool want_memblock)
>> +{
>> +	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>> +			     size, PAGE_KERNEL, pgd_pgtable_alloc, 0);
>> +
>> +	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>> +			   altmap, want_memblock);
>> +}
> 
> If we're mapping the new memory into the linear map, shouldn't we be
> respecting rodata_full and debug page alloc by forcing page granularity
> and tweaking the permissions?

Bah, James mentioned debug_pagealloc long ago, and I did have a slight 
nagging feeling that I was still missing something - yes, I need to fix 
the flags for that case. I'm not sure about rodata_full (do you mean 
STRICT_KERNEL_RWX?) since a section being added here won't contain 
kernel text nor data, and I can't seem to find anywhere that rodata 
options affect the linear mapping of plain free RAM.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
