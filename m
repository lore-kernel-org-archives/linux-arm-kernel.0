From: stefan@agner.ch (Stefan Agner)
Date: Tue, 15 Jul 2014 14:56:17 +0200
Subject: [PATCH v3 0/4] ARM: vf610: add FlexCAN support
Message-ID: <cover.1405428166.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Vybrid (aka vf610) to the FlexCAN
controller and extends the device tree accordingly.

Changes in v3:
- Return error number in flexcan_get_berr_counter if clock enabling fails
- Add the FLEXCANX_EN clocks as new clocks

Changes in v2:
- Split out patch (seperate dt, clocks and driver changes)
- Use spaces for hardware feature flags table
- Remove drive-by change of esdhc register length
- Added related fix which enables clock in berr_counter

Stefan Agner (4):
  ARM: dts: vf610: add FlexCAN node
  ARM: imx: clk-vf610: fix FlexCAN clock gating
  can: flexcan: switch on clocks before accessing ecr register
  can: flexcan: add vf610 support for FlexCAN

 arch/arm/boot/dts/vf610.dtsi            | 23 +++++++++
 arch/arm/mach-imx/clk-vf610.c           |  6 ++-
 drivers/net/can/flexcan.c               | 91 +++++++++++++++++++++++++++++----
 include/dt-bindings/clock/vf610-clock.h |  4 +-
 4 files changed, 110 insertions(+), 14 deletions(-)

-- 
2.0.1
