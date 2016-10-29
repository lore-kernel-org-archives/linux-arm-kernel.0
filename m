From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 29 Oct 2016 19:06:09 +0800
Subject: [PATCH v3 0/2] ARM: dts: sun6i: hummingbird-a31: Enable display
 output through VGA bridge
Message-ID: <20161029110611.28951-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of my sun6i DRM/KMS display enablement series. Most of the
patches in v2 were merged, leaving only the dumb-vga-dac patch and the
hummingbird-a31 VGA output patch.

A few things were changed, mainly the DAC enable method from a GPIO
to a regulator supply.

Changes since v2:

  - Changed the enable-gpio of dumb-vga-dac to vdd-supply regulator.
    This better matches the hardware that I have: the DAC has a fixed
    regulator dropping the voltage from the board-wide 5V to 3.3V the
    DAC uses. The regulator is controlled through a GPIO pin.

  - Renamed the node of the VGA connector from "vga" to "vga-connector".

  - Renamed the node of the VGA DAC from "bridge" to "vga-dac".


Regards
ChenYu


Chen-Yu Tsai (2):
  drm/bridge: dumb-vga-dac: Support a VDD regulator supply
  ARM: dts: sun6i: hummingbird-a31: Enable display output through VGA
    bridge

 .../bindings/display/bridge/dumb-vga-dac.txt       |  2 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        | 76 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/dumb-vga-dac.c              | 35 ++++++++++
 3 files changed, 113 insertions(+)

-- 
2.9.3
