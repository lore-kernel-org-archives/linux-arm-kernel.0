From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 16:10:27 +0100
Subject: [PATCH 0/3] Fixes and DT conversion for QNAP TS219
Message-ID: <1359213030-18588-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains fixes to the patchset "ARM: kirkwood: cleanup
DT conversion" from Jason Cooper, and converts QNAP TS219 ethernet to
DT.

Probably the best way to use these patches:

place "NET: mv643xx: Get clk from device tree." directly after Ian
Moltons "mv643xx.c: Add basic device tree support" patch.

Squash "ARM: Kirkwood: Revert clkdev changes." into
"ARM: kirkwood: mv643xx_eth dt conversion"

Put "ARM: Kirkwood: Convert QNAP TS219 Ethernet to DT."
at the end of the set.

Andrew Lunn (3):
  NET: mv643xx: Get clk from device tree.
  ARM: Kirkwood: Revert clkdev changes.
  ARM: Kirkwood: Convert QNAP TS219 Ethernet to DT.

 arch/arm/boot/dts/kirkwood-ts219-6281.dts  |    9 +++++++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts  |   10 ++++++++
 arch/arm/mach-kirkwood/Kconfig             |   17 ++-----------
 arch/arm/mach-kirkwood/Makefile            |    1 -
 arch/arm/mach-kirkwood/board-dt.c          |    7 ++----
 arch/arm/mach-kirkwood/board-ts219.c       |   37 ----------------------------
 arch/arm/mach-kirkwood/common.h            |    6 -----
 drivers/net/ethernet/marvell/mv643xx_eth.c |    5 +++-
 8 files changed, 27 insertions(+), 65 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-ts219.c

-- 
1.7.10.4
