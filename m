From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 27 May 2014 17:00:20 +0100
Subject: [PATCH v6 4/5] arm: Seperate DEBUG_UART_PHYS from DEBUG_LL on EP93XX
In-Reply-To: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
References: <1400857819-7975-1-git-send-email-daniel.thompson@linaro.org>
 <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1401206421-29832-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On EP93XX uncompress.h uses CONFIG_DEBUG_UART_PHYS instead of a hard
coded serial port. This means the build breaks when DEBUG_LL
(and DEBUG_LL_UART_PL01X) is not enabled.

This is fixed by adding a new dependancy.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 33f0b38..9a391f7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1058,7 +1058,8 @@ config DEBUG_UART_PHYS
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
+		ARCH_EP93XX
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
-- 
1.9.0
