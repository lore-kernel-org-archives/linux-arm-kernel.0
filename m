Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BDCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:28:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7C92083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uhk1gDVg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="R3OKPtUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7C92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wQ0CcdYcM13r5AhliJjwkW9fymv7Ip4KVoPPGErCkis=; b=Uhk1gDVgVkGF4W
	3GUtoav7+aVnBeiF+gSJJUQrxPNkzWTpYQAGzD3awQS8dP5iqY7TfGoqSj8CljbR/dd2lt6dVQDE0
	Fh9suS7M9DAl5bUdcy9xyVn9t9ULOlUrXBviI10ly5jQTTwI2WO1n4m83WdEH5zq3zUD++gtwdRBQ
	La8zIxDR1AjnltwjY1MyE0EF5onb9156dNlHn+XkPw9Vql5/38KM4/rCIBIHRV64/Jm9RsMyaO1T9
	nVBOxiMaf1xwmk+ex6PPPQ52TReejpqKMdp0M0c55sQ0wKtSW53clvN5N30iWfom/juvy1rNBPW83
	eS2lekJ9Ty93baE47YfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwDsW-0000vC-W1; Tue, 19 Feb 2019 22:28:40 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwDsT-0000uH-7x
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 22:28:39 +0000
Received: by mail-it1-x142.google.com with SMTP id z131so10185338itf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 14:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BKRd5AyyK61scsjgCwEIyTQj0eRdMqLiIZW6sZLtvKI=;
 b=R3OKPtUjdUCZIw87Ibh7o6aDdAs0vzWVIYWa5QAOcfBzDwH9bZwB+EMnz4kD8GjLlO
 byuTLz068rv/8UpFmomNkA4F4LazeVxgTT4/8YauHoiHT/N30hqQyGyrqRq7lP839w1Z
 xyDCyrTEk6k5IAPeXlsi0VIkvd/U3VBXp1IW4pQqwjy4zV/sX62Y1Pu9oKWITE2S6JII
 HrAjqloWBN8iimotuNw6TR/VjQUi+wWOEX6ZyU1BioayAjydUtOWhh9SA6Z0o6n8tEEg
 16JWBcqysj262OGcUGjZX+euq4nF0UxoMkEep/xaEeg9hHjDGaDpqUi0VdnoWZRHfscJ
 OxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BKRd5AyyK61scsjgCwEIyTQj0eRdMqLiIZW6sZLtvKI=;
 b=SatbqszD+zBGKjrID3Q+H2Ea7IbERAe0p1XnvPGwstpU4xBLvE4+JR5/7RWZMrcj1j
 70UhKJ9NMmIKL86vSS5g6iepS6NH+3PSYTYwkh8EbNnuvts7r17JAmZjvr/hfRVPlBtr
 YxsNSnMHqJNESGGQEx4YadX09TZBslDJdUfZgNk47GLD9hZpXWLvd3wuU0cE03IsIXwA
 ai+6Dk54Qmk0r3gb0ewc4Li88VlwUYKJKlRHLifKHkoEJoEgO5nApGPErVse9v22zhDu
 2vdupHr6TnN2z0CG5lr/wNWONp7il6Kdj4MorT/BZYX6ebvQtZEEBdmlvwWPbLc573G1
 rJDg==
X-Gm-Message-State: AHQUAuaesFi5N8z3+CIUWtGb9fROCG11FRPFwUTUYq4MRxtEXGxhZFjG
 ANssmZeSNgMd8q2yMtDDc1Chbg==
X-Google-Smtp-Source: AHgI3IYDrRq/fljAVOdA83+8pvwWb7QsvvWaKeFJSwJZsRzEaSegd5cU0sMDfnBu0WjxoCa4wTZy0w==
X-Received: by 2002:a24:9d81:: with SMTP id f123mr4298178itd.55.1550615311324; 
 Tue, 19 Feb 2019 14:28:31 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id t5sm6916976ioi.43.2019.02.19.14.28.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 14:28:30 -0800 (PST)
