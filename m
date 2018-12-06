Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B50AC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E488021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G9nl2HEj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqbB8I8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E488021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AVaDkmR1YXxgAuZICINywdi3hAohWz2arRMvyI/QM7Q=; b=G9nl2HEjl05OnE
	9xz+df3/H+dej/HlZYY+dyk7r6fNRx4tyLyMdPK0LMbojKxwT5L8xUiZkx0epNZk1V+0M5chmTq6p
	slQ6Lo5f+r58trZn6Mnns7t+LrRpMMFDqXOkGkZ6NJ3h4lRBd70Rjo6friDVgOuW748//SCxX44Qz
	NnrM2Y1dJL4OViZbbm/ws1pyGWyFHaTIXKQT7tQllUSfUotqoBCt7w92cqLSevbivPSHNVOOslXGd
	4TMDoFjVF4yCm6NUj9FiGn4AP+0NYrUXPoKNLtJpDkbmSl2x2F7zWTwuI6y64FfHD2l5Du0GGMi+8
	c3NdCeKhPP/8U17EYpkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUp8x-0006Pi-Ub; Thu, 06 Dec 2018 08:36:23 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUp8q-0006P0-RW
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 08:36:22 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so22320839wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 00:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k8piYFi7GmPmirEREfvSuHHPQo5FG6pgsnTHA0vdVzc=;
 b=KqbB8I8g5IDTO2JVtK4mCE9xtIlMC6Ru6knim+BHGInpcHhR+vwK05LiHf91dFXisM
 bLsj8uI1V0vhy135GBDLWOvZm26/yFzA7gApgv7ucKZqUdI5+W+ydNKLrXQTB/+VfkY7
 DdikhPq3vgFIPAGODSFQyqH4p3Y2/Mpp8gMo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k8piYFi7GmPmirEREfvSuHHPQo5FG6pgsnTHA0vdVzc=;
 b=M8OwHeG7H3Wnwi33wWiBsD0uernUyQOpX3jTO+OGxwfuuR4YBgcGjOIakuhHOyu6+B
 l1FrJbEe0E6GGH/46ptIEg6u8aXoGG1u4eR5/bprlpUUCrjHNztt2N/i5AL6hSGMinEy
 GPyCL+bCPfAa0oeqMACdgpDazSVjx0nTo3Ls0KLJDpO4O0RJI3UIziEfYC8egKqtiIrG
 Wpy7t4LfrBKGkfGnfYva/Tjv0QM309vZnTlk2YeEIrS2RlV8EgIZQT6KZBbJG+HKQcWD
 /sYVIzUPnmXO+W8SMoZwfuGSWGOrNF/m4/YihW/ziwShSKjknWlds6Oo6rKFoJ4onnxP
 LAsg==
X-Gm-Message-State: AA+aEWZunr9o1HuhPWUfdJL8LhylCmld/dsyCa7kBdEnxCIN3PPpNdbl
 oO0BRn+itwS5tY5Fkvde/hqnXw==
X-Google-Smtp-Source: AFSGD/U0C1z+MgPsdZztqIyZrXahfbaD8YB/nzZ897FMh2y1I2YmQ23F5IUO/yGJPxFeepEXC6rsdg==
X-Received: by 2002:adf:f691:: with SMTP id v17mr23492446wrp.114.1544085364427; 
 Thu, 06 Dec 2018 00:36:04 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:992c:f260:a375:8d9e])
 by smtp.gmail.com with ESMTPSA id y9sm21084151wrq.55.2018.12.06.00.36.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 00:36:03 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux@armlinux.org.uk
Subject: [PATCH v3] ARM: smp: add support for per-task stack canaries
Date: Thu,  6 Dec 2018 09:32:57 +0100
Message-Id: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_003616_901451_200B5567 
X-CRM114-Status: GOOD (  29.83  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 kernel-hardening@lists.openwall.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Emese Revfy <re.emese@gmail.com>,
 Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On ARM, we currently only change the value of the stack canary when
switching tasks if the kernel was built for UP. On SMP kernels, this
is impossible since the stack canary value is obtained via a global
symbol reference, which means
a) all running tasks on all CPUs must use the same value
b) we can only modify the value when no kernel stack frames are live
   on any CPU, which is effectively never.

So instead, use a GCC plugin to add a RTL pass that replaces each
reference to the address of the __stack_chk_guard symbol with an
expression that produces the address of the 'stack_canary' field
that is added to struct thread_info. This way, each task will use
its own randomized value.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Laura Abbott <labbott@redhat.com>
Cc: kernel-hardening@lists.openwall.com
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3:
- enable the feature automatically if CONFIG_STACKPROTECTOR and
  CONFIG_GCC_PLUGINS are both enabled
- move the stack canary to the front of struct thread_info so it shares
  a cacheline with the flags, preempt_count and task pointer members
