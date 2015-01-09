From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 8 Jan 2015 20:53:54 -0600
Subject: [PATCHv6 3/5] edac: altera: Remove SDRAM module compile
In-Reply-To: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
References: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1420772036-3112-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

The SDRAM EDAC requires SDRAM configuration/initialization before
SDRAM is accessed (in the preloader). Having a module compile is
not desired so force to be built into kernel.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v3: Added in this version as a separate patch.

v4-6: No change.
---
 drivers/edac/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 49c2652..4d7285e 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -377,8 +377,8 @@ config EDAC_OCTEON_PCI
 	  Cavium Octeon family of SOCs.
 
 config EDAC_ALTERA_MC
-	tristate "Altera SDRAM Memory Controller EDAC"
-	depends on EDAC_MM_EDAC && ARCH_SOCFPGA
+	bool "Altera SDRAM Memory Controller EDAC"
+	depends on EDAC_MM_EDAC=y && ARCH_SOCFPGA
 	help
 	  Support for error detection and correction on the
 	  Altera SDRAM memory controller. Note that the
-- 
1.7.9.5
