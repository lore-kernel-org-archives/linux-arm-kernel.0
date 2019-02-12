Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED81C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:01:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F8E222C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ky5APRZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F8E222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dHc8JUETglEf7JLlkmXp6wbW7oCj6AUGnf3+j1qSiik=; b=Ky5APRZb+XZYL/WkAoOn+h/V6
	iktLefEj+xExveb1wuVTsQRZEW7+Wf0+y3XZ+qwpBpi+pw2CB7I4JpL3WqCLudpiu27mY7x5r+qRi
	VG8P/y5GVNLKbB3xwsgw6eNCP8uk4UrnuKwOp4+mbnZ1hKVzy+olQNxAOD+1ZXdNZ2g0R2zxgBAV5
	RGvy/pnwt6IffR86WGTaH2eeVqj3signZfxIKQvKnSX9zLqpG6DrLSMpNPAXPfN6KckpY36UQtobg
	EHad2h/Htgo3a5sW2sGcLZHtyOf0vvzqC4z96TMFGEv05zg57EvMKBVmxWt/9XI1dl4302+ODGaAm
	VWs0qTltw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gteFX-0005RL-Mz; Tue, 12 Feb 2019 20:01:47 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gteFS-0005Qx-Qh
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:01:45 +0000
Received: by mail-qt1-f194.google.com with SMTP id o6so4478439qtk.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 12:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5J3BEVMX8I3R6aDWiylH49L5Eh0Yio3E7KsL+Og9pHE=;
 b=XTZUegNseUynSQCo12vJVOMfRN6L6nd4omLTVBdDL5gGy0mH7QjtQR0gmVznQh+wkT
 Y0ziRDYKvXQ5EhgMLt9o2A4Yna8BdEa9bfhYUTkFUOPwQl6CyMMV+WDUgDBno2AJ6/xo
 rTgEkkMFOhGJHlpCPc6r1gO3Vgxg795V/DOWBGa1oKlg67Ooi7RTfAqtyhU/iYAd4ANC
 BSX/a2jo7h/PHS/MC219yxzL1oVvNd2cGAZjqzYkB9q1B3T/0Zr6GFSNZE3g4G9DGvRL
 NoNaNUP6Q/arAijzS6ouJfuuJJC5pV99NRNZFWBurepXjEA4HKozB4+QbumQw6cLaBKp
 UA5w==
X-Gm-Message-State: AHQUAuZYKZYr6GFsBGXVbkdCDU45vabBPKjo8rWXSHjrLWiH4KGUNkwC
 eMMhk6zVNmOGEXS8ToE6rkfkmQ==
X-Google-Smtp-Source: AHgI3Ibb/fAwJBL5b9xb1ME5M4mJiSWWwndBNvOjwi+A3vbQNEu+Xmy/HhD6sB4kQ8UGZQAnBK23iQ==
X-Received: by 2002:ac8:21ce:: with SMTP id 14mr4243520qtz.306.1550001701410; 
 Tue, 12 Feb 2019 12:01:41 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
 by smtp.gmail.com with ESMTPSA id t123sm14960812qkc.6.2019.02.12.12.01.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 12:01:40 -0800 (PST)
Subject: Re: [RFC PATCH v7 05/16] arm64/mm: Add support for XPFO
To: Khalid Aziz <khalid.aziz@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <89f03091af87f5ab27bd6cafb032236d5bd81d65.1547153058.git.khalid.aziz@oracle.com>
 <20190123142410.GC19289@Konrads-MacBook-Pro.local>
 <4dfba458-1bf6-25ff-df4c-b96a1221cd95@oracle.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <7497bd44-1fda-e073-ba7f-18a76577b64a@redhat.com>
Date: Tue, 12 Feb 2019 12:01:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4dfba458-1bf6-25ff-df4c-b96a1221cd95@oracle.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_120142_869440_2B864C14 
X-CRM114-Status: GOOD (  23.56  )
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
Cc: Tycho Andersen <tycho@docker.com>, kernel-hardening@lists.openwall.com,
 linux-mm@kvack.org, deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, tycho@tycho.ws,
 ak@linux.intel.com, hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 pradeep.vincent@oracle.com, jcm@redhat.com, liran.alon@oracle.com,
 tglx@linutronix.de, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, juergh@gmail.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>,
 dwmw@amazon.co.uk, keescook@google.com, torvalds@linux-foundation.org,
 kirill.shutemov@linux.intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/12/19 7:52 AM, Khalid Aziz wrote:
