From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:12:43 +0100
Subject: [Patch v3 12/23] ARM: Fix default CPU selection for ARCH_MULTI_V5
In-Reply-To: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392819174-11634-13-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_ARM926T should be selected if no other CPU is. Put the ! in the
right place so this works.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e25419817791..beba369d74de 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -898,7 +898,7 @@ config ARCH_MULTI_V5
 	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
-	select CPU_ARM926T if (!CPU_ARM946E || CPU_ARM1020 || \
+	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
 		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
 		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
 
-- 
1.8.5.3
