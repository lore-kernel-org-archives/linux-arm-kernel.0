From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 6 Dec 2012 16:49:17 -0700
Subject: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
 spi-orion
In-Reply-To: <20121206232305.719E23E0B24@localhost>
References: <20121121192335.GA14868@obsidianresearch.com>
 <20121206142521.4185A3E0948@localhost>
 <20121206172504.GB9676@obsidianresearch.com>
 <20121206232305.719E23E0B24@localhost>
Message-ID: <20121206234917.GF25069@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 06, 2012 at 11:23:05PM +0000, Grant Likely wrote:

> > This will likely switch all current users from using 'whatever the
> > firmware left behind' to 'whatever the kernel default is' - which will
> > surely break something here and there??
> 
> Hmmm. Hard to say. Just the fact that existing users are depending on
> little more than dumb luck that firmware touched the SPI is worrysome.

It isn't entirely dumb luck, all the DT files I looked at were using
SPI to connect to FLASH, so the boot firmware will have to set the SPI
bus properly since it is executing out of the SPI boot flash.

At the very least, if it breaks it will be of the very obvious 'boot
from flash is completely broken' sort.

> For platform_data configuration, you might want to enable it with a
> flag. Whatever you decide send me a fixup patch against linux-next.

Okay, I think instead of the #ifdef a test for 'dev->ofdev == NULL'
would do the trick for now, then at least people can test the DT vs
the platform boot.

I am hoping to have time to revise patches on Friday, I will see.

Jason: Do you have any of these possibly affected boards with a SPI
flash to test linux-next? dove, dreamplug, ts219 and lsxl

Thanks,
Jason
