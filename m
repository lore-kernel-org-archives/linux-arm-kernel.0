From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Fri, 16 May 2014 10:49:00 +0200
Subject: [PATCH v2 0/3] Update the Keymile kirkwood DTS files
Message-ID: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series resynchs the Keymile Kirkwood DTS files with mainline since
the boards do not boot anymore with the 3.15 rc kernels (to be honest, I
have not tested the last 2-3 releases).

The changes are the addition of the PCIe controller for the 98dx4122
SoC, the explicit disabling of the SATA phys for this same SoC and
finally the enabling of the PCIe controller on the Keymile Reference
design.

The series introduces kirkwood-km_common.dtsi that factors the common
nodes between kirkwood-km_kirkwood.dts and the new board/design below.

The series also adds a new DTS for another Keymile generic design where
the mv64xxx eth interace is configured with fixed parameters to no phy
but a switch (for board internal communication).

The series applies and was tested on top of Jason's mvebu/dt branch
(mvebu-dt-3.16 tag).

Changes in v2:
- introduce kirkwood-km_common.dtsi to allow factoring some nodes
  between boards
- Take advantage of the kirkwood-km_common.dtsi file for
  kirkwood-km_fixedeth.dts

Valentin Longchamp (3):
  ARM: dts: kirkwood: resynch 98dx4122 dtsi
  ARM: dts: kirkwood: add kirkwood-km_common DTSI files
  ARM: dts: kirkwood: add kirkwood-km_fixedeth DTS file

 arch/arm/boot/dts/kirkwood-98dx4122.dtsi   | 43 ++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-km_common.dtsi  | 48 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-km_fixedeth.dts | 23 ++++++++++++++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts | 38 +----------------------
 4 files changed, 115 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-km_common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-km_fixedeth.dts

-- 
1.8.0.1
