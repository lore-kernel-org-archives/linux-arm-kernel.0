From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Oct 2014 11:05:45 +0800
Subject: [PATCH v2 0/6] ARM: sun9i: Enable extra uarts,
 leds and i2c controllers
Message-ID: <1414724751-25580-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series enables the uart and i2c controller found on the A80 Optimus
board's gpio expansion header, as well as 2 out of 3 onboard LEDs. The
last LED needs R_PIO support.

This series contains only changes to the dtsi and dts files, and is based
on Maxime's pinctrl driver series. The patches should be self-explanatory.

Changes since v1:

  - Dropped a80_ prefix on the led labels
  - Fixed mapping for leds to pins, previously led2 and led4 were reversed.
  - Use dash instead of underscore in led-pins DT node name

Cheers,
ChenYu


Chen-Yu Tsai (6):
  ARM: dts: sun9i: Add i2c controller nodes to a80 dtsi
  ARM: dts: sun9i: Add i2c3 pinmux setting for A80 SoC
  ARM: dts: sun9i: Enable i2c3 on A80 Optimus board
  ARM: dts: sun9i: Add GPIO LEDs for A80 Optimus board
  ARM: dts: sun9i: Add uart4 pinmux setting for A80 SoC
  ARM: dts: sun9i: Enable uart4 for A80 Optimus board

 arch/arm/boot/dts/sun9i-a80-optimus.dts | 51 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun9i-a80.dtsi        | 69 +++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

-- 
2.1.1