- fix incorrect reference to task_struct::stack_canary in previous
  version

 arch/arm/Kconfig                              |  15 +++
 arch/arm/Makefile                             |  12 +++
 arch/arm/boot/compressed/Makefile             |   1 +
 arch/arm/include/asm/stackprotector.h         |  12 ++-
 arch/arm/include/asm/thread_info.h            |   3 +
 arch/arm/kernel/asm-offsets.c                 |   4 +
 arch/arm/kernel/process.c                     |   6 +-
 scripts/Makefile.gcc-plugins                  |   6 ++
 scripts/gcc-plugins/Kconfig                   |   4 +
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 103 ++++++++++++++++++++
 10 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..5c0305585a0a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1810,6 +1810,21 @@ config XEN
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
 
+config STACKPROTECTOR_PER_TASK
+	bool "Use a unique stack canary value for each task"
+	depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED_DATA
+	select GCC_PLUGIN_ARM_SSP_PER_TASK
+	default y
+	help
+	  Due to the fact that GCC uses an ordinary symbol reference from
+	  which to load the value of the stack canary, this value can only
+	  change at reboot time on SMP systems, and all tasks running in the
+	  kernel's address space are forced to use the same canary value for
+	  the entire duration that the system is up.
+
+	  Enable this option to switch to a different method that uses a
+	  different canary value for each task.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 05a91d8b89f3..0436002d5091 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -303,6 +303,18 @@ else
 KBUILD_IMAGE := $(boot)/zImage
 endif
 
+ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
+prepare: stack_protector_prepare
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += \
+		-fplugin-arg-arm_ssp_per_task_plugin-tso=$(shell	\
+			awk '{if ($$2 == "THREAD_SZ_ORDER") print $$3;}'\
+				include/generated/asm-offsets.h)	\
+		-fplugin-arg-arm_ssp_per_task_plugin-offset=$(shell	\
+			awk '{if ($$2 == "TI_STACK_CANARY") print $$3;}'\
+				include/generated/asm-offsets.h))
+endif
+
 all:	$(notdir $(KBUILD_IMAGE))
 
 
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 1f5a5ffe7fcf..01bf2585a0fa 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -101,6 +101,7 @@ clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S \
 		$(libfdt) $(libfdt_hdrs) hyp-stub.S
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += $(DISABLE_ARM_SSP_PER_TASK_PLUGIN)
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
diff --git a/arch/arm/include/asm/stackprotector.h b/arch/arm/include/asm/stackprotector.h
index ef5f7b69443e..72a20c3a0a90 100644
--- a/arch/arm/include/asm/stackprotector.h
+++ b/arch/arm/include/asm/stackprotector.h
@@ -6,8 +6,10 @@
  * the stack frame and verifying that it hasn't been overwritten when
  * returning from the function.  The pattern is called stack canary
  * and gcc expects it to be defined by a global variable called
- * "__stack_chk_guard" on ARM.  This unfortunately means that on SMP
- * we cannot have a different canary value per task.
+ * "__stack_chk_guard" on ARM.  This prevents SMP systems from using a
+ * different value for each task unless we enable a GCC plugin that
+ * replaces these symbol references with references to each task's own
+ * value.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -16,6 +18,8 @@
 #include <linux/random.h>
 #include <linux/version.h>
 
+#include <asm/thread_info.h>
+
 extern unsigned long __stack_chk_guard;
 
 /*
@@ -33,7 +37,11 @@ static __always_inline void boot_init_stack_canary(void)
 	canary ^= LINUX_VERSION_CODE;
 
 	current->stack_canary = canary;
+#ifndef CONFIG_STACKPROTECTOR_PER_TASK
 	__stack_chk_guard = current->stack_canary;
+#else
+	current_thread_info()->stack_canary = current->stack_canary;
+#endif
 }
 
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 8f55dc520a3e..286eb61c632b 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -53,6 +53,9 @@ struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	__u32			cpu;		/* cpu */
 	__u32			cpu_domain;	/* cpu domain */
+#ifdef CONFIG_STACKPROTECTOR_PER_TASK
+	unsigned long		stack_canary;
+#endif
 	struct cpu_context_save	cpu_context;	/* cpu context */
 	__u32			syscall;	/* syscall number */
 	__u8			used_cp[16];	/* thread used copro */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 3968d6c22455..28b27104ac0c 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -79,6 +79,10 @@ int main(void)
 #ifdef CONFIG_CRUNCH
   DEFINE(TI_CRUNCH_STATE,	offsetof(struct thread_info, crunchstate));
 #endif
