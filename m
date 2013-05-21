From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 21 May 2013 12:09:47 -0400 (EDT)
Subject: [PATCH v4 21/32] arm64: KVM: Build system integration
In-Reply-To: <20130521154227.GM27002@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-22-git-send-email-marc.zyngier@arm.com>
 <20130521154227.GM27002@arm.com>
Message-ID: <850310439.5245685.1369152587054.JavaMail.root@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----- Messaggio originale -----
> Da: "Catalin Marinas" <catalin.marinas@arm.com>
> A: "Marc Zyngier" <Marc.Zyngier@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org, kvmarm at lists.cs.columbia.edu, kvm at vger.kernel.org, "Will Deacon"
> <Will.Deacon@arm.com>, pbonzini at redhat.com, gleb at redhat.com, "Christopher Covington" <cov@codeaurora.org>
> Inviato: Marted?, 21 maggio 2013 17:42:27
> Oggetto: Re: [PATCH v4 21/32] arm64: KVM: Build system integration
> 
> On Tue, May 14, 2013 at 03:13:49PM +0100, Marc Zyngier wrote:
> > --- /dev/null
> > +++ b/arch/arm64/kvm/Kconfig
> ...
> > +config KVM_ARM_VGIC
> > +        bool
> > +	depends on KVM_ARM_HOST && OF
> > +	select HAVE_KVM_IRQCHIP
> > +	---help---
> > +	  Adds support for a hardware assisted, in-kernel GIC emulation.
> > +
> > +config KVM_ARM_TIMER
> > +        bool
> > +	depends on KVM_ARM_VGIC
> > +	select HAVE_KVM_IRQCHIP
> > +	---help---
> > +	  Adds support for the Architected Timers in virtual machines
> > +
> > +source drivers/virtio/Kconfig
> 
> Shouldn't the above configs go to drivers/virtio/Kconfig as well (or
> drivers/virtio/arm/Kconfig)?

virtio doesn't mean "virtual versions of devices that also exist in
hardware"; those are indeed in arch/ARCH/kvm.  virtio is a specific bus
for paravirtualized devices.  It is not KVM-specific and the code runs
in the guest (whereas arch/arm64/kvm/Kconfig is host code).

That said, drivers/virtio/Kconfig is already sourced by drivers/Kconfig.
Why do you need to source it again here?

Paolo
