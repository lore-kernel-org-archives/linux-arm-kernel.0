From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 2 Sep 2011 16:25:16 +0200
Subject: [PATCH v2 2/6] OMAP3: beagle-board: Use the omap_hwmod_name_get_dev
	API
In-Reply-To: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314973520-3585-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the multiple omap2_get_XXX_device APIs with the new
omap_hwmod_name_get_dev that uses the hwmod name to get the proper
device.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ce3234d..d2aafce 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -491,8 +491,8 @@ static void __init beagle_opp_init(void)
 	if (cpu_is_omap3630()) {
 		struct device *mpu_dev, *iva_dev;
 
-		mpu_dev = omap2_get_mpuss_device();
-		iva_dev = omap2_get_iva_device();
+		mpu_dev = omap_hwmod_name_get_dev("mpu");
+		iva_dev = omap_hwmod_name_get_dev("iva");
 
 		if (!mpu_dev || !iva_dev) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
-- 
1.7.0.4
