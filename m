From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 13 Dec 2011 15:49:32 +0530
Subject: [PATCH v2 0/3] Device tree support for TWL regulators
Message-ID: <1323771575-3550-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT support for TWL regulator driver and
passes regulator data for two OMAP4 boards (OMAP4 panda and
OMAP4 sdp) from device tree.

Patches are based on for-next of the regulator tree[1] with
omap i2c/twl DT adaptation patches[2] from Benoit pulled in
and are available here:
git://gitorious.org/omap-pm/linux.git for-dt/regulator-twl

regards,
Rajendra

[1] git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
[2] git://gitorious.org/omap-pm/linux.git for_3.3/3_omap_dt_i2c_twl

Rajendra Nayak (3):
  regulator: twl: adapt twl-regulator driver to dt
  ARM: omap4-sdp: Pass regulator data from dt
  omap4: panda: Pass regulator data from dt

 .../bindings/regulator/twl-regulator.txt           |   57 +++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   24 ++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   36 ++++++
 drivers/regulator/twl-regulator.c                  |  128 +++++++++++++-------
 4 files changed, 199 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
