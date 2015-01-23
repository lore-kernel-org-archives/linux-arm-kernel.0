From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Jan 2015 17:16:43 +0800
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 3.20
Message-ID: <20150123091641.GC27337@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please note this change set depends on imx-soc-3.20, thanks.

Shawn

The following changes since commit c205389557aac828f8403db0368d1fc2ef859213:

  ARM: imx: clk-vf610: Add clock for SNVS (2015-01-13 19:16:26 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.20

for you to fetch changes up to 16baf8ddd84b36e6880092da777a67de362f8677:

  ARM: dts: imx28-evk: remove duplicate property (2015-01-20 19:39:28 +0800)

----------------------------------------------------------------
The i.MX device tree update for 3.20:
 - Update i.MX6 operating-points setting in device tree to match the
   latest i.MX6 data sheet
 - Add i.MX6SX sabreauto board support
 - Add imx6dl-udoo board support based off imx6q-udoo
 - Update sabrelite board to include I2C and HDMI support
 - Update the VPU compatible strings to also use cnm,coda<model>
 - Remove the ocram clock from the VPU node, as the clock is already
   provided inside the ocram node
 - Add system reset controller and syscon-reboot for VF610
 - Update VF610 device tree to use zero based naming for GPIO nodes,
   so that the number scheme matches hardware manual
 - A number of random device additions like watchdog for VF610, sahara
   for i.MX53, QSPI for imx6sx-sdb board, etc.

Note: the branch imx/soc was merged into imx/dt because the SNVS device
tree node needs to refer to the new clock ID added by the imx/soc patch.

----------------------------------------------------------------
Anson Huang (3):
      ARM: dts: imx6q: update cpufreq volt/freq table
      ARM: dts: imx6dl: correct cpufreq volt/freq table
      ARM: dts: imx6sx: add i.mx6sx sabreauto board support

Anton Bondarenko (1):
      ARM: dts: imx6q: enable dma for ecspi5

Eric Nelson (3):
      ARM: dts: sabrelite: add i2c2
      ARM: dts: sabrelite: add hdmi
      ARM: dts: sabrelite: add i2c3

Fabio Estevam (3):
      ARM: dts: imx: Update VPU compatible strings
      ARM: dts: imx6qdl: Remove OCRAM clock from VPU node
      ARM: dts: imx6sx-sdb: Add QSPI support

Gwenhael Goavec-Merou (1):
      ARM: imx: apf51dev: add gpio-backlight support

Michael Heimpold (1):
      ARM: dts: imx28-evk: remove duplicate property

Philippe Reynes (1):
      apf27dev: add max5821 to the dts

Robert Nelson (1):
      ARM: dts: imx6dl-udoo: Add board support based off imx6q-udoo

Sanchayan Maity (1):
      ARM: dts: vfxxx: Add SNVS node

Shawn Guo (1):
      Merge branch 'imx/soc' into imx/dt

Stefan Agner (4):
      ARM: dts: vf610: enable watchdog for Cortex-A5 dt's
      ARM: dts: vf-colibri: add CLKOUT pin to pinctrl of FEC1
      ARM: dts: vf610: add system reset controller and syscon-reboot
      ARM: vf610: use zero based naming for GPIO nodes

Steffen Trumtrar (1):
      ARM: i.MX53: dts: add sahara module

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/imx27-apf27dev.dts      |  21 +++++
 arch/arm/boot/dts/imx27.dtsi              |   2 +-
 arch/arm/boot/dts/imx28-evk.dts           |   1 -
 arch/arm/boot/dts/imx51-apf51dev.dts      |  14 +++
 arch/arm/boot/dts/imx53.dtsi              |  11 ++-
 arch/arm/boot/dts/imx6dl-udoo.dts         |  18 ++++
 arch/arm/boot/dts/imx6dl.dtsi             |   2 +-
 arch/arm/boot/dts/imx6q-udoo.dts          | 124 +------------------------
 arch/arm/boot/dts/imx6q.dtsi              |   4 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  |  33 +++++++
 arch/arm/boot/dts/imx6qdl-udoo.dtsi       | 134 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi            |   5 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts    | 146 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb.dts          |  39 ++++++++
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |   2 +-
 arch/arm/boot/dts/vf-colibri.dtsi         |   3 +-
 arch/arm/boot/dts/vf500.dtsi              |  23 ++++-
 arch/arm/boot/dts/vf610-twr.dts           |   2 +-
 arch/arm/boot/dts/vfxxx.dtsi              |  48 +++++++---
 20 files changed, 484 insertions(+), 150 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-udoo.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-udoo.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sx-sabreauto.dts
