Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31399C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00FF21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j+J5buUp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WUvAQuSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00FF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVmY3cLTt5oAP1/g5UmUT6olNkEqRZkiCij90mDqV7I=; b=j+J5buUpTTNC/M
	+kCz9xzatKX7R3W9igYAIKHVNWaYtoOxx1fSapOvJrQHJtuCNpjVznp1cb7yHupahSMLuX2/Y7EBw
	k07nkwcYy36fS01hLq049pWgPjQyUcIwOIx3lby2t9McYFzib5HxbS24DZBfyi2vOFxRY42xLolAI
	k+FueGF9I1B8q3DvpTjs7GvWF2IAC2TUoW/nksNZWtqH7GyEub1v5QglNgDmC7xBgjv6WZAfT5oaG
	SkNkfRu8NkkVnjE9kSFD0B9HhTarb5p1gd5goxzToWiHKO0qp6gBTjoQyuOpav8aArtki+BbphXC2
	Qj1EA3ERjxV3R87t/CHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfWzw-0000cc-P6; Fri, 04 Jan 2019 21:27:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfWzv-0000cW-31
 for linux-arm-kernel@bombadil.infradead.org; Fri, 04 Jan 2019 21:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M0/WqjEFBOBxF3WhSh93UacXL4+Qhil1296ev4EO57Q=; b=WUvAQuSSn57PN3hP4Y1OJgBwY
 4w/YqN5lh2obiB+PCvIYH4MOmigfdkziCuphd68jfUCIQSVAxlGLSZSpD4A1r2UWbBHh47rRk1mLs
 avM1DwqRw+I1n0dJSDE31oAS5w+dG5Lyc0UkS+6aF3/QxF5+dAkPmj3hPOmxhpW9tZCPpsdzu5ZlF
 SUWYHGCXca8Gx4+BJUl5JlQeQKjxcsBwhII/fVid64spWu2yC9WBqs172IUEe44aZ0GQncfmg7tX9
 WRbFcMtLjzQfB6D1C0e/sQu1vlhzXsTnDxsI5JbpFGkREJx811IeHnuEJN0TJzRgt7FGWfcaqNkcB
 nO9yqk7pQ==;
Received: from mga18.intel.com ([134.134.136.126])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfWzq-0001gK-UB
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 21:27:17 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jan 2019 13:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; d="scan'208";a="307580654"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.154])
 by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 13:27:02 -0800
Date: Fri, 4 Jan 2019 13:27:02 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: lantianyu1986@gmail.com
Subject: Re: [PATCH 7/11] KVM: Remove redundant check in the
 kvm_get_dirty_log_protect()
Message-ID: <20190104212702.GD11288@linux.intel.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
 <20190104155036.GA11288@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104155036.GA11288@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_212715_284629_6B8217A3 
X-CRM114-Status: GOOD (  22.43  )
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, benh@kernel.crashing.org,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 07:50:36AM -0800, Sean Christopherson wrote:
> On Fri, Jan 04, 2019 at 04:54:01PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > 
> > The dirty bits have already been checked in the previous check of
> > "dirty_bitmap" and mask must be non-zero value at this point.
> > 
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  virt/kvm/kvm_main.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index cf7cc0554094..e75dbb15fd09 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1206,11 +1206,9 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
> >  			mask = xchg(&dirty_bitmap[i], 0);
> >  			dirty_bitmap_buffer[i] = mask;
> >  
> > -			if (mask) {
> > -				offset = i * BITS_PER_LONG;
> > -				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
> > -									offset, mask);
> > -			}
> > +			offset = i * BITS_PER_LONG;
> > +			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
> > +								offset, mask);
> 
> Hmm, the check against mask was explicitly added by commit 58d2930f4ee3
> ("KVM: Eliminate extra function calls in kvm_get_dirty_log_protect()").
> AFAIK KVM only *sets* bits in dirty_bitmap without holding slots_lock
> and/or mmu_lock, so I agree that checking mask is redundant, but it'd be
> nice to elaborate a bit more in the changelog.
> 
> At the very least this needs a Fixes tag for the aforementioned commit.

Actually, this can be a straight revert of 58d2930f4ee3.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
