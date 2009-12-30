From: abhijitpagare@ti.com (Abhijit Pagare)
Date: Wed, 30 Dec 2009 21:38:17 +0530
Subject: [PATCH] ARM: OMAP4 clock domains : Add the missing Clock Domain
	Structure
Message-ID: <1262189297-22133-1-git-send-email-abhijitpagare@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the clock domains was missing from the auto-generated file.
It has been added here.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
Re-submitting with proper subject line.

Compiled and Boot Tested on OMAP4430 simulator, ES1 Chip & OMAP3430 SDP.
And also Compiled for OMAP2430 and OMAP2420

This patch has a dependency on the earlier set of OMAP4 clock-domain patches.

 arch/arm/mach-omap2/clockdomains.h     |    1 +
 arch/arm/mach-omap2/clockdomains44xx.h |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index f985e0a..6dc5ddc 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -461,6 +461,7 @@ static struct clockdomain *clockdomains_omap[] = {
 	&l4_secure_44xx_clkdm,
 	&l4_per_44xx_clkdm,
 	&abe_44xx_clkdm,
+	&l3_instr_44xx_clkdm,
 	&l3_init_44xx_clkdm,
 	&mpuss_44xx_clkdm,
 	&mpu0_44xx_clkdm,
diff --git a/arch/arm/mach-omap2/clockdomains44xx.h b/arch/arm/mach-omap2/clockdomains44xx.h
index 6fc55e4..438aaee 100644
--- a/arch/arm/mach-omap2/clockdomains44xx.h
+++ b/arch/arm/mach-omap2/clockdomains44xx.h
@@ -102,6 +102,14 @@ static struct clockdomain abe_44xx_clkdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+static struct clockdomain l3_instr_44xx_clkdm = {
+	.name		  = "l3_instr_clkdm",
+	.pwrdm		  = { .name = "core_pwrdm" },
+	.clkstctrl_reg	  = OMAP4430_CM_L3INSTR_CLKSTCTRL,
+	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static struct clockdomain l3_init_44xx_clkdm = {
 	.name		  = "l3_init_clkdm",
 	.pwrdm		  = { .name = "l3init_pwrdm" },
-- 
1.5.4.7
