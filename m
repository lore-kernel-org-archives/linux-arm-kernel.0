From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 27 Oct 2011 13:34:31 +0530
Subject: [PATCH 0/3] Device tree support for TWL regulators
Message-ID: <1319702674-16304-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adapts TWL regulator driver to work with device
tree and passes regulator data for two OMAP4 boards (OMAP4
panda and OMAP4 sdp) from device tree.

The series has a few dependencies
-1- base regulator dt support series posted here
http://marc.info/?l=linux-omap&m=131970236516788&w=2
-2- All base omap3/4 DT support patches lined up
for 3.2 merge here
git://github.com/tmlind/linux.git dt
-3- patches for i2c/twl support posted here
http://marc.info/?l=linux-omap&m=131705583821757&w=2

All the dependent patches and the ones posted as part
of this series are pulled in one branch can be found here
git://gitorious.org/omap-pm/linux.git for-dt/regulator-i2c-twl

regards,
Rajendra

Rajendra Nayak (3):
  regulator: twl: adapt twl-regulator driver to dt
  omap4: sdp: Pass regulator data from dt
  omap4: panda: Pass regulator data from DT

 .../bindings/regulator/twl-regulator.txt           |   57 +++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   34 +++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   36 ++++++
 drivers/regulator/Kconfig                          |    1 +
 drivers/regulator/twl-regulator.c                  |  128 +++++++++++++-------
 5 files changed, 211 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
