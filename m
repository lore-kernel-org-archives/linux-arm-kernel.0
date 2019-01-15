Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA539C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:11:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C74220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q2l+/YMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C74220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JcEUDkcjtpchazW0KTJypKm1Q8d1GuUvL7QGTh950jI=; b=Q2l+/YMQJTOSdK
	Rh3jW+Pl7TGiEtVRNnlfrmY/x6wI3D3dmhrJRdyGpMZ5kBGqiaPBiY3LGLpd+SsGFPOciP1TIbc0d
	UFYrIvs7eMIv1u0R3l6SdjpSsR/1iwa8iyQ0Ql8eiioTLfhO0eR9NGslNHpIArmELV/YDyLKeWDhP
	hWnHURjL9ifpqiCz7zlAolebf/uz95vnexjjv03O6qL4I9lJDuxrYT92YV+qMjBBLhgRyX7Kys21I
	BUA3j++jVIX/AYASdPvEg3wCHrVA+ZWkFknLfaespDp/OrExt9H2ejrj5fIVxdF8T7+PzMWj/iKWF
	7wLBEksR5YHQD0ESzZkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPRM-0008OB-Ce; Tue, 15 Jan 2019 14:11:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPRJ-0008Nh-OE
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:11:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B198A78;
 Tue, 15 Jan 2019 06:11:34 -0800 (PST)
Received: from [10.163.1.4] (unknown [10.163.1.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FFAC3F739;
 Tue, 15 Jan 2019 06:11:25 -0800 (PST)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To: Michal Hocko <mhocko@kernel.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190113173555.GC1578@dhcp22.suse.cz>
 <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
 <20190114070137.GB21345@dhcp22.suse.cz>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a81dd27a-b7d1-ddad-e104-4ce51699ac3d@arm.com>
Date: Tue, 15 Jan 2019 19:41:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190114070137.GB21345@dhcp22.suse.cz>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_061137_802436_D455DFFD 
X-CRM114-Status: GOOD (  21.88  )
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
Cc: mark.rutland@arm.com, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz,
 rientjes@google.com, marc.zyngier@arm.com, rppt@linux.vnet.ibm.com,
 shakeelb@google.com, kirill@shutemov.name, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org,
 robin.murphy@arm.com, steve.capper@arm.com, christoffer.dall@arm.com,
 james.morse@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/14/2019 12:31 PM, Michal Hocko wrote:
> On Mon 14-01-19 09:30:55, Anshuman Khandual wrote:
>>
>>
>> On 01/13/2019 11:05 PM, Michal Hocko wrote:
>>> On Sat 12-01-19 15:56:38, Anshuman Khandual wrote:
>>>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>>>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>>>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>>>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>>>> architecture. This creates a new generic GFP flag flag which can be used
>>>> for any page table page allocation. Does not cause any functional change.
>>>
>>> I agree that some unification is due but GFP_PGTABLE is not something to
>>> expose in generic gfp.h IMHO. It just risks an abuse. I would be looking
>>
>> Why would you think that it risks an abuse ? It does not create new semantics
>> of allocation in the buddy. Its just uses existing GFP_KERNEL allocation which
>> is then getting zeroed out. The risks (if any) is exactly same as GFP_KERNEL.
> 
> Beucase my experience just tells me that people tend to use whatever
> they find and name fits what they think they need.
> 
>>> at providing asm-generic implementation and reuse it to remove the code
>>
>> Does that mean GFP_PGTABLE can be created but not in gfp.h but in some other
>> memory related header file ?
> 
> I would just keep it close to its users. If that is a single arch
> generic place then only better. But I suspect some arches have special
> requirements.

We can move the definition into include/asm-generic/pgtable.h which can be
used by all archs. If there any special requirements those can be added on
this generic and common minimum allocation flag. The minimum required flag
should not be duplicated every where.

> 
>>> duplication. But I haven't tried that to know that it will work out due
>>> to small/subtle differences between arches.
>>
>> IIUC from the allocation perspective GFP_ACCOUNT is the only thing which gets
>> added with GFP_PGTABLE for user page table for memcg accounting purpose. There
>> does not seem to be any other differences unless I am missing something.
> 
> It's been some time since I've checked the last time. Some arches were
> using GPF_REPEAT (__GFP_RETRY_MAYFAIL) back then. I have removed most of
> those but some were doing a higher order allocations so they probably
> have stayed.

A simple grep shows that still there are some places which use the flag
__GFP_RETRY_MAYFAIL. But that can be added on GFP_PGTABLE for these archs.

arch/nds32/include/asm/pgalloc.h:           (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL |
arch/nds32/include/asm/pgalloc.h:       pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO, 0);
arch/powerpc/include/asm/book3s/64/pgalloc.h:   page = alloc_pages(pgtable_gfp_flags(mm, PGALLOC_GFP | __GFP_RETRY_MAYFAIL),
arch/powerpc/kvm/book3s_64_mmu_hv.c:            hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL
arch/riscv/include/asm/pgalloc.h:               GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
arch/riscv/include/asm/pgalloc.h:               GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
arch/riscv/include/asm/pgalloc.h:       pte = alloc_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
arch/sparc/kernel/mdesc.c:      base = kmalloc(handle_size + 15, GFP_KERNEL | __GFP_RETRY_MAYFAIL);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
