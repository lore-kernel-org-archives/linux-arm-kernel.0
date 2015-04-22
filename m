From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:14 -0700
Subject: [GIT PULL 7/9] ARM: SoC defconfig updates for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We keep collecting defconfig updates in a separate branch mostly to encourage
people to handle them separately and avoid conflicts between different topics.

Most of these are enablement of new drivers that have come in, or minor config
refreshes due to reorderings in Kconfig files, etc. I.e. mostly minor churn
of various kinds.

We might start folding this branch into something else for upstream merge
since it's so small, but keep it independent in our own tree for the above
reasons.


Conflicts: None

----------------------------------------------------------------

The following changes since commit c972226d171f288dda4d99d8eeda95a195e98a60:

  Merge tag 'armsoc-multiplatform' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to b50c9c2de553102d42842db842f57c6cad676494:

  ARM: multi_v7_defconfig: enable alpine platform

----------------------------------------------------------------

Arnd Bergmann (1):
      Merge tag 'mvebu-defconfig-4.1' of git://git.infradead.org/linux-mvebu into next/defconfig

Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Enable CONFIG_PHY_SUN9I_USB
      ARM: multi_v7_defconfig: Enable CONFIG_PHY_SUN9I_USB

Ezequiel Garcia (1):
      ARM: mvebu: Enable perf support in mvebu_v7_defconfig

Fabio Estevam (3):
      ARM: mxs_defconfig: Add VFAT support
      ARM: imx_v4_v5_defconfig: Add VFAT support
      ARM: imx_v6_v7_defconfig: Enable Bluetooth support

Felipe Balbi (1):
      arm: config: omap2plus_defconfig: switch over to LZMA compression

Geert Uytterhoeven (4):
      ARM: shmobile: Enable ape6evm board in multiplatform defconfig
      ARM: shmobile: Enable R-Mobile reset driver in multiplatform defconfig
      ARM: shmobile: defconfig: Drop useless SERIAL_8250_EXTENDED=y
      ARM: shmobile: Enable bockw board in multiplatform defconfig

Georgi Djakov (1):
      ARM: qcom: Increase MMC_BLOCK_MINORS in defconfig

Javier Martinez Canillas (5):
      ARM: exynos_defconfig: Disable IOMMU support
      ARM: exynos_defconfig: Enable Marvell WiFi-Ex support
      ARM: exynos_defconfig: Enable ChromeOS EC chardev driver
      ARM: exynos_defconfig: Enable options to mount a rootfs via NFS
      ARM: exynos_defconfig: Enable HDMI support

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable CPU idle

Kuninori Morimoto (1):
      ARM: configs: remove all CONFIG_RCAR_AUDMAC_PP from ARM defconfigs

Lukasz Majewski (3):
      ARM: exynos_defconfig: Remove CONFIG_EXYNOS_THERMAL_CORE define
      ARM: exynos_defconfig: Enable thermal emulation for Exynos TMU
      ARM: exynos_defconfig: Enable support for cpufreq on Exynos SoCs

Olof Johansson (8):
      Merge tag 'qcom-defconfig-for-4.1' of git://git.kernel.org/.../galak/linux-qcom into next/defconfig
      Merge tag 'v4.1-defconfig' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'mvebu-defconfig-4.1-2' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.1' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.1-1' of git://git.kernel.org/.../galak/linux-qcom into next/defconfig
      Merge tag 'imx-defconfig-4.1' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'samsung-defconfig' of git://git.kernel.org/.../kgene/linux-samsung into next/defconfig

Paul Walmsley (1):
      ARM: omap1_defconfig: drop obsolete Kconfig symbols

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: Add CONFIG_GPIO_PCA953X

Rajendra Nayak (1):
      arm: qcom: Enable lpass clock driver in defconfig

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB

Stephen Boyd (1):
      arm: qcom: Update defconfig

Thomas Petazzoni (2):
      ARM: mvebu: enable Armada 39x in mvebu_v7_defconfig
      ARM: configs: enable Marvell Armada 39x in multi_v7_defconfig

Tomeu Vizoso (4):
      ARM: multi_v7_defconfig: Enable Tegra ACTMON support
      ARM: multi_v7_defconfig: Enable support for ELAN i2c trackpads
      ARM: multi_v7_defconfig: Build the Marvell WiFi-Ex driver as a module
      ARM: multi_v7_defconfig: Add gpio-restart driver

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Enable leds-pwm
      ARM: omap2plus_defconfig: Update bluetooth options
      ARM: omap2plus_defconfig: Enable n900 modem as loadable modules

Tsahee Zidenberg (1):
      ARM: multi_v7_defconfig: enable alpine platform

Tyler Baker (1):
      ARM: sunxi_defconfig: increase the number of maximum number of CPUs to 8


 arch/arm/configs/exynos_defconfig    | 20 ++++++++++++++++++--
 arch/arm/configs/imx_v4_v5_defconfig |  1 +
 arch/arm/configs/imx_v6_v7_defconfig |  4 ++++
 arch/arm/configs/multi_v7_defconfig  | 14 +++++++++++++-
 arch/arm/configs/mvebu_v7_defconfig  |  2 ++
 arch/arm/configs/mxs_defconfig       |  1 +
 arch/arm/configs/omap1_defconfig     | 16 ----------------
 arch/arm/configs/omap2plus_defconfig | 27 +++++++++++++++++++++++++++
 arch/arm/configs/qcom_defconfig      |  9 +++++----
 arch/arm/configs/shmobile_defconfig  |  9 ++++++++-
 arch/arm/configs/sunxi_defconfig     |  1 +
 11 files changed, 80 insertions(+), 24 deletions(-)
