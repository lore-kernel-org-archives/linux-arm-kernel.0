Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5BAC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:14:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584D720659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lsf9YgG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584D720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D+eFKYxiAqFKrQmOwCld5P/+IWC7Fr92kRY6tR7mhSo=; b=lsf9YgG7i/dRQL
	opOPm7+FuKrnNg8mZ9iR9jMaVtzWz7CxbTffeJVpSqPJMET+YcPaSWtQQcVLIRymYAHir5fRaI3kD
	ckGdCsa7VRNjjh/U98ai66EtFVFzZAbbu/sD/Afx7EZ/2em6+e3QWhRYRRlQDrzNmqUJXU7EPuup1
	pfuZ166Qrs+hzm5XY1IySrtSPZJDolztjXcCOe6nLDxnF8rsye4+WGOwMlZPG9n4BkyQJ4zXY6W41
	9gsjMhcm3i4gegiwC0uATv2DfNUoa7ACRYBRnwCRunVVid42XEK8svxXbYZNDNh/xEjpzVIeVbyD4
	C8v/8UTX/UEdTB9lHATg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gitdj-0008JW-6X; Mon, 14 Jan 2019 04:14:19 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gitdf-0008J4-DU
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 04:14:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4127080D;
 Sun, 13 Jan 2019 20:14:14 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 F36C23F5BD; Sun, 13 Jan 2019 20:14:04 -0800 (PST)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To: Shakeel Butt <shakeelb@google.com>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <CALvZod5euX2mW7qgL28YZrTVQ-gYYR83aGKfOyZ9=BEzHwyJOw@mail.gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5e87d900-9548-1782-6244-6dcf7339139d@arm.com>
Date: Mon, 14 Jan 2019 09:44:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALvZod5euX2mW7qgL28YZrTVQ-gYYR83aGKfOyZ9=BEzHwyJOw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_201415_475233_BE5147E4 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: mark.rutland@arm.com, Michal Hocko <mhocko@suse.com>,
 linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, will.deacon@arm.com,
 LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au, linux@armlinux.org.uk,
 Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 David Rientjes <rientjes@google.com>, marc.zyngier@arm.com,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/12/2019 10:18 PM, Shakeel Butt wrote:
>> --- a/arch/x86/kernel/espfix_64.c
>> +++ b/arch/x86/kernel/espfix_64.c
>> @@ -57,8 +57,6 @@
>>  # error "Need more virtual address space for the ESPFIX hack"
>>  #endif
>>
>> -#define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
>> -
>>  /* This contains the *bottom* address of the espfix stack */
>>  DEFINE_PER_CPU_READ_MOSTLY(unsigned long, espfix_stack);
>>  DEFINE_PER_CPU_READ_MOSTLY(unsigned long, espfix_waddr);
>> @@ -172,7 +170,7 @@ void init_espfix_ap(int cpu)
>>         pud_p = &espfix_pud_page[pud_index(addr)];
>>         pud = *pud_p;
>>         if (!pud_present(pud)) {
>> -               struct page *page = alloc_pages_node(node, PGALLOC_GFP, 0);
>> +               struct page *page = alloc_pages_node(node, GFP_PGTABLE, 0);
>>
>>                 pmd_p = (pmd_t *)page_address(page);
>>                 pud = __pud(__pa(pmd_p) | (PGTABLE_PROT & ptemask));
>> @@ -184,7 +182,7 @@ void init_espfix_ap(int cpu)
>>         pmd_p = pmd_offset(&pud, addr);
>>         pmd = *pmd_p;
>>         if (!pmd_present(pmd)) {
>> -               struct page *page = alloc_pages_node(node, PGALLOC_GFP, 0);
>> +               struct page *page = alloc_pages_node(node, GFP_PGTABLE, 0);
>>
>>                 pte_p = (pte_t *)page_address(page);
>>                 pmd = __pmd(__pa(pte_p) | (PGTABLE_PROT & ptemask));
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 7bd0170..d608b03 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>>  EXPORT_SYMBOL(physical_mask);
>>  #endif
>>
>> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>> -
> You have silently dropped __GFP_ACCOUNT from all the allocations in this file.

Right, they need to be added back explicitly after GFP_PGTABLE. Matthew had
pointed this earlier. Will fix it next time around.

> 
> BTW why other archs not using __GFP_ACCOUNT for the user page tables?
> 

Some archs do and some dont. User page tables pages should use __GFP_ACCOUNT
for allocation. I am working on fixing it for arm64.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
