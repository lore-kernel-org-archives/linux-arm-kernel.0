From: john.garry@huawei.com (John Garry)
Date: Tue, 30 Jan 2018 21:22:57 +0800
Subject: [PATCH] arm64: defconfig: enable IOSCHED_DEADLINE
Message-ID: <1517318577-56430-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For certain workloads the deadline IO scheduler offers
particular advantages over other schedulers and has shown
to perform better, so enable it.

The default IO scheduler is unaffected by this change, and
currently is CFQ.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..40c72e6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,7 +31,6 @@ CONFIG_PROFILING=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_BCM2835=y
-- 
1.9.1
