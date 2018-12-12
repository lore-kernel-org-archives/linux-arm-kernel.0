Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C524BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:09:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943762086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SnYh/rPm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8biaPt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943762086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=32aYjtLwjr8cNndxpKPNf5fZtvXwsQtJ6fGenPib3OA=; b=SnYh/rPm++J6H6
	g1UkBdm5PbXWIVqS9kJ/WfcCLbTqExjeRV9fxfugN4y7RH5mxW5AFtJyyG0rzLC0j8RasNExaENW6
	woNCVwtu1jKx1zVKe8Ipm1xqw0hKCivDTlcr6q9fgU4xUB6FMk1x2XnDJkhUv5Ak48tG0TJZk7tQS
	f4LAjIIMsTwLvYZvDCeitcMJCLj3jGQ2cxg2aTgzPE7DPa3IYFMwzPVBKZ3oRjdrfGdkaRGO9OIA6
	zfmGg7WFMR3Kf3eb5xHCHUhVrffY57aiXBFpvVX1Y4GWtwbMJ1Ef6+P1tSk7QjuiljdKqkvOx2kMf
	eCluGfQD5RQUp3bl2VfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3K4-0008AJ-Q5; Wed, 12 Dec 2018 12:09:04 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3K1-00089R-UP
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:09:03 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so17437372wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 04:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XpF7vbnOFsXhLrb4aTwEuYmizpZRsEcIFhJoxX7Cs2o=;
 b=Z8biaPt4td1tZc4rFJfg5u+kcQeHJxmOj+0bpU2FUhXcVrcwMwQ+Z/VWXUZpuG7Fz0
 FyOgBxVPZ6UgFD0hwLl6aahH5yjG6/0bJEHloJgovFvE9Z9U82m9u6bwyWxXGKS71AZQ
 nfXDEyU15zJ7PocPMx5y7kri9hH5pRFzBzgaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XpF7vbnOFsXhLrb4aTwEuYmizpZRsEcIFhJoxX7Cs2o=;
 b=qvnPUxEqax+Kd+E58nTNX3phzvGt/3BlvSbTg4SDiQu6aVzqoi+AsHKhnAXvRt2xRV
 CyybZaEpN9xftzJlvnCN7FEs587vWxljPEuOuIG47z3Qdi8qvZDtmNpGvw/VAwY9o1uO
 MP8uEkwmS9D4p0g7xrYhofYW/wLdu9lnzUZdcEPDtmkVEWMec2H80A4ZFM9zt7BUK7Qn
 F+yNLh51buKc8mkwe3fzk/00npTxzLoAPHlmJpcUCug187xmDC40cB51+o4c2ixnOCce
 0ymP/bvtCLugzgYqltvm5tQ4w0TJDx9EQK1PV6KrY6Skua6F3YFt9cg+xDN/TSK6L056
 kxnQ==
X-Gm-Message-State: AA+aEWYd94Sl4Me+QbswHZZ1ZvTHKLGmYey5TMckVRSUNJqd/yci/pWK
 O1EwXzzI0rgJaLg4Kr81ClRrnKlRvUk2wg==
X-Google-Smtp-Source: AFSGD/UCEBxqYi4ONoNgEGm95A5ReDGM5HlbiZVyIxlX+NdIQvn3Dt9nGmDG2LmE6rsJrjxKbCvQAA==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr18380673wrw.113.1544616528752; 
 Wed, 12 Dec 2018 04:08:48 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:1db:abd7:f798:3277])
 by smtp.gmail.com with ESMTPSA id j8sm4748531wmd.0.2018.12.12.04.08.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 04:08:47 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] arm64: enable per-task stack canaries
Date: Wed, 12 Dec 2018 13:08:44 +0100
Message-Id: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_040901_976670_5F6FFC72 
X-CRM114-Status: GOOD (  14.71  )
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
Cc: mark.rutland@arm.com, linux-hardened@lists.openwall.com,
 keescook@chromium.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Ramana.Radhakrishnan@arm.com, labbott@fedoraproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This enables the use of per-task stack canary values if GCC has
support for emitting the stack canary reference relative to the
value of sp_el0, which holds the task struct pointer in the arm64
kernel.

The $(eval) extends KBUILD_CFLAGS at the moment the make rule is
applied, which means asm-offsets.o (which we rely on for the offset
value) is built without the arguments, and everything built afterwards
has the options set.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3: add all 3 options to the Kconfig cc-option check, to avoid relying on
    implementation defined logic in the compiler regarding which options
    need to appear together.

 arch/arm64/Kconfig                      |  7 +++++++
 arch/arm64/Makefile                     | 10 ++++++++++
 arch/arm64/include/asm/stackprotector.h |  3 ++-
 arch/arm64/kernel/asm-offsets.c         |  3 +++
 arch/arm64/kernel/process.c             |  2 +-
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..e355946cde97 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1272,6 +1272,13 @@ config RANDOMIZE_MODULE_REGION_FULL
 	  a limited range that contains the [_stext, _etext] interval of the
 	  core kernel, so branch relocations are always in range.
 
+config CC_HAVE_STACKPROTECTOR_SYSREG
+	def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
+
+config STACKPROTECTOR_PER_TASK
+	def_bool y
+	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..79d927542322 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -56,6 +56,16 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
+prepare: stack_protector_prepare
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard=sysreg		  \
+				-mstack-protector-guard-reg=sp_el0	  \
+				-mstack-protector-guard-offset=$(shell	  \
+			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
+					include/generated/asm-offsets.h))
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
index 58d15be11c4d..5884a2b02827 100644
--- a/arch/arm64/include/asm/stackprotector.h
+++ b/arch/arm64/include/asm/stackprotector.h
@@ -34,7 +34,8 @@ static __always_inline void boot_init_stack_canary(void)
 	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
-	__stack_chk_guard = current->stack_canary;
+	if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
+		__stack_chk_guard = current->stack_canary;
 }
 
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5f2fe6..65b8afc84466 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -46,6 +46,9 @@ int main(void)
   DEFINE(TSK_TI_TTBR0,		offsetof(struct task_struct, thread_info.ttbr0));
 #endif
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
+#ifdef CONFIG_STACKPROTECTOR
+  DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
+#endif
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d9a4c2d6dd8b..8a2d68f04e0d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -59,7 +59,7 @@
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
-- 
2.19.2

s

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
