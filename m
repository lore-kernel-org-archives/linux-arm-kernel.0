From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  8 Apr 2017 14:04:56 +0200
Subject: [PATCH 5/6] ARM: gemini: select ARM_AMBA
In-Reply-To: <20170408120457.22750-1-linus.walleij@linaro.org>
References: <20170408120457.22750-1-linus.walleij@linaro.org>
Message-ID: <20170408120457.22750-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This selects the ARM_AMBA PrimeCell bus for the Gemini so we can
use the PL08x DMA engine derivative FTDMAC020 through the
combined PL08x driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Vinod: this is just for context, this patch will be directed through
the ARM SoC tree once the rest is done.
---
 arch/arm/mach-gemini/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index eaae82637da3..2c5bc692bc59 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	depends on ARCH_MULTI_V4
+	select ARM_AMBA
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
 	select FARADAY_FTINTC010
 	select FTTMR010_TIMER
-- 
2.9.3
