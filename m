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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:48:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBC6205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R+zevwaq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NUQUzfw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBC6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kHMkzOejOhc6mz6FMKxmEM77KZh9Oh8pZCgYsYD+Fdo=; b=R+zevwaqtyK6lh
	WkFNfi1QxlLeX1onvxG+NF8PfSmk6eJADgYycqKSQ6AQXemumjY3LXjbiHWd8IT5e31HEodBRHevu
	0fLXzi7heOlfZdKU7llQTnC5qiDJoM+8QXAAvGDm3fLTrXqUKJxJ+JC1303Qn6o4bNVFaaxra6FWO
	Ob2aYHcu/3arX0qxvYdvwfEDvfla1Uf7p+obS2exBnKpI/DsqoDpLChRGjFGi0bW3AZRZwtrAmAfO
	xGznRH6YzyMcAKNE1I4qXjCOatzEavMhjd0dYeOnsmjBSz+Ofw2ZX8M0IUBED5vzpSX2Xr5TddvXF
	jy6XsnjqzF3aE7Pp9+3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvpqL-0006uv-SH; Mon, 18 Feb 2019 20:48:49 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvpqJ-0006uW-14
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 20:48:48 +0000
Received: by mail-it1-x143.google.com with SMTP id g137so863000ita.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/NLpiy+j/zrpP+sVhQdIcgCVfL0HwEex4aRdsJ4vY8Q=;
 b=NUQUzfw8/x7dr0Q70sqUQawAGRy1k43ldVFkm4ZbYxr1A3YdpzcGBs+YvYXIOhmZr+
 45UfT9cky6fpnR0KZOUXAxs90kZDwfEffomg1cwN/PpVg0WEPS6aW5GpHLtuct5JMUJq
 K213WVXJIDZ0l/iI9bu25oOyzAcMIFxP79Nzr9hkj/tZezv0NOLTYFZ9AnOC59poJK9q
 21/h5HJxE20vXVmiNlzp3I8scZNb5ELd+yb3+OnbaSox94ydiQ/+kUattnzPon/0+iDL
 dldi9AiGX42H8k9DyNw8FdUIZITG8BoFgW4sWn7w7K/aJ6rwcJ5lSHZ1Wj1Iso7Z53Ba
 dSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/NLpiy+j/zrpP+sVhQdIcgCVfL0HwEex4aRdsJ4vY8Q=;
 b=Nwddtkyw1LLdC/aywAbOpSZ9feu4LaJrHx15FiRhtU0DGHv2UzEI0a0v1kAf/Mcwf0
 rYHutp/TfPHTNGu6b+kzds12MQS/tz0dMrz5vyRM65UVtlc5dayAXcGOrItDtSFBOcjj
 o0CCSEAJbTfVORHCpn9EvqjY/I8TebmtP5ZLDd4IN+YFykRBSZk/pGFcCZ1e4uy3ID0J
 /pxVyPJGf2On+PJYV4cs7LpKC/ffRZCDPQJ9bAnNa6wK0OEUoIqUG8FgXZbo2Haxpe4E
 EJChekI0g20tblJ3+UdGWwQvRkB6NEEQEgXY2Fwlvt9MFrdwHChkYfe9uFTWjQqFHEb0
 Xj3w==
X-Gm-Message-State: AHQUAuYA4a8UzdpgByGru9E23W8oI2iGYh0065oUH5YP1mviJ1xeDtNR
 WE0oR2Lw2bILHwdjL/UOyI16eA==
X-Google-Smtp-Source: AHgI3IYoW571J1Mbargry0dSLvhBvQdK5/NeOan6qv4n/bRuaI5i5jinvq0JPQkH5R/r3DLUERBiXg==
X-Received: by 2002:a24:4648:: with SMTP id j69mr470647itb.56.1550522925849;
 Mon, 18 Feb 2019 12:48:45 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id d6sm5943432ioc.44.2019.02.18.12.48.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 12:48:44 -0800 (PST)
