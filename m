From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Thu, 15 May 2014 11:48:52 +0200
Subject: [PATCH 0/3] Update the Keymile kirkwood DTS files
Message-ID: <1400147335-20947-1-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series resynchs the Keymile Kirkwood DTS files with mainline since
the boards do not boot anymore with the 3.15 rc kernels (to be honest, I
have not tested the last 2-3 releases).

The changes are the addition of the PCIe controller for the 98dx4122
SoC, the explicit disabling of the SATA phys for this same SoC and
finally the enabling of the PCIe controller on the Keymile Reference
design.

The series also adds a new DTS for another Keymile generic design where
the mv64xxx eth interace is configured with fixed parameters to no phy
but a switch (for board internal communication).

The series applies and was tested on top of Jason's mvebu/dt branch
(mvebu-dt-3.16 tag).


Valentin Longchamp (3):
  ARM: dts: kirkwood: resynch 98dx4122 dtsi
  ARM: dts: kirkwood: enable the PCIe for km_kirkwood
  ARM: dts: kirkwood: add kirkwood-km_fixedeth DTS file

 arch/arm/boot/dts/kirkwood-98dx4122.dtsi   | 43 ++++++++++++++++++
 arch/arm/boot/dts/kirkwood-km_fixedeth.dts | 70 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts | 10 +++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-km_fixedeth.dts

-- 
1.8.0.1
