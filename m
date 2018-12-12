Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBBBC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:06:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDED20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fI9MzW4i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GWwYg5qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDED20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NIjhnQWK1s3SMED1wx6VxGX2KAaZtj89Q/w5gnCZvc0=; b=fI9MzW4iN5kWD7
	C08eRGViBqXYQU4fPbk5Tlx6jkinFCqVIWq9ZusdTkROIk7smDCsBd3lDgGEJBX0yS5aDNBGmQIMm
	+kSMFgabNlswgxuWk/dfRn7tWNfPcbYwPB7dx/UCYLqRY3R3iXiDEwoG9qdqWE5HS47u3X/ynRHI/
	ukpZHSfuCEnWah2yL8fP6meDF2NK/PfocnVIxna7M/jSVsRJ+VwDVecCz5hq1PsQhbyPZcKr/j7vh
	lI8ELUvIGguAwHngmDN3t78z5DX1NNyxdEXd7917Mlz7ucDu0mjuSbD8kM3/mctNctwJE4w1RRJYs
	lyxcIz9ZxLjSpFlEOAjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX65p-0002j8-2A; Wed, 12 Dec 2018 15:06:33 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62z-00073h-RH
 for linux-arm-kernel@bombadil.infradead.org; Wed, 12 Dec 2018 15:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BMeUQpzaHVS0zKav8f2SKKYOPDtyQysmrTEMPfEsayE=; b=GWwYg5qgyOZShccVk8g3u/nOj5
 3b1RmUaGzqQJjanJoWmMBrfqIuuVGWy1cjUT8fzJLk0RFy0a8M3McGZ4EFdpIQPLEAOpi2H02un94
 z1UhFfpUhvkdBNXKWeVXCraVAgeXrF7SMpczxllPGlEXSxYNxGDhQHwlj+4Dmd7d9v3yCYW3NJ7uQ
 LVZwONEIA1HHe7HzYG/eJSpwm5BpwrX2Skt+2GiHbEB+NwqTUyN92YPRVdYL7kWCsBIQopJyE1d8U
 4GDlF3uOeS7Hs3DkhisDg7JORUTYGxDcYenSE79KFOlgHUZHvipV5lA2nZO94mS4r3ebOY+bqJ8LG
 4BWgGrVQ==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62v-0000zG-Hx
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF5D16A3;
 Wed, 12 Dec 2018 07:03:18 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5DDF3F59C;
 Wed, 12 Dec 2018 07:03:16 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 11/12] clocksource: arm_arch_timer: Use paravirtualized
 LPT
Date: Wed, 12 Dec 2018 15:02:25 +0000
Message-Id: <20181212150226.38051-12-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_100333_756217_56579A98 
X-CRM114-Status: GOOD (  25.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable paravirtualized time to be used in a KVM guest if the host
supports it. This allows the guest to derive a counter which is clocked
at a persistent rate even when the guest is migrated.

If we discover that the system supports SMCCC v1.1 then we probe to
determine whether the hypervisor supports paravirtualized features and
finally whether it supports "Live Physical Time" reporting. If so a
shared structure is made available to the guest containing coefficients
to calculate the derived clock.

The guest kernel uses the coefficients to present a clock to user space
that is always clocked at the same rate whenever the guest is running
('live'), even if the physical clock changes (due to the guest being
migrated).

The existing workaround framework for CNTVCT is used to disable the VDSO
and trap user space accesses to the timer registers so we can present the
derived clock.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  |  32 ++++-
 arch/arm64/kernel/cpuinfo.c          |   2 +-
 drivers/clocksource/arm_arch_timer.c | 177 ++++++++++++++++++++++++++-
 3 files changed, 205 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index f2a234d6516c..ec0e7250c453 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -20,12 +20,14 @@
 #define __ASM_ARCH_TIMER_H
 
 #include <asm/barrier.h>
+#include <asm/pvclock-abi.h>
 #include <asm/sysreg.h>
 
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
 #include <linux/smp.h>
+#include <linux/static_key.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -79,6 +81,19 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 	_val;								\
 })
 
