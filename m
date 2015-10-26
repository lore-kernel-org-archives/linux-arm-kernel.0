From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 26 Oct 2015 11:48:16 +0800
Subject: [RFC PATCH] arm64: make Timer Interrupt Frequency selectable
Message-ID: <1445831296-7020-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It allows a selectable timer interrupt frequency of 100, 250, 300 and 1000 HZ.
We will get better performance when choose a suitable frequency in some scene.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..4a07d89 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -432,10 +432,7 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu.
 
 source kernel/Kconfig.preempt
-
-config HZ
-	int
-	default 100
+source kernel/Kconfig.hz
 
 config ARCH_HAS_HOLES_MEMORYMODEL
 	def_bool y if SPARSEMEM
-- 
1.7.12.4
