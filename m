From: stefan@agner.ch (Stefan Agner)
Date: Fri, 18 Jul 2014 19:01:36 +0200
Subject: [PATCH 0/6] vf610: Add USB support
Message-ID: <cover.1405702442.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds USB support for Vybrid VF610 SoC. It extends the
clock framework to support the USB PHY cocks, extends the device
tree files and adds support for the non-core registers in the
usbmisc_imx driver.

This patchset needs the eSDHC length fix available in Shawn's
for-next branch.

The whole patchset proved to be working on a Colibri VF61. The
first USB controller runs in peripheral mode. I could successfully
use RNDIS, however with some stability issues: Suddenly the other
side was not reachable anymore and the interface needed to brought
down and back up again. I'm still investigating this.

The second USB controller, running in USB host mode, showed no
issues so far.

Stefan Agner (6):
  ARM: dts: vf610: add USB PHY and controller
  ARM: imx: clk-vf610: add USBPHY clocks
  ARM: dts: vf610: Add usbmisc for non-core registers
  chipidea: usbmisc_imx: Add USB support for VF610 SoCs
  usb: phy: mxs: Add VF610 USB PHY support
  ARM: dts: vf610-colibri: add USB support

 arch/arm/boot/dts/vf610-colibri.dts     | 10 +++++
 arch/arm/boot/dts/vf610.dtsi            | 55 ++++++++++++++++++++++--
 arch/arm/mach-imx/clk-vf610.c           | 12 +++++-
 drivers/usb/chipidea/usbmisc_imx.c      | 76 +++++++++++++++++++++++----------
 drivers/usb/phy/phy-mxs-usb.c           |  5 +++
 include/dt-bindings/clock/vf610-clock.h |  5 ++-
 6 files changed, 135 insertions(+), 28 deletions(-)

-- 
2.0.1
