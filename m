Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E4CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:02:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C213720660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0ZFpKhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C213720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k8+YFdXW4AvJt0+BQQEs+qtYZoNyYLDujHkMUNUEiF8=; b=C0ZFpKhZZZ9Xm3
	HeTf53h1h/bB34QTfZ9n571lGnuW4yPIV4sj4Nj6F6h0xSwF/4a9Ec4zSQpcasZt/tuCMPzwNMpXs
	ohaCUlafh2QZefJH/7mB+HwYbdt5fL11faBAjj1e08uw8hK2uH6/PwoUiiy53fDnyvGL9/CtFCCbc
	bg56An1Il95eNfO7iZdoIoEwYQUNA992b5egNkGNYR+H7E2GNxo7zw81WHpSBuCCtM0z67hxsYhy8
	9ow94SCdOnPyZs20lkQQno2ghmqNH0eKQo37j5/B3Gk81CyHg+gEwGwF0YlKRbRI2x7qwh9xJRkSV
	MicW3aPdcpEI/szPPArg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giwFp-0001iW-Kt; Mon, 14 Jan 2019 07:01:49 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giwFl-0001X5-Oz
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 07:01:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4F069AE72;
 Mon, 14 Jan 2019 07:01:41 +0000 (UTC)
Date: Mon, 14 Jan 2019 08:01:37 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190114070137.GB21345@dhcp22.suse.cz>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190113173555.GC1578@dhcp22.suse.cz>
 <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_230145_960467_722E83F6 
X-CRM114-Status: GOOD (  16.60  )
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

On Mon 14-01-19 09:30:55, Anshuman Khandual wrote:
> 
> 
> On 01/13/2019 11:05 PM, Michal Hocko wrote:
> > On Sat 12-01-19 15:56:38, Anshuman Khandual wrote:
> >> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> >> __GFP_ZERO) and using it for allocating page table pages. This causes some
> >> code duplication which can be easily avoided. GFP_KERNEL allocated and
> >> cleared out pages (__GFP_ZERO) are required for page tables on any given
> >> architecture. This creates a new generic GFP flag flag which can be used
> >> for any page table page allocation. Does not cause any functional change.
> > 
> > I agree that some unification is due but GFP_PGTABLE is not something to
> > expose in generic gfp.h IMHO. It just risks an abuse. I would be looking
> 
> Why would you think that it risks an abuse ? It does not create new semantics
> of allocation in the buddy. Its just uses existing GFP_KERNEL allocation which
> is then getting zeroed out. The risks (if any) is exactly same as GFP_KERNEL.

Beucase my experience just tells me that people tend to use whatever
they find and name fits what they think they need.

> > at providing asm-generic implementation and reuse it to remove the code
> 
> Does that mean GFP_PGTABLE can be created but not in gfp.h but in some other
> memory related header file ?

I would just keep it close to its users. If that is a single arch
generic place then only better. But I suspect some arches have special
requirements.

> > duplication. But I haven't tried that to know that it will work out due
> > to small/subtle differences between arches.
> 
> IIUC from the allocation perspective GFP_ACCOUNT is the only thing which gets
> added with GFP_PGTABLE for user page table for memcg accounting purpose. There
> does not seem to be any other differences unless I am missing something.

It's been some time since I've checked the last time. Some arches were
using GPF_REPEAT (__GFP_RETRY_MAYFAIL) back then. I have removed most of
those but some were doing a higher order allocations so they probably
have stayed.
-- 
Michal Hocko
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
