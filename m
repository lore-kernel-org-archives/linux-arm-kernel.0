From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  4 Oct 2017 10:48:05 +0100
Subject: [PATCH] arm64: Enable MRS emulation early
Message-ID: <20171004094805.24009-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure the MRS emulation is enabled early enough, such that the
early userspace applications (e.g, those run from initrd) could
use the facility without crashing them.

Fixes: commit 77c97b4ee2129 ("arm64: cpufeature: Expose CPUID registers by emulation")
Reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
Cc: James Morse <james.morse@arm.com>
Cc: Dave Martin <Dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: stable at vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f9e0064c8c1..276eecab6cea 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1294,4 +1294,4 @@ static int __init enable_mrs_emulation(void)
 	return 0;
 }
 
-late_initcall(enable_mrs_emulation);
+core_initcall(enable_mrs_emulation);
-- 
2.13.5
