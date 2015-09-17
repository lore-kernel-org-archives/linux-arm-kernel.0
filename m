From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 17 Sep 2015 17:31:02 +0200
Subject: [PATCH 5/8] arm64: KVM: Disable virtual timer even if the guest
 is not using it
In-Reply-To: <55FADC1E.50909@arm.com>
References: <1442501171-24484-1-git-send-email-marc.zyngier@arm.com>
 <1442501171-24484-6-git-send-email-marc.zyngier@arm.com>
 <55FAD607.9040305@redhat.com> <55FADC1E.50909@arm.com>
Message-ID: <55FADCB6.8010100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/09/2015 17:28, Marc Zyngier wrote:
> > diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> > index 702740d37465..93e322b4d242 100644
> > --- a/arch/arm/kvm/interrupts_head.S
> > +++ b/arch/arm/kvm/interrupts_head.S
> > @@ -514,6 +514,7 @@ ARM_BE8(rev	r6, r6  )
> >  	beq	1f
> >  
> >  	mrc	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
> > +	and	r2, r2, #3
> 
> I don't think we need this. Exposing the ISTATUS bit to the kernel (or
> even userspace) is not really a problem (that's actually an interesting
> piece of information), and restoring it is not possible since it is
> read-only.
> 
> We should drop the equivalent 'and' from the arm64 version.

Ok.  I'll resend the thing as a proper patch.

Paolo
