Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE90C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:04:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE582081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MF/6JkIW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PV1dsF8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE582081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/Xgzd6pCJVP95/Emd2XtUiCwQeI09fQV7dh/Bxc7BjQ=; b=MF/6JkIWgvU39o
	6yjK18zhOtCp2hg2aHWvVE9uUWapXsftQWJy9Z7ioGjoU1FYf7ybQQ/rCV+QY0KkFhRs9JqP+ip4B
	SglGvK1S5gK+9SIJiZhdGMc92v0SPWqwAzuJ9mAfFt9DtKCPy0pelB2ZfuwBnRiH/cTjKWiE9KkwY
	wKzkvE/3uKizspAIkVGWrmtz266nZFooNAK21SOWTstPPvfzdzg1fInjm3Wug3vjmSXqypJUDqaAm
	dfddH807qrTUnfmxbiR8fw48J7fSpfTSBaPyjRNNFWOIZJX0LOwWGH39wpg1auR0Bmad2lFZNewTy
	lFPoaeu6arbnAkQfZx2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTre0-00059Q-Tg; Mon, 03 Dec 2018 17:04:28 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrdw-00058l-QH
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:04:26 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so12981935wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=60XAvdPY644yAj1trw+YuG8h1xXNYKykMI5dp0ulurA=;
 b=PV1dsF8y5JNqqgQhzP3XxY9wOEhc9bTMgrrEVGqlNMLOXoqKU8dGvL9Zq0/E+wMzXG
 E3TlfKMe1tFwGmRSZtfa47cPNeNE6tL0GxyypiYd1Ovdrhyh8gxV8QgkY0wWOfA/3xbQ
 7HYoHfU3PpFKmxGS4HNPjh0ZTMyP+YRKNeCsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=60XAvdPY644yAj1trw+YuG8h1xXNYKykMI5dp0ulurA=;
 b=XDlGKXfsbmYxu4JzFyoVLaM4OWb4/8FygFJI/W2W6FoJtixLt3HK/BKFtUreWZent4
 dn2//YV83rpiioyMwlM0F8DmUS0eSsXILh+mAAh7Kbm+rkGzmFlHpOAc08+Xy7V9I5f7
 Tyh+pP2e//GEzUv6Wr7Wxq5+0FFFCXf0GzMqK80wK9iY2wCRJiJTKJfRSsX7OWeNIGIr
 8fNHIHcaSeIndk/LghqqHiLNXP3+dPpliEegO5xQXfdURYzQ1QpTS/ywN7+tJipX3OE6
 GA2cTmZuAkTbxZWdLwDp9UX83jldtemUwUfmSBZC7nn5VVVU+UBKLbChH1uRSWFcAaR2
 B90A==
X-Gm-Message-State: AA+aEWZmulzffGftq6M7G6iYJXwuocz26UnxZi4J84mwrSG6GVulwhUH
 mJo890Q4g9eOH5S3PAoJjMIlYISck1iVfw==
X-Google-Smtp-Source: AFSGD/U8DNpA2yJJ05PkoXuW+HBTY/NzvnaQZagk2zV2HbphvxsjVq6WZdXQpo8UPV5n56li95jKVg==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr15466973wro.78.1543856651871; 
 Mon, 03 Dec 2018 09:04:11 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id q2sm14722302wru.56.2018.12.03.09.04.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 09:04:10 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: enable per-task stack canaries
Date: Mon,  3 Dec 2018 18:03:43 +0100
Message-Id: <20181203170343.2602-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_090424_867217_38F5F083 
X-CRM114-Status: GOOD (  14.68  )
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
 keescook@chromium.org, arnd@arndb.de,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, will.deacon@arm.com,
 Ramana.Radhakrishnan@arm.com, labbott@fedoraproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This enables the use of per-task stack canary values if GCC has
support for emitting the stack canary reference relative to the
value of sp_el0, which holds the task struct pointer in the arm64
kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Note that the cc-option invocation below relies on the fact that Ramana's
current implementation of the GCC support permits -mstack-protector-guard=sysreg
to appear without defining the register name or offset.

The $(eval) extends KBUILD_CFLAGS at the moment the make rule is applied,
which means asm-offsets.o (which we rely on for the offset value) is built
without the arguments, and everything built afterwards has the options set.

 arch/arm64/Kconfig                      |  5 +++++
 arch/arm64/Makefile                     | 10 ++++++++++
 arch/arm64/include/asm/stackprotector.h |  3 ++-
 arch/arm64/kernel/asm-offsets.c         |  3 +++
 arch/arm64/kernel/process.c             |  2 +-
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..0d7fb47fe5e1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1272,6 +1272,11 @@ config RANDOMIZE_MODULE_REGION_FULL
 	  a limited range that contains the [_stext, _etext] interval of the
 	  core kernel, so branch relocations are always in range.
 
+config STACKPROTECTOR_PER_TASK
+	def_bool y
+	depends on STACKPROTECTOR
+	depends on $(cc-option,-mstack-protector-guard=sysreg)
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
