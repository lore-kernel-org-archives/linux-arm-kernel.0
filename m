From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 24 Oct 2014 11:54:23 +0100
Subject: [PATCH v12 02/15] arm: iop32x: Enable DEBUG_LL_UART_8250
In-Reply-To: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1414148076-12685-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defconfig already enables DEBUG_LL and by default DEBUG_LL_UART_NONE
will be selected (but due to some back compatibility magic we eventually
need to remove it is not actually honoured). DEBUG_LL_UART_8250 is a much
saner default.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/configs/iop32x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index 4f2ec3a..c3058da 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -106,6 +106,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=y
-- 
1.9.3
