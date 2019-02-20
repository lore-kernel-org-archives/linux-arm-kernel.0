Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA61C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:59:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0058C2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YPiF6Zjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0058C2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gChwLofvj5JGhGgOO8EDnApDNP7jMpx3EK4GmwlmYes=; b=YPiF6ZjzYycOCm
	UVq7uk6Bh1jAvYXOpX2q0s5aBHRqrHYKuWXn/h6b2Cv02Rqi9ZPrsZMvP0+9ymQC5pi/KegaRKLxr
	4DfBjH+iFjjSPuD9F4turouy54EpuvvenSDn9pfLfx+b/i62Fx3KtoRtyVYzpXoV5EmTS6kvMIQpb
	8JK0f6pLt2DGBnSsOgFiXiwDq78rTtcXi/4D+Yrtzj0BvpQqEcQdgG/fEPZOmfnsoydv1bNNVD2UK
	zJgeeXIqtlyFuEp7Tn+brKuMvUCwRRqYxepFlOcSf8HojNdV/NsOXI6xSWTn/6Ue9ec0khKBCzyh7
	ilAR8uwm1BaeHEgZmM4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwYxo-00036k-C4; Wed, 20 Feb 2019 20:59:32 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gwYxm-00036R-7C; Wed, 20 Feb 2019 20:59:30 +0000
Date: Wed, 20 Feb 2019 12:59:30 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190220205930.GL12668@bombadil.infradead.org>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
 <20190219222828.GA68281@google.com>
 <f7e4db43-b836-4ac2-1aea-922be585d8b1@arm.com>
 <20190220202244.GA80497@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220202244.GA80497@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
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

On Wed, Feb 20, 2019 at 01:22:44PM -0700, Yu Zhao wrote:
> On Wed, Feb 20, 2019 at 03:57:59PM +0530, Anshuman Khandual wrote:
> > Using pgtable_pmd_page_ctor() during PMD level pgtable page allocation
> > as suggested in the patch breaks pmd_alloc_one() changes as per the
> > previous proposal. Hence we all would need some agreement here.
> > 
> > https://www.spinics.net/lists/arm-kernel/msg701960.html
> 
> A proposal that requires all page tables to go through a same set of
> ctors on all archs is not only inefficient (for kernel page tables)
> but also infeasible (for arches use kmem for page tables). I've
> explained this clearly.
> 
> The generalized page table functions must recognize the differences
> on different levels and between user and kernel page tables, and
> provide unified api that is capable of handling the differences.

The two architectures I'm aware of (s390 and power) which use sub-page
allocations for page tables do so by allocating entire pages and then
implementing their own allocators.  It shouldn't be a huge problem to
use a ctor for the pages.  We can probably even implement a dtor for them.

Oh, another corner-case I've just remembered is x86-32's PAE with four
8-byte entries in the PGD.  That should also go away and be replaced
with a shared implementation of sub-page allocations which can also be
marked as PageTable.

Ideally PTEs, PMDs, etc, etc would all be accounted to the individual
processes causing them to be allocated.  This isn't really feasible
with the x86 PGD; by definition there's only one per process.  I'm OK
with failing to account this 32-byte allocation to the task though.
So maybe the pgd_cache can remain separate from the hypothetical unified
ppc/s390 code.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
