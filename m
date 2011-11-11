From: b29396@freescale.com (Dong Aisheng)
Date: Sat, 12 Nov 2011 00:09:06 +0800
Subject: [PATCH 2/2] ARM: mx5: add __initconst for fec pdata
In-Reply-To: <1321027746-5906-1-git-send-email-b29396@freescale.com>
References: <1321027746-5906-1-git-send-email-b29396@freescale.com>
Message-ID: <1321027746-5906-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c  |    2 +-
 arch/arm/mach-mx5/board-mx53_loco.c |    2 +-
 arch/arm/mach-mx5/board-mx53_smd.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 6a3e616..bc3a636 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -106,7 +106,7 @@ static inline void mx53_evk_fec_reset(void)
 	gpio_set_value(MX53_EVK_FEC_PHY_RST, 1);
 }
 
-static struct fec_platform_data mx53_evk_fec_pdata = {
+static const struct fec_platform_data mx53_evk_fec_pdata __initconst = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 7149416..d269ef3 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -242,7 +242,7 @@ static inline void mx53_loco_fec_reset(void)
 	gpio_set_value(LOCO_FEC_PHY_RST, 1);
 }
 
-static struct fec_platform_data mx53_loco_fec_data = {
+static const struct fec_platform_data mx53_loco_fec_data __initconst = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index e64fd2c..6a1fe88 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -103,7 +103,7 @@ static inline void mx53_smd_fec_reset(void)
 	gpio_set_value(SMD_FEC_PHY_RST, 1);
 }
 
-static struct fec_platform_data mx53_smd_fec_data = {
+static const struct fec_platform_data mx53_smd_fec_data __initconst = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
-- 
1.7.0.4
