From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Nov 2011 08:39:54 +0800
Subject: [PATCH] ARM: Update mach-types to fix mxs build breakage
Message-ID: <1321490394-4162-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry m28evk to fix the following mxs build breakage.

  CHK     include/generated/compile.h
  CC      arch/arm/mach-mxs/clock-mx28.o
arch/arm/mach-mxs/clock-mx28.c: In function 'clk_misc_init':
arch/arm/mach-mxs/clock-mx28.c:748: error: implicit declaration of
function 'machine_is_m28evk'
make[1]: *** [arch/arm/mach-mxs/clock-mx28.o] Error 1
make: *** [arch/arm/mach-mxs] Error 2

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/tools/mach-types |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 5bdeef9..ccbe16f 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -1123,5 +1123,6 @@ blissc			MACH_BLISSC		BLISSC			3491
 thales_adc		MACH_THALES_ADC		THALES_ADC		3492
 ubisys_p9d_evp		MACH_UBISYS_P9D_EVP	UBISYS_P9D_EVP		3493
 atdgp318		MACH_ATDGP318		ATDGP318		3494
+m28evk			MACH_M28EVK		M28EVK			3613
 smdk4212		MACH_SMDK4212		SMDK4212		3638
 smdk4412		MACH_SMDK4412		SMDK4412		3765
-- 
1.7.4.1
