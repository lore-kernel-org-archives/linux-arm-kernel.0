From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri,  4 Dec 2009 04:47:04 +0200
Subject: [RFC][PATCH 04/10] arm: mxc: Fix Drive Strength Field in the IOMUX
	controller
In-Reply-To: <58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<e99e70e2a619693064130a747b6ee3a93273337b.1259893118.git.amit.kucheria@canonical.com>
	<6608c4dca645d87efce78ae0b7dbad265004f482.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <a079a0627e77f2df590840e4798fc067f4436160.1259893118.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX51 defines 4 values:

00: Low Drive Strength
01: Medium Drive Strength
10: High Drive Strength
11: Max Drive Strength

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/plat-mxc/include/mach/iomux-v3.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index a0fa402..8c351d6 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -81,11 +81,13 @@ struct pad_desc {
 
 #define PAD_CTL_ODE			(1 << 3)
 
-#define PAD_CTL_DSE_STANDARD		(0 << 1)
-#define PAD_CTL_DSE_HIGH		(1 << 1)
-#define PAD_CTL_DSE_MAX			(2 << 1)
+#define PAD_CTL_DSE_LOW			(0 << 1)
+#define PAD_CTL_DSE_MED			(1 << 1)
+#define PAD_CTL_DSE_HIGH		(2 << 1)
+#define PAD_CTL_DSE_MAX			(3 << 1)
 
 #define PAD_CTL_SRE_FAST		(1 << 0)
+#define PAD_CTL_SRE_SLOW		(0 << 0)
 
 /*
  * setups a single pad:
-- 
1.6.3.3
