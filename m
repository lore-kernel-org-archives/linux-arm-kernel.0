From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Jul 2012 12:47:56 -0600
Subject: [GIT PULL V2 1/7] ARM: tegra: for-3.6/cleanup branch
In-Reply-To: <1341600482-11020-1-git-send-email-swarren@wwwdotorg.org>
References: <1341600482-11020-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1341600482-11020-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains various minor cleanups, such as binding and .dts renames,
DT content cleanup, SDHCI support-8bit property usage cleanup, and removal of
some unnecessary sleep code.

This branch depends only on v3.5-rc2.

This branch is included in many later pull requests.

----------------------------------------------------------------

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.6/cleanup

for you to fetch changes up to 702b0e4f2f2782962aab7d9a0a40ad68770bb1f6:

  ARM: dt: tegra: rename board files to match SoC

----------------------------------------------------------------

Prashant Gaikwad (1):
      ARM: tegra: Remove flow controller programming

Stephen Warren (5):
      dt: name all Tegra binding docs consistently
      mmc: tegra: use bus-width property instead of support-8bit
      ARM: dt: tegra: remove legacy support-8bit property
      ASoC: tegra: simplify Kconfig dependencies
      ARM: dt: tegra: rename board files to match SoC

hdoyu at nvidia.com (5):
      amba: tegra-ahb: Remove empty *_remove()
      ARM: dt: tegra{20,30}.dtsi: Rename "mc" to "memory-controller"
      ARM: tegra{20,30}: Rename "mc" to "memory-controller"
      ARM: dt: tegra20: Rename "emc" to "memory-controller"
      ARM: tegra20: Rename "emc" to "memory-controller"

 .../arm/tegra/{emc.txt => nvidia,tegra20-emc.txt}  |    2 +-
 .../bindings/arm/tegra/nvidia,tegra20-mc.txt       |    2 +-
 .../bindings/arm/tegra/nvidia,tegra30-mc.txt       |    2 +-
 .../{gpio_nvidia.txt => nvidia,tegra20-gpio.txt}   |    0
 .../{tegra-kbc.txt => nvidia,tegra20-kbc.txt}      |    0
 .../{nvidia-sdhci.txt => nvidia,tegra20-sdhci.txt} |    0
 .../nvec/{nvec_nvidia.txt => nvidia,nvec.txt}      |    0
 ...-alc5632.txt => nvidia,tegra-audio-alc5632.txt} |    0
 ...mslice.txt => nvidia,tegra-audio-trimslice.txt} |    0
 ...io-wm8753.txt => nvidia,tegra-audio-wm8753.txt} |    0
 ...io-wm8903.txt => nvidia,tegra-audio-wm8903.txt} |    0
 .../{tegra20-das.txt => nvidia,tegra20-das.txt}    |    0
 .../{tegra20-i2s.txt => nvidia,tegra20-i2s.txt}    |    0
 .../spi/{spi_nvidia.txt => nvidia,tegra20-spi.txt} |    0
 .../usb/{tegra-usb.txt => nvidia,tegra20-ehci.txt} |    0
 .../dts/{tegra-harmony.dts => tegra20-harmony.dts} |    1 -
 .../dts/{tegra-paz00.dts => tegra20-paz00.dts}     |    1 -
 .../{tegra-seaboard.dts => tegra20-seaboard.dts}   |    3 +-
 .../{tegra-trimslice.dts => tegra20-trimslice.dts} |    0
 .../dts/{tegra-ventana.dts => tegra20-ventana.dts} |    1 -
 arch/arm/boot/dts/tegra20.dtsi                     |    4 +-
 .../dts/{tegra-cardhu.dts => tegra30-cardhu.dts}   |    1 -
 arch/arm/boot/dts/tegra30.dtsi                     |    2 +-
 arch/arm/mach-tegra/Kconfig                        |    3 --
 arch/arm/mach-tegra/Makefile.boot                  |   12 +++---
 arch/arm/mach-tegra/cpuidle.c                      |    6 ++--
 arch/arm/mach-tegra/sleep.S                        |   29 ---------------
 drivers/amba/tegra-ahb.c                           |    6 ---
 drivers/mmc/host/sdhci-tegra.c                     |    5 ++-
 sound/soc/tegra/Kconfig                            |   10 +-----
 30 files changed, 21 insertions(+), 69 deletions(-)
 rename Documentation/devicetree/bindings/arm/tegra/{emc.txt => nvidia,tegra20-emc.txt} (99%)
 rename Documentation/devicetree/bindings/gpio/{gpio_nvidia.txt => nvidia,tegra20-gpio.txt} (100%)
 rename Documentation/devicetree/bindings/input/{tegra-kbc.txt => nvidia,tegra20-kbc.txt} (100%)
 rename Documentation/devicetree/bindings/mmc/{nvidia-sdhci.txt => nvidia,tegra20-sdhci.txt} (100%)
 rename Documentation/devicetree/bindings/nvec/{nvec_nvidia.txt => nvidia,nvec.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-alc5632.txt => nvidia,tegra-audio-alc5632.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-trimslice.txt => nvidia,tegra-audio-trimslice.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-wm8753.txt => nvidia,tegra-audio-wm8753.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-wm8903.txt => nvidia,tegra-audio-wm8903.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra20-das.txt => nvidia,tegra20-das.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra20-i2s.txt => nvidia,tegra20-i2s.txt} (100%)
 rename Documentation/devicetree/bindings/spi/{spi_nvidia.txt => nvidia,tegra20-spi.txt} (100%)
 rename Documentation/devicetree/bindings/usb/{tegra-usb.txt => nvidia,tegra20-ehci.txt} (100%)
 rename arch/arm/boot/dts/{tegra-harmony.dts => tegra20-harmony.dts} (99%)
 rename arch/arm/boot/dts/{tegra-paz00.dts => tegra20-paz00.dts} (99%)
 rename arch/arm/boot/dts/{tegra-seaboard.dts => tegra20-seaboard.dts} (99%)
 rename arch/arm/boot/dts/{tegra-trimslice.dts => tegra20-trimslice.dts} (100%)
 rename arch/arm/boot/dts/{tegra-ventana.dts => tegra20-ventana.dts} (99%)
 rename arch/arm/boot/dts/{tegra-cardhu.dts => tegra30-cardhu.dts} (99%)
