From: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 09 Mar 2012 14:56:52 +1030
Subject: [PATCH 3/8] ARM: KVM: make struct coproc_params arg const.
Message-ID: <1331267212.32474.rusty@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Rusty Russell <rusty@rustcorp.com.au>

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/arm/kvm/emulate.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index 108db38..87a1141 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -165,7 +165,7 @@ struct coproc_params {
 	bool is_write;
 };
 
-static void cp15_op(struct kvm_vcpu *vcpu, struct coproc_params *p,
+static void cp15_op(struct kvm_vcpu *vcpu, const struct coproc_params *p,
 			   enum cp15_regs cp15_reg)
 {
 	if (p->is_write)
@@ -174,7 +174,7 @@ static void cp15_op(struct kvm_vcpu *vcpu, struct coproc_params *p,
 		*vcpu_reg(vcpu, p->Rt1) = vcpu->arch.cp15[cp15_reg];
 }
 
-static void print_cp_instr(struct coproc_params *p)
+static void print_cp_instr(const struct coproc_params *p)
 {
 	if (p->is_64bit) {
 		kvm_debug("%s\tp15, %lu, r%lu, r%lu, c%lu",
@@ -213,7 +213,7 @@ int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run)
  * @p:    The coprocessor parameters struct pointer holding trap inst. details
  */
 static int emulate_cp15_c9_access(struct kvm_vcpu *vcpu,
-				  struct coproc_params *p)
+				  const struct coproc_params *p)
 {
 	BUG_ON(p->CRn != 9);
 	BUG_ON(p->is_64bit);
@@ -251,7 +251,7 @@ static int emulate_cp15_c9_access(struct kvm_vcpu *vcpu,
  * to these registers.
  */
 static int emulate_cp15_c10_access(struct kvm_vcpu *vcpu,
-				   struct coproc_params *p)
+				   const struct coproc_params *p)
 {
 	BUG_ON(p->CRn != 10);
 	BUG_ON(p->is_64bit);
@@ -293,7 +293,7 @@ static int emulate_cp15_c10_access(struct kvm_vcpu *vcpu,
  * This may need to be refined.
  */
 static int emulate_cp15_c15_access(struct kvm_vcpu *vcpu,
-				   struct coproc_params *p)
+				   const struct coproc_params *p)
 {
 	trace_kvm_emulate_cp15_imp(p->Op1, p->Rt1, p->CRn, p->CRm,
 				   p->Op2, p->is_write);
