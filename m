From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 11 Feb 2014 14:21:59 -0600
Subject: [PATCH] drm/msm: drop ARCH_MSM Kconfig depend
Message-ID: <1392150119-21132-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_MSM depend is redundant with ARCH_MSM8960, so we can remove it.
Additionally, we are splitting Qualcomm MSM support into legacy (ARCH_MSM)
and multiplatform (ARCH_QCOM).  The MSM8960 with be ARCH_QCOM going forward
so dropping ARCH_MSM will work properly for the new ARCH_QCOM multiplatform
build.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
David/Rob,

If you can ack this I'll send it via linux-qcom/arm-soc tree's

thanks

- k
 drivers/gpu/drm/msm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index c69d1e0..b698497 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -3,7 +3,7 @@ config DRM_MSM
 	tristate "MSM DRM"
 	depends on DRM
 	depends on MSM_IOMMU
-	depends on (ARCH_MSM && ARCH_MSM8960) || (ARM && COMPILE_TEST)
+	depends on ARCH_MSM8960 || (ARM && COMPILE_TEST)
 	select DRM_KMS_HELPER
 	select SHMEM
 	select TMPFS
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
