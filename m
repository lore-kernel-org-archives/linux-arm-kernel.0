From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 27 Jan 2017 17:10:46 -0300
Subject: [PATCH] ARM: dts: exynos: Increase MFC left reserved memory region
 size
Message-ID: <1485547846-12778-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sizes of the MFC reserved memory regions for CMA are 16 MiB for the
left bank and 8 MiB for the right bank. But this isn't enough to decode
high resolution videos so increase the size for the left bank to 36 MiB
which is enough for 1080p (1920x1080).

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
index f78c14c82e17..25186ac4188d 100644
--- a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
+++ b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
@@ -17,7 +17,7 @@
 		mfc_left: region_mfc_left {
 			compatible = "shared-dma-pool";
 			no-map;
-			size = <0x1000000>;
+			size = <0x2400000>;
 			alignment = <0x100000>;
 		};
 
-- 
2.7.4
