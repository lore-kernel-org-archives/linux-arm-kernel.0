From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 21 Mar 2016 11:01:38 -0500
Subject: [PATCHv3 1/9] EDAC: Altera L2 Kconfig change from select to depends
 upon.
In-Reply-To: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1458576106-24505-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Force L2 cache dependency instead of forcing selection of
L2 cache.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2/3 No change
---
 drivers/edac/Kconfig |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 37755e6..6ca7474 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -378,12 +378,11 @@ config EDAC_ALTERA
 
 config EDAC_ALTERA_L2C
 	bool "Altera L2 Cache ECC"
-	depends on EDAC_ALTERA=y
-	select CACHE_L2X0
+	depends on EDAC_ALTERA=y && CACHE_L2X0
 	help
 	  Support for error detection and correction on the
 	  Altera L2 cache Memory for Altera SoCs. This option
-	  requires L2 cache so it will force that selection.
+	  requires L2 cache.
 
 config EDAC_ALTERA_OCRAM
 	bool "Altera On-Chip RAM ECC"
-- 
1.7.9.5
