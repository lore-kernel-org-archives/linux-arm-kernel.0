From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  1 Jan 2014 10:30:45 +0800
Subject: [PATCH v3 0/5] clk: sunxi: add A20 external output clock support
Message-ID: <1388543450-16741-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v3 of A20 external output clock support patch series,
addressing issues raised by Maxime.

The patch series builds upon Emilio's clock series, and adds
support for external output clocks on the Allwinner A20 SoC.
The outputs can be used to supply a stable clock to external
modules, such as WiFi or Bluetooth.

Mike Turquette has already taken patch #1 via Emilio's pull
request.

Changes since v2:

  - #2, #3: Change dummy clock names to clk at N
  - #5: Change pin mux labels to clk_out_[ab]_pins_a

Changes since v1:

  - Add clock binding to sunxi clock DT binding documentation
  - Rename clock nodes to match device tree conventions
  - Add commit message for pin function/mux commits
  - Add comments to pin functions


Cheers,
ChenYu


Chen-Yu Tsai (5):
  clk: sunxi: Allwinner A20 output clock support
  ARM: dts: sun7i: Change 32768 Hz oscillator node name to clk at N style
  ARM: dts: sun7i: external clock outputs
  pinctrl: sunxi: Add Allwinner A20 clock output pin functions
  ARM: dts: sun7i: Add pin muxing options for clock outputs

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 45 +++++++++++++++++-
 drivers/clk/sunxi/clk-sunxi.c                     | 57 +++++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi-pins.h              |  2 +
 4 files changed, 104 insertions(+), 1 deletion(-)

-- 
1.8.5.2
