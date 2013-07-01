From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  1 Jul 2013 15:23:21 +0200
Subject: [PATCHv4 0/8] ARM: mxs: Various Crystalfontz DT additions
Message-ID: <1372685009-15564-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add DT for the Crystalfontz CFA-10056 and Crystalfontz
CFA-10058.

The first patch simplifies board detection in mach-mxs.c as suggested by Thomas
Petazzoni in his review of the precedent DT additions.

The next two patches are adding the DTs.

The last patches are cleaning up the remaining boards DTs.

Changes in v4
 - corrected comment for cfa-10056 and made it cfa-10037 compatible
 - reordered patches

Changes in v3
 - Cleaned up all the DTs for crystalfontz boards.

Changes in v2:
 - took into account the review from Maxime Ripard

Thanks,

Alexandre Belloni (6):
  ARM: mxs: Simplify detection of CrystalFontz boards
  ARM: mxs: dt: cfa10037: make hogpins grabbed by respective drivers
  ARM: mxs: dt: cfa10049: make hogpins grabbed by respective drivers
  ARM: mxs: dt: cfa10055: make hogpins grabbed by respective drivers
  ARM: mxs: dt: cfa10057: remove hogpins
  ARM: mxs: dt: cfa10036: make hogpins grabbed by respective drivers

Brian Lilly (2):
  ARM: mxs: dt: Add Crystalfontz CFA-10056 device tree
  ARM: mxs: dt: Add Crystalfontz CFA-10058 device tree

 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/imx28-cfa10036.dts |   7 +-
 arch/arm/boot/dts/imx28-cfa10037.dts |  19 +++--
 arch/arm/boot/dts/imx28-cfa10049.dts |  73 +++++++++++++++---
 arch/arm/boot/dts/imx28-cfa10055.dts |  38 ++++------
 arch/arm/boot/dts/imx28-cfa10056.dts | 119 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-cfa10057.dts |  23 +-----
 arch/arm/boot/dts/imx28-cfa10058.dts | 141 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c         |   5 +-
 9 files changed, 359 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-cfa10056.dts
 create mode 100644 arch/arm/boot/dts/imx28-cfa10058.dts

-- 
1.8.1.2
