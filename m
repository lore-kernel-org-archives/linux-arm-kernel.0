From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 28 Nov 2015 12:14:04 +0100
Subject: [PATCH 0/4] ARM: dt: mvebu: ix4-300d: NAND cleanup and ECC
Message-ID: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a list of patches cleaning up some things I noticed while
working with barebox boot loader support for NAND node of Lenovo ix4-300d.

Patch 1 removes a flash partition node for the whole flash. The flash
as a whole is already best represented by the NAND device itself.

Patch 2 moves the stock flash partitions to a partitions sub-node. This
will also ease removal of stock flash partition layout for barebox and
other boot loaders.

Patch 3 cleans the flash partitions ranges by prefixing them to 32-bit
lower-case hex numbers. Also, a stale 'x' is removed from one partition
name offset.

Patch 4 finally adds ECC properties for 4-bit BCH ECC used by the ix4-300d
flash.

Sebastian

Sebastian Hesselbarth (4):
  ARM: dt: mvebu: ix4-300d: remove whole flash partition
  ARM: dt: mvebu: ix4-300d: move partitions to partition sub-node
  ARM: dt: mvebu: ix4-300d: Cleanup NAND partition ranges
  ARM: dt: mvebu: ix4-300d: Add ECC properties to NAND flash

 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 76 +++++++++++++------------
 1 file changed, 39 insertions(+), 37 deletions(-)

---
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com> 
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Pawel Moll <pawel.moll@arm.com> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
Cc: Kumar Gala <galak@codeaurora.org> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Benoit Masson <yahoo@perenite.com>
Cc: linux-arm-kernel at lists.infradead.org 
Cc: devicetree at vger.kernel.org 
Cc: linux-kernel at vger.kernel.org 
-- 
2.1.4
