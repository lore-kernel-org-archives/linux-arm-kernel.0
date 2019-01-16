Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B643FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:54:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6529320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gp+jx4Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6529320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BkjqGYHIbjgHU1dqCiwtg+GM7RgevAViSiX7aHJLCzw=; b=gp+jx4WxG3puNa
	8K7DZUM7ZkAPZ1+e+FUqzyCADzIMWPuIdgZ5otdI1XGCsB8PM24zf1gHgn2RqzwRyyPTjSYEKZquv
	yDUYiHqfQ6J+yVpcXN+mL0eet8UtCORuLZy2nC9HjypanatdbIw0DIRIy473+QziPpFh0BWcfMBAn
	nAnCNO5bwliWkoSuJXsRqLGU7Lym1urf9swyyoIFjBbHNevlfYyenx9GIHR6CIRIs6UXSU/fHIKXu
	Pm9P3a0iPn7H//rLKcPicA+23Q2qHiz/1sW+sGG7lZdIhZ+mBdgqluUmje31/shlu1OCCaJBm9tbR
	Mkhq3G5AUsKT7GFAMeng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkhh-0005X1-IY; Wed, 16 Jan 2019 12:53:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkhd-0005Vz-Eq; Wed, 16 Jan 2019 12:53:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D548780D;
 Wed, 16 Jan 2019 04:53:52 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 DD8B93F5AF; Wed, 16 Jan 2019 04:53:42 -0800 (PST)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Mike Rapoport <rppt@linux.ibm.com>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065521.GC6643@rapoport-lnx>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ddac2cef-43af-cda3-fe03-3fc070084731@arm.com>
Date: Wed, 16 Jan 2019 18:23:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190116065521.GC6643@rapoport-lnx>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_045353_507956_91325098 
X-CRM114-Status: GOOD (  15.19  )
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
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz,
 rientjes@google.com, palmer@sifive.com, greentime@andestech.com,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/16/2019 12:25 PM, Mike Rapoport wrote:
> On Wed, Jan 16, 2019 at 11:51:32AM +0530, Anshuman Khandual wrote:
>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>> architecture. This creates a new generic GFP flag flag which can be used
>> for any page table page allocation. Does not cause any functional change.
>>
>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>> generic page tabe header just to prevent it's potential misuse as a general
>> allocation flag if included in include/linux/gfp.h.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Build tested on arm, arm64, powerpc, powerpc64le and x86.
>> Boot tested on arm64 and x86.
>>
>> Changes in V2:
>>
>> - Moved GFP_PGTABLE into include/asm-generic/pgtable.h
>> - On X86 added __GFP_ACCOUNT into GFP_PGTABLE at various places
>> - Replaced possible flags on riscv and nds32 with GFP_PGTABLE
>>
>> Original V1: https://lkml.org/lkml/2019/1/12/54 
>>
>>  arch/arm/include/asm/pgalloc.h               |  8 +++-----
>>  arch/arm/mm/mmu.c                            |  2 +-
>>  arch/arm64/include/asm/pgalloc.h             |  9 ++++-----
>>  arch/arm64/mm/mmu.c                          |  2 +-
>>  arch/arm64/mm/pgd.c                          |  4 ++--
>>  arch/nds32/include/asm/pgalloc.h             |  3 +--
>>  arch/powerpc/include/asm/book3s/64/pgalloc.h |  6 +++---
>>  arch/powerpc/include/asm/pgalloc.h           |  2 --
>>  arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 +-
>>  arch/powerpc/mm/pgtable-frag.c               |  4 ++--
>>  arch/riscv/include/asm/pgalloc.h             |  8 +++-----
>>  arch/sh/mm/pgtable.c                         |  6 ++----
>>  arch/unicore32/include/asm/pgalloc.h         |  6 ++----
>>  arch/x86/kernel/espfix_64.c                  |  6 ++----
>>  arch/x86/mm/pgtable.c                        | 15 +++++++--------
>>  include/asm-generic/pgtable.h                |  2 ++
>>  virt/kvm/arm/mmu.c                           |  2 +-
>>  17 files changed, 37 insertions(+), 50 deletions(-)
> I wonder, what about the other arches? Do they use different GFP flags?
>  

Some of them as listed below use (GFP_KERNEL | __GFP_ZERO) which I will fix
next time around. Some how was focused on removing PGALLOC_GFP that missed
the other ones.

arch/powerpc/include/asm/nohash/64/pgalloc.h
arch/alpha/include/asm/pgalloc.h
arch/alpha/mm/init.c
arch/csky/include/asm/pgalloc.h
arch/arc/include/asm/pgalloc.h
........
........

But then there are those which use GFP_KERNEL alone without __GFP_ZERO like
pmd_alloc_one() in arch/sparc/include/asm/pgalloc_64.h cannot be replaced
with this patch as it does not intend to change functionality.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