+#ifdef CONFIG_STACKPROTECTOR_PER_TASK
+  DEFINE(TI_STACK_CANARY,	offsetof(struct thread_info, stack_canary));
+#endif
+  DEFINE(THREAD_SZ_ORDER,	THREAD_SIZE_ORDER);
   BLANK();
   DEFINE(S_R0,			offsetof(struct pt_regs, ARM_r0));
   DEFINE(S_R1,			offsetof(struct pt_regs, ARM_r1));
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 82ab015bf42b..16601d1442d1 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -39,7 +39,7 @@
 #include <asm/tls.h>
 #include <asm/vdso.h>
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
@@ -267,6 +267,10 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	thread_notify(THREAD_NOTIFY_COPY, thread);
 
+#ifdef CONFIG_STACKPROTECTOR_PER_TASK
+	thread->stack_canary = p->stack_canary;
+#endif
+
 	return 0;
 }
 
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 46c5c6809806..048179d8c07f 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -36,6 +36,12 @@ ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 endif
 export DISABLE_STACKLEAK_PLUGIN
 
+gcc-plugin-$(CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK) += arm_ssp_per_task_plugin.so
+ifdef CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK
+    DISABLE_ARM_SSP_PER_TASK_PLUGIN += -fplugin-arg-arm_ssp_per_task_plugin-disable
+endif
+export DISABLE_ARM_SSP_PER_TASK_PLUGIN
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 0d5c799688f0..d45f7f36b859 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -190,4 +190,8 @@ config STACKLEAK_RUNTIME_DISABLE
 	  runtime to control kernel stack erasing for kernels built with
 	  CONFIG_GCC_PLUGIN_STACKLEAK.
 
+config GCC_PLUGIN_ARM_SSP_PER_TASK
+	bool
+	depends on GCC_PLUGINS && ARM
+
 endif
diff --git a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
new file mode 100644
index 000000000000..de70b8470971
--- /dev/null
+++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "gcc-common.h"
+
+__visible int plugin_is_GPL_compatible;
+
+static unsigned int sp_mask, canary_offset;
+
+static unsigned int arm_pertask_ssp_rtl_execute(void)
+{
+	rtx_insn *insn;
+
+	for (insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		const char *sym;
+		rtx body;
+		rtx masked_sp;
+
+		/*
+		 * Find a SET insn involving a SYMBOL_REF to __stack_chk_guard
+		 */
+		if (!INSN_P(insn))
+			continue;
+		body = PATTERN(insn);
+		if (GET_CODE(body) != SET ||
+		    GET_CODE(SET_SRC(body)) != SYMBOL_REF)
+			continue;
+		sym = XSTR(SET_SRC(body), 0);
+		if (strcmp(sym, "__stack_chk_guard"))
+			continue;
+
+		/*
+		 * Replace the source of the SET insn with an expression that
+		 * produces the address of the copy of the stack canary value
+		 * stored in struct thread_info
+		 */
+		masked_sp = gen_reg_rtx(Pmode);
+
+		emit_insn_before(gen_rtx_SET(masked_sp,
+					     gen_rtx_AND(Pmode,
+							 stack_pointer_rtx,
+							 GEN_INT(sp_mask))),
+				 insn);
+
+		SET_SRC(body) = gen_rtx_PLUS(Pmode, masked_sp,
+					     GEN_INT(canary_offset));
+	}
+	return 0;
+}
+
+#define PASS_NAME arm_pertask_ssp_rtl
+
+#define NO_GATE
+#include "gcc-generate-rtl-pass.h"
+
+__visible int plugin_init(struct plugin_name_args *plugin_info,
+			  struct plugin_gcc_version *version)
+{
+	const char * const plugin_name = plugin_info->base_name;
+	const int argc = plugin_info->argc;
+	const struct plugin_argument *argv = plugin_info->argv;
+	int tso = 0;
+	int i;
+
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		error(G_("incompatible gcc/plugin versions"));
+		return 1;
+	}
+
+	for (i = 0; i < argc; ++i) {
+		if (!strcmp(argv[i].key, "disable"))
+			return 0;
+
+		/* all remaining options require a value */
+		if (!argv[i].value) {
+			error(G_("no value supplied for option '-fplugin-arg-%s-%s'"),
+			      plugin_name, argv[i].key);
+			return 1;
+		}
+
+		if (!strcmp(argv[i].key, "tso")) {
+			tso = atoi(argv[i].value);
+			continue;
+		}
+
+		if (!strcmp(argv[i].key, "offset")) {
+			canary_offset = atoi(argv[i].value);
+			continue;
+		}
+		error(G_("unknown option '-fplugin-arg-%s-%s'"),
+		      plugin_name, argv[i].key);
+		return 1;
+	}
+
+	/* create the mask that produces the base of the stack */
+	sp_mask = ~((1U << (12 + tso)) - 1);
+
+	PASS_INFO(arm_pertask_ssp_rtl, "expand", 1, PASS_POS_INSERT_AFTER);
+
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  NULL, &arm_pertask_ssp_rtl_pass_info);
+
+	return 0;
+}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