Date: Mon, 18 Feb 2019 13:48:42 -0700
From: Yu Zhao <yuzhao@google.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: mm: enable per pmd page table lock
Message-ID: <20190218204842.GA203083@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218151223.GB16091@fuggles.cambridge.arm.com>
 <20190218194938.GA184109@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218194938.GA184109@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_124847_092788_E37CDD38 
X-CRM114-Status: GOOD (  28.83  )
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

On Mon, Feb 18, 2019 at 12:49:38PM -0700, Yu Zhao wrote:
> On Mon, Feb 18, 2019 at 03:12:23PM +0000, Will Deacon wrote:
> > [+Mark]
> > 
> > On Thu, Feb 14, 2019 at 02:16:42PM -0700, Yu Zhao wrote:
> > > Switch from per mm_struct to per pmd page table lock by enabling
> > > ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
> > > large system.
> > > 
> > > I'm not sure if there is contention on mm->page_table_lock. Given
> > > the option comes at no cost (apart from initializing more spin
> > > locks), why not enable it now.
> > > 
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > ---
> > >  arch/arm64/Kconfig               |  3 +++
> > >  arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
> > >  arch/arm64/include/asm/tlb.h     |  5 ++++-
> > >  3 files changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index a4168d366127..104325a1ffc3 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
> > >  config ARCH_HAS_CACHE_LINE_SIZE
> > >  	def_bool y
> > >  
> > > +config ARCH_ENABLE_SPLIT_PMD_PTLOCK
> > > +	def_bool y
> > > +
> > >  config SECCOMP
> > >  	bool "Enable seccomp to safely compute untrusted bytecode"
> > >  	---help---
> > > diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> > > index 52fa47c73bf0..dabba4b2c61f 100644
> > > --- a/arch/arm64/include/asm/pgalloc.h
> > > +++ b/arch/arm64/include/asm/pgalloc.h
> > > @@ -33,12 +33,22 @@
> > >  
> > >  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> > >  {
> > > -	return (pmd_t *)__get_free_page(PGALLOC_GFP);
> > > +	struct page *page;
> > > +
> > > +	page = alloc_page(PGALLOC_GFP);
> > > +	if (!page)
> > > +		return NULL;
> > > +	if (!pgtable_pmd_page_ctor(page)) {
> > > +		__free_page(page);
> > > +		return NULL;
> > > +	}
> > > +	return page_address(page);
> > 
> > I'm a bit worried as to how this interacts with the page-table code in
> > arch/arm64/mm/mmu.c when pgd_pgtable_alloc is used as the allocator. It
> > looks like that currently always calls pgtable_page_ctor(), regardless of
> > level. Do we now need a separate allocator function for the PMD level?
> 
> Thanks for reminding me, I never noticed this. The short answer is
> no.
> 
> I guess pgtable_page_ctor() is used on all pud/pmd/pte entries
> there because it's also compatible with pud, and pmd too without
> this patch. So your concern is valid. Thanks again.
> 
> Why my answer is no? Because I don't think the ctor matters for
> pgd_pgtable_alloc(). The ctor is only required for userspace page
> tables, and that's why we don't have it in pte_alloc_one_kernel().
> AFAICT, none of the pgds (efi_mm.pgd, tramp_pg_dir and init_mm.pgd)
> pre-populated by pgd_pgtable_alloc() is. (I doubt we pre-populate
> userspace page tables in any other arch).
> 
> So to avoid future confusion, we might just remove the ctor from
> pgd_pgtable_alloc().

I'm sorry. I've missed that we call apply_to_page_range() on efi_mm.
The function does require the ctor. So we actually can't remove it.
Though pgtable_page_ctor() also does the work adequately for pmd in
terms of giving apply_to_page_range() what it requires, it would be
more appropriate to use pgtable_pmd_page_ctor() instead (and not
calling the ctor at all on pud).

I could add this change prior to this patch, if it makes sense to
you. Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
