Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC025C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:33:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8511F207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aKneAdwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8511F207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ar2OmilqP21p8ZHRw0P4qbGhaE/0SJ4Jn/kNIfvUALA=; b=aKn
	eAdwx7fEqP168TRIgKcu8SyuXZ6omc5bHE9WvLXBhwh0D5dY94Y6Z9BA6X2oRmKMTm/bBpadvGwC0
	vNaBkFkAMhC3a0GW1qdQEKzfzyjxDONV1v/Q3rsg98nh+i90AXfMPzKd6zY32pY4s9V/iIR4tEdQK
	S6l1xY5smEQIlctqbDD+Ro+ArlDvrty2emmDGVQ8QyN5qkeUPGUdZFHx2IntZTz0gAWImXjk1r+kz
	v3jYcgDtmpzRTEdJKfr5eBz6Db/M3vZL0cMDduCCfBg3cgCzYDHjif7asc9W1FoR+wtEWbb1kl8ie
	QB0s910NtDn1jdkACvQ0ezd0OZZEN6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7CV-0008FN-ST; Fri, 22 Feb 2019 09:32:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7CT-0008F2-Ii
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:32:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4A180D;
 Fri, 22 Feb 2019 01:32:56 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95C993F703;
 Fri, 22 Feb 2019 01:32:55 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: Rename get_thread_info()
Date: Fri, 22 Feb 2019 09:32:50 +0000
Message-Id: <1550827970-9355-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_013257_625076_7198079A 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Julien Thierry <julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The assembly macro get_thread_info() actually returns a task_struct and is
analogous to the current/get_current macro/function.

While it could be argued that thread_info sits at the start of
task_struct and the intention could have been to return a thread_info,
instances of loads from/stores to the address obtained from
get_thread_info() use offsets that are generated with
offsetof(struct task_struct, [...]).

Rename get_thread_info() to state it returns a task_struct.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 2 +-
 arch/arm64/include/asm/assembler.h   | 6 +++---
 arch/arm64/kernel/entry.S            | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 4128bec..f74909b 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -24,7 +24,7 @@
 	.endm

 	.macro	__uaccess_ttbr0_enable, tmp1, tmp2
-	get_thread_info \tmp1
+	get_current_task \tmp1
 	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
 	mrs	\tmp2, ttbr1_el1
 	extr    \tmp2, \tmp2, \tmp1, #48
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 7acf243..9c5c876 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -528,9 +528,9 @@
 	.endm

 /*
- * Return the current thread_info.
+ * Return the current task_struct.
  */
-	.macro	get_thread_info, rd
+	.macro	get_current_task, rd
 	mrs	\rd, sp_el0
 	.endm

@@ -713,7 +713,7 @@

 	.macro		if_will_cond_yield_neon
 #ifdef CONFIG_PREEMPT
-	get_thread_info	x0
+	get_current_task	x0
 	ldr		x0, [x0, #TSK_TI_PREEMPT]
 	sub		x0, x0, #PREEMPT_DISABLE_OFFSET
 	cbz		x0, .Lyield_\@
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6bf7e12..c50a7a7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -185,7 +185,7 @@ alternative_cb_end

 	.else
 	add	x21, sp, #S_FRAME_SIZE
-	get_thread_info tsk
+	get_current_task tsk
 	/* Save the task's original addr_limit and set USER_DS */
 	ldr	x20, [tsk, #TSK_TI_ADDR_LIMIT]
 	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
@@ -1104,7 +1104,7 @@ ENTRY(ret_from_fork)
 	cbz	x19, 1f				// not a kernel thread
 	mov	x0, x20
 	blr	x19
-1:	get_thread_info tsk
+1:	get_current_task tsk
 	b	ret_to_user
 ENDPROC(ret_from_fork)
 NOKPROBE(ret_from_fork)
--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
