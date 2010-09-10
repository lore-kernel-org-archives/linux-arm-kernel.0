From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Sep 2010 21:03:12 +0900
Subject: [PATCH 1/2] ARM: Update number of VIC for S5PV210
In-Reply-To: <1284120193-23291-1-git-send-email-kgene.kim@samsung.com>
References: <1284120193-23291-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1284120193-23291-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

S5PV210 SoC have 4 VICs. It requires for suspend and resume.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 arch/arm/common/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 0a34c81..0ac3d81 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -6,6 +6,7 @@ config ARM_VIC
 
 config ARM_VIC_NR
 	int
+	default 4 if ARCH_S5PV210
 	default 2
 	depends on ARM_VIC
 	help
-- 
1.6.2.5
