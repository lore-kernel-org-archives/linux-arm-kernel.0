From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 30 Aug 2016 17:25:54 +0930
Subject: [PATCH v3 1/7] mach-aspeed: Select pinctrl drivers
In-Reply-To: <20160830075600.11559-1-andrew@aj.id.au>
References: <20160830075600.11559-1-andrew@aj.id.au>
Message-ID: <20160830075600.11559-2-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/mach-aspeed/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 5225fbcb250d..f3f8c5c658db 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -5,6 +5,8 @@ menuconfig ARCH_ASPEED
 	select WATCHDOG
 	select ASPEED_WATCHDOG
 	select MOXART_TIMER
+	select MFD_SYSCON
+	select PINCTRL
 	help
 	  Say Y here if you want to run your kernel on an ASpeed BMC SoC.
 
@@ -14,6 +16,7 @@ config MACH_ASPEED_G4
 	bool "Aspeed SoC 4th Generation"
 	depends on ARCH_MULTI_V5
 	select CPU_ARM926T
+	select PINCTRL_ASPEED_G4
 	help
 	 Say yes if you intend to run on an Aspeed ast2400 or similar
 	 fourth generation BMCs, such as those used by OpenPower Power8
@@ -23,6 +26,7 @@ config MACH_ASPEED_G5
 	bool "Aspeed SoC 5th Generation"
 	depends on ARCH_MULTI_V6
 	select CPU_V6
+	select PINCTRL_ASPEED_G5
 	help
 	 Say yes if you intend to run on an Aspeed ast2500 or similar
 	 fifth generation Aspeed BMCs.
-- 
2.9.3.1.g0db844e
