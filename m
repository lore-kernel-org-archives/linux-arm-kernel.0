From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 13 Aug 2010 20:09:48 +0900
Subject: [PATCH] ARM: Update number of VIC
Message-ID: <1281697788-18018-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the number of VIC to handle the 3 or 4 VICs of
the S5PV210, S5P6442 and S5PC100.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 arch/arm/common/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 0a34c81..b7c76a9 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -6,8 +6,10 @@ config ARM_VIC
 
 config ARM_VIC_NR
 	int
-	default 2
 	depends on ARM_VIC
+	default 4 if ARCH_S5PV210
+	default 3 if ARCH_S5P6442 || ARCH_S5PC100
+	default 2
 	help
 	  The maximum number of VICs available in the system, for
 	  power management.
-- 
1.6.2.5
