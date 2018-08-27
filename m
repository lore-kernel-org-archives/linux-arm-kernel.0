From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Aug 2018 17:10:58 +0800
Subject: [GIT PULL] i.MX fixes for 4.19
Message-ID: <20180827091056.GN3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.19

for you to fetch changes up to b9543a2e39dc909e6b7ec901b6c7208d01d5c0dd:

  ARM: imx_v6_v7_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G (2018-08-27 15:05:48 +0800)

----------------------------------------------------------------
i.MX fixes for 4.19:
 - i.MX display folks decided to switch MXS display driver from legacy
   FB to DRM during 4.19 merge window.  It leads to a fallout on some
   Freescale/NXP development boards with Seiko 43WVF1G panel, because
   this DRM panel driver is not enabled in i.MX defconfig.  Here is
   a series from Fabio to convert i.MX23/28 EVK DT to Seiko 43WVF1G
   panel bindings and enable the panel driver in i.MX defconfig, so that
   users can still get functional LCD on these boards by default.
 - A fix from Leonard to revert incorrect legacy PCI irq mapping in
   i.MX7 device tree, that was caused by document errors.

----------------------------------------------------------------
Fabio Estevam (6):
      ARM: dts: imx28-evk: Move regulators outside simple-bus
      ARM: dts: imx28-evk: Convert to the new display bindings
      ARM: dts: imx23-evk: Move regulators outside simple-bus
      ARM: dts: imx23-evk: Convert to the new display bindings
      ARM: mxs_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G
      ARM: imx_v6_v7_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G

Leonard Crestez (1):
      Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"

 arch/arm/boot/dts/imx23-evk.dts      |  90 ++++++++---------
 arch/arm/boot/dts/imx28-evk.dts      | 183 ++++++++++++++++-------------------
 arch/arm/boot/dts/imx7d.dtsi         |  12 ++-
 arch/arm/configs/imx_v6_v7_defconfig |   1 +
 arch/arm/configs/mxs_defconfig       |   1 +
 5 files changed, 136 insertions(+), 151 deletions(-)
