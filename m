From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jul 2010 21:05:53 +0100
Subject: [PATCH] RFC: U300 clock updates to match PrimeCell clocking
In-Reply-To: <20100714190311.GA18649@debian>
References: <1279065807-22238-1-git-send-email-linus.walleij@stericsson.com>
	<20100714190311.GA18649@debian>
Message-ID: <20100714200553.GC18138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 12:33:11AM +0530, Rabin Vincent wrote:
> (corrected lakml address)
> 
> On Wed, Jul 14, 2010 at 02:03:27AM +0200, Linus Walleij wrote:
> > This makes the U300 architecture use the PrimeCell (AMBA) bus
> > clocking method suggested by Russell King. Since the bus will
> > now clock itself, we can remove the special PrimeCell clocking
> > hooks in the clock file.
> 
> In order to be able to remove your clock enabling around the
> amba_device_register() calls, the busclk get/enabling would need to be
> also added around the peripheral ID read in amba_device_register(), not
> just before the probe call, where Russell's patch added it.

Ok, let's do that too.
