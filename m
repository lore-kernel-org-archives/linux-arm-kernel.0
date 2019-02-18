Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D162C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F253221773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mo2xbn9J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wMBVbZXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F253221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Gv+8N8a02YyeXyGxFkZhV8FtjQshuTrXRBuCN65QTYE=; b=mo2xbn9JUenwWJiN1ufmbC7WwQ
	W/mw4Q7PhwhKtin6tUhQWawOeraK/dEjh0gMBwi0W3RtPYBNFjBb1HqI8yRaI81FSAm6GQSri9PXf
	2EAZayieK0gxQymLMfxvtKZEI0srWBb6/9e29/fIBlt1aAC4gAKC+OZsA77mxMbk9NSd8EqUJd00J
	V61/58tHdTNjFbjTTv2dnM9S27V3tZz7anNYo5RapbMp4b/GKWTlesgxetytL18ckhRhfi1le+fES
	aLmN8UFSWg68qE5KEdP9z9YNbjc6Qw702tkLr9gwELoW3y+TS+F+RFoQ8XnfLGihs/Opz4iEBP/jL
	s633dj9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp2u-0001Ag-Hw; Mon, 18 Feb 2019 19:57:44 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozs-00055I-ST
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 19:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l2cPXn9Tla/kk+aLiKUaDiykxZ23Iyt12OPQpxG7vcs=; b=wMBVbZXb7XwO/ygR7+DW7aBnO
 UvF6Ma+p2XbPt+6JHoraAxzLtqu1n+/KMGp9M/gXCBRhyIN2ejnCp5cQvfdwS2MpeUh/+s4B1HOJx
 4RlxSXP+VKcH2YGlIAoTHw45ScVPpGmF0FmSCabiVRfdfwAmfMReo3n2tvROqQc0XKMb3S54GOFfC
 e1+T5oLrXRtYK8YEURi3tM1GKwIXMHNs6kDOomhqtonabkyruHErtxUuxVVmUDYY6XY4P8aYFfHYD
 58svSrQyozjmvQd7t9kooyGeRXVjeubg2DSIiRFuC2XWzUQf0QgIQRNEAo16W4zzu1g8hNLTB99Aj
 y9Zv/T+sw==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozn-0005mj-J3
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025FD1BC0;
 Mon, 18 Feb 2019 11:54:08 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 142033F740;
 Mon, 18 Feb 2019 11:54:05 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 18/26] KVM: arm64/sve: Add SVE support to register access
 ioctl interface
Date: Mon, 18 Feb 2019 19:52:31 +0000
Message-Id: <1550519559-15915-19-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_195432_059146_89A02F12 
X-CRM114-Status: GOOD (  29.80  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the following registers for access via the
KVM_{GET,SET}_ONE_REG interface:

 * KVM_REG_ARM64_SVE_ZREG(n, i) (n = 0..31) (in 2048-bit slices)
 * KVM_REG_ARM64_SVE_PREG(n, i) (n = 0..15) (in 256-bit slices)
 * KVM_REG_ARM64_SVE_FFR(i) (in 256-bit slices)

In order to adapt gracefully to future architectural extensions,
the registers are logically divided up into slices as noted above:
the i parameter denotes the slice index.

This allows us to reserve space in the ABI for future expansion of
these registers.  However, as of today the architecture does not
permit registers to be larger than a single slice, so no code is
needed in the kernel to expose additional slices, for now.  The
code can be extended later as needed to expose them up to a maximum
of 32 slices (as carved out in the architecture itself) if they
really exist someday.

The registers are only visible for vcpus that have SVE enabled.
They are not enumerated by KVM_GET_REG_LIST on vcpus that do not
have SVE.

Accesses to the FPSIMD registers via KVM_REG_ARM_CORE is not
allowed for SVE-enabled vcpus: SVE-aware userspace can use the
KVM_REG_ARM64_SVE_ZREG() interface instead to access the same
register state.  This avoids some complex and pointless emulation
in the kernel to convert between the two views of these aliased
registers.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v4:

 * Add "BASE" #defines for the Z-reg and P-reg ranges in the KVM
   register ID space, to make the 0x400 magic number a little less
   cryptic.

 * Pull KVM_SVE_{Z,P}REG_SIZE defines from "KVM: arm64: Enumerate SVE
   register indices for KVM_GET_REG_LIST", since we now use them here.

 * Simplify sve_reg_region(), and give up on the attempt to make
   kreg_region a general thing: nothing else will use it for now,
   anyway, so let's keep it as simple as possible.

 * Drop support for multiple slices per register.  This functionality
   can be added back in later if needed, without ABI breaks.

 * Pull vcpu_sve_state_size() into kvm_host.h, from "KVM: arm64/sve:
   Allow userspace to enable SVE for vcpus".  This is needed for use
   with array_index_nospec() to determine the applicable buffer bounds.
   To avoid circular header deependency issues, the function is also
   converted into a macro, but is otherwise equivalent to the original
   version.

 * Guard sve_state base offset in kernel memory with
   array_index_nospec(), since it is generated from user data that can
   put it out of range.

   (sve_state will get allocated with the corresponding size later in
   the series.  For now, this code is dormant since no means is
   provided for userspace to create SVE-enabled vcpus yet.)
---
 arch/arm64/include/asm/kvm_host.h |  14 ++++
 arch/arm64/include/uapi/asm/kvm.h |  17 +++++
 arch/arm64/kvm/guest.c            | 138 ++++++++++++++++++++++++++++++++++----
 3 files changed, 157 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 77b6f3e..d233855 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -310,6 +310,20 @@ struct kvm_vcpu_arch {
 #define vcpu_sve_pffr(vcpu) ((void *)((char *)((vcpu)->arch.sve_state) + \
 				      sve_ffr_offset((vcpu)->arch.sve_max_vl)))
 
