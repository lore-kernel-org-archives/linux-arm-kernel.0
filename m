From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 11 Nov 2013 15:57:02 +0100
Subject: SPARSE_IRQ on Kirkwood
In-Reply-To: <5280ED8B.5060206@keymile.com>
References: <51E6F9E3.9030302@keymile.com>
	<5280ED8B.5060206@keymile.com>
Message-ID: <20131111155702.24e020c5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerlando Falauto,

On Mon, 11 Nov 2013 15:45:31 +0100, Gerlando Falauto wrote:

> On 07/17/2013 10:09 PM, Gerlando Falauto wrote:
> > Hi everyone,
> >
> > newbie's question: are sparse IRQs [going to be] supported on Kirkwood?
> > I thought irq domains were pretty much the same thing...
> > So if I understand correctly, without sparse IRQs I still have to
> > increase NR_IRQS within arch/arm/mach-kirkwood/include/mach/irqs.h in
> > order to support additional PICs.

I believe all the Kirkwood boards that have been converted to the
Device Tree now use a driver in drivers/irqchip/ for IRQ handling, and
therefore use all the modern irqdomain stuff.

I do have a bunch of other patches to convert more Kirkwood boards to
DT (needs more work), and once that's done, we can throw away the
legacy IRQ handling for Kirkwood.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
