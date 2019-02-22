Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E97C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:39:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784B620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lm47eKi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784B620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rm8175zvkOSP8MdaovtF6IxO7bGSHh1ZEnsavbU0dPk=; b=Lm47eKi4+ORK09
	jP0r9pnuAMwMUJJOkWEahds20Jdrip2P7A/mFeTX7rOGe81mzDuJXALCd1YGdFUzROCPaQkhqK1MH
	H+j3BQ3cgmXcgfPFKVgq2LftVSC1Tmn+IHu+sOVIvyj8G06lV9Y/AAYvD0Hz6feBJ12qyUWNAbuwe
	vxa24BOQtzRK4AbZMnBIUBgSkY3CLGEX6YVn18kuygUvGRVL5aPpfuTlZRIx3gHF6y1wMyp/VPHzd
	TUqmHcOmTFTxR8gs7lJlbP6Y5x5n9g/0yh/x6qLGiY87kx+Hg61Njrw1+6lE7aL+uptUlPbwXMfZK
	JOZLQNTdlEgFCYAJzBzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7It-0001n0-UG; Fri, 22 Feb 2019 09:39:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7Ir-0001mC-0Y
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:39:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90A0080D;
 Fri, 22 Feb 2019 01:39:31 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B2C53F703;
 Fri, 22 Feb 2019 01:39:28 -0800 (PST)
Date: Fri, 22 Feb 2019 09:39:23 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Message-ID: <20190222093923.09e36583@why.wild-wind.fr.eu.org>
In-Reply-To: <20190222085439.GA845@leoy-ThinkPad-X240s>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-3-leo.yan@linaro.org>
 <20190222083756.359523ca@why.wild-wind.fr.eu.org>
 <20190222085439.GA845@leoy-ThinkPad-X240s>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_013933_066040_CC13DEB5 
X-CRM114-Status: GOOD (  26.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 Jun Yao <yaojun8558363@gmail.com>, James Morse <james.morse@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 16:54:39 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> Hi Marc,
> 
> On Fri, Feb 22, 2019 at 08:37:56AM +0000, Marc Zyngier wrote:
> > On Fri, 22 Feb 2019 16:23:24 +0800
> > Leo Yan <leo.yan@linaro.org> wrote:
> >   
> > > The function kvm_vgic_inject_irq() is not only used by PPIs but also can
> > > be used to inject interrupt for SPIs; this patch improves comment for
> > > argument @cpuid to reflect support SPIs as well.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  virt/kvm/arm/vgic/vgic.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > > index 7cfdfbc910e0..79fe64c15051 100644
> > > --- a/virt/kvm/arm/vgic/vgic.c
> > > +++ b/virt/kvm/arm/vgic/vgic.c
> > > @@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
> > >  /**
> > >   * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
> > >   * @kvm:     The VM structure pointer
> > > - * @cpuid:   The CPU for PPIs
> > > + * @cpuid:   The CPU for PPIs and SPIs
> > >   * @intid:   The INTID to inject a new state to.
> > >   * @level:   Edge-triggered:  true:  to trigger the interrupt
> > >   *			      false: to ignore the call  
> > 
> > What does the CPU mean for SPIs? By definition, the routing of an SPI
> > is defined by the distributor configuration.  
> 
> In the code, KVM injects PPIs by specifying CPU id, so that every PPI
> is bound to specific target CPU.  But for SPIs, it always pass '0' for
> cpuid, from my understanding this means VM will set interrupt affinity
> to VCPU0 by default; in theory we also can set different cpuid for
> SPIs so that the SPIs also can be handled by other secondary VCPUs;
> this is why I think @cpuid also can be used by SPIs.

SPIs are not hardcoded to vcpu0. This would be a gross violation of the
architecture. To convince yourself of this, just run a guest:

root@unassigned-hostname:~# cat /proc/interrupts 
           CPU0       CPU1       
  2:       7315       7353     GIC-0  27 Level     arch_timer
  4:        158          0     GIC-0  33 Level     uart-pl011
 42:          0          0     GIC-0  23 Level     arm-pmu
 43:          0          0     pl061   3 Edge      ACPI:Event
 44:          0          0       MSI 32768 Edge      virtio1-config
 45:      10476          0       MSI 32769 Edge      virtio1-req.0
 46:          0          0       MSI 16384 Edge      virtio0-config
 47:          3         10       MSI 16385 Edge      virtio0-input.0
[...]

On this last line, you can see an SPI being routed to both of these
vcpus.

I urge you to read the code further, and understand that for any other
interrupt class, the cpuid parameter is *ignored*. Yes, we pass zero in
that case. We could also pass an approximation of PI with the same
effect. The interrupt affinity is either defined by the distributor
configuration (SPIs) or the ITS configuration (LPIs).

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
