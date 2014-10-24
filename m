From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 24 Oct 2014 11:54:27 +0100
Subject: [PATCH v12 06/15] arm: mv78xx0: Enable DEBUG_LL_UART_8250
In-Reply-To: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1414148076-12685-7-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defconfig already enables DEBUG_LL and by default DEBUG_LL_UART_NONE
will be selected (but due to some back compatibility magic we eventually
need to remove it is not actually honoured). DEBUG_LL_UART_8250 is a much
saner default.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/configs/mv78xx0_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 0dae1c1..85d10d2 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -132,6 +132,7 @@ CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-- 
1.9.3
