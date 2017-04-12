From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 12 Apr 2017 15:04:59 +0100
Subject: [PATCH 3/3] arm64: kconfig: allow support for memory failure handling
In-Reply-To: <20170412140459.21824-1-punit.agrawal@arm.com>
References: <20170412140459.21824-1-punit.agrawal@arm.com>
Message-ID: <20170412140459.21824-4-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

Declare ARCH_SUPPORTS_MEMORY_FAILURE, as arm64 does support
memory failure recovery attempt.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
(Dropped changes to ACPI APEI Kconfig and updated commit log)
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3741859765cf..993a5fd85452 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,6 +19,7 @@ config ARM64
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
-- 
2.11.0
