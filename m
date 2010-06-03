From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 03 Jun 2010 19:09:54 +0900
Subject: [PATCH] S5PV210: Increase the VIC_NR as 4
Message-ID: <20100603100954.GA17434@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S5PV210 SoC have 4 VICs. It requires for suspend and resume.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

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
