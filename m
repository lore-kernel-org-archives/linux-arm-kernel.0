From: martin@sperl.org (Martin Sperl)
Date: Mon, 29 Feb 2016 11:09:03 +0100
Subject: [PATCH 0/4] bcm2835 SDHOST controller
In-Reply-To: <1456527942-3045-1-git-send-email-eric@anholt.net>
References: <1456527942-3045-1-git-send-email-eric@anholt.net>
Message-ID: <8DAA6B46-4AF3-4DB2-AFAF-E9749FA178E8@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 27.02.2016, at 00:05, Eric Anholt <eric@anholt.net> wrote:
> 
> Here's a series to enable the SDHOST controller.  It gives us better
> performance than our old sdhci-bcm2835.c.  The downstream Raspberry Pi
> kernel appears to be using this controller by default at this point.
> 
> I've tried to do some testing on it (mounting filesystem,
> reading/writing files, speed tests), but I'm not sure what a good
> testing regimen for storage drivers would be.
> 
> Eric Anholt (4):
>  dt-bindings: Add binding for brcm,bcm2835-sdhost.
>  mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
>  ARM: bcm2835: Include SDHOST in the device tree.
>  ARM: bcm2835: Enable SDHOST by default.

This patchset misses defconfig changes to enable
the new sdhost driver.

So we end up with a default kernel
without the sdhost driver compiled in
but with sdhost enabled in the default device-tree (patch4)
resulting in a system that does not boot.

Thanks,
	Martin
