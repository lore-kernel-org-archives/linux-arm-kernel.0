From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 22 Sep 2012 14:07:56 +0100
Subject: [PATCH v2] ARM: pxa2xx: Remove EXPERIMENTAL dependency from spi-pxa2xx
 driver
Message-ID: <505DB82C.5030205@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI_PXA2XX config option has had an EXPERIMENTAL dependency since it
was first added in 2006. Since there seem to have been no changes to the
spi-pxa2xx driver since February 2011 other than tree sweeps, this patch
removes the EXPERIMENTAL dependency in the expectation that the
spi-pxa2xx driver is now stable.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V2: Removed excess parentheses.

The motivation for this patch was to remove the EXPERIMENTAL option from
the hx4700 platform config: SPI_PXA2XX is the only option which is still
EXPERIMENTAL.

  drivers/spi/Kconfig |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5f84b55..d49b836 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -284,7 +284,7 @@ config SPI_PPC4xx

  config SPI_PXA2XX
  	tristate "PXA2xx SSP SPI master"
-	depends on (ARCH_PXA || (X86_32 && PCI)) && EXPERIMENTAL
+	depends on ARCH_PXA || (X86_32 && PCI)
  	select PXA_SSP if ARCH_PXA
  	help
  	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
-- 
1.7.8.6
