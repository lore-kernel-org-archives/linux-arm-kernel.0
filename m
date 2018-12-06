Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C80C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3126520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X4UksoI8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="f1rf2n/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3126520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0xUEuWvW86GIZgZD79d3KCiQYKT3RWlXG1jiHLYK4GI=; b=X4UksoI8OnOG5S
	4wqkCEeNIMiaSsLYii4O4ZHP919zrrK4GBAaQ0opQtVAHeZhhZqKY5s0tQAU7fQf1R/celDzKnbjh
	QFQkTYg90qFPuFiCuAjRqB3KQz3pyDhV8QHgscV68nT7bfPh0VoxYIIE+vxxco4xJKonhjjT2/2/C
	CI2fJgyHBovnfQUjMpKo/KKk65wfAkYS3/N+TsF0zndBm688dd/98keeusficv6fpfjKsViq5tw+x
	50oXM3fstG26zqaqf+GvqkCC37BhIHhoO57DX4EHtjpg7DT1QsGg+Qwl/hDaI6I8LqPvmji5D6UQG
	+BXqVHP38wdxiz9MLEBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsoq-0002hx-W5; Thu, 06 Dec 2018 12:31:53 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsiX-0003JB-8i
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:30 +0000
Received: by mail-wr1-x443.google.com with SMTP id j2so326508wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iKeBMeDd/hvI2FA7NoeqR+ehI2COJOXIft3otGKQ0o8=;
 b=f1rf2n/scEn9iSpaT9i5tOsqH/hxKSAj6AnhXUunXk4GSnehLOZkxC8cS0pFgw4bCr
 42W27ioXpFlJswetDzyyU0v692af90Dwqs2quECtDhWBNax5gIvsKM9hLqrPPRE7j0Ll
 lmKjB6prDWZDTCgiFHkvtWUXldCGgNI4PTdYxfbNiIsm2fa8ndTPa1e2B+IMHiZLgluF
 UvIdIRqvosMF9vBLQPQf3Fu54KS26Ppo8EJfjWJw1gIDuHptmHhmoyMxHbTYk0g63dy+
 hltg6bPlJ/Z27FVdlMne0eMdsDAKMqpXWJn7svGa5OscnMUePNv3cTmSevfnP+UDZuxC
 SKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iKeBMeDd/hvI2FA7NoeqR+ehI2COJOXIft3otGKQ0o8=;
 b=JeZWQLaphaz4ZkMfkHFB8ax6BQJS4Yc/ZPJjekHu5WX5nEjpcXGGkfLzXJhw3wzzBg
 2VTBAi3/dVTajuV29jBqoDOm+Jl3EYkfjid0ajLPAwGR0QSDR1ZpNiLpQCrrST52ZCsu
 gbkTCqy0wnrRwm7I3p8C3kDx1SUakZwtTEfqiON5c5CWzlLcMdJg6Mxtxz++16VAXh/c
 47Z+74Otmdu3iEQqv/MTmVQzoUnfCk2kvVBnc5VSEJspzWQVzKjayrk9MhnyehvL4X08
 CMy3RAuzbLul+fijakTJ3WE6+Ps6N/dSS80fQeDaN++0+AQ03+Ry9z+/sjnksRgCVCv2
 tI2g==
X-Gm-Message-State: AA+aEWbnexHKQsA+Og+vN8mEgMHOzoDWAZtzLsBY2SE+bRvtRlp5XdX5
 C9xglWkGAG0COalcPQqGUQe8pw==
X-Google-Smtp-Source: AFSGD/Xy9XUT3vO1le8FTX7MP1mbCfMSAzWTSUArSSG7mR6VEHKyozrE6h4RIddLRyoXver8Ony3nw==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr24022433wrv.308.1544099109600; 
 Thu, 06 Dec 2018 04:25:09 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:25:08 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v13 13/25] kasan, arm64: fix up fault handling logic
Date: Thu,  6 Dec 2018 13:24:31 +0100
Message-Id: <3f349b0e9e48b5df3298a6b4ae0634332274494a.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042525_554945_780527A4 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: Vishwath Mohan <vishwath@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Jann Horn <jannh@google.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Mark Brand <markbrand@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Right now arm64 fault handling code removes pointer tags from addresses
covered by TTBR0 in faults taken from both EL0 and EL1, but doesn't do
that for pointers covered by TTBR1.

