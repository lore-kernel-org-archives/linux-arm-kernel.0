From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 27 Sep 2016 11:57:18 +0800
Subject: [PATCH -next] arm64: Kconfig: remove SMP dependence for NUMA
In-Reply-To: <1474875410-23016-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1474875410-23016-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1474948638-52271-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 forces CONFIG_SMP=y with commit 4b3dc9679cf7, no need to
add SMP dependence for NUMA.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4572f00..17c14a1d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -579,7 +579,6 @@ config HOTPLUG_CPU
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
-	depends on SMP
 	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	help
-- 
1.7.12.4
