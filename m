From: ideal.song@samsung.com (Inha Song)
Date: Fri, 23 Jan 2015 14:03:27 +0900
Subject: [alsa-devel] [PATCH v4 0/3] Sound support for Exynos4412 Trats2 board
Message-ID: <1421989410-12490-1-git-send-email-ideal.song@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set adds basic sound support for the Trats2 boards.
It just support primary I2s and external speaker playback.

Changes in v4:
  - Move to clock out parent settings in exynos4412-trats2.dts
  - Remove unnecessary lines in Trats2 machine driver.
  - Change name of dai stream to more cleary.
  - Add MFD_WM8994 to select in machine driver kconfig.

Changes in v3:
  - Set clock out parent to XUSBXTI in pmu_system_controller DT node.

Changes in v2:
  - Remove unnecessary lines in Trats2 machine driver.
  - move clock enable/disable to .startup / .shutdown.
  - Fix code style issues.
  - Remove mclk DT property in Trats2 sound and add MCLK1 property in WM1811 node.
    (MCLK1 is optional property in WM8994 node - refer: Document/devicetree/bindings/sound/wm8994.txt)
  - Use mclk that defined in WM1811 DT node.
  - Add "samsung,audio-codec" property to required properties.

Inha Song (3):
  ASoC: samsung: Add machine driver for Trats2
  ASoC: samsung: Document Trats2 audio subsystem bindings
  ARM: dts: Add sound nodes for exynos4412-trats2

 .../bindings/sound/samsung,trats2-wm1811.txt       |  25 +++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  42 ++++
 sound/soc/samsung/Kconfig                          |   9 +
 sound/soc/samsung/Makefile                         |   2 +
 sound/soc/samsung/trats2_wm1811.c                  | 211 +++++++++++++++++++++
 5 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,trats2-wm1811.txt
 create mode 100644 sound/soc/samsung/trats2_wm1811.c

-- 
2.0.0.390.gcb682f8
