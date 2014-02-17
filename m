From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 17 Feb 2014 17:40:17 -0300
Subject: [PATCH 0/2] irqchip: Armada 370/XP MPIC as a slave controller
In-Reply-To: <20140217202709.GA7862@titan.lakedaemon.net>
References: <1392062402-27357-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140217202709.GA7862@titan.lakedaemon.net>
Message-ID: <20140217204016.GA23303@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 03:27:09PM -0500, Jason Cooper wrote:
> On Mon, Feb 10, 2014 at 05:00:00PM -0300, Ezequiel Garcia wrote:
> > The newly introduced Armada 375 and Armada 38x Marvell SoCs are based on
> > Cortex-A9 CPU cores and use the ARM GIC as their main interrupt controller.
> > 
> > However, for various purposes (wake-up from suspend, MSI interrupts),
> > the SoCs have a separate MPIC interrupt controller, acting as a slave
> > to the GIC. This MPIC was already used as the primary controller on
> > previous Marvell SoCs, so this commit extends the existing driver to
> > allow the MPIC to be used as a GIC slave.
> > 
> > This series consists in two patches: the first one adds a helper function
> > to handle MSI interrupts. The second patch implements a chained handler, which
> > uses the previously introduced helper.
> > 
> > These patches apply cleanly on v3.14-rc1 plus:
> > 
> >   36802fd irqchip: armada-370-xp: fix MSI race condition
> >   e1603bb irqchip: armada-370-xp: fix IPI race condition
> > 
> > Or simply on v3.14-rc2.
> > 
> > Ezequiel Garcia (2):
> >   irqchip: armada-370-xp: Add helper for the MSI IRQ handling
> >   irqchip: armada-370-xp: Setup a chained handler for the MPIC
> > 
> >  .../devicetree/bindings/arm/armada-370-xp-mpic.txt |  8 +-
> >  drivers/irqchip/irq-armada-370-xp.c                | 96 ++++++++++++++++------
> >  2 files changed, 76 insertions(+), 28 deletions(-)
> 
> I've tentatively applied these to mvebu/irqchip with the dependencies on
> v3.14-rc1 + tags/mvebu-irqchip-fixes-3.13 to get them some coverage in
> -next.
> 

Thanks Jason. You rock.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
