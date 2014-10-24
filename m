From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 24 Oct 2014 11:54:26 +0100
Subject: [PATCH v12 05/15] arm: lpc32xx: Enable DEBUG_LL_UART_8250
In-Reply-To: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1414148076-12685-6-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defconfig already enables DEBUG_LL and by default DEBUG_LL_UART_NONE
will be selected (but due to some back compatibility magic we eventually
need to remove it is not actually honoured). DEBUG_LL_UART_8250 is a much
saner default.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/configs/lpc32xx_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 9f56ca3..c100b7d 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -204,6 +204,7 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
 CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 # CONFIG_CRYPTO_HW is not set
-- 
1.9.3
