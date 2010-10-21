From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 21 Oct 2010 18:54:32 -0000
Subject: [PATCH 1/4] ARM: SAMSUNG: make SAMSUNG_PM_DEBUG select DEBUG_LL
In-Reply-To: <cover.1287681256.git.mcuelenaere@gmail.com>
References: <cover.1287681256.git.mcuelenaere@gmail.com>
Message-ID: <abb98ea05ee7deeffcf69e5f0980a397c8a6b56e.1287681256.git.mcuelenaere@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When selecting SAMSUNG_PM_DEBUG, it complains about a missing printascii()
function if you do not select DEBUG_LL, so make the former select the latter.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-samsung/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 7c0bde7..d5816e7 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -260,6 +260,7 @@ comment "Power management"
 config SAMSUNG_PM_DEBUG
 	bool "S3C2410 PM Suspend debug"
 	depends on PM
+	select DEBUG_LL
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
 	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
-- 
1.7.2.3
