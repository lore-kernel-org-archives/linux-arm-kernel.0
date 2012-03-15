From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 20:41:53 +0000
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <20120315195753.GA2842@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com> <4F621939.9040906@ti.com>
 <20120315195753.GA2842@n2100.arm.linux.org.uk>
Message-ID: <201203152041.53754.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 15, 2012 at 05:30:49PM +0100, Cousson, Benoit wrote:
> > This was done like IRQ on purpose, because an Interrupt ReQuest line and  
> > a DMA Request line are really similar for the HW point of view at IP 
> > level.
> 
> I'm not sure about that at all levels.  Sure, at hardware level they're
> the same, but I think the flat numeric namespace for IRQs has been
> proven to be a problem when there's multiple IRQ controllers in the
> system.

In the DT bindings, both IRQ and the suggested DMA are not flat number
spaces, but instead can be of arbitrarly length defined by the controller.

> As far as I'm concerned for DMA stuff, there is currently no real solution
> for a DT representation; TI have asked me to take over the conversion of
> OMAP DMA support to the DMA engine API, and I'm not yet convinced that
> the existing numbering system is the right solution - especially as
> there's several overlapping numberspaces for OMAP DMA numbers which
> are SoC specific.

The numbers definitely need to become local to each of the controllers, but
that is the case pretty much automatically using the proposed binding,
because each dma request identifier starts with the phandle of the
controller.

	Arnd
