From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Wed,  1 Feb 2017 14:38:35 -0700
Subject: [PATCH] arm64: kconfig: allow support for memory failure handling
Message-ID: <1485985115-27274-1-git-send-email-tbaicar@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

If ACPI_APEI and MEMORY_FAILURE is configured, select
ACPI_APEI_MEMORY_FAILURE. This enables memory failure recovery
when such memory failure is reported through ACPI APEI. APEI
(ACPI Platform Error Interfaces) provides a means for the
platform to convey error information to the kernel.

Declare ARCH_SUPPORTS_MEMORY_FAILURE, as arm64 does support
memory failure recovery attempt.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f92778d..4cd12a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -15,6 +15,8 @@ config ARM64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ACPI_APEI_MEMORY_FAILURE if ACPI_APEI && MEMORY_FAILURE
+	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
