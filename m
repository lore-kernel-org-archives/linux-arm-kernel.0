From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 19:15:47 +0100
Subject: [PATCH v2 0/6] Add multiple GPIO and external clock to MMC
 pwrseq_simple
Message-ID: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

Many WLAN chips attached to an SDIO interface needs more than one GPIO
for their reset sequence and also an external clock to be operational.

Since this is very common, this series extend the simple MMC power sequence
to support more than one reset GPIO and also an optional external clock.

This is the second version of the series that addressed issues pointed out
by Arend van Spriel and Srinivas Kandagatla.

The series depend on v4 "mmc: core: Add support for MMC power sequences":

http://comments.gmane.org/gmane.linux.kernel.mmc/30665

Javier Martinez Canillas (6):
  mmc: pwrseq: Document that simple sequence support more than one GPIO
  mmc: pwrseq_simple: Extend to support more pins
  mmc: pwrseq: Document optional clock for the simple power sequence
  mmc: pwrseq_simple: Add optional reference clock support
  ARM: dts: exynos5250-snow: Enable wifi power-on
  ARM: dts: exynos5250-snow: Add cap-sdio-irq to wifi mmc node

 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  | 11 ++-
 arch/arm/boot/dts/exynos5250-snow.dts              | 26 ++++++-
 drivers/mmc/core/pwrseq_simple.c                   | 85 ++++++++++++++++++----
 3 files changed, 103 insertions(+), 19 deletions(-)

Patch #1 extends the simple MMC power sequence DT binding to support more
than one GPIO and patch #2 adds the actual implementation.

In the same way, patch #3 and #4 extend the simple MMC power sequence DT
binding and pwrseq_simple driver to support an optional external clock.

Finally as an example, patch #5 and patch #6 adds support for the wifi
chip in the Exynos5250 Snow that needs all these resources. These two
patches were added to the series only for completeness.

Best regards,
Javier
