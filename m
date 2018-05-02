From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed,  2 May 2018 23:31:40 +0200
Subject: [PATCH] arm64: defconfig: Increase CMA size for VC4
Message-ID: <1525296700-3588-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VC4 needs more memory than the default setting (16 MB):

  vc4-drm soc:gpu: swiotlb: coherent allocation failed, size=16777216
  [drm:vc4_bo_create [vc4]] *ERROR* Failed to allocate from CMA:
  vc4_v3d 3fc00000.v3d: Failed to allocate memory for tile binning: -12.
    You may need to enable CMA or give it more memory.
  vc4-drm soc:gpu: failed to bind 3fc00000.v3d (ops vc4_v3d_ops [vc4]): -12
  vc4-drm soc:gpu: master bind failed: -12
  vc4-drm: probe of soc:gpu failed with error -12

So increase the value to 32 MB and fix this issue.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---

Hi,
i known it's a little bit late for 4.18 or should i rebase for 4.17?

Regards

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7ca583e..0e1f6d7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -172,6 +172,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-- 
2.7.4
