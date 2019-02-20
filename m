Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:13:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28BF20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KpFftHIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28BF20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RNbkaR+KUPI4mXrEvMFKWBJjUjG15X0ssJvqsTgbraA=; b=KpFftHIJ2IUExY
	TdTd/u1E+dCHvWhG7i+IdnXGw3eKVkFoTB+Hh1JOZYUW3GHdNmc1MJQ0ZnGthCINH/AxFw6v1mdwW
	rr0qV1kFumnJzLnligMHd9eWCZUfJeyBpDNYnUBV1SF95Rz/ZRYBnD7q+eRPlWv8sdanvK9tUTm3S
	rJoWgZTa7IzQTx95b44MD9G66YW1edTo+OtPrQ73m4x0phpi0EcThfzeXViVH7VinchfU+EfSFJG6
	mzN4wXAX1CvGrkxPjUdqp7BgJNXuqpJCH7Ys/X/R7Vfk4oxB5AVNRn8f2CJFy0nAb1g5qqdsleqtL
	eFRV5LZ9h0o//QGhXoQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwScx-0007cx-UE; Wed, 20 Feb 2019 14:13:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwScu-0007cN-SF
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:13:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87DDEBD;
 Wed, 20 Feb 2019 06:13:30 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBA643F690;
 Wed, 20 Feb 2019 06:13:29 -0800 (PST)
Date: Wed, 20 Feb 2019 14:13:27 +0000
From: Will Deacon <will.deacon@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/2] arm64: virt: Relax GIC version check
Message-ID: <20190220141327.GC7523@fuggles.cambridge.arm.com>
References: <1550662986-40987-1-git-send-email-vladimir.murzin@arm.com>
 <20190220134616.7a8da0f5@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220134616.7a8da0f5@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_061332_919840_A1884E98 
X-CRM114-Status: GOOD (  20.12  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 01:46:16PM +0000, Marc Zyngier wrote:
> + Will, Catalin
> 
> On Wed, 20 Feb 2019 11:43:05 +0000
> Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> 
> > Updates to the GIC architecture allow ID_AA64PFR0_EL1.GIC to have
> > values other than 0 or 1. At the moment, Linux is quite strict in the
> > way it handles this field at early boot stage (cpufeature is fine) and
> > will refuse to use the system register CPU interface if it doesn't
> > find the value 1.
> > 
> > To help backports (even though the code was correct at the time of writing)
> > Fixes: 021f653791ad17e03f98aaa7fb933816ae16f161 ("irqchip: gic-v3: Initial support for GICv3")
> > 
> > Reported-by: Chase Conklin <Chase.Conklin@arm.com>
> > Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > ---
> >  arch/arm64/kernel/head.S | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 15d79a8..eecf792 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -539,8 +539,7 @@ set_hcr:
> >  	/* GICv3 system register access */
> >  	mrs	x0, id_aa64pfr0_el1
> >  	ubfx	x0, x0, #24, #4
> > -	cmp	x0, #1
> > -	b.ne	3f
> > +	cbz	x0, 3f
> >  
> >  	mrs_s	x0, SYS_ICC_SRE_EL2
> >  	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Will, Catalin: It is probably too late for the merge window, but on the
> odd chance you could queue it as a fix... Otherwise, this will be a 5.2
> candidate.

Sure, I'll grab it.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
