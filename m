Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A9B205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VUyOslOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A9B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HknG1KqhFEu4cOLOj4Ok0baP4XyFMUE/6nA/IDut5e0=; b=VUyOslOQsmesPv
	iC8OqLKUnh0SgRc9yW8xYJYeyss+jX8g+xI8E47b8CUmAvAraVF+X9hhRhoE7UJhMLKOixWUnXaEY
	FU8/gUad7bFKcbY6lfZbTAp+Kdhz+qaFtKKM/bEC3E+sKvdKEjlicH1dSc4FpyLvfltQ763MOB1PQ
	PqU3mQq8zF1wcxMYf1yYWoh8cnMJ99Vj92gwPoRgHLMt8UamwFSnatAD3yn15xZ1tMwDixaycogSh
	oWmRKG1UbyayJ6GHdTvHbysfx+H+hIObkKoV1QnQ+7lJpmVlmjXaLgqUXTe1FQYjnmLDjZO85NnyP
	5aiY+sBDQFSqmgGrK9eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjm3H-0006bf-7U; Wed, 16 Jan 2019 14:20:19 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gjm3C-0006U0-M1; Wed, 16 Jan 2019 14:20:14 +0000
Date: Wed, 16 Jan 2019 06:20:14 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
Message-ID: <20190116142014.GJ6310@bombadil.infradead.org>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
 <20190116131827.GH6310@bombadil.infradead.org>
 <521d8511-4c87-49c6-de03-67a71d5bacca@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521d8511-4c87-49c6-de03-67a71d5bacca@c-s.fr>
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
Cc: mark.rutland@arm.com, christoffer.dall@arm.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, palmer@sifive.com,
 will.deacon@arm.com, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 aneesh.kumar@linux.ibm.com, greentime@andestech.com, linux@armlinux.org.uk,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, rientjes@google.com,
 dave.hansen@linux.intel.com, Anshuman Khandual <anshuman.khandual@arm.com>,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, vbabka@suse.cz,
 ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 02:47:16PM +0100, Christophe Leroy wrote:
> Le 16/01/2019 =E0 14:18, Matthew Wilcox a =E9crit=A0:
> > I disagree with your objective.  Making more code common is a great ide=
a,
> > but this patch is too unambitious.  We should be heading towards one or
> > two page table allocation functions instead of having every architectur=
e do
> > its own thing.
> > =

> > So start there.  Move the x86 function into common code and convert one
> > other architecture to use it too.
> =

> Are we talking about pte_alloc_one_kernel() and pte_alloc_one() ?
> =

> I'm not sure x86 function is the best common one, as it seems to allocate=
 a
> multiple of PAGE_SIZE only.

And that's the common case.  Most architectures use a single page for at
least one level of the pte/pmd/pud/p4d/pgd hierarchy.  Some use multiple
pages and some use a fraction of a page.

> Some arches like powerpc use pagetables which are smaller than a page, for
> instance powerpc 8xx uses 4k pagetables even with 16k pages, which means a
> single page can be used by 4 pagetables.

Those can be added later.  Note I said "one or two", and that's what I
had in mind; I think we want one function that allocates just a page
and another that allocates a page fragment.  Then we can have a good
discussion about what method we use; s390 and ppc use different techniques
today and there's really no good reason for that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
