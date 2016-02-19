From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 19 Feb 2016 17:18:46 +0000
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <20160219164344.GY19428@n2100.arm.linux.org.uk>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <3974581.yknKb3tq7o@wuerfel>
 <HK2PR06MB056137892B6F968A8A1008C58AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <14272873.q312Ii8Axy@wuerfel> <20160219164344.GY19428@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB0561C34E8FE1480224C2C6778AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 Feb 2016, Russell King wrote:

> Using the DTB location on XIP platforms is a no-goer - the flattened
> DTB information can be fixed, so on an XIP platform it makes sense
> for this to also be in flash, not in RAM (the whole point of XIP is
> to remove constant data from RAM after all, so why would you want to
> copy the FDT to RAM?)

I was under the impression that the DTB had a limited life span, and once booted, it could be clobbered. Hence, RAM would not really be wasted (post boot that is).

For an XIP system (with MMU), if you have your DTB in ROM someplace, you run the risk of getting it cut off after the MMU setup is done because it would fall someplace after the _exiprom marker.


> Passing it in a register to the kernel image is also not possible:
> we've been out of spare registers for some time now for passing
> additional information into the kernel.  It wouldn't be a problem
> had folk not had this "eww, I don't like ATAGs, lets get rid of them
> and use DT instead" attitude: had we kept ATAGs, then we'd have an
> in-memory format to pass this kind of information to the kernel.
> That would solve soo many problems today it's untrue: stuff like
> where a debugging UART is located and the type of it...

Too bad we just couldn't have added an ATAG to point to a DTB. Sigh.


Chris
