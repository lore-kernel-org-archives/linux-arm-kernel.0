From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 2 Nov 2012 16:50:40 +0400
Subject: [PATCH 01/15] ARM: clps711x: Load serial driver from boards
In-Reply-To: <20121101122731.GS21164@n2100.arm.linux.org.uk>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
 <20121101122731.GS21164@n2100.arm.linux.org.uk>
Message-ID: <20121102165040.09be40cce1feb5845d7e51b5@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Nov 2012 12:27:31 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> BOn Thu, Nov 01, 2012 at 01:26:31PM +0400, Alexander Shiyan wrote:
> >  MACHINE_START(AUTCPU12, "autronix autcpu12")
> >  	/* Maintainer: Thomas Gleixner */
> >  	.atag_offset	= 0x20000,
> > -	.init_machine	= autcpu12_init,
> >  	.map_io		= autcpu12_map_io,
> > +	.init_machine	= autcpu12_init,
> >  	.init_irq	= clps711x_init_irq,
> > -	.timer		= &clps711x_timer,
> >  	.restart	= clps711x_restart,
> > +	.timer		= &clps711x_timer,
> >  MACHINE_END
> 
> NAK.  If you're going to sort them, arrange them in the same order as
> in the structure declaration in mach/arch.h.  That's the order in which
> the functions will be called.
> 
> IOW, changing the order of .timer to be after .restart is wrong, .restart
> should be the last.  .timer should be immediately before .init_machine.
> .init_irq should be immediately before .timer.

It's just sort by functionality and does not affect on operation.
Original sort I will return in the next patch after applying it.
Please comment on the rest of the patches in this series.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
