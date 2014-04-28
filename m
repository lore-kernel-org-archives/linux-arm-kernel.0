From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 28 Apr 2014 20:32:55 +0200 (CEST)
Subject: [PATCH] arm: edma: Fix xbar mapping
In-Reply-To: <534BED36.2060907@ti.com>
References: <alpine.DEB.2.02.1404132123100.22697@ionos.tec.linutronix.de>
 <534BED36.2060907@ti.com>
Message-ID: <alpine.DEB.2.02.1404282032150.6261@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Apr 2014, Sekhar Nori wrote:
> > Fix the issues by:
> > 
> > - annotating the device tree entry with "/bits/ 16" as documented in
> >   the of_property_read_u16_array kernel doc
> > 
> > - make the size of the xbar register mapping correct
> > 
> > - invalidating the end of the array and not the start
> > 
> > This convoluted mess wants to be completely rewritten as there is no
> > point to keep the xbar_chan array memory and the iomapping of the xbar
> > regs around forever. Marking the xbar mapped channels as used should
> > be done right there.
> > 
> > But that's a different issue and this patch is small enough to make it
> > work and allows a simple backport for stable.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> This time, I tested this patch and FWIW you can add:
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Can someone pick this up please?
