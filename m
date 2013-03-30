From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 30 Mar 2013 10:54:39 +0100
Subject: [PATCH] ARM: S5P64X0: Fix typo "CONFIG_S5P64X0_SETUP_SDHCI"
Message-ID: <1364637279.1345.115.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebc433c2890f8ecad2da39fe2dbf2b6e7b309afa ("ARM: S5P64X0: Add
HSMMC setup for host Controller") added the Kconfig symbol
S5P64X0_SETUP_SDHCI_GPIO. By accident it also used a macro
CONFIG_S5P64X0_SETUP_SDHCI. Fix that typo.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. Since this typo has been in the tree since v3.3, and some code
has therefore (basically) been compiled out ever since, this does need
testing.

 arch/arm/plat-samsung/include/plat/sdhci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 9b87f38..5560586 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -206,7 +206,7 @@ static inline void s3c6400_default_sdhci2(void) { }
 
 /* S5P64X0 SDHCI setup */
 
-#ifdef CONFIG_S5P64X0_SETUP_SDHCI
+#ifdef CONFIG_S5P64X0_SETUP_SDHCI_GPIO
 static inline void s5p64x0_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
@@ -241,7 +241,7 @@ static inline void s5p64x0_default_sdhci1(void) { }
 static inline void s5p6440_default_sdhci2(void) { }
 static inline void s5p6450_default_sdhci2(void) { }
 
-#endif /* CONFIG_S5P64X0_SETUP_SDHCI */
+#endif /* CONFIG_S5P64X0_SETUP_SDHCI_GPIO */
 
 /* S5PC100 SDHCI setup */
 
-- 
1.7.11.7
