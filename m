From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  5 Jan 2015 12:40:17 +0000
Subject: [PATCH 3.19-rc2 v15 1/8] arm: cnx3xxx: Remove spurious default for
 DEBUG_CNS3xxx
In-Reply-To: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
References: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1420461624-4410-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default value for DEBUG_CNS3xxx appears twice. This patch removes
the one with the wrong sort order.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ddd4906f7a7..c5648cc1466d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1269,7 +1269,6 @@ config DEBUG_UART_PHYS
 				DEBUG_S3C2410_UART2)
 	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x7c0003f8 if FOOTBRIDGE
-	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x80010000 if DEBUG_ASM9260_UART
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
-- 
1.9.3
