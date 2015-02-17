From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:28 -0800
Subject: [GIT PULL 7/7] ARM: SoC 64-bit changes and additions
In-Reply-To: <1424162008-23768-1-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
Message-ID: <1424162008-23768-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 64-bit set of updates this release cycle adds support for three new platforms:

- Samsunc Exynos 7
- Freescale LS2085a
- Mediatek MT8173

For all these, the changes mostly consititude additions of DT contents,
but also some Kconfig entries to allow dependency/selection of drivers
per-platform, etc.


Conflicts:

Documentation/devicetree/bindings/serial/mtk-uart.txt  add/add with our
own 32-bit branches, keep both sides.

----------------------------------------------------------------

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/64bit-for-linus

for you to fetch changes up to 0d2fdcd76504535bd1721ba9e8d4d03bcbb10afd:

  arm64: Kconfig: clean up two no-op Kconfig options from CONFIG_ARCH_TEGRA*

----------------------------------------------------------------

Abhilash Kesavan (2):
      arm64: dts: Add PMU DT node for exynos7 SoC
      arm64: dts: Add nodes for mmc, i2c, rtc, watchdog, adc on exynos7

Alim Akhtar (1):
      arm64: Enable ARMv8 based exynos7 SoC support

Bhupesh Sharma (2):
      arm64: Add DTS support for FSL's LS2085A SoC
      arm64: Add support for FSL's LS2085A SoC in Kconfig and defconfig

Eddie Huang (3):
      Document: DT: Add bindings for mediatek MT8173 SoC Platform
      arm64: dts: Add mediatek MT8173 SoC and evaluation board dts and Makefile
      arm64: mediatek: Add MT8173 SoC Kconfig and defconfig

Naveen Krishna Ch (2):
      arm64: dts: Add initial device tree support for exynos7
      arm64: dts: Add initial pinctrl support to exynos7

Olof Johansson (4):
      Merge tag 'samsung-dt-64' of git://git.kernel.org/.../kgene/linux-samsung into next/arm64
      Merge tag 'tegra-for-3.20-arm64' of git://git.kernel.org/.../tegra/linux into next/arm64
      Merge tag 'v3.20-next-arm64' of https://github.com/mbgg/linux-mediatek into next/arm64
      arm64: Fix sort of platform Kconfig entries

Paul Walmsley (2):
      arm64: Add Tegra132 support
      arm64: Kconfig: clean up two no-op Kconfig options from CONFIG_ARCH_TEGRA*

Thierry Reding (1):
      Merge branch 'for-3.20/soc' into for-3.20/arm64


 .../devicetree/bindings/arm/mediatek.txt        |   4 +
 .../bindings/arm/mediatek/mediatek,sysirq.txt   |   1 +
 .../devicetree/bindings/arm/samsung/pmu.txt     |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt     |   4 +-
 arch/arm64/Kconfig                              |  54 ++
 arch/arm64/boot/dts/Makefile                    |   3 +
 arch/arm64/boot/dts/exynos/Makefile             |   5 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |  84 +++
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 588 +++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         | 530 +++++++++++++++++
 arch/arm64/boot/dts/freescale/Makefile          |   5 +
 .../boot/dts/freescale/fsl-ls2085a-simu.dts     |  65 ++
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi  | 163 +++++
 arch/arm64/boot/dts/mediatek/Makefile           |   5 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts     |  38 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        | 168 ++++++
 arch/arm64/configs/defconfig                    |   3 +
 17 files changed, 1720 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/exynos/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/Makefile
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/Makefile
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173.dtsi
