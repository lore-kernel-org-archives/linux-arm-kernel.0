Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744D7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:49:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C242218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uUQFcg53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C242218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6UsBlDgf186qSD2biuIbPhcr88Akvdmlft1Du2GeyHs=; b=uUQFcg53KhQAM+
	Glyt6kj2YmTukexs/67eJ9iVApRjLiTQ1fOuk96/Vv1iMilRphjTNt0IS6TgXz0BQLqjzu3J6ScxE
	N/OSwiAx54d8YHjDjdnYIltAH/YYK6YKU6FFqdYt6cVNN9Kbkos0kfJvezilQHefDSZE862gl5icF
	ZUCMjSRmg+yTcdTHvc0uwceH3Mehy1d5fb4dtOP+ZIlc0Wy8vB74bc9959mIZA2vWj5lIqbpZSzCc
	58uniro2T2E9rPn9mBAgPl8pzdRA/2pIQuTkjnoB5LMNXGP5kaChvEm1G+6KyPtocerYWq/3FpF0F
	fZ5hTFxqh+fhom7HYzXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomUd-0001MT-KW; Wed, 30 Jan 2019 09:49:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomUa-0001M7-27
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:49:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB8AA78;
 Wed, 30 Jan 2019 01:49:11 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03EA13F557;
 Wed, 30 Jan 2019 01:49:10 -0800 (PST)
Date: Wed, 30 Jan 2019 10:49:09 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 3/5] KVM: arm/arm64: Require VCPU threads to turn them
 self off
Message-ID: <20190130094909.GF13482@e113682-lin.lund.arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-4-christoffer.dall@arm.com>
 <20190129161644.v4ncrcgvukkd7d5w@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129161644.v4ncrcgvukkd7d5w@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_014912_113806_BAAC544D 
X-CRM114-Status: GOOD (  24.25  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 05:16:44PM +0100, Andrew Jones wrote:
> 
> Summary edit
> 
> > KVM: arm/arm64: Require VCPU threads to turn them self off
> 
> themselves
> 
> On Fri, Jan 25, 2019 at 10:46:54AM +0100, Christoffer Dall wrote:
> > To avoid a race between turning VCPUs off and turning them on, make sure
> > that only the VCPU threat itself turns off the VCPU.  When other threads
> > want to turn of a VCPU, they now do this via a request.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/include/asm/kvm_host.h   |  2 ++
> >  arch/arm64/include/asm/kvm_host.h |  2 ++
> >  virt/kvm/arm/arm.c                |  8 ++++++--
> >  virt/kvm/arm/psci.c               | 11 ++---------
> >  4 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> > index 50e89869178a..b1cfae222441 100644
> > --- a/arch/arm/include/asm/kvm_host.h
> > +++ b/arch/arm/include/asm/kvm_host.h
> > @@ -49,6 +49,8 @@
> >  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> >  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> >  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> > +#define KVM_REQ_VCPU_OFF \
> > +	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> >  
> >  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
> >  
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index da3fc7324d68..d43b13421987 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -49,6 +49,8 @@
> >  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> >  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
> >  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
> > +#define KVM_REQ_VCPU_OFF \
> > +	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> >  
> >  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
> >  
> > diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> > index 9c486fad3f9f..785076176814 100644
> > --- a/virt/kvm/arm/arm.c
> > +++ b/virt/kvm/arm/arm.c
> > @@ -404,8 +404,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> >  
> >  static void vcpu_power_off(struct kvm_vcpu *vcpu)
> >  {
> > -	vcpu->arch.power_off = true;
> > -	kvm_make_request(KVM_REQ_SLEEP, vcpu);
> > +	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
> >  	kvm_vcpu_kick(vcpu);
> >  }
> 
> I think we should leave this function alone. Otherwise if userspace sets
> the MP state to STOPPED and then queries the state before the vcpu
> has a chance to manage its vcpu requests, the state will still indicate
> RUNNBLE. The same goes for a query right after doing a vcpu init.
> 

We can't leave this alone, because that could lead to userspace racing
with two PSCI_VCPU_ON requests which could then both enter the critical
section gated only by the cmpxchg in kvm_psci_vcpu_on.

But we could do something like this (completely untested):


diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 1e3195155860..538b5eb9d920 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -404,6 +404,17 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 static void vcpu_power_off(struct kvm_vcpu *vcpu)
 {
+	enum vcpu_power_state old_power_state;
+
+	/*
+	 * Set power_state directly to reflect the power state back to user
+	 * space even when the VCPU thread has not had a chance to run, but
+	 * only if this doesn't accidentally allow interleaved PSCI_VCPU_ON
+	 * requests.
+	 */
+	old_power_state = cmpxchg(&vcpu->arch.power_state,
+				  KVM_ARM_VCPU_ON,
+				  KVM_ARM_VCPU_OFF);
 	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
 	kvm_vcpu_kick(vcpu);
 }


> >  
> > @@ -646,6 +645,11 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
> >  		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
> >  			vcpu_req_sleep(vcpu);
> >  
> > +		if (kvm_check_request(KVM_REQ_VCPU_OFF, vcpu)) {
> > +			vcpu->arch.power_off = true;
> > +			vcpu_req_sleep(vcpu);
> > +		}
> > +
> >  		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
> >  			kvm_reset_vcpu(vcpu);
> >  
> > diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> > index b9cff1d4b06d..20255319e193 100644
> > --- a/virt/kvm/arm/psci.c
> > +++ b/virt/kvm/arm/psci.c
> > @@ -97,9 +97,7 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
> >  
> >  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
> >  {
> > -	vcpu->arch.power_off = true;
> > -	kvm_make_request(KVM_REQ_SLEEP, vcpu);
> > -	kvm_vcpu_kick(vcpu);
> > +	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
> >  }
> 
> This was currently fine since it implements CPU_OFF which only applies to
> the calling vcpu, but there's also no reason not to change it to be
> consistent with the below change
> 

Same problem as above, we don't want two VCPUs to be messing with a
target VCPU state at the same time.


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
