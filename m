From: manjeet.p@samsung.com (Manjeet Pawar)
Date: Thu, 23 Jun 2016 17:57:06 +0530
Subject: [PATCH] arm:swiotlb:keep disabled in default configuration
Message-ID: <1466684826-26682-1-git-send-email-manjeet.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Thapliyal <r.thapliyal@samsung.com>

swiotlb implementation not required to be enabled in arm and
disabling it reduces uImage size by 16KB.

Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
Signed-off-by: Ajeet Kumar Yadav <ajeet.y@samsung.com>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90542db..ae65f29 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1754,7 +1754,7 @@ config SECCOMP
 	  defined by each seccomp mode.
 
 config SWIOTLB
-	def_bool y
+	def_bool n
 
 config IOMMU_HELPER
 	def_bool SWIOTLB
-- 
1.7.9.5
