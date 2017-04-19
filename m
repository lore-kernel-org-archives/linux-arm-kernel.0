From: code@mmayer.net (Markus Mayer)
Date: Wed, 19 Apr 2017 15:50:40 -0700
Subject: [PATCH v2] soc: brcmstb: enable drivers for ARM64 and BMIPS
Message-ID: <20170419225040.71650-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

We enable the BRCMSTB SoC drivers not only for ARM, but also ARM64 and
BMIPS.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

I used (COMPILE_TEST & OF) as condition like Raspberry Pi, since we
have of_* calls in our code, too.

Changes since v1:
  - Add BMIPS
  - Add COMPILE_TEST

 drivers/soc/bcm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index a39b0d58ddd0..9463d6709909 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -11,7 +11,7 @@ config RASPBERRYPI_POWER
 
 config SOC_BRCMSTB
 	bool "Broadcom STB SoC drivers"
-	depends on ARM
+	depends on ARM || ARM64 || BMIPS_GENERIC || (COMPILE_TEST && OF)
 	select SOC_BUS
 	help
 	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
-- 
2.12.0
