From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Oct 2011 13:44:24 +0200
Subject: [PATCH 2/9] ARM: SPMP8000: Add machine base files
In-Reply-To: <20111016205221.GL1459@game.jcrosoft.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<201110162259.19960.arnd@arndb.de>
	<20111016205221.GL1459@game.jcrosoft.org>
Message-ID: <201110171344.24697.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 16 October 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:59 Sun 16 Oct     , Arnd Bergmann wrote:
> > On Sunday 16 October 2011, Zoltan Devai wrote:
> >> BTW, the static mappings are only needed to be able to set up the
> >> clk stuff in init_early. That in turn is only needed for the timer code to
> >> determinate its input clock.
> >> If I would hard-code the timer clock rate in its driver (the bootloader is
> >> very unlikely to change), then I could init the clk driver from
> >> machine_init and get rid of these mappings.
> >> How about that ?
> > 
> > Maybe you can just pass the clock rate in the device tree then. If the boot
> > loader changes it, it can still pass the correct rate and you don't
> > need the early mappings for functional reasons any more.
>
> please don't update the DT from the bootloader, I'll recommand you to limit
> your bootloader to just update the strict minimun (same as ATAG) and touch
> noting else

Why? Do you think it's better to hardcode it and have no way to update it?
Note that the more likely scenario even with clock rate in the device tree
would be that the value is hardcoded in the board's file and would not
be touched by the boot loader. Only if the boot loader actually changes
the physical clock rate (which Zoltan described as very unlikely), it
would also have to go the full length and update the device tree as well.

	Arnd
