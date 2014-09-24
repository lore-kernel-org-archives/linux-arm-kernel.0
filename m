From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Sep 2014 17:17:41 +0900
Subject: [GIT PULL 1/2] Second Samsung DT updates for v3.18
Message-ID: <54227E25.2060903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin

Here is second bunch of Samsung DT updates for v3.18.

This is based on previous pull-request for tags/samsung-dt but not yet 
pulled into arm-soc.

Please pull and if any problems, kindly let me know.

Thanks,
Kukjin


The following changes since commit 9b02732643d9f4b92b14f5ec041c166bd36033fc:

   ARM: dts: remove old USB2 PHY node for exynos5250 (2014-09-14 
10:11:20 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt-2

for you to fetch changes up to 57901371c9914d5e5eeabf2870c35162837198d2:

   ARM: dts: add MFC codec device node for exynos3250 (2014-09-24 
01:33:23 +0900)

----------------------------------------------------------------
Second Samsung DT updates for v3.18

- add new exynos5250-spring DT
- cleanup exynos5250-arndale, smdk5250 and snow DT

- exynos Peach boards (exynos5420-peach-pit and exynos5800-peach-pi)
   correct mmc0 capability string

- exynos5250-arndale: fix apparent GPIO typo and simplify USB3503
- exynos5250-snow and exynos Peach boards: add rtc_src clock for RTC

- exynos4x12-pinctrl: add utility macro to define pin sleep states
- exynos4412-trats2: add Maxim77693 PMIC node, add sleep mode pin
   configuration and keep eMMC regulators soft-disabled

- exynos3250: add MFC codec nodes

- s3c64xx: enable PWM node by default

----------------------------------------------------------------
Andreas Faerber (8):
       ARM: dts: Prepare node labels for exynos5250
       ARM: dts: Clean up exynos5250-snow
       ARM: dts: Fill in bootargs for exynos5250-snow
       ARM: dts: Clean up exynos5250-smdk5250
       ARM: dts: Clean up exynos5250-arndale
       ARM: dts: Fix apparent GPIO typo in exynos5250-arndale
       ARM: dts: Simplify USB3503 on exynos5250-arndale
       ARM: dts: Add exynos5250-spring device tree

Jacek Anaszewski (1):
       ARM: dts: add MFC codec device node for exynos3250

Javier Martinez Canillas (2):
       ARM: dts: Add rtc_src clk for s3c-rtc on exynos Peach boards
       ARM: dts: Add rtc_src clk for s3c-rtc on exynos5250-snow

Krzysztof Kozlowski (1):
       ARM: dts: Add Maxim 77693 PMIC to exynos4412-trats2

Naveen Krishna Chatradhi (1):
       ARM: dts: correct the mmc0 capability string for exynos Peach boards

Tomasz Figa (4):
       ARM: dts: Enable PWM node by default for s3c64xx
       ARM: dts: Keep eMMC regulators soft-disabled for exynos4412-trats2
       ARM: dts: Add utility macro to define pin sleep states for 
exynos4x12-pinctrl
       ARM: dts: Add sleep mode pin configuration for exynos4412-trats2

  arch/arm/boot/dts/Makefile                 |   1 +
  arch/arm/boot/dts/exynos3250.dtsi          |  10 +
  arch/arm/boot/dts/exynos4412-trats2.dts    | 352 ++++++++++-
  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi  |  16 +
  arch/arm/boot/dts/exynos5250-arndale.dts   | 907 
++++++++++++++---------------
  arch/arm/boot/dts/exynos5250-smdk5250.dts  | 618 ++++++++++----------
  arch/arm/boot/dts/exynos5250-snow.dts      | 280 ++++-----
  arch/arm/boot/dts/exynos5250-spring.dts    | 536 +++++++++++++++++
  arch/arm/boot/dts/exynos5250.dtsi          |  16 +-
  arch/arm/boot/dts/exynos5420-peach-pit.dts |   7 +-
  arch/arm/boot/dts/exynos5800-peach-pi.dts  |   7 +-
  arch/arm/boot/dts/s3c6410-mini6410.dts     |   4 -
  arch/arm/boot/dts/s3c64xx.dtsi             |   1 -
  13 files changed, 1842 insertions(+), 913 deletions(-)
  create mode 100644 arch/arm/boot/dts/exynos5250-spring.dts
