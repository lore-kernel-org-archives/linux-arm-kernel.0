From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 1 Jul 2015 10:57:03 +0200
Subject: [PATCH 10/10] KVM: arm/arm64: vgic: Allow non-shared device HW
 interrupts
In-Reply-To: <5593A453.4090903@arm.com>
References: <1433783045-8002-1-git-send-email-marc.zyngier@arm.com>
 <1433783045-8002-11-git-send-email-marc.zyngier@arm.com>
 <20150630201903.GX11332@cbox> <5593A453.4090903@arm.com>
Message-ID: <20150701085703.GC11332@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 09:26:59AM +0100, Marc Zyngier wrote:
> On 30/06/15 21:19, Christoffer Dall wrote:
> > On Mon, Jun 08, 2015 at 06:04:05PM +0100, Marc Zyngier wrote:
> >> So far, the only use of the HW interrupt facility is the timer,
> >> implying that the active state is context-switched for each vcpu,
> >> as the device is is shared across all vcpus.
> >>
> >> This does not work for a device that has been assigned to a VM,
> >> as the guest is entierely in control of that device (the HW is
> >> not shared). In that case, it makes sense to bypass the whole
> >> active state switchint, and only track the deactivation of the
> >> interrupt.
> >>
> > The discinction here between shared and non-shared feels a bit arbitrary
> > (it may not be, but just feel that way) and I can't easily convince
> > myself that this is the logical/correct/all-encompassing word to
> > describe the nature of the two devices.
> 
> Does the idea of global vs private resource feel more correct?
> 
I think shared covers that equally well.  This feels like one of those
things that just doesn't make intuitive sense on its own but when you
think about the cases we are familiar with, then it fits for now.  So
what you have here is probably as good as it gets and hopefully it does
cover all the cases we care about, i.e. shared and non-shared :)

-Christoffer
