From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 1 Feb 2011 19:15:05 -0600
Subject: Unable to ioremap a SZ_64M region
Message-ID: <0D753D10438DA54287A00B027084269764CEF59BAC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to use the platform nand driver on an ep93xx board and am
having trouble getting the iomem region remapped.

The nand device is connected to nCS3 on the ep93xx which has a physical
base address of 0x30000000.  The ALE and CLE lines of the nand are
unfortunatly connected to address lines A24 and A25 so I need to map a
64MB region in order to use them.

I believe I have the platform init code setup correctly to use the nand
driver.  And /proc/iomem shows the proper resource allocation:

# cat /proc/iomem | grep gen_nand
30000000-33ffffff : gen_nand

When the plat_nand driver tries to ioremap the resource I get a remapped
address of 0xc9000000.  The ioremap does not fail but, from what I can
tell, this address will only allow me to access up to 16MB.

Am I missing something here?

Thanks,
Hartley
