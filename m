From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 24 Oct 2014 11:54:22 +0100
Subject: [PATCH v12 01/15] arm: cnx3xxxx: Remove spurious default for
 DEBUG_CNS3XXX
In-Reply-To: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1414148076-12685-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default value for DEBUG_CNS3XXX appears twice. This patch removes
the one with the wrong sort order.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 03dc4c1..295428d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1134,7 +1134,6 @@ config DEBUG_UART_PHYS
 				DEBUG_S3C2410_UART2)
 	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x7c0003f8 if FOOTBRIDGE
-	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
 	default 0x80230000 if DEBUG_PICOXCELL_UART
-- 
1.9.3
