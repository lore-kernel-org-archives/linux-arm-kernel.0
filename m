From: s-anna@ti.com (Suman Anna)
Date: Thu, 13 Feb 2014 12:15:40 -0600
Subject: [PATCHv2 09/16] ARM: OMAP2+: change the ISP device archdata MMU name
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Message-ID: <1392315347-32967-10-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMMU DT adaptation support uses the device name instead
of an iommu object name. The iommu object names should eventually
vanish when all the IOMMU users have been converted to DT nodes.

NOTE: This change is not compatible with legacy boots, but OMAP3
is expected to be DT-boot only going forward.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 0dd6398..3bf0452 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -224,7 +224,7 @@ static struct platform_device omap3isp_device = {
 };
 
 static struct omap_iommu_arch_data omap3_isp_iommu = {
-	.name = "mmu_isp",
+	.name = "480bd400.mmu",
 };
 
 int omap3_init_camera(struct isp_platform_data *pdata)
-- 
1.8.5.3
