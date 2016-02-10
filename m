From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Feb 2016 18:13:26 +0000
Subject: [PATCH v2 0/6] irqchip: irq-armada-370-xp: generic MSI
 infrastructure and assorted fixes
In-Reply-To: <87mvr8xwrz.fsf@free-electrons.com>
References: <1453899395-3532-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160210150046.118fc991@free-electrons.com>
 <56BB4451.3070707@arm.com>
 <20160210153829.GA5183@io.lakedaemon.net>
 <87mvr8xwrz.fsf@free-electrons.com>
Message-ID: <20160210181325.GB5183@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 07:09:20PM +0100, Gregory CLEMENT wrote:
> Hi Jason,
>  
>  On mer., f?vr. 10 2016, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > On Wed, Feb 10, 2016 at 02:08:17PM +0000, Marc Zyngier wrote:
> >> On 10/02/16 14:00, Thomas Petazzoni wrote:
> >> > Hello,
> >> > 
> >> > On Wed, 27 Jan 2016 13:56:29 +0100, Thomas Petazzoni wrote:
> >> > 
> >> >> Thomas Petazzoni (6):
> >> >>   irqchip: irq-armada-370-xp: add Kconfig option for the driver
> >> >>   irqchip: irq-armada-370-xp: use the generic MSI infrastructure
> >> >>   irqchip: irq-armada-370-xp: use PCI_MSI_DOORBELL_START where
> >> >>     appropriate
> >> >>   irqchip: irq-armada-370-xp: use shorter names for irq_chip
> >> >>   irqchip: irq-armada-370-xp: allow allocation of multiple MSIs
> >> >>   ARM: mvebu: use the ARMADA_370_XP_IRQ option
> >> > 
> >> > Jason, Thomas, any chance to get this applied soonish?
> >> > 
> >> > The core patch of the series, which migrates the irq-armada-370-xp
> >> > driver to use the generic MSI infrastructure has been Reviewed-by: Marc
> >> > Zyngier, and the other patches in the series have Acked-by/Reviewed-by
> >> > from Gregory Clement.
> >> > 
> >> > Of course, if there's anything left to be changed, I'd be happy to
> >> > respin a new version of this series.
> >> > 
> >> 
> >> Noticing the distribution list, it would be good to repost these patches
> >> with acks and co to LKML...
> >
> > agreed, and I'll pick it up within the next day or so.  Still getting my
> > home network setup... too much wifi. :(
> 
> I proposed that you take the 6th patch to ensure that this driver will
> always be selected for the mvebu platform which need it. It is still OK
> but, since this offer, I sent a series which depend of the 1st patch:
> http://thread.gmane.org/gmane.linux.ide/61178

I saw that. ;-)

> Would you agree to provide an immutable tag containing the first patch?
> Thanks to this I will be able to provide it to the arm-soc maintainer
> for my pull request.

Sure, that's my default MO since most of the time, people only touch
irqchip drivers when they are changing something else.  Thus, there's
usually a dependency on the irqchip changes.

thx,

Jason.
