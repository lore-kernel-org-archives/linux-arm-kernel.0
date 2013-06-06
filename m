From: matt.porter@linaro.org (Matt Porter)
Date: Thu,  6 Jun 2013 01:41:33 -0400
Subject: [PATCH 0/2] ARM dts: bcm281xx: use preprocessor for device trees
Message-ID: <1370497295-12682-1-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series follows the same approach as taken on Tegra and
OMAP DT files to use the C preprocessor in order to improve
readability. Since bcm281xx does not yet have gpio and pinctrl
support, this series just enables the C preprocessor and removes
the magic constants from existing irq properties. Any new
additions can come in using human readable definitions.

The resulting dtb was diff-tested to validate it versus the non
preprocessed dts version.

Matt Porter (2):
  ARM: dts: bcm281xx: use #include for device tree files
  ARM: dts: bcm281xx: use existing defines for irqs

 arch/arm/boot/dts/bcm11351-brt.dts |    2 +-
 arch/arm/boot/dts/bcm11351.dtsi    |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.7.9.5
