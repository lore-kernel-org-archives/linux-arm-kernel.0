From: Thomas.Betker@rohde-schwarz.com (Thomas.Betker at rohde-schwarz.com)
Date: Tue, 12 May 2015 14:42:02 +0200
Subject: [PATCH] ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)
In-Reply-To: <5551A2C8.1070803@xilinx.com>
References: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
 <55519E47.7040008@de.bosch.com> <5551A2C8.1070803@xilinx.com>
Message-ID: <OF5BDDADA7.8131210F-ONC1257E43.00444460-C1257E43.0045C4A1@rohde-schwarz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> This patch is based on the
> >> commit 1a8e41cd672f ("ARM: 6395/1: VExpress: Set bit 22 in the PL310
> >> (cache controller) AuxCtlr register")
> > 
> > 
> > I've been under the impression that this shouldn't be done in the
> > kernel, but in the boot loader/firmware:
> > 
> > https://lkml.org/lkml/2015/2/20/199
> > 
> > http://lists.denx.de/pipermail/u-boot/2015-March/207803.html
> 
> Tegra, Exynos, sti still have this bit set.

In 4.1-rc3, the bit is set by berlin, exynos, nomadik, omap2, sti, tegra, 
vexpress.

> Does that mean that they should be just removed because fix should be in
> bootloader?
> 
> Anyway it is normal that bootloader stay on system untouched and only OS
> is updated. But OK - let's make this in bootloader if this is preferred
> solution.

So the plan is to update each and every Zynq bootloader for a problem we 
have encountered in Linux (in our case, a problem we have been hunting for 
months)? My u-boot doesn't even use the cache; it's disabled until the 
kernel boots.

I do understand that the kernel should not overwrite hardwired settings 
such as cache size, but shouldn't we at least allow to fix things that 
definitely need to be fixed?

Best regards,
Thomas Betker
