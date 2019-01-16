Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64F1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:34:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7E720651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQcVPthd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7E720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qK7q8/hNi7AuBD/W9uYT03J+Dq5DVW6yCoyo2/PJGGI=; b=bQcVPthdravbol
	DF96XESQprgNmlE4qGxkBEiLT+S0TCDqt7YcWFd+iGCbU6SNAbQMMzurZt+VD1R9d0KjtLWdY7cJD
	mLDxNx4cu6lRBhddm1camrvdqPzB4OF9UOBnxTLSegUP4/UIdDQdv3tP4mYGIuhnaxM+tinbGpSm9
	uMVzPO7W0FdaGeRWLbtbQXhamCpjtpvbhNZ0hwrr/OZMcWx1L2KUB+e8Rc71juzBaBJmEcoWgkeEL
	p0dXX1Jrbv0QKIdfUC8OG5MxOHcxKbZx00URMwBXn31pAiwvnvXrCEllY+2xYzuU/R3lhBwni4Q0a
	hrU7pOAcrC6UIgJZ8iYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkOt-0004dc-6Z; Wed, 16 Jan 2019 12:34:31 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkOr-0004dF-9T; Wed, 16 Jan 2019 12:34:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id A441B2029D919; Wed, 16 Jan 2019 13:34:27 +0100 (CET)
Date: Wed, 16 Jan 2019 13:34:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
Message-ID: <20190116123427.GE10803@hirez.programming.kicks-ass.net>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116123018.GF6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, christoffer.dall@arm.com, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, greentime@andestech.com, linux@armlinux.org.uk,
 mingo@redhat.com, vbabka@suse.cz, rientjes@google.com, palmer@sifive.com,
 Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 04:30:18AM -0800, Matthew Wilcox wrote:
> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
> > On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
> > > All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> > > __GFP_ZERO) and using it for allocating page table pages. This causes some
> > > code duplication which can be easily avoided. GFP_KERNEL allocated and
> > > cleared out pages (__GFP_ZERO) are required for page tables on any given
> > > architecture. This creates a new generic GFP flag flag which can be used
> > > for any page table page allocation. Does not cause any functional change.
> > > 
> > > GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
> > > generic page tabe header just to prevent it's potential misuse as a general
> > > allocation flag if included in include/linux/gfp.h.
> > 
> > I haven't reviewed the patch yet but I am wondering whether this is
> > really worth it without going all the way down to unify the common code
> > and remove much more code duplication. Or is this not possible for some
> > reason?
> 
> Exactly what I suggested doing in response to v1.
> 
> Also, the approach taken here is crazy.  x86 has a feature that no other
> architecture has bothered to implement yet -- accounting page tables
> to the process.  Yet instead of spreading that goodness to all other
> architectures, Anshuman has gone to more effort to avoid doing that.

Also, s390 (of course, who else) has a fun custom page-table allocator
for reasons that don't apply to many other archs.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