+#define vcpu_sve_state_size(vcpu) ({					\
+	size_t __size_ret;						\
+	unsigned int __vcpu_vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+		__size_ret = 0;						\
+	} else {							\
+		__vcpu_vq = sve_vq_from_vl((vcpu)->arch.sve_max_vl);	\
+		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
+	}								\
+									\
+	__size_ret;							\
+})
+
 /* vcpu_arch flags field values: */
 #define KVM_ARM64_DEBUG_DIRTY		(1 << 0)
 #define KVM_ARM64_FP_ENABLED		(1 << 1) /* guest FP regs loaded */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 97c3478..ced760c 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -226,6 +226,23 @@ struct kvm_vcpu_events {
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
 
+/* SVE registers */
+#define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
+
+/* Z- and P-regs occupy blocks at the following offsets within this range: */
+#define KVM_REG_ARM64_SVE_ZREG_BASE	0
+#define KVM_REG_ARM64_SVE_PREG_BASE	0x400
+
+#define KVM_REG_ARM64_SVE_ZREG(n, i)	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
+					 KVM_REG_ARM64_SVE_ZREG_BASE |	\
+					 KVM_REG_SIZE_U2048 |		\
+					 ((n) << 5) | (i))
+#define KVM_REG_ARM64_SVE_PREG(n, i)	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
+					 KVM_REG_ARM64_SVE_PREG_BASE |	\
+					 KVM_REG_SIZE_U256 |		\
+					 ((n) << 5) | (i))
+#define KVM_REG_ARM64_SVE_FFR(i)	KVM_REG_ARM64_SVE_PREG(16, i)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index f491456..8cfa889 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -19,8 +19,11 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/bits.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/nospec.h>
+#include <linux/kernel.h>
 #include <linux/kvm_host.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -29,9 +32,12 @@
 #include <kvm/arm_psci.h>
 #include <asm/cputype.h>
 #include <linux/uaccess.h>
+#include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_host.h>
+#include <asm/sigcontext.h>
 
 #include "trace.h"
 
@@ -211,6 +217,114 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return err;
 }
 
