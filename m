From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 19 Aug 2014 12:04:58 +0200
Subject: [RFC PATCH] ARM: KVM: add irqfd support
In-Reply-To: <53F3107C.6060404@linaro.org>
References: <1407154102-26459-1-git-send-email-eric.auger@linaro.org>
 <20140813145523.GR10550@cbox> <53F3107C.6060404@linaro.org>
Message-ID: <20140819100458.GA31086@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 10:53:16AM +0200, Eric Auger wrote:
> On 08/13/2014 04:55 PM, Christoffer Dall wrote:
> > On Mon, Aug 04, 2014 at 02:08:22PM +0200, Eric Auger wrote:
> >> This patch enables irqfd on ARM.
> >>
> >> irqfd framework enables to inject a virtual IRQ into a guest upon an
> >> eventfd trigger. User-side uses KVM_IRQFD VM ioctl to provide KVM with
> >> a kvm_irqfd struct that associates a VM, an eventfd, an IRQ number
> >> (aka. the gsi). When an actor signals the eventfd (typically a VFIO
> >> platform driver), the kvm irqfd subsystem injects the provided virtual
> >> IRQ into the guest.
> >>
> >> The gsi must correspond to a shared peripheral interrupt (SPI), ie the
> >> GIC interrupt ID is gsi+32.
> > 
> > Why can't we support PPIs?
> Hi Christoffer,
> 
> Well, in case we want to support PPI at irqfd level, we would need to
> change the semantic of the GSI value and use the same as KVM_IRQ_LINE,
> to specify the target vcpu. This is obviously feasible but this also
> induces changes in currently generic user parts, vfio, vhost. is PPI
> injection though irqfd a valid use case?

I don't see why you wouldn't want to be able to support PPIs as
passthrough interrupts to a guest?

[...]

> >> +
> >> +/* MSI not implemented yet */
> > 
> > yet?  What is an MSI on ARM?
> Well some MSI support comes with GICv2m and GICv3. My current
> understanding is it makes sense to inject an MSI from an irqfd trigger.
> Don't you share this understanding?
> 
Doh, I read GSI and wrote MSI, of course, complete brain meltdown on my
side.

-Christoffer
