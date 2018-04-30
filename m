From: john.garry@huawei.com (John Garry)
Date: Mon, 30 Apr 2018 23:15:40 +0800
Subject: [PATCH 1/3] arm64: defconfig: Enable HISILICON_LPC
In-Reply-To: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
References: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
Message-ID: <1525101342-27120-2-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the driver has been merged for the HiSilicon
LPC host, enable the relevant config.

Turning on this config will also enable config
INDIRECT_PIO, which would have not been enabled
previously - see config info for more details.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0d8ae1d..c959bc8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -171,6 +171,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
+CONFIG_HISILICON_LPC=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-- 
1.9.1
