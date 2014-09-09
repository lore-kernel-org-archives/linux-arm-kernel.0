From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue,  9 Sep 2014 18:50:57 +0200
Subject: [PATCH v3 0/7] arm: mediatek: Add more basic features
Message-ID: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds some minor changes to the Mediatek mt6589 support.

Features are low-level debugging on the mt6589, the addition to the
"make dtbs" and multi_v7_defconfig, earlyprintk suppport, as well as a small
changes in the DTS files.

The patch set is based on v3.17-rc1

Changes for v3:
- drop quirk to enable ARM arch timer

Changes for v2:
- rebased on v3.17-rc1
- add patch for the compatible property of aquaris5
- add patch setting GIC compatible string to new "arm,cortex-a7-gic"
- set ARM arch timer frequency in DTS

---

Matthias Brugger (7):
  arm: dts: Build dtb for Mediatek board
  arm: multi_v7_defconfig: Enable Mediatek platform
  arm: dts: mt6589: Fix typo in GIC unit address
  arm: mediatek: Add earlyprintk support for mt6589
  arm: dts: mt6589-aquaris5: Add boot argument earlyprintk
  arm: dts: mediatek: Add compatible property for aquaris5
  arm: dts: mt6589: Change compatible string for GIC

 Documentation/devicetree/bindings/arm/mediatek.txt |  6 ++++++
 arch/arm/Kconfig.debug                             | 10 ++++++++++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/mt6589-aquaris5.dts              |  5 +++++
 arch/arm/boot/dts/mt6589.dtsi                      |  4 ++--
 arch/arm/configs/multi_v7_defconfig                |  1 +
 6 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.9.1