This patch adds two helper functions is_ttbr0_addr() and is_ttbr1_addr(),
where the latter one accounts for the fact that TTBR1 pointers might be
tagged when tag-based KASAN is in use, and uses these helper functions to
perform pointer checks in arch/arm64/mm/fault.c.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7d9571f4ae3d..c1d98f0a3086 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -40,6 +40,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
+#include <asm/kasan.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/pgtable.h>
@@ -132,6 +133,18 @@ static void mem_abort_decode(unsigned int esr)
 		data_abort_decode(esr);
 }
 
+static inline bool is_ttbr0_addr(unsigned long addr)
+{
+	/* entry assembly clears tags for TTBR0 addrs */
+	return addr < TASK_SIZE;
+}
+
+static inline bool is_ttbr1_addr(unsigned long addr)
+{
+	/* TTBR1 addresses may have a tag if KASAN_SW_TAGS is in use */
+	return arch_kasan_reset_tag(addr) >= VA_START;
+}
+
 /*
  * Dump out the page tables associated with 'addr' in the currently active mm.
  */
@@ -141,7 +154,7 @@ void show_pte(unsigned long addr)
 	pgd_t *pgdp;
 	pgd_t pgd;
 
-	if (addr < TASK_SIZE) {
+	if (is_ttbr0_addr(addr)) {
 		/* TTBR0 */
 		mm = current->active_mm;
 		if (mm == &init_mm) {
@@ -149,7 +162,7 @@ void show_pte(unsigned long addr)
 				 addr);
 			return;
 		}
-	} else if (addr >= VA_START) {
+	} else if (is_ttbr1_addr(addr)) {
 		/* TTBR1 */
 		mm = &init_mm;
 	} else {
@@ -254,7 +267,7 @@ static inline bool is_el1_permission_fault(unsigned long addr, unsigned int esr,
 	if (fsc_type == ESR_ELx_FSC_PERM)
 		return true;
 
-	if (addr < TASK_SIZE && system_uses_ttbr0_pan())
+	if (is_ttbr0_addr(addr) && system_uses_ttbr0_pan())
 		return fsc_type == ESR_ELx_FSC_FAULT &&
 			(regs->pstate & PSR_PAN_BIT);
 
@@ -319,7 +332,7 @@ static void set_thread_esr(unsigned long address, unsigned int esr)
 	 * type", so we ignore this wrinkle and just return the translation
 	 * fault.)
 	 */
-	if (current->thread.fault_address >= TASK_SIZE) {
+	if (!is_ttbr0_addr(current->thread.fault_address)) {
 		switch (ESR_ELx_EC(esr)) {
 		case ESR_ELx_EC_DABT_LOW:
 			/*
@@ -455,7 +468,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	if (addr < TASK_SIZE && is_el1_permission_fault(addr, esr, regs)) {
+	if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs)) {
 		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 		if (regs->orig_addr_limit == KERNEL_DS)
 			die_kernel_fault("access to user memory with fs=KERNEL_DS",
@@ -603,7 +616,7 @@ static int __kprobes do_translation_fault(unsigned long addr,
 					  unsigned int esr,
 					  struct pt_regs *regs)
 {
-	if (addr < TASK_SIZE)
+	if (is_ttbr0_addr(addr))
 		return do_page_fault(addr, esr, regs);
 
 	do_bad_area(addr, esr, regs);
@@ -758,7 +771,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	 * re-enabled IRQs. If the address is a kernel address, apply
 	 * BP hardening prior to enabling IRQs and pre-emption.
 	 */
-	if (addr > TASK_SIZE)
+	if (!is_ttbr0_addr(addr))
 		arm64_apply_bp_hardening();
 
 	local_daif_restore(DAIF_PROCCTX);
@@ -771,7 +784,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 					   struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
-		if (instruction_pointer(regs) > TASK_SIZE)
+		if (!is_ttbr0_addr(instruction_pointer(regs)))
 			arm64_apply_bp_hardening();
 		local_daif_restore(DAIF_PROCCTX);
 	}
@@ -825,7 +838,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+	if (user_mode(regs) && !is_ttbr0_addr(instruction_pointer(regs)))
 		arm64_apply_bp_hardening();
 
 	if (!inf->fn(addr, esr, regs)) {
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