+#define SVE_REG_SLICE_SHIFT	0
+#define SVE_REG_SLICE_BITS	5
+#define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
+#define SVE_REG_ID_BITS		5
+
+#define SVE_REG_SLICE_MASK					\
+	GENMASK(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS - 1,	\
+		SVE_REG_SLICE_SHIFT)
+#define SVE_REG_ID_MASK							\
+	GENMASK(SVE_REG_ID_SHIFT + SVE_REG_ID_BITS - 1, SVE_REG_ID_SHIFT)
+
+#define SVE_NUM_SLICES (1 << SVE_REG_SLICE_BITS)
+
+#define KVM_SVE_ZREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0))
+#define KVM_SVE_PREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0))
+
+struct sve_state_region {
+	unsigned int koffset;	/* offset into sve_state in kernel memory */
+	unsigned int klen;	/* length in kernel memory */
+	unsigned int upad;	/* extra trailing padding in user memory */
+};
+
+/* Get sanitised bounds for user/kernel SVE register copy */
+static int sve_reg_region(struct sve_state_region *region,
+			  struct kvm_vcpu *vcpu,
+			  const struct kvm_one_reg *reg)
+{
+	/* reg ID ranges for Z- registers */
+	const u64 zreg_id_min = KVM_REG_ARM64_SVE_ZREG(0, 0);
+	const u64 zreg_id_max = KVM_REG_ARM64_SVE_ZREG(SVE_NUM_ZREGS - 1,
+						       SVE_NUM_SLICES - 1);
+
+	/* reg ID ranges for P- registers and FFR (which are contiguous) */
+	const u64 preg_id_min = KVM_REG_ARM64_SVE_PREG(0, 0);
+	const u64 preg_id_max = KVM_REG_ARM64_SVE_FFR(SVE_NUM_SLICES - 1);
+
+	unsigned int vq;
+	unsigned int reg_num;
+
+	unsigned int reqoffset, reqlen; /* User-requested offset and length */
+	unsigned int maxlen; /* Maxmimum permitted length */
+
+	size_t sve_state_size;
+
+	/* Only the first slice ever exists, for now: */
+	if ((reg->id & SVE_REG_SLICE_MASK) != 0)
+		return -ENOENT;
+
+	vq = sve_vq_from_vl(vcpu->arch.sve_max_vl);
+
+	reg_num = (reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	if (reg->id >= zreg_id_min && reg->id <= zreg_id_max) {
+		reqoffset = SVE_SIG_ZREG_OFFSET(vq, reg_num) -
+				SVE_SIG_REGS_OFFSET;
+		reqlen = KVM_SVE_ZREG_SIZE;
+		maxlen = SVE_SIG_ZREG_SIZE(vq);
+	} else if (reg->id >= preg_id_min && reg->id <= preg_id_max) {
+		reqoffset = SVE_SIG_PREG_OFFSET(vq, reg_num) -
+				SVE_SIG_REGS_OFFSET;
+		reqlen = KVM_SVE_PREG_SIZE;
+		maxlen = SVE_SIG_PREG_SIZE(vq);
+	} else {
+		return -ENOENT;
+	}
+
+	sve_state_size = vcpu_sve_state_size(vcpu);
+	if (!sve_state_size)
+		return -EINVAL;
+
+	region->koffset = array_index_nospec(reqoffset, sve_state_size);
+	region->klen = min(maxlen, reqlen);
+	region->upad = reqlen - region->klen;
+
+	return 0;
+}
+
+static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	struct sve_state_region region;
+	char __user *uptr = (char __user *)reg->addr;
+
+	if (!vcpu_has_sve(vcpu) || sve_reg_region(&region, vcpu, reg))
+		return -ENOENT;
+
+	if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
+			 region.klen) ||
+	    clear_user(uptr + region.klen, region.upad))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	struct sve_state_region region;
+	const char __user *uptr = (const char __user *)reg->addr;
+
+	if (!vcpu_has_sve(vcpu) || sve_reg_region(&region, vcpu, reg))
+		return -ENOENT;
+
+	if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
+			   region.klen))
+		return -EFAULT;
+
+	return 0;
+}
+
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	return -EINVAL;
@@ -371,12 +485,12 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
 		return -EINVAL;
 
-	/* Register group 16 means we want a core register. */
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
-		return get_core_reg(vcpu, reg);
-
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
-		return kvm_arm_get_fw_reg(vcpu, reg);
+	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
+	case KVM_REG_ARM_CORE:	return get_core_reg(vcpu, reg);
+	case KVM_REG_ARM_FW:	return kvm_arm_get_fw_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
+	default: break; /* fall through */
+	}
 
 	if (is_timer_reg(reg->id))
 		return get_timer_reg(vcpu, reg);
@@ -390,12 +504,12 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
 		return -EINVAL;
 
-	/* Register group 16 means we set a core register. */
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
-		return set_core_reg(vcpu, reg);
-
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
-		return kvm_arm_set_fw_reg(vcpu, reg);
+	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
+	case KVM_REG_ARM_CORE:	return set_core_reg(vcpu, reg);
+	case KVM_REG_ARM_FW:	return kvm_arm_set_fw_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
+	default: break; /* fall through */
+	}
 
 	if (is_timer_reg(reg->id))
 		return set_timer_reg(vcpu, reg);
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
