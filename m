From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 18 May 2016 10:41:21 +0200
Subject: [PATCH 00/11] Clock improvement for video playback
Message-ID: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie allows to increase video resolutions and make audio
adjustment during a video playback.

Gabriel Fernandez (11):
  drivers: clk: st: Add fs660c32 synthesizer algorithm
  drivers: clk: st: Add clock propagation for audio clocks
  drivers: clk: st: Handle clkgenD2 clk synchronous mode
  ARM: DT: STiH407: Add compatibility string on clkgend0 for audio
    clocks
  ARM: DT: STiH410: Add compatibility string on clkgend0 for audio
    clocks
  ARM: DT: STiH418: Add compatibility string on clkgend0 for audio
    clocks
  ARM: DT: STiH407: Enable synchronous clock mode on clkgend2
  ARM: DT: STiH410: Enable synchronous clock mode on clkgend2
  ARM: DT: STiH418: Enable synchronous clock mode on clkgend2
  ARM: DT: STi: STiH407: clock configuration to address 720p and 1080p
  ARM: DT: STi: STiH410: clock configuration to address 720p and 1080p

 .../devicetree/bindings/clock/st/st,flexgen.txt    |   3 +
 arch/arm/boot/dts/stih407-clock.dtsi               |   4 +-
 arch/arm/boot/dts/stih407.dtsi                     |  16 ++-
 arch/arm/boot/dts/stih410-clock.dtsi               |   4 +-
 arch/arm/boot/dts/stih410.dtsi                     |  16 ++-
 arch/arm/boot/dts/stih418-clock.dtsi               |   4 +-
 drivers/clk/st/clk-flexgen.c                       |  61 +++++++-
 drivers/clk/st/clkgen-fsyn.c                       | 159 +++++++++++++++------
 8 files changed, 211 insertions(+), 56 deletions(-)

-- 
1.9.1
