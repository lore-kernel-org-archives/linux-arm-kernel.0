From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat,  4 Oct 2014 02:15:42 +0200
Subject: [PATCH v3 0/3] ASoC/ARM: tegra: apalis/colibri t30: sgtl5000 audio
Message-ID: <cover.1412381377.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds/integrates Freescale SGTL5000 analogue audio codec
support.

Changes in v3:
- Revert to not using simple-audio-card being incompatible with tegra.
- Rebased to for-next.

Changes in v2:
- Using simple-audio-card as suggested by Fabio.

Marcel Ziswiler (3):
  ASoC: tegra: add tegra sgtl5000 machine driver
  ARM: tegra: apalis/colibri t30: integrate audio support
  ARM: tegra: enable sgtl5000 audio

 .../bindings/sound/nvidia,tegra-audio-sgtl5000.txt |  45 +++++
 arch/arm/boot/dts/tegra30-apalis.dtsi              |  49 +++++
 arch/arm/boot/dts/tegra30-colibri.dtsi             |  49 +++++
 arch/arm/configs/tegra_defconfig                   |   1 +
 sound/soc/tegra/Kconfig                            |  10 +
 sound/soc/tegra/Makefile                           |   2 +
 sound/soc/tegra/tegra_sgtl5000.c                   | 216 +++++++++++++++++++++
 7 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.txt
 create mode 100644 sound/soc/tegra/tegra_sgtl5000.c

-- 
1.9.3