> On 1/23/19 7:24 AM, Konrad Rzeszutek Wilk wrote:
>> On Thu, Jan 10, 2019 at 02:09:37PM -0700, Khalid Aziz wrote:
>>> From: Juerg Haefliger <juerg.haefliger@canonical.com>
>>>
>>> Enable support for eXclusive Page Frame Ownership (XPFO) for arm64 and
>>> provide a hook for updating a single kernel page table entry (which is
>>> required by the generic XPFO code).
>>>
>>> v6: use flush_tlb_kernel_range() instead of __flush_tlb_one()
>>>
>>> CC: linux-arm-kernel@lists.infradead.org
>>> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
>>> Signed-off-by: Tycho Andersen <tycho@docker.com>
>>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>>> ---
>>>   arch/arm64/Kconfig     |  1 +
>>>   arch/arm64/mm/Makefile |  2 ++
>>>   arch/arm64/mm/xpfo.c   | 58 ++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 61 insertions(+)
>>>   create mode 100644 arch/arm64/mm/xpfo.c
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index ea2ab0330e3a..f0a9c0007d23 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -171,6 +171,7 @@ config ARM64
>>>   	select SWIOTLB
>>>   	select SYSCTL_EXCEPTION_TRACE
>>>   	select THREAD_INFO_IN_TASK
>>> +	select ARCH_SUPPORTS_XPFO
>>>   	help
>>>   	  ARM 64-bit (AArch64) Linux support.
>>>   
>>> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
>>> index 849c1df3d214..cca3808d9776 100644
>>> --- a/arch/arm64/mm/Makefile
>>> +++ b/arch/arm64/mm/Makefile
>>> @@ -12,3 +12,5 @@ KASAN_SANITIZE_physaddr.o	+= n
>>>   
>>>   obj-$(CONFIG_KASAN)		+= kasan_init.o
>>>   KASAN_SANITIZE_kasan_init.o	:= n
>>> +
>>> +obj-$(CONFIG_XPFO)		+= xpfo.o
>>> diff --git a/arch/arm64/mm/xpfo.c b/arch/arm64/mm/xpfo.c
>>> new file mode 100644
>>> index 000000000000..678e2be848eb
>>> --- /dev/null
>>> +++ b/arch/arm64/mm/xpfo.c
>>> @@ -0,0 +1,58 @@
>>> +/*
>>> + * Copyright (C) 2017 Hewlett Packard Enterprise Development, L.P.
>>> + * Copyright (C) 2016 Brown University. All rights reserved.
>>> + *
>>> + * Authors:
>>> + *   Juerg Haefliger <juerg.haefliger@hpe.com>
>>> + *   Vasileios P. Kemerlis <vpk@cs.brown.edu>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License version 2 as published by
>>> + * the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/mm.h>
>>> +#include <linux/module.h>
>>> +
>>> +#include <asm/tlbflush.h>
>>> +
>>> +/*
>>> + * Lookup the page table entry for a virtual address and return a pointer to
>>> + * the entry. Based on x86 tree.
>>> + */
>>> +static pte_t *lookup_address(unsigned long addr)
>>> +{
>>> +	pgd_t *pgd;
>>> +	pud_t *pud;
>>> +	pmd_t *pmd;
>>> +
>>> +	pgd = pgd_offset_k(addr);
>>> +	if (pgd_none(*pgd))
>>> +		return NULL;
>>> +
>>> +	pud = pud_offset(pgd, addr);
>>> +	if (pud_none(*pud))
>>> +		return NULL;
>>> +
>>> +	pmd = pmd_offset(pud, addr);
>>> +	if (pmd_none(*pmd))
>>> +		return NULL;
>>> +
>>> +	return pte_offset_kernel(pmd, addr);
>>> +}
>>> +
>>> +/* Update a single kernel page table entry */
>>> +inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
>>> +{
>>> +	pte_t *pte = lookup_address((unsigned long)kaddr);
>>> +
>>> +	set_pte(pte, pfn_pte(page_to_pfn(page), prot));
>>
>> Thought on the other hand.. what if the page is PMD? Do you really want
>> to do this?
>>
>> What if 'pte' is NULL?
>>> +}
>>> +
>>> +inline void xpfo_flush_kernel_tlb(struct page *page, int order)
>>> +{
>>> +	unsigned long kaddr = (unsigned long)page_address(page);
>>> +	unsigned long size = PAGE_SIZE;
>>> +
>>> +	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
>>
>> Ditto here. You are assuming it is PTE, but it may be PMD or such.
>> Or worts - the lookup_address could be NULL.
>>
>>> +}
>>> -- 
>>> 2.17.1
>>>
> 
> Hi Konrad,
> 
> This makes sense. x86 version of set_kpte() checks pte for NULL and also
> checks if the page is PMD. Now what you said about adding level to
> lookup_address() for arm makes more sense.
> 
> Can someone with knowledge of arm64 mmu make recommendations here?
> 
> Thanks,
> Khalid
> 

arm64 can't split larger pages and requires everything must be
mapped as pages (see [RFC PATCH v7 08/16] arm64/mm: disable
section/contiguous mappings if XPFO is enabled) . Any
situation where we would get something other than a pte
would be a bug.

Thanks,
Laura

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