+void pvclock_reg_write_cntv_tval_el0(u32 val);
+extern struct static_key_false arch_counter_cntfrq_ool_enabled;
+extern u64 pvclock_get_cntfrq(void);
+extern struct static_key_false arch_counter_cntvct_ool_enabled;
+extern u64 pvclock_get_cntvct(void);
+
+static __always_inline void __write_cntv_tval_el0(u32 val)
+{
+	if (static_branch_unlikely(&arch_counter_cntvct_ool_enabled))
+		return pvclock_reg_write_cntv_tval_el0(val);
+	write_sysreg(val, cntv_tval_el0);
+}
+
 /*
  * These register accessors are marked inline so the compiler can
  * nicely work out which register we want, and chuck away the rest of
@@ -102,7 +117,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 			write_sysreg(val, cntv_ctl_el0);
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			write_sysreg(val, cntv_tval_el0);
+			__write_cntv_tval_el0(val);
 			break;
 		}
 	}
@@ -134,7 +149,10 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 
 static inline u32 arch_timer_get_cntfrq(void)
 {
-	return read_sysreg(cntfrq_el0);
+	if (static_branch_unlikely(&arch_counter_cntfrq_ool_enabled))
+		return pvclock_get_cntfrq();
+	else
+		return read_sysreg(cntfrq_el0);
 }
 
 static inline u32 arch_timer_get_cntkctl(void)
@@ -154,12 +172,20 @@ static inline u64 arch_counter_get_cntpct(void)
 	return arch_timer_reg_read_stable(cntpct_el0);
 }
 
-static inline u64 arch_counter_get_cntvct(void)
+static inline u64 __arch_counter_get_cntvct(void)
 {
 	isb();
 	return arch_timer_reg_read_stable(cntvct_el0);
 }
 
+static inline u64 arch_counter_get_cntvct(void)
+{
+	if (static_branch_unlikely(&arch_counter_cntvct_ool_enabled))
+		return pvclock_get_cntvct();
+	else
+		return __arch_counter_get_cntvct();
+}
+
 static inline int arch_timer_arch_init(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index bcc2831399cb..74410727829d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -324,7 +324,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 {
-	info->reg_cntfrq = arch_timer_get_cntfrq();
+	info->reg_cntfrq = read_cpuid(CNTFRQ_EL0);
 	/*
 	 * Use the effective value of the CTR_EL0 than the raw value
 	 * exposed by the CPU. CTR_E0.IDC field value must be interpreted
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..6e84e1acc4f4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt)	"arm_arch_timer: " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -23,6 +24,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
+#include <linux/psci.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/sched/clock.h>
 #include <linux/sched_clock.h>
@@ -86,6 +89,171 @@ static int __init early_evtstrm_cfg(char *buf)
 }
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
 
+#ifdef CONFIG_ARM64
+/* Paravirtualised time is only supported for 64 bit */
+static struct pvclock_vm_time_info *pvclock_vm_time_info;
+
+DEFINE_STATIC_KEY_FALSE(arch_counter_cntvct_ool_enabled);
+EXPORT_SYMBOL_GPL(arch_counter_cntvct_ool_enabled);
+DEFINE_STATIC_KEY_FALSE(arch_counter_cntfrq_ool_enabled);
+EXPORT_SYMBOL_GPL(arch_counter_cntfrq_ool_enabled);
+
+static inline u64 native_to_pv_cycles(const struct pvclock_vm_time_info *info,
+		u64 cnt)
+{
+	u32 shift = le32_to_cpu(info->shift);
+	u64 scale_mult = le64_to_cpu(info->scale_mult);
+
+	cnt <<= shift;
+	return mul_u64_u64_shr(scale_mult, cnt, 64);
+}
+
+static inline u64 pv_to_native_cycles(const struct pvclock_vm_time_info *info,
+		u64 cnt)
+{
+	u64 native_freq = le64_to_cpu(info->native_freq);
+	u64 pv_freq = le64_to_cpu(info->pv_freq);
+	u64 div_by_pv_freq_mult = le64_to_cpu(info->div_by_pv_freq_mult);
+
+	cnt = native_freq * cnt + pv_freq - 1;
+	return mul_u64_u64_shr(div_by_pv_freq_mult, cnt, 64);
+}
+
+u64 pvclock_get_cntvct(void)
+{
+	u64 cval;
+	__le64 seq_begin, seq_end;
+
+	do {
+		seq_begin = READ_ONCE(pvclock_vm_time_info->sequence_number);
+
+		barrier();
+
+		cval = __arch_counter_get_cntvct();
+		cval = native_to_pv_cycles(pvclock_vm_time_info, cval);
+
+		barrier();
+		seq_end = READ_ONCE(pvclock_vm_time_info->sequence_number);
+	} while (unlikely(seq_begin != seq_end));
+
+	return cval;
+}
+
+u64 pvclock_get_cntfrq(void)
+{
+	return le64_to_cpu(pvclock_vm_time_info->pv_freq);
+}
+
+static void arch_timer_pvclock_init(void)
+{
+	struct arm_smccc_res res;
+	void *kaddr;
+
+	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
+		return;
+
+	arm_smccc_1_1_call(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			   ARM_SMCCC_HV_PV_FEATURES, &res);
+
+	if (res.a0 != SMCCC_RET_SUCCESS)
+		return;
+
+	arm_smccc_1_1_call(ARM_SMCCC_HV_PV_FEATURES,
+			   ARM_SMCCC_HV_PV_TIME_LPT, &res);
+
+	if ((s32)res.a0 < 0)
+		return;
+
+	arm_smccc_1_1_call(ARM_SMCCC_HV_PV_TIME_LPT, 0, &res);
+
+	if ((s64)res.a0 < 0)
+		return;
+
+	kaddr = memremap(res.a0,
+			sizeof(struct pvclock_vm_time_info),
+			MEMREMAP_WB);
+
+	if (!kaddr) {
+		pr_warn("Failed to map LPT structure for paravirtualized clock\n");
+		return;
+	}
+
+	pvclock_vm_time_info = kaddr;
+
+	static_branch_enable(&arch_counter_cntvct_ool_enabled);
+	static_branch_enable(&arch_counter_cntfrq_ool_enabled);
+
+	pr_info("Using paravirtualized clock\n");
+}
+
+static inline bool pvclock_trap_cntvct(void)
+{
+	return static_branch_unlikely(&arch_counter_cntvct_ool_enabled);
+}
+
+static inline void arch_timer_reg_write_cntv_tval(u32 val,
+						  struct arch_timer *timer)
+{
+	__le64 seq_begin, seq_end;
+
+	if (!static_branch_unlikely(&arch_counter_cntvct_ool_enabled)) {
+		writel_relaxed(val, timer->base + CNTV_TVAL);
+		return;
+	}
+
+	do {
+		u32 n_val;
+
+		seq_begin = READ_ONCE(pvclock_vm_time_info->sequence_number);
+
+		barrier();
+
+		n_val = pv_to_native_cycles(pvclock_vm_time_info, val);
+
+		writel_relaxed(n_val, timer->base + CNTV_TVAL);
+		barrier();
+
+		seq_end = READ_ONCE(pvclock_vm_time_info->sequence_number);
+	} while (unlikely(seq_begin != seq_end));
+}
+
+void pvclock_reg_write_cntv_tval_el0(u32 val)
+{
+	__le64 seq_begin, seq_end;
+
+	do {
+		u32 n_val;
+
+		seq_begin = READ_ONCE(pvclock_vm_time_info->sequence_number);
+
+		barrier();
+
+		n_val = pv_to_native_cycles(pvclock_vm_time_info, val);
+
+		write_sysreg(n_val, cntv_tval_el0);
+		barrier();
+
+		seq_end = READ_ONCE(pvclock_vm_time_info->sequence_number);
+	} while (unlikely(seq_begin != seq_end));
+}
+
+#else /* CONFIG_ARM64 */
+static void arch_timer_pvclock_init(void)
+{
+}
+
+static inline bool pvclock_trap_cntvct(void)
+{
+	return false;
+}
+
+static inline void arch_timer_reg_write_cntv_tval(u32 val,
+						 struct arch_timer *timer)
+{
+	writel_relaxed(val, timer->base + CNTV_TVAL);
+}
+#endif /* CONFIG_ARM64 */
+
 /*
  * Architected system timer support.
  */
