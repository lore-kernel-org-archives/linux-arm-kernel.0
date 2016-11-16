From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Nov 2016 23:42:30 +0800
Subject: [PATCH v4 0/2] ARM: dts: sun6i: hummingbird-a31: Enable display
 output through VGA bridge
Message-ID: <20161116154232.872-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v4 of my sun6i DRM/KMS display enablement series. It adds
regulator support to the dumb-vga-dac bridge and enables the VGA
output on the A31 Hummingbird.


Changes since v3:

  - Add Rob's Ack.

  - Fix up enable/disable callbacks as Archit suggested.

  - Dropped pinmux settings for GPIO pin.

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
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        | 67 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/dumb-vga-dac.c              | 35 +++++++++++
 3 files changed, 104 insertions(+)

-- 
2.10.2
