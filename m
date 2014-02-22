From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Feb 2014 20:14:56 +0100
Subject: [PATCH v4 14/22] ARM: MM Enable building Feroceon L2 cache controller
 with ARCH_MVEBU
In-Reply-To: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
Message-ID: <1393096504-11844-15-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kirkwood, which uses the Feroceon L2 cache controller will soon be
moving into mach-mvebu. Allow the cache controller to be built in this
situation.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 1f8fed94c2a4..dccd7e177653 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -855,7 +855,7 @@ config OUTER_CACHE_SYNC
 
 config CACHE_FEROCEON_L2
 	bool "Enable the Feroceon L2 cache controller"
-	depends on ARCH_KIRKWOOD || ARCH_MV78XX0
+	depends on ARCH_KIRKWOOD || ARCH_MV78XX0 || ARCH_MVEBU
 	default y
 	select OUTER_CACHE
 	help
-- 
1.8.5.3
