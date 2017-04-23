From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:21 +0200
Subject: [PULL 11/79] KVM: arm64: Use common GICv3 sysreg definitions
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-12-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Now that we have common definitions for the GICv3 register encodings,
make the KVM code use these, simplifying the sys_reg_descs table.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/sys_regs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 63b0785..1f3062b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -973,12 +973,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
 	  NULL, reset_val, VBAR_EL1, 0 },
 
-	/* ICC_SGI1R_EL1 */
-	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
-	  access_gic_sgi },
-	/* ICC_SRE_EL1 */
-	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1100), Op2(0b101),
-	  access_gic_sre },
+	{ SYS_DESC(SYS_ICC_SGI1R_EL1), access_gic_sgi },
+	{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
 
 	/* CONTEXTIDR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
-- 
2.9.0
