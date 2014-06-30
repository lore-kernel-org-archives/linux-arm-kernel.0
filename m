From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 30 Jun 2014 12:30:54 +0100
Subject: [PATCH v7 3/4] arm: Seperate DEBUG_UART_PHYS from DEBUG_LL on EP93XX
In-Reply-To: <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
References: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
 <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1404127855-30459-4-git-send-email-daniel.thompson@linaro.org>
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
index 11db37e..459c7f9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1114,7 +1114,8 @@ config DEBUG_UART_PHYS
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
-		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
+		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
+		ARCH_EP93XX
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
-- 
1.9.3
