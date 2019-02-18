Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68C4217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BsvkmXe6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lnCZINN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68C4217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g/OiDrmU8CFMUaOYaB9foGGmmdAwm7smFskj7BpWCNw=; b=BsvkmXe62u9Chc
	z0vhX3vqorbX+9+/C4hNcUCtSgMnUnhnK1PyDv+JnutS2WaNVaBAc3QR56B+clwOYVA0mUHjVIGMu
	e0GARMxeUbdy+jCzEv4Vkpk+rM91YeWlZ7a0dMYVwx/s+IP4Xi9qjvwauDTp61DQUC5Uq4B2xhpXk
	/R/xF76Y5pYA25O26u3mNMxXWcS6a5hJNZ/RSkaLEyvApqLpQzC62e0VR/zTDVBF96B9tx0g8xEMF
	EQfX20rgtvvRQs6uOzlZnOULrv+O+9kDzxYDnhkAjpWwntpVyzDJgEbJ2Ax3rby079+kWCObbFU72
	lDPY2Wzxz5mOhs/Gheaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvovI-0002GQ-2I; Mon, 18 Feb 2019 19:49:52 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvovB-0002D0-5T
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:49:47 +0000
Received: by mail-it1-x142.google.com with SMTP id l66so743869itg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0wtsBdExeMA1wwCJ28I4aSi9QBIDjm+ySXCh9WlH+r8=;
 b=lnCZINN7IoVMhyN6Ibb/qlSwbfdgcKLoKqRCpyFvlLWtuAoP/FCJcQKLFGQi09gDVr
 5DiPNsJ3wLufD+iHIhNZDCwwyRCLWiwKRGn/GJIg8q191GC4x6c+6wVVnjJ1WaSYzq9O
 3x4YrPPt0p1oh4zkAc1KgwK83gxLOg25m+qlcqCvbwwptQv/6HSlZVPVC36c+OTBDIBy
 APQe2ue7roT6A2u6aQFmTgeF65aUI+pCdpn/VkyjDeN3Lu2FSg8S8Dqg0Li9uFHFoFEt
 Kjpz3ydKeddO0GqHPTLYFF+2YmEsV0f+vPa64ELLx8sRS1MhTdY5T/XF3M1qgBM3LpeO
 eB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0wtsBdExeMA1wwCJ28I4aSi9QBIDjm+ySXCh9WlH+r8=;
 b=Xvbud6klMhspoOuuZPSrhDG7Y/oHHAy9jMDv6vGR0kTRPU5O69iyVVBxiVMS8tn+F8
 JS1QxKUuj0I4Oba5CRJLxx+xsoIbY07nW+nae/2N9zA3BE7bPgTQsO4N7mZRyNtMq7yB
 QMiUq9dFv22e0DYt+bbHn0E5iu0UGE3mZHzSC+4irgEgHt2+jcv/prxsSlLY41MwUYY8
 FhlFhgXPUq4VjYTBHmVBCV+wFFoXffVXbomcYjJYk9wZ00wH33yBl6oMhcRvYNZAyXvq
 0XKX0gKjQXLS1UX2geFMZWhqMZQr/BkGYBGdQCyNvupaCsqAiF1Ey5h5l4luFM94MdXQ
 Dy/A==
X-Gm-Message-State: AHQUAuYOCxN3V3uRachd+Yk0CbY5hiZHmoufK03+pUZJTg3p4YvDNa/m
 xg8z+IKKAO23aVWoiEgFjQeU9A==
X-Google-Smtp-Source: AHgI3IYgK3DVojWmklhiIeoLq404ESnMMVIaR2vGDGMXORI8El0uFkQrhGihzkrV0E3C0Mg6kZr77A==
X-Received: by 2002:a02:c943:: with SMTP id u3mr13451152jao.96.1550519381443; 
 Mon, 18 Feb 2019 11:49:41 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id x17sm5606036ioa.6.2019.02.18.11.49.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 11:49:40 -0800 (PST)
Date: Mon, 18 Feb 2019 12:49:38 -0700
From: Yu Zhao <yuzhao@google.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: mm: enable per pmd page table lock
Message-ID: <20190218194938.GA184109@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218151223.GB16091@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218151223.GB16091@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_114945_304433_A32CCB0B 
X-CRM114-Status: GOOD (  24.03  )
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

On Mon, Feb 18, 2019 at 03:12:23PM +0000, Will Deacon wrote:
> [+Mark]
> 
> On Thu, Feb 14, 2019 at 02:16:42PM -0700, Yu Zhao wrote:
> > Switch from per mm_struct to per pmd page table lock by enabling
> > ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
> > large system.
> > 
> > I'm not sure if there is contention on mm->page_table_lock. Given
> > the option comes at no cost (apart from initializing more spin
> > locks), why not enable it now.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  arch/arm64/Kconfig               |  3 +++
> >  arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
> >  arch/arm64/include/asm/tlb.h     |  5 ++++-
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index a4168d366127..104325a1ffc3 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
> >  config ARCH_HAS_CACHE_LINE_SIZE
> >  	def_bool y
> >  
> > +config ARCH_ENABLE_SPLIT_PMD_PTLOCK
> > +	def_bool y
> > +
> >  config SECCOMP
> >  	bool "Enable seccomp to safely compute untrusted bytecode"
> >  	---help---
> > diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> > index 52fa47c73bf0..dabba4b2c61f 100644
> > --- a/arch/arm64/include/asm/pgalloc.h
> > +++ b/arch/arm64/include/asm/pgalloc.h
> > @@ -33,12 +33,22 @@
> >  
> >  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> >  {
> > -	return (pmd_t *)__get_free_page(PGALLOC_GFP);
> > +	struct page *page;
> > +
> > +	page = alloc_page(PGALLOC_GFP);
> > +	if (!page)
> > +		return NULL;
> > +	if (!pgtable_pmd_page_ctor(page)) {
> > +		__free_page(page);
> > +		return NULL;
> > +	}
> > +	return page_address(page);
> 
> I'm a bit worried as to how this interacts with the page-table code in
> arch/arm64/mm/mmu.c when pgd_pgtable_alloc is used as the allocator. It
> looks like that currently always calls pgtable_page_ctor(), regardless of
> level. Do we now need a separate allocator function for the PMD level?

Thanks for reminding me, I never noticed this. The short answer is
no.

I guess pgtable_page_ctor() is used on all pud/pmd/pte entries
there because it's also compatible with pud, and pmd too without
this patch. So your concern is valid. Thanks again.

Why my answer is no? Because I don't think the ctor matters for
pgd_pgtable_alloc(). The ctor is only required for userspace page
tables, and that's why we don't have it in pte_alloc_one_kernel().
AFAICT, none of the pgds (efi_mm.pgd, tramp_pg_dir and init_mm.pgd)
pre-populated by pgd_pgtable_alloc() is. (I doubt we pre-populate
userspace page tables in any other arch).

So to avoid future confusion, we might just remove the ctor from
pgd_pgtable_alloc().

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
