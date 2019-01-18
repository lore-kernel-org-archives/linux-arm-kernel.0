Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:53:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C243C2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BCt3gvDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C243C2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bMPj3US11CHUUxkT4tWACCc1Sx9jpZtPDxv0f/T262s=; b=BCt
	3gvDRjzy9Hvc7EPhKPy/tdYbYMdghTNP1NPT20B4n8jYijJ1AIEUX2uAcNe/0yiyCzZ4fxx1DH5iS
	Bi9UFff20kAWqxWCMvVY199UzR/r1f9G7tBAwQhcU7z3Uur0dbKYDxAKOKuX7zjrcSlAT5n/Y+bdB
	9N3dpeh3ktvquX96RijK3tc4E/neby83QRuluZdb/edneOovvqQC90Tdt5J4TpVwF/Dhvm6bkVAcz
	tFzxVdNaHx8aYxpxE8/WQGQ02iKP+K95Wnu0/FOEzhp3HQZplt3zDDvK7z9fd2CE2Ths4I1LqJH4P
	WMcqEhzV1duKStPKxv6n1g//BVRAfjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUa8-0000ZL-U4; Fri, 18 Jan 2019 13:53:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUa5-0000Ys-Iw
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:53:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE11CEBD;
 Fri, 18 Jan 2019 05:53:03 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB99F3F5C1;
 Fri, 18 Jan 2019 05:53:02 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: asm-offsets: remove unused offsets
Date: Fri, 18 Jan 2019 13:52:42 +0000
Message-Id: <1547819562-16143-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_055309_635088_F145F17A 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are a number of offsets defined in asm-offsets.c which no longer
have any users. Let's clean this up by removing them.

All the remaining offsets are in use.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/kernel/asm-offsets.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 65b8afc..0552b91 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -53,13 +53,9 @@ int main(void)
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
-  DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
   DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
-  DEFINE(S_X3,			offsetof(struct pt_regs, regs[3]));
   DEFINE(S_X4,			offsetof(struct pt_regs, regs[4]));
-  DEFINE(S_X5,			offsetof(struct pt_regs, regs[5]));
   DEFINE(S_X6,			offsetof(struct pt_regs, regs[6]));
-  DEFINE(S_X7,			offsetof(struct pt_regs, regs[7]));
   DEFINE(S_X8,			offsetof(struct pt_regs, regs[8]));
   DEFINE(S_X10,			offsetof(struct pt_regs, regs[10]));
   DEFINE(S_X12,			offsetof(struct pt_regs, regs[12]));
@@ -73,12 +69,8 @@ int main(void)
   DEFINE(S_X28,			offsetof(struct pt_regs, regs[28]));
   DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
   DEFINE(S_SP,			offsetof(struct pt_regs, sp));
-#ifdef CONFIG_COMPAT
-  DEFINE(S_COMPAT_SP,		offsetof(struct pt_regs, compat_sp));
-#endif
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
   DEFINE(S_PC,			offsetof(struct pt_regs, pc));
-  DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
@@ -93,7 +85,6 @@ int main(void)
   BLANK();
   DEFINE(PAGE_SZ,	       	PAGE_SIZE);
   BLANK();
-  DEFINE(DMA_BIDIRECTIONAL,	DMA_BIDIRECTIONAL);
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
   DEFINE(DMA_FROM_DEVICE,	DMA_FROM_DEVICE);
   BLANK();
@@ -110,25 +101,18 @@ int main(void)
   BLANK();
   DEFINE(VDSO_CS_CYCLE_LAST,	offsetof(struct vdso_data, cs_cycle_last));
   DEFINE(VDSO_RAW_TIME_SEC,	offsetof(struct vdso_data, raw_time_sec));
-  DEFINE(VDSO_RAW_TIME_NSEC,	offsetof(struct vdso_data, raw_time_nsec));
   DEFINE(VDSO_XTIME_CLK_SEC,	offsetof(struct vdso_data, xtime_clock_sec));
-  DEFINE(VDSO_XTIME_CLK_NSEC,	offsetof(struct vdso_data, xtime_clock_nsec));
   DEFINE(VDSO_XTIME_CRS_SEC,	offsetof(struct vdso_data, xtime_coarse_sec));
   DEFINE(VDSO_XTIME_CRS_NSEC,	offsetof(struct vdso_data, xtime_coarse_nsec));
   DEFINE(VDSO_WTM_CLK_SEC,	offsetof(struct vdso_data, wtm_clock_sec));
-  DEFINE(VDSO_WTM_CLK_NSEC,	offsetof(struct vdso_data, wtm_clock_nsec));
   DEFINE(VDSO_TB_SEQ_COUNT,	offsetof(struct vdso_data, tb_seq_count));
   DEFINE(VDSO_CS_MONO_MULT,	offsetof(struct vdso_data, cs_mono_mult));
-  DEFINE(VDSO_CS_RAW_MULT,	offsetof(struct vdso_data, cs_raw_mult));
   DEFINE(VDSO_CS_SHIFT,		offsetof(struct vdso_data, cs_shift));
   DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
-  DEFINE(VDSO_TZ_DSTTIME,	offsetof(struct vdso_data, tz_dsttime));
   DEFINE(VDSO_USE_SYSCALL,	offsetof(struct vdso_data, use_syscall));
   BLANK();
   DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
-  DEFINE(TVAL_TV_USEC,		offsetof(struct timeval, tv_usec));
   DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
-  DEFINE(TSPEC_TV_NSEC,		offsetof(struct timespec, tv_nsec));
   BLANK();
   DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
@@ -142,13 +126,9 @@ int main(void)
   DEFINE(VCPU_WORKAROUND_FLAGS,	offsetof(struct kvm_vcpu, arch.workaround_flags));
   DEFINE(CPU_GP_REGS,		offsetof(struct kvm_cpu_context, gp_regs));
   DEFINE(CPU_USER_PT_REGS,	offsetof(struct kvm_regs, regs));
-  DEFINE(CPU_FP_REGS,		offsetof(struct kvm_regs, fp_regs));
-  DEFINE(VCPU_FPEXC32_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
-  DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
   DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
 #endif
 #ifdef CONFIG_CPU_PM
-  DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
   DEFINE(MPIDR_HASH_MASK,	offsetof(struct mpidr_hash, mask));
   DEFINE(MPIDR_HASH_SHIFTS,	offsetof(struct mpidr_hash, shift_aff));
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
