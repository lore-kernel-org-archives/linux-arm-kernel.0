From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Aug 2018 14:14:58 +0100
Subject: [PATCH 1/4] KVM: arm64: Remove non-existent AArch32 ICC_SGI1R encoding
In-Reply-To: <20180808131501.584-1-marc.zyngier@arm.com>
References: <20180808131501.584-1-marc.zyngier@arm.com>
Message-ID: <20180808131501.584-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ICC_SGI1R is a 64bit system register, even on AArch32. It is thus
pointless to have such an encoding in the 32bit cp15 array. Let's
drop it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 774d72155904..e04aacb2a24c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1622,8 +1622,6 @@ static const struct sys_reg_desc cp14_64_regs[] = {
  * register).
  */
 static const struct sys_reg_desc cp15_regs[] = {
-	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
-
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_vm_reg, NULL, c1_SCTLR },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
-- 
2.18.0
