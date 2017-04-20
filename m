From: code@mmayer.net (Markus Mayer)
Date: Thu, 20 Apr 2017 09:55:48 -0700
Subject: [PATCH v3] soc: brcmstb: enable drivers for ARM64 and BMIPS
Message-ID: <20170420165548.21964-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

We enable the BRCMSTB SoC drivers not only for ARM, but also ARM64 and
BMIPS.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

Changes since v2:
  - It is not necessary to use (COMPILE_TEST && OF)

Changes since v1:
  - Add BMIPS
  - Add COMPILE_TEST



 drivers/soc/bcm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index a39b0d58ddd0..49f1e2a75d61 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -11,7 +11,7 @@ config RASPBERRYPI_POWER
 
 config SOC_BRCMSTB
 	bool "Broadcom STB SoC drivers"
-	depends on ARM
+	depends on ARM || ARM64 || BMIPS_GENERIC || COMPILE_TEST
 	select SOC_BUS
 	help
 	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
-- 
2.12.0
