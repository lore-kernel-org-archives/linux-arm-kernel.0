From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Thu,  8 Jun 2017 11:16:54 +0900
Subject: [PATCH 2/2] arm:omap2+: drop dependence on DEBUG_OMAP2PLUS_UART for
 DEBUG_UNCOMPRESS
In-Reply-To: <1496888232-30764-1-git-send-email-hoeun.ryu@gmail.com>
References: <1496888232-30764-1-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <1496888232-30764-2-git-send-email-hoeun.ryu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 With a patch 9a5151e1d1ba4df41bc4b8e8c0f17163247645ac, "arm:omap2+: put
omap_uart_phys/virt/lsr in .text section when ZIMAGE is true", the
dependence on DEBUG_OMAP2PLUS_UART for DEBUG_UNCOMPRESS can be dropped,
because all code of omap2+'s DEBUG_LL_INCLUDE file is in .text section when
it's included in the decompressor.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 arch/arm/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ba2cb63..52eb0bf 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1735,8 +1735,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 config DEBUG_UNCOMPRESS
 	bool
 	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
-	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
-		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
+	default y if DEBUG_LL && (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART
 	help
 	  This option influences the normal decompressor output for
-- 
2.7.4
