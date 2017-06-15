From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 15 Jun 2017 16:21:17 -0700
Subject: [PATCH 3/3] misc: sram: Allow ARM64 to select SRAM_EXEC
In-Reply-To: <20170615232117.29727-1-f.fainelli@gmail.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
Message-ID: <20170615232117.29727-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ARM64 also has a fncpy() implementation, allow selection
SRAM_EXEC for ARM64 as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 07bbd4cc1852..ac8779278c0c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -464,7 +464,7 @@ config SRAM
 	bool "Generic on-chip SRAM driver"
 	depends on HAS_IOMEM
 	select GENERIC_ALLOCATOR
-	select SRAM_EXEC if ARM
+	select SRAM_EXEC if ARM || ARM64
 	help
 	  This driver allows you to declare a memory region to be managed by
 	  the genalloc API. It is supposed to be used for small on-chip SRAM
-- 
2.9.3
