From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Dec 2013 21:26:16 +0800
Subject: [PATCH 0/4] clk: sunxi: add A20 external output clock support
In-Reply-To: <1387787827-11341-1-git-send-email-wens@csie.org>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
Message-ID: <1387891580-30715-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of A20 external output clock support patch series.

The patch series builds upon Emilio's clock series, and adds
support for external output clocks on the Allwinner A20 SoC.
The outputs can be used to supply a stable clock to external
modules, such as WiFi or Bluetooth.


Changes since v1:

  - Add clock binding to sunxi clock DT binding documentation
  - Rename clock nodes to match device tree conventions
  - Add commit message for pin function/mux commits
  - Add comments to pin functions


Cheers,
ChenYu


Chen-Yu Tsai (4):
  clk: sunxi: Allwinner A20 output clock support
  ARM: dts: sun7i: external clock outputs
  pinctrl: sunxi: Add Allwinner A20 clock output pin functions
  ARM: dts: sun7i: Add pin muxing options for clock outputs

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 41 ++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                     | 57 +++++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi-pins.h              |  2 +
 4 files changed, 101 insertions(+)

-- 
1.8.5.2
