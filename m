From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 21 Jun 2016 14:55:23 +0800
Subject: [PATCH] arm64: Add support ARCH_SUPPORTS_INT128
Message-ID: <1466492123-3356-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gcc support __SIZEOF_INT128__ and __int128 in arm64, thus,
enable ARCH_SUPPORTS_INT128 to make mul_u64_u32_shr() a bit
more efficient in scheduler.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a0a691..ab319eb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -11,6 +11,7 @@ config ARM64
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
-- 
1.7.12.4
