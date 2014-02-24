From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 14:30:50 -0500
Subject: [PATCH v2 2/5] ARM: mvebu: Add i2c alias so setting bus number
In-Reply-To: <20140224191108.GA29288@lunn.ch>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
 <1393264898-28939-3-git-send-email-andrew@lunn.ch>
 <20140224190509.GD1010@titan.lakedaemon.net>
 <20140224191108.GA29288@lunn.ch>
Message-ID: <20140224193050.GG1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

+ arm-soc maintainers

On Mon, Feb 24, 2014 at 08:11:08PM +0100, Andrew Lunn wrote:
> On Mon, Feb 24, 2014 at 02:05:09PM -0500, Jason Cooper wrote:
> > Subject should be "ARM: kirkwood: ..."
> 
> Humm, why?
> 
> linux/arch/arm/boot/dts$ git log --oneline armada-370.dtsi 

No, you're editing:

 arch/arm/boot/dts/kirkwood.dtsi | 3 ++-

> a095b1c78a35 ARM: mvebu: sort DT nodes by address
> d4fa99417a07 ARM: mvebu: link PCIe controllers to the MSI controller
> 238493e34d3f ARM: dts: mvebu: Update with the new compatible string for mv64xxx-
> 6cbe0e1feaf8 Merge tag 'dt-3.12' of git://git.infradead.org/linux-mvebu into nex
> 5d3b88307176 ARM: mvebu: Fix the Armada 370/XP timer compatible strings
> ca60985c0042 ARM: mvebu: use correct #interrupt-cells instead of #interrupts-cel
> 14fd8ed0a7fd ARM: mvebu: Relocate Armada 370/XP PCIe device tree nodes
> 0cd3754a8317 ARM: mvebu: Add BootROM to Armada 370/XP device tree
> 5e12a613ce39 ARM: mvebu: Add MBus to Armada 370/XP device tree
> 38149887ef8b ARM: mvebu: Use the preprocessor on Armada 370/XP device tree files
> 9214cbe50fe7 Merge tag 'dt-3.11-5' of git://git.infradead.org/users/jcooper/linu
> 83735101959e ARM: mvebu: Remove device tree unused properties on A370
> 489e138eec96 ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache n
> 8eed481e6fe2 arm: mvebu: fix the 'ranges' property to handle PCIe
> 
> Seems to me, now that it is part of mach-mvebu, ARM: mvebu is correct.

"ARM: kirkwood: ..." is more helpful to someone searching --oneline for
changes to the kirkwood SoC.

So yeah, mvebu encompasses kirkwood now with your patchset.  Which makes
the 'mvebu' term more vague.  Before, folks could restrict commit
history on mach-kirkwood/ or mach-dove/ to see changes for a particular
SoC.  With it all in mach-mvebu (and not in a single file), we need
another way for developers to spot relevant commits.  That's why I
prefer the above.

ex: What changed from v3.15 to v3.16 for kirkwood?

$ git log --oneline v3.15..v3.16 -- arch/arm/mach-mvebu | \
	grep -i 'ARM: kirkwood'

This seems to be new territory for us (mvebu), perhaps one of the
arm-soc maintainers has a preference?  I'll add them to this reply.

thx,

Jason.
