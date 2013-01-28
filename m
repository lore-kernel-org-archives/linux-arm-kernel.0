From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 28 Jan 2013 18:54:06 +0100
Subject: [PATCH 0/2] ARM: dts: OMAP3: Add GPMC controller and NAND memory to
 Overo
Message-ID: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is more an RFC serie, as an issue is still unclear to me.
Building on the work of Daniel Mack for the GPMC controller (staged
in Tony's tree [1]), it was easy to add the GPMC controller to OMAP3.

The issue comes from the Overo on-board NAND, as the amount of flash
depends on the revision. Currently, partitions are handled in the board
file using MTDPART_SIZ_FULL, but looking at the ofpart parser, the size
given to the parser must be fixed.

So how should we handle such case? Having several dtsi depending
on the Overo's revision would be a mess to my sense, considering
the non-conditional include inside the expansion boards' dts.
Or would it make sense to extend the DT binding for partitions?

This serie was tested on an Overo with 512MB of NAND.

Best regards,

Florian

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v3.9/gpmc

Florian Vaussard (2):
  ARM: dts: OMAP3: Add GPMC controller
  ARM: dts: OMAP3: Add NAND memory for Overo products

 arch/arm/boot/dts/omap3-overo.dtsi |   49 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi       |   11 ++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

-- 
1.7.5.4
