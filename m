From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 31 Jan 2017 17:16:30 +0000
Subject: [PATCH v4 9/9] arm/arm64: KVM: Initialise the host pmu
In-Reply-To: <20170131171630.26898-1-punit.agrawal@arm.com>
References: <20170131171630.26898-1-punit.agrawal@arm.com>
Message-ID: <20170131171630.26898-10-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we've added support for handling TLB traps as well as
infrastructure for monitoring these operations, all that remains is
initialising the host pmu for arm/arm64.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9d7446456e0c..e5f77a3d08ea 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1266,6 +1266,7 @@ static int init_subsystems(void)
 		goto out;
 
 	kvm_perf_init();
+	arm_host_pmu_init();
 	kvm_coproc_table_init();
 
 out:
@@ -1456,6 +1457,7 @@ int kvm_arch_init(void *opaque)
 void kvm_arch_exit(void)
 {
 	kvm_perf_teardown();
+	arm_host_pmu_teardown();
 }
 
 static int arm_init(void)
-- 
2.11.0
