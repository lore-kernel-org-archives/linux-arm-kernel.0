From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 19 Aug 2014 16:16:46 +0100
Subject: [PATCH v9 8/9] arm: Seperate DEBUG_UART_PHYS from DEBUG_LL on EP93XX
In-Reply-To: <1408461407-10429-1-git-send-email-daniel.thompson@linaro.org>
References: <1408459715-10151-1-git-send-email-daniel.thompson@linaro.org>
 <1408461407-10429-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1408461407-10429-9-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On EP93XX uncompress.h uses CONFIG_DEBUG_UART_PHYS instead of a hard
coded serial port. This means the build breaks when DEBUG_LL
(and DEBUG_LL_UART_PL01X) is not enabled.

This is fixed by adding a new dependancy.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 227ae88..f92b98f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1219,7 +1219,8 @@ config DEBUG_UART_PHYS
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
 		DEBUG_MSM_UART || DEBUG_NETX_UART || DEBUG_QCOM_UARTDM || \
-		DEBUG_S3C24XX_UART || DEBUG_SA1100_UART
+		DEBUG_S3C24XX_UART || DEBUG_SA1100_UART || \
+		ARCH_EP93XX
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
-- 
1.9.3
