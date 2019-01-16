Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA90C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:33:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503A620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DLxMu8I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503A620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sK+ULvZD2R4E6RZXQG/iAqPqW2H2afX3G9SChFuAU14=; b=DLxMu8I6OkNWRI
	RBgxNQLJBOCIjOw3SS+dluB5+9nC8i+colOHCUYERS0e8r3Ui/3ZNMp+0e44QqW/TxkuxbmIcBUx0
	/RegTBbMCRIGW/VTAKqhCSRpuv7h8xFwinKQUb7Q1SK0f8QZfAaQDb5tMRLuwaVs5jOuROACYK1Ul
	1nE2ikQ/KtSj3rxMjkT9g+0pnhZXwCVnCtKA4+mV2sieJ88OwBnrziSFMPnf6E0lLmYd/TXNnypWK
	27P9NMN4DssiWL7g/jqZIzqta9frLpKTXHBubtUzFohCGmpiGsXY1fgkZyhbgpAT1ZRwCBWKLBDPh
	XMrZY6CAoosZ/fUu6g0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlJe-0004Z5-EB; Wed, 16 Jan 2019 13:33:10 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlJb-0004Yb-9G; Wed, 16 Jan 2019 13:33:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7292FAF8A;
 Wed, 16 Jan 2019 13:33:05 +0000 (UTC)
Date: Wed, 16 Jan 2019 14:33:02 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
Message-ID: <20190116133302.GN24149@dhcp22.suse.cz>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
 <20190116131827.GH6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116131827.GH6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_053307_466230_FF22A3CE 
X-CRM114-Status: GOOD (  20.86  )
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
 christoffer.dall@arm.com, linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au, greentime@andestech.com,
 linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
 palmer@sifive.com, Anshuman Khandual <anshuman.khandual@arm.com>,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed 16-01-19 05:18:27, Matthew Wilcox wrote:
> On Wed, Jan 16, 2019 at 06:42:22PM +0530, Anshuman Khandual wrote:
> > On 01/16/2019 06:00 PM, Matthew Wilcox wrote:
> > > On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
> > >> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
> > >>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> > >>> __GFP_ZERO) and using it for allocating page table pages. This causes some
> > >>> code duplication which can be easily avoided. GFP_KERNEL allocated and
> > >>> cleared out pages (__GFP_ZERO) are required for page tables on any given
> > >>> architecture. This creates a new generic GFP flag flag which can be used
> > >>> for any page table page allocation. Does not cause any functional change.
> > >>>
> > >>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
> > >>> generic page tabe header just to prevent it's potential misuse as a general
> > >>> allocation flag if included in include/linux/gfp.h.
> > >>
> > >> I haven't reviewed the patch yet but I am wondering whether this is
> > >> really worth it without going all the way down to unify the common code
> > >> and remove much more code duplication. Or is this not possible for some
> > >> reason?
> > > 
> > > Exactly what I suggested doing in response to v1.
> > > 
> > > Also, the approach taken here is crazy.  x86 has a feature that no other
> > > architecture has bothered to implement yet -- accounting page tables
> > > to the process.  Yet instead of spreading that goodness to all other
> > > architectures, Anshuman has gone to more effort to avoid doing that.
> > 
> > The basic objective for this patch is to create a common minimum allocation
> > flag that can be used by architectures but that still allows archs to add
> > on additional constraints if they see fit. This patch does not intend to
> > change functionality for any arch.
> 
> I disagree with your objective.  Making more code common is a great idea,
> but this patch is too unambitious.  We should be heading towards one or
> two page table allocation functions instead of having every architecture do
> its own thing.
> 
> So start there.  Move the x86 function into common code and convert one
> other architecture to use it too.

Agreed!

-- 
Michal Hocko
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