Date: Tue, 19 Feb 2019 15:28:28 -0700
From: Yu Zhao <yuzhao@google.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190219222828.GA68281@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_142837_289588_0554E095 
X-CRM114-Status: GOOD (  31.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
 Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 11:47:12AM +0530, Anshuman Khandual wrote:
> + Matthew Wilcox
> 
> On 02/19/2019 11:02 AM, Yu Zhao wrote:
> > On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
> >>
> >>
> >> On 02/19/2019 04:43 AM, Yu Zhao wrote:
> >>> For pte page, use pgtable_page_ctor(); for pmd page, use
> >>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> >>> p4d and pgd), don't use any.
> >> pgtable_page_ctor()/dtor() is not optional for any level page table page
> >> as it determines the struct page state and zone statistics.
> > 
> > This is not true. pgtable_page_ctor() is only meant for user pte
> > page. The name isn't perfect (we named it this way before we had
> > split pmd page table lock, and never bothered to change it).
> > 
> > The commit cccd843f54be ("mm: mark pages in use for page tables")
> > clearly states so:
> >   Note that only pages currently accounted as NR_PAGETABLES are
> >   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.
> 
> I think the commit is the following one and it does say so. But what is
> the rationale of tagging only PTE page as PageTable and updating the zone
> stat but not doing so for higher level page table pages ? Are not they
> used as page table pages ? Should not they count towards NR_PAGETABLE ?
> 
> 1d40a5ea01d53251c ("mm: mark pages in use for page tables")

Well, I was just trying to clarify how the ctor is meant to be used.
The rational behind it is probably another topic.

For starters, the number of pmd/pud/p4d/pgd is at least two orders
of magnitude less than the number of pte, which makes them almost
negligible. And some archs use kmem for them, so it's infeasible to
SetPageTable on or account them in the way the ctor does on those
archs.

But, as I said, it's not something can't be changed. It's just not
the concern of this patch.

> > 
> > I'm sure if we go back further, we can find similar stories: we
> > don't set PageTable on page tables other than pte; and we don't
> > account page tables other than pte. I don't have any objection if
> > you want change these two. But please make sure they are consistent
> > across all archs.
> 
> pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
> for generalization which has been already acknowledged earlier. But for now we
> can atleast fix this on arm64.
> 
> https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/

This is again not true. Please stop making claims not backed up by
facts. And the link is completely irrelevant to the ctor.

I just checked *all* arches. Only four arches call the ctor outside
pte_alloc_one(). They are arm, arm64, ppc and s390. The last two do
so not because they want to SetPageTable on or account pmd/pud/p4d/
pgd, but because they have to work around something, as arm/arm64
do.

> 
> > 
> >> We should not skip it for any page table page.
> > 
> > In fact, calling it on pmd/pud/p4d is peculiar, and may even be
> > considered wrong. AFAIK, no other arch does so.
> 
> Why would it be considered wrong ? IIUC archs have their own understanding
> of this and there are different implementations. But doing something for
> PTE page and skipping for others is plain inconsistent.

Allocating memory that will never be used is wrong. Please look into
the ctor and find out what exactly it does under different configs.

And why I said "may"? Because we know there is only negligible number
of pmd/pud/p4d, so the memory allocated may be considered negligible
as well.

> 
> > 
> >> As stated before pgtable_pmd_page_ctor() is not a replacement for
> >> pgtable_page_ctor().
> > 
> > pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
> > it's okay to use pgtable_page_ctor() instead only because kernel
> > doesn't have thp.
> 
> The only extra thing to be done for THP is initializing page->pmd_huge_pte
> apart from calling pgtable_page_ctor(). Right not it just works on arm64
> may be because page->pmd_huge_pte never gets accessed before it's init and
> no path checks for it when not THP. Its better to init/reset pmd_huge_pte.

This is not the reason. Arm64 gets by with calling
pgtable_page_ctor() on pmd because it only does so on efi_mm. efi_mm
is not user mm, therefore doesn't involve thp.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
