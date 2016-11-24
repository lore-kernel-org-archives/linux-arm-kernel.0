From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 24 Nov 2016 08:08:28 +0200
Subject: [GIT PULL 2/3] ARM: dts: exynos: DT for v4.10, second round
In-Reply-To: <1479967709-6619-1-git-send-email-krzk@kernel.org>
References: <1479967709-6619-1-git-send-email-krzk@kernel.org>
Message-ID: <1479967709-6619-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull/tag.

Possible trivial conflict:
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@@ -197,10 -188,10 +197,10 @@@
        };
  
        gmac: ethernet at 00230000 {
-               compatible = "snps,dwmac-3.70a";
+               compatible = "snps,dwmac-3.70a", "snps,dwmac";
                reg = <0x00230000 0x8000>;
                interrupt-parent = <&gic>;
 -              interrupts = <0 31 4>;
 +              interrupts = <GIC_SPI 31 4>;
                interrupt-names = "macirq";
                phy-mode = "sgmii";
                clocks = <&clock CLK_GMAC0>;


Best regards,
Krzysztof


The following changes since commit 05a3589f46f913fbe91704f12fdca46a0eb0a27b:

  ARM: dts: exynos: Add SCU device node to exynos4.dtsi (2016-11-05 17:39:50 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.10-2

for you to fetch changes up to 79700041b37f0aca5da3ea27858ad6c42f99a474:

  ARM: dts: exynos: Remove the cd-gpios property for eMMC of Odroid XU3/4 (2016-11-23 19:17:11 +0200)

----------------------------------------------------------------
Samsung DeviceTree second update for v4.10:
1. Cleanups in MSHC nodes.
2. Enable ADC on Odroid boards.
3. Fix interrupt flags on recently added DMA sound nodes in Exynos5410.

----------------------------------------------------------------
Jaehoon Chung (2):
      ARM: dts: exynos: Replace "clock-freq-min-max" with "max-frequency"
      ARM: dts: exynos: Remove the cd-gpios property for eMMC of Odroid XU3/4

Krzysztof Kozlowski (1):
      ARM: dts: exynos: Fix invalid GIC interrupt flags in audio block of Exynos5410

Markus Reichl (1):
      ARM: dts: exynos: Add ADCs on 4412 and 5422 based odroid boards.

Niklas Cassel (1):
      ARM: dts: exynos: Specify snps, dwmac in compatible string for gmac

 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |  2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |  2 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |  2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  5 +++++
 arch/arm/boot/dts/exynos5410.dtsi                  |  4 ++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 12 +++++++++++-
 arch/arm/boot/dts/exynos5440.dtsi                  |  2 +-
 8 files changed, 23 insertions(+), 8 deletions(-)
