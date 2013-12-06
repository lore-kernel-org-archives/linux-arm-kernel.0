From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 6 Dec 2013 15:45:45 -0300
Subject: Merge order in Armada 370/XP (mvebu) NAND support
Message-ID: <20131206184544.GA14986@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Now that all the pxa3xx-nand code has been merged by proper maintainers
and is available in each subsystem's trees I'd like to ask for suggestions
regarding a potential problem.

Since v3.12, the pxa3xx-nand driver supports the "armada370-nand"
compatible. This was probably a mistake as little to no NAND support
is present in that release.

The support to handle 4K pages devices (for instance, supporting the Mirabox
board) was submitted later, and is currently in MTD tree, waiting to be
pulled in v3.14.

On the other side, the devicetree files (dts and dtsi) needed to enable
such support was taken through the mvebu tree. Currently, a board booted
using mvebu's for-next branch will try to probe the NAND device
(because the compatible was merged in v3.12) and there's a chance it
hits on of NAND core's BUG().

The patchset containing the devicetree changes was prepared under the
assumption that the driver would be merged first, so no risk existed.

I admit this was a crappy assumption on my side to make (and worse:
it's not the first time I assume this).

Jason/Brian: What do you think we can do?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
