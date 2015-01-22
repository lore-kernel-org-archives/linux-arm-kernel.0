From: ideal.song@samsung.com (Inha Song)
Date: Thu, 22 Jan 2015 20:17:58 +0900
Subject: [alsa-devel] [PATCH v3 0/4] Sound support for Exynos4412 Trats2 board
Message-ID: <1421925482-15861-1-git-send-email-ideal.song@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set adds basic sound support for the Trats2 boards.
It just support primary I2s and external speaker playback.

Changes in v3:
  - Set clock out parent to XUSBXTI in pmu_system_controller DT node.

Changes in v2:
  - Remove unnecessary lines in Trats2 machine driver
  - move clock enable/disable to .startup / .shutdown
  - Fix code style issues
  - Remove mclk DT property in Trats2 sound and add MCLK1 property in WM1811 node.
    (MCLK1 is optional property in WM8994 node - refer: Document/devicetree/bindings/sound/wm8994.txt)
  - Use mclk that defined in WM1811 DT node.
  - Add "samsung,audio-codec" property to required properties.

Inha Song (4):
  ASoC: samsung: Add machine driver for Trats2
  ASoC: samsung: Document Trats2 audio subsystem bindings
  ARM: dts: set clock out parent to XUSBXTI
  ARM: dts: Add sound nodes for exynos4412-trats2

 .../bindings/sound/samsung,trats2-wm1811.txt       |  25 +++
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  37 ++++
 sound/soc/samsung/Kconfig                          |   8 +
 sound/soc/samsung/Makefile                         |   2 +
 sound/soc/samsung/trats2_wm1811.c                  | 218 +++++++++++++++++++++
 6 files changed, 292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,trats2-wm1811.txt
 create mode 100644 sound/soc/samsung/trats2_wm1811.c

-- 
2.0.0.390.gcb682f8
