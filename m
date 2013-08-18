From: robherring2@gmail.com (Rob Herring)
Date: Sat, 17 Aug 2013 19:12:28 -0500
Subject: [PATCH v2] ARM: highbank: fix debug uart virtual address for LPAE
Message-ID: <1376784748-31914-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Section entries are 2MB on LPAE, so the DEBUG_LL virtual address must
have the same offset in the 2MB section as the physical address. This
fixes async external aborts when DEBUG_LL is enabled on Midway.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
v2: Rebase on Russell's DEBUG_LL clean-up

 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 2d57da3..2a88a4d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1005,7 +1005,7 @@ config DEBUG_UART_VIRT
 	default 0xfee003f8 if FOOTBRIDGE
 	default 0xfee08300 if DEBUG_DAVINCI_TNETV107X_UART1
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
-	default 0xfee36000 if DEBUG_HIGHBANK_UART
+	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfee82340 if ARCH_IOP13XX
 	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
-- 
1.8.1.2
