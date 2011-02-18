From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 18 Feb 2011 20:26:30 +0800
Subject: [PATCH v2 1/1] ARM: imx53: correct Silicon Revision definition
	following fuse map
Message-ID: <1298031990-4521-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index d40671d..df46b5e 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -78,11 +78,16 @@ static int get_mx53_srev(void)
 	void __iomem *iim_base = MX51_IO_ADDRESS(MX53_IIM_BASE_ADDR);
 	u32 rev = readl(iim_base + IIM_SREV) & 0xff;
 
-	if (rev == 0x0)
+	switch (rev) {
+	case 0x0:
 		return IMX_CHIP_REVISION_1_0;
-	else if (rev == 0x10)
+	case 0x2:
 		return IMX_CHIP_REVISION_2_0;
-	return 0;
+	case 0x3:
+		return IMX_CHIP_REVISION_2_1;
+	default:
+		return IMX_CHIP_REVISION_UNKNOWN;
+	}
 }
 
 /*
-- 
1.7.1
