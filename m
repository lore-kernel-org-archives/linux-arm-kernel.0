From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 Oct 2015 09:42:52 +0100
Subject: [PATCH v3 0/5] ARM: sunxi: Introduce CHIP support
Message-ID: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a serie introducing the support for the Allwinner R8 and the
Nextthing's CHIP.

Support is almost complete for the CHIP itself, the only missing part
for now is the WiFi chip that needs to be powered through two combined
regulators (AXP209's LDO3 and LDO4). The audio codec is also missing
since it's not already enabled in the DT.

Both these features will be addressed eventually.

Let me know what you think,
Maxime

Changes from v2:
  - Fixed whitespace issue
  - Changed DTSI include to R8
  - Removed i2c1 to be consitent with the other boards

Changes from v1:
  - Collected tags
  - Removed unused include files
  - Removed ipsout, dram and vcc regulators
  - Added USB power supply

Maxime Ripard (5):
  ARM: sunxi: Add R8 support
  ARM: sun5i: Add R8 DTSI
  ARM: sun5i: dt: Move uart3 pinctrl node to common DTSI
  ARM: sun5i: dt: Add UART3 CTS and RTS pins
  ARM: sun5i: Add C.H.I.P DTS

 Documentation/arm/sunxi/README                  |   2 +-
 Documentation/devicetree/bindings/arm/sunxi.txt |   1 +
 arch/arm/boot/dts/Makefile                      |   3 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi               |   7 -
 arch/arm/boot/dts/sun5i-r8-chip.dts             | 213 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-r8.dtsi                 |  59 +++++++
 arch/arm/boot/dts/sun5i.dtsi                    |  14 ++
 arch/arm/mach-sunxi/sunxi.c                     |   3 +-
 drivers/clk/sunxi/clk-sunxi.c                   |   1 +
 9 files changed, 293 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun5i-r8-chip.dts
 create mode 100644 arch/arm/boot/dts/sun5i-r8.dtsi

-- 
2.5.3
