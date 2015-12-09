From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed,  9 Dec 2015 09:57:17 +0000
Subject: [RFC PATCH v3 6/8] arm64: Add hook for checking early CPU features
In-Reply-To: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1449655039-22022-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a hook for checking whether a secondary CPU has the
features used already by the kernel during early boot, based
on the boot CPU.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b94a198..e63da0f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -824,6 +824,14 @@ static u64 __raw_read_system_reg(u32 sys_id)
 }
 
 /*
+ * Check for CPU features that are used in early boot
+ * based on the Boot CPU value.
+ */
+static void check_early_cpu_features(void)
+{
+}
+
+/*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
  * Any new CPU should match the system wide status of the capability. If the
@@ -836,6 +844,8 @@ void verify_local_cpu_capabilities(void)
 	int i;
 	const struct arm64_cpu_capabilities *caps;
 
+	check_early_cpu_features();
+
 	/*
 	 * If we haven't computed the system capabilities, there is nothing
 	 * to verify.
-- 
1.7.9.5