@@ -111,7 +279,7 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 			writel_relaxed(val, timer->base + CNTV_CTL);
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTV_TVAL);
+			arch_timer_reg_write_cntv_tval(val, timer);
 			break;
 		}
 	} else {
@@ -589,6 +757,7 @@ static bool arch_timer_this_cpu_has_cntvct_wa(void)
 #define erratum_set_next_event_tval_phys(...)		({BUG(); 0;})
 #define erratum_handler(fn, r, ...)			({false;})
 #define arch_timer_this_cpu_has_cntvct_wa()		({false;})
+
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static __always_inline irqreturn_t timer_handler(const int access,
@@ -815,7 +984,7 @@ static void arch_counter_set_user_access(void)
 	 * need to be workaround. The vdso may have been already
 	 * disabled though.
 	 */
-	if (arch_timer_this_cpu_has_cntvct_wa())
+	if (pvclock_trap_cntvct() || arch_timer_this_cpu_has_cntvct_wa())
 		pr_info("CPU%d: Trapping CNTVCT access\n", smp_processor_id());
 	else
 		cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
@@ -1222,6 +1391,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 
+	arch_timer_pvclock_init();
+
 	rate = arch_timer_get_cntfrq();
 	arch_timer_of_configure_rate(rate, np);
 
@@ -1552,6 +1723,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 
+	arch_timer_pvclock_init();
+
 	/*
 	 * When probing via ACPI, we have no mechanism to override the sysreg
 	 * CNTFRQ value. This *must* be correct.
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
