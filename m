From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Aug 2016 23:42:06 +0800
Subject: [PATCH 2/4] arm64: defconfig: Set cma heap size to 128MB
In-Reply-To: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
References: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1471621328-21102-3-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xinliang Liu <xinliang.liu@linaro.org>

For debian linux, cma heap is used to allocate graphic buffers.
The default size is 16 MB which is not enought.
So increase the size to 128 MB.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e27f086..c94f2fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -130,6 +130,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=128
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
-- 
1.9.1
