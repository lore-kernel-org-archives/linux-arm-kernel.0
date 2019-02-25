Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE48213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QQ5EHbwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE48213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d/pWDxmciuBaDtMTM0jhXwxWhdxC8CmEYEw/xnZWWIU=; b=QQ5EHbwGSBmQ9m
	kAfCXvDIK2e3VLhk+idXJVZAM5joC1x9ulXFnXMgVhFo78WZAblIVuu/V+pU1X5BoaNBsbbwKYAKG
	A7bNn+1KZcm5l4QXAstkhC3uQQ0vpwj/rMMQsvne1MXx5PIWRHCUVxb9eql37UlmKUdkWCNREYxG0
	WgZiGMB4Ide7OcBRnOBhuhjrlHM/EckeaNljj6b71tNQ2vg9qnxbspXEkVTKFUJnplEMR8j+Cz/TR
	9mpnYBUDn9Y4Ce+NLIfR1NWIN2OWT7rUrO5ew4Clt5aQagA/wx7wqMKbuttQbuFAIzgD6eFIfcaEw
	sNFVtLbvuPnipYNXPk1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyH7N-0000C6-9d; Mon, 25 Feb 2019 14:20:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyH7J-0008Ur-Od
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:20:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCDA180D;
 Mon, 25 Feb 2019 06:20:24 -0800 (PST)
Received: from [10.163.1.20] (unknown [10.163.1.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B755D3F575;
 Mon, 25 Feb 2019 06:20:21 -0800 (PST)
Subject: Re: [PATCH V2 1/6] KVM: ARM: Remove pgtable standard functions from
 stage-2 page tables
To: Mark Rutland <mark.rutland@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-2-git-send-email-anshuman.khandual@arm.com>
 <20190225110014.GB26236@lakrids.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7bf0d18e-9714-4da9-a340-10aae5fa9f38@arm.com>
Date: Mon, 25 Feb 2019 19:50:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225110014.GB26236@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_062025_808180_4960C82F 
X-CRM114-Status: GOOD (  14.87  )
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



On 02/25/2019 04:30 PM, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Mon, Feb 25, 2019 at 10:33:54AM +0530, Anshuman Khandual wrote:
>> ARM64 standard pgtable functions are going to use pgtable_page_[ctor|dtor]
>> constructs. Certain stage-2 page table allocations are multi order which
>> cannot be allocated through a generic pgtable function as it does not exist
>> right now. This prevents all pgtable allocations including multi order ones
>> in stage-2 from moving into new ARM64 (pgtable_page_[ctor|dtor]) pgtable
>> functions. Hence remove all generic pgtable allocation function dependency
>> from stage-2 page tables till there is one multi-order allocation function
>> available.
> 
> I'm a bit confused by this. Which allocations are multi-order?
> 

Stage-2 PGD.

kvm_alloc_stage2_pgd -> alloc_pages_exact
kvm_free_stage2_pgd -> free_pages_exact
 
> Why does that prevent other allcoations from using the regular routines?

At present both stage-2 PGD (kvm_alloc_stage2_pgd -> alloc_pages_exact), PUD|PMD
(mmu_memory_cache_alloc) allocates directly from buddy allocator but then while
freeing back stage-2 PGD directly calls buddy allocator via free_pages_exact but
PUD|PMD get freed with stage2_[pud|pmd]_free which calls pud|pmd_free instead
of calling free_pages() directly.

All of these worked fine because pud|pmd_free called free_pages() directly with
out going through pgtable_page_dtor(). But now we are changing pud|pmd_free to
use pgtable_page_dtor() both for user and host kernel page tables. This will
break stage2 page table (bad page state errors) because the new free path which
would call pgtable_page_dtor() where as alloc patch never called pgtable_page_ctor().

To fix this situation either we move all stage-2 page table to use pte_alloc_one()
and pte_free() which goes through pgtable_page_ctor/dtor cycle or just keep the
virtualization page tables out of it (stage2/hyp) and remove the only dependency
which breaks because of these changes. This series went with the second option. 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
