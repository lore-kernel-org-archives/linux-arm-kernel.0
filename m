From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Nov 2018 14:53:08 +0800
Subject: [PATCH 0/3] arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 and
 LEDs
Message-ID: <20181120065311.30009-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small series enables USB 2.0 and LEDs on the Orange Pi Lite 2 and
Orange Pi One Plus. The two features are unrelated, but included in the
same series as the patch contexts overlap.

Patch one adds a fixed regulator to represent the board-wide 5V rail.
While not strictly necessary, this helps define the relationship between
regulators.

Patch two enables USB 2.0 host and OTG. Note that VBUS on both ports are
directly tied to the 5V rail, without any power switches or current
limiters.

Patch three add device nodes for the two LEDs. These LEDs are driven
directly by the GPIO pins, without a current limiting resistor. At the
default drive strength, the LEDs are quite bright.

Please have a look.
ChenYu

Chen-Yu Tsai (3):
  arm64: dts: allwinner: h6: orangepi: Add board-wide 5V regulator
  arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 host and OTG ports
  arm64: dts: allwinner: h6: orangepi: Add device nodes for LEDs

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

-- 
2.19.1
