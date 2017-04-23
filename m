From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:22 +0200
Subject: [PULL 12/79] KVM: arm64: Use common physical timer sysreg definitions
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-13-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Now that we have common definitions for the physical timer control
registers, make the KVM code use these, simplifying the sys_reg_descs
table.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/sys_regs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1f3062b..860707f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1016,15 +1016,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
 	  NULL, reset_unknown, TPIDRRO_EL0 },
 
-	/* CNTP_TVAL_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b0010), Op2(0b000),
-	  access_cntp_tval },
-	/* CNTP_CTL_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b0010), Op2(0b001),
-	  access_cntp_ctl },
-	/* CNTP_CVAL_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b0010), Op2(0b010),
-	  access_cntp_cval },
+	{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_cntp_tval },
+	{ SYS_DESC(SYS_CNTP_CTL_EL0), access_cntp_ctl },
+	{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_cntp_cval },
 
 	/* PMEVCNTRn_EL0 */
 	PMU_PMEVCNTR_EL0(0),
-- 
2.9.0
