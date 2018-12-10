Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D7C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8055E20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QVS9wx36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8055E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IXPSMCix54DDy2n97I/mCiJsccjyZIseqAhmmF4pyBk=; b=QVS9wx36idx7bQ
	pQUdjcafXoBYJX/EWwPm9Cvzk6OMb+qjIBADOKSqhoztl+/xl2hEnpuidCGmkNnpvPpMZwYb97F6y
	357G43xMwZsQ8fLIZSAJtLm/lv2tqVxwk1sxwnB0aUSQSvoHpSz5s6bUS23XAd3WpS65vIhGdnLd2
	Z9Vm4mVuJitW8rP9dJ4FFQNAQ4X3g8aftMEOqyrtxs/IogHdJPyYTT9ZABqX/SsF76bFgEK7keeSR
	4RvT/EfLr6FiVDqak/anFjQvrK5VwTpG15xqAJCaqgkWtnVrLuMk/oEF67H8+09ZLOP7FmrNJam2k
	Sstzud9Q+X3+ry6lwwBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOPx-0008KE-5L; Mon, 10 Dec 2018 16:28:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOG7-0007jy-08
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 834D81596;
 Mon, 10 Dec 2018 08:18:04 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 536D53F6A8;
 Mon, 10 Dec 2018 08:18:04 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 013211AE0B8F; Mon, 10 Dec 2018 16:18:26 +0000 (GMT)
Date: Mon, 10 Dec 2018 16:18:26 +0000
From: Will Deacon <will.deacon@arm.com>
To: Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Message-ID: <20181210161826.GA11135@edgewater-inn.cambridge.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-6-steve.capper@arm.com>
 <81860712-ff5f-5a51-d39e-9db9e3d31a26@arm.com>
 <20181207152529.GB2682@edgewater-inn.cambridge.arm.com>
 <be06b735-c6b4-1520-73f6-02a3a8e8af45@arm.com>
 <20181210133640.GA31425@edgewater-inn.cambridge.arm.com>
 <20181210160348.GA4564@capper-debian.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210160348.GA4564@capper-debian.cambridge.arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081815_312761_BC5EB333 
X-CRM114-Status: GOOD (  25.72  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Suzuki Poulose <Suzuki.Poulose@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "jcm@redhat.com" <jcm@redhat.com>,
 nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 04:04:02PM +0000, Steve Capper wrote:
> On Mon, Dec 10, 2018 at 01:36:40PM +0000, Will Deacon wrote:
> > On Fri, Dec 07, 2018 at 05:28:58PM +0000, Suzuki K Poulose wrote:
> > > On 07/12/2018 15:26, Will Deacon wrote:
> > > > On Fri, Dec 07, 2018 at 10:47:57AM +0000, Suzuki K Poulose wrote:
> > > > > On 12/06/2018 10:50 PM, Steve Capper wrote:
> > > > > > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > > > > > index f60081be9a1b..58fcc1edd852 100644
> > > > > > --- a/arch/arm64/kernel/head.S
> > > > > > +++ b/arch/arm64/kernel/head.S
> > > > > > @@ -707,6 +707,7 @@ secondary_startup:
> > > > > >    	/*
> > > > > >    	 * Common entry point for secondary CPUs.
> > > > > >    	 */
> > > > > > +	bl	__cpu_secondary_check52bitva
> > > > > >    	bl	__cpu_setup			// initialise processor
> > > > > >    	adrp	x1, swapper_pg_dir
> > > > > >    	bl	__enable_mmu
> > > > > > @@ -785,6 +786,31 @@ ENTRY(__enable_mmu)
> > > > > >    	ret
> > > > > >    ENDPROC(__enable_mmu)
> > > > > > +ENTRY(__cpu_secondary_check52bitva)
> > > > > > +#ifdef CONFIG_ARM64_52BIT_VA
> > > > > > +	ldr_l	x0, vabits_user
> > > > > > +	cmp	x0, #52
> > > > > > +	b.ne	2f > +
> > > > > > +	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
> > > > > > +	and	x0, x0, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> > > > > > +	cbnz	x0, 2f
> > > > > > +
> > > > > > +	adr_l	x0, va52mismatch
> > > > > > +	mov	w1, #1
> > > > > > +	strb	w1, [x0]
> > > > > > +	dmb	sy
> > > > > > +	dc	ivac, x0	// Invalidate potentially stale cache line
> > > > > 
> > > > > You may have to clear this variable before a CPU is brought up to avoid
> > > > > raising a false error message when another secondary CPU doesn't boot
> > > > > for some other reason (say granule support) after a CPU failed with lack
> > > > > of 52bitva. It is really a crazy corner case.
> > > > 
> > > > Can't we just follow the example set by the EL2 setup in the way that is
> > > > uses __boot_cpu_mode? In that case, we only need one variable and you can
> > > > detect a problem by comparing the two halves.
> > > 
> > > The only difference here is, the support is bolted at boot CPU time and hence
> > > we need to verify each and every CPU, unlike the __boot_cpu_mode where we
> > > check for mismatch after the SMP CPUs are brought up. If we decide to make
> > > the choice later, something like that could work. The only caveat is the 52bit
> > > kernel VA will have to do something like the above.
> > 
> > So looking at this a bit more, I think we're better off repurposing the
> > upper bits of the early boot status word to contain a reason code, rather
> > than introducing new variables for every possible mismatch.
> > 
> > Does the untested diff below look remotely sane to you?
> > 
> > Will
> > 
> 
> Thanks Will,
> This looks good to me, I will test now and fold this into a patch.

Cheers, Steve. Testing would be handy, but don't worry about respinning the
patches as I'm already on top of this and hope to push this out later today.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
