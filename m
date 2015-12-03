From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 3 Dec 2015 14:11:24 +0800
Subject: [PATCH v5 14/21] KVM: ARM64: Add reset and access handlers for
 PMUSERENR register
In-Reply-To: <1449123091-20252-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449123091-20252-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1449123091-20252-15-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

The reset value of PMUSERENR_EL0 is UNKNOWN, use reset_unknown.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f5e0732..eb4fcf9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -835,7 +835,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  access_pmu_regs, reset_unknown, PMXEVCNTR_EL0 },
 	/* PMUSERENR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b000),
-	  trap_raz_wi },
+	  access_pmu_regs, reset_unknown, PMUSERENR_EL0 },
 	/* PMOVSSET_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
 	  access_pmu_regs, reset_unknown, PMOVSSET_EL0 },
@@ -1218,7 +1218,8 @@ static const struct sys_reg_desc cp15_regs[] = {
 	  NULL, c9_PMXEVTYPER },
 	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), access_pmu_cp15_regs,
 	  NULL, c9_PMXEVCNTR },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), trap_raz_wi },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), access_pmu_cp15_regs,
+	  NULL,  c9_PMUSERENR, 0 },
 	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), access_pmu_cp15_regs,
 	  NULL, c9_PMINTENSET },
 	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), access_pmu_cp15_regs,
-- 
2.0.4
