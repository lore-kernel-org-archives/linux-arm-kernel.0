From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue,  2 Feb 2010 21:16:25 -0800
Subject: [PATCHv2 03/11] mxc: Fix Drive Strength Field in the IOMUX controller
In-Reply-To: <9fa7a3c70c46a1f776c6520051481cff6525ef02.1265173480.git.amit.kucheria@canonical.com>
References: <cover.1265173246.git.amit.kucheria@verdurent.com>
	<0511204199ab83aed2340e70a4639500c0528dab.1265173480.git.amit.kucheria@canonical.com>
	<9fa7a3c70c46a1f776c6520051481cff6525ef02.1265173480.git.amit.kucheria@canonical.com>
Message-ID: <ccc89dd7a6035abf5a78680404a2b30b9e025353.1265173480.git.amit.kucheria@canonical.com>
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
index 1deda01..f2f73d3 100644
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
  * setups a single pad in the iomuxer
-- 
1.6.3.3
