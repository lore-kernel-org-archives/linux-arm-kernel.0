From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Thu, 17 Aug 2017 16:04:24 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK
Message-ID: <20170817140424.4614-1-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows to load firmware files which aren't built inside the kernel.

Especially useful for CODA firmware (vpu_fw_imx6q.bin) which is usually
located in the rootfs.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
Hi Shawn,

I'm not sure if this patch is acceptable since I've noticed that no
configuration currently has that option enabled (why?).

As mentioned in the commit, I had to enable that in order to have CODA
load the VPU firmware properly.

Another option would be to make the CODA driver a module...

Let me know your thoughts.

Regards,
Gary
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e74de69caeab..6f571d8b5a7e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -89,6 +89,7 @@ CONFIG_RFKILL_INPUT=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
+CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_IMX_WEIM=y
-- 
2.14.1
