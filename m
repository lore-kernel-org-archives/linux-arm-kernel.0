From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 29 Dec 2015 15:03:17 +0900
Subject: [GIT PULL] ARM: EXYNOS: dts: DeviceTree for v4.5, 2nd try
In-Reply-To: <20151222045221.GH30172@localhost>
References: <20151222045221.GH30172@localhost>
Message-ID: <1451368997-16809-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


This is an updated pull request, without the Exynos5410 DTS pinctrl
changes.

I am still not sure why they have to be acked separately but I do not
want to hold on the changes because of this. However if the pinctrl
commit is okay, then please pull tag 'tags/samsung-dt-4.5' instead.


This contains the dependency: SSS clock for Exynos4, acked by Stephen
Boyd (tag: 'samsung-clk-exynos4-4.5').


Best regards,
Krzysztof

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.5-2

for you to fetch changes up to bf0dda345b0ee1af287f043857fc34ecfa206293:

  ARM: dts: Unify G2D device node with other devices on exynos4 (2015-12-29 09:07:44 +0900)

----------------------------------------------------------------
Samsung DeviceTree updates and improvements for 4.5
1. eMMC/SDIO minor fixes usage of bindings on Snow and Peach
   Chromebooks.
2. Remove FIMD from Odroid XU3-family because on XU3 it cannot be used
   yet and on XU3-Lite and XU4 it is not supported.
3. Remove deprecated since June 2013 samsung,exynos5-hdmi.
4. Add support for Pseudo Random Generator on Exynos4 (Trats2 for now).
   This depends on new SSS clock.
5. Add rotator nodes for Exynos4 and Exynos5.
6. Switch DWC3_1 on Odroid XU3 and XU3-Lite to peripheral mode because
   now it cannot be used as OTG.
7. Cleanup the G2D usage on Exynos4 and add it to a proper domain
   in case of Exynos4210.
8. Put MDMA1 in proper domain on Exynos4210 as well.
9. Minor cleanups.

----------------------------------------------------------------
Andrzej Hajda (1):
      dt-bindings: remove deprecated compatible string from exynos-hdmi

Javier Martinez Canillas (7):
      ARM: dts: Mark SDIO as non-removable in exynos5800-peach-pi
      ARM: dts: Mark SDIO as non-removable in exynos5420-peach-pit
      ARM: dts: Mark SDIO as non-removable in exynos5250-snow-common
      ARM: dts: Remove broken-cd from eMMC node in exynos5800-peach-pi
      ARM: dts: Remove broken-cd from eMMC node in exynos5420-peach-pi
      ARM: dts: Mark eMMC as non-removable in exynos5250-snow-common
      ARM: dts: Remove unneeded GPIO include in exynos4412-odroidu3

Krzysztof Kozlowski (4):
      clk: samsung: exynos4: Add SSS gate clock
      Merge tag 'samsung-clk-exynos4-4.5' into next/dt
      ARM: dts: Add PRNG module for exynos4
      ARM: dts: Enable PRNG module on exynos4412-trats2

Marek Szyprowski (10):
      ARM: dts: Remove fimd node from exynos5422-odroidxu3-common
      ARM: dts: Add rotator nodes on exynos4
      ARM: dts: Fix power domain for sysmmu-rotator device on exynos4
      ARM: dts: Add rotator node on exynos5250
      ARM: dts: Add rotator node on exynos5420
      ARM: dts: Use peripheral mode for dwc3_1 on exynos5422-odroidxu3
      ARM: dts: exynos4210-universal_c210: Disable DMA for UARTs
      ARM: dts: MDMA1 device belongs to LCD0 power domain on exynos4210
      ARM: dts: Add power domain to G2D device on exynos4210
      ARM: dts: Unify G2D device node with other devices on exynos4

 .../bindings/display/exynos/exynos_hdmi.txt           |  7 +++----
 arch/arm/boot/dts/exynos4.dtsi                        | 18 +++++++++++++++++-
 arch/arm/boot/dts/exynos4210-origen.dts               |  4 ----
 arch/arm/boot/dts/exynos4210-smdkv310.dts             |  4 ----
 arch/arm/boot/dts/exynos4210-universal_c210.dts       |  8 ++++++++
 arch/arm/boot/dts/exynos4210.dtsi                     | 14 +++++++++++++-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi       |  4 ----
 arch/arm/boot/dts/exynos4412-odroidu3.dts             |  1 -
 arch/arm/boot/dts/exynos4412-origen.dts               |  4 ----
 arch/arm/boot/dts/exynos4412-smdk4412.dts             |  4 ----
 arch/arm/boot/dts/exynos4412-trats2.dts               |  4 ++++
 arch/arm/boot/dts/exynos4x12.dtsi                     |  5 ++++-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi         |  6 ++----
 arch/arm/boot/dts/exynos5250.dtsi                     |  9 +++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts            |  5 +----
 arch/arm/boot/dts/exynos5420.dtsi                     | 19 +++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi    |  5 -----
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts       |  2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts            |  2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts             |  5 +----
 drivers/clk/samsung/clk-exynos4.c                     |  1 +
 include/dt-bindings/clock/exynos4.h                   |  1 +
 22 files changed, 85 insertions(+), 47 deletions(-)
