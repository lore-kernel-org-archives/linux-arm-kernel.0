From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Wed, 30 May 2018 15:19:56 +0200
Subject: [PATCH v2 2/2] ARM: debug: fix BCM2836 order entry
In-Reply-To: <20180530131956.13972-1-peron.clem@gmail.com>
References: <20180530131956.13972-1-peron.clem@gmail.com>
Message-ID: <20180530131956.13972-2-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cl?ment Peron <clement.peron@devialet.com>

Entries are sorted by their address value, except the BCM2836/KONA
which are not in the proper order.

Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 4ea9d5793b91..1571d6c8f40e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1572,8 +1572,8 @@ config DEBUG_UART_PHYS
 	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0x20201000 if DEBUG_BCM2835
-	default 0x3f201000 if DEBUG_BCM2836
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
+	default 0x3f201000 if DEBUG_BCM2836
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
-- 
2.17.0
