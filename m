From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 10:11:24 +0100
Subject: [PATCH v2 0/8] ARM: at91: Remove mach/ includes from the reset
 driver
In-Reply-To: <20141028090454.GD722@piout.net>
References: <1414451377-11053-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20141028085053.41c6ce46@bbrezillon>
 <20141028085202.GC722@piout.net> <20141028085908.GB31979@lukather>
 <20141028090454.GD722@piout.net>
Message-ID: <20141028091124.GC31979@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 10:04:55AM +0100, Alexandre Belloni wrote:
> > > > I'd rather keep the reset driver as is and move SDRAM related macros
> > > > into a specific header (include/linux/memory/atmel-sdram.h or
> > > > include/soc/atmel/memory.h as you proposed) so that the reset driver
> > > > can reference them without including mach headers.
> > > > 
> > > 
> > > My personal opinion is that it is better to hide the registers/bits from
> > > the reset driver right now as we have two different IPs and the sdram
> > > driver already knows how to make the difference between them.
> > 
> > The reset driver doesn't do anything anymore with these patches. Why
> > not just remove it altogether?
> > 
> 
> It does, the reset driver knows about the reset registers.

So the only thing it does it to define a few register and that's it?
It looks like it's a case for a header, not a driver.

> The plan is to move the actual reset back to that driver when the
> kernel will be able to easily execute code from sram.

Why not go directly for the plan then?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/7158c471/attachment.sig>
