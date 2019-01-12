Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9491C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:57:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62F52133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OPixFSSF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRnKx3i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62F52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=SE6FA2UWlpEf4LwL6BuQVUa7urp+50WOO2BJVHhH5ms=; b=OPi
	xFSSFQ/uaFhq99Xeh/AVAsXbSVp8ANrIiyp8Z1gGt5/lAUnlkETp6jhGUcowYGJTQNEddQzMNdctn
	LOUhOhDYOfxYAnMjp1YvGLW+K/9r913abCAZGox8Nkhq1sbcR0F6rEJ0TTL2Sd12kRqln/l+WOMrb
	Ly4cdPg6LmOzr7aJiD/BfyhckL/ZRP4wA4H/kBWIvWwze+HJNYY4bpl5mllzhTA7F4lwIPxc7WKmO
	BJnvKVuaUi+jBH73j4ovVJtZw201Dkm9TKBlo4P1vL+oyB3WJrTt7hIoqPlLv7UOMcoIUJNq5vzKD
	5KamOg6v2yWeUYFdeSX4w4yUuEY7XTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giDEi-0006hJ-LC; Sat, 12 Jan 2019 06:57:40 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giDEe-0006gt-Sz
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 06:57:38 +0000
Received: by mail-pg1-x544.google.com with SMTP id c25so7258658pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Kza12m7mTDBONx6xi5B5vA7x0Xzdj0O3Hs4RtEGS2Gc=;
 b=DRnKx3i8jJjaPY0uutVGwG0B9vDcdRUqdWHEnke0rv4pIdKoZXB2ysOmYAWYBlMXvQ
 +BRkFfsrtM9t2vVsaEijO0ND4dz8lSRq6KB2ujujO0gV7JbJa/xDXFIreARiZ6Drq2T6
 y3pUsT4bL40yrtjRodOwbDB4zD3zaHKB/m24kAIsm/vPxgX2PkJz6Ox2zElwEboRGbw9
 BNvSXzknS5uVGmA2spzuVTuuMofQ5NuCRPUOXFm8hA1/t645ecgYr9biAD2WZxvPM2so
 oZTTom+84qAXWM1jNR+IJcwrPM/NXrEbHjET3ZSVDNkJDmuK3HNcFHkYwbmYTIIjSqdB
 oozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Kza12m7mTDBONx6xi5B5vA7x0Xzdj0O3Hs4RtEGS2Gc=;
 b=cepjg0JOHr3bITBqIR3xMNLfQBXhKTxLoCokH6qalWpiZoXCV8DU9B07lqsjgWQGch
 SgkDoKhpNotce+lOxiVTd203roD09Y57gLl5G4J5JWAp5A9gtKc2+dT96qcAydBGllPP
 emzbinw75r1XO64rdo7/yJZ1m2r/qjJXxIsFd9hEDAjgBQg5rDFQwVrGifvOlu/gRs/8
 UHDkxUrH3aDXIJVWmZ3350QkcdFcfqsuVZcMOQRFg0uizTdMt5RvEZtspyE9G6Zy/ybK
 qly46cybUUprIHNlbczWL9H4bcRqx9+ZxlpktAvXJC52WFijRIMmBo/iYRlrTy5JeXZj
 hAeg==
X-Gm-Message-State: AJcUukeP4fDoC/zFPFKudLrcH5oYfTmiPUmk5MgjakVW4lmwcNGZq8W2
 xvocxPFLOVuNh+bN/Ffavvk=
X-Google-Smtp-Source: ALg8bN6qqn85YLWnsEtZ05uFg7SUkDNe7Tp0gp35NkCUrZWA+TsG9p6cknpk0KLogkFSkEL3sqSQpQ==
X-Received: by 2002:a62:3141:: with SMTP id x62mr17415870pfx.12.1547276254693; 
 Fri, 11 Jan 2019 22:57:34 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
 by smtp.gmail.com with ESMTPSA id 4sm131917577pfq.10.2019.01.11.22.57.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 22:57:34 -0800 (PST)
From: Changbin Du <changbin.du@gmail.com>
To: rostedt@goodmis.org
Subject: [PATCH] fgraph: record function return value
Date: Sat, 12 Jan 2019 14:57:01 +0800
Message-Id: <20190112065701.30841-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_225736_968982_B835AE55 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 Changbin Du <changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds a new trace option 'funcgraph-retval' and is disabled by
default. When this option is enabled, fgraph tracer will show the return
value of each function. This is useful to find/analyze a original error
source in a call graph.

One limitation is that kernel doesn't know the prototype of functions. So
fgraph assumes all functions have a retvalue of type int. You must ignore
the value of *void* function. And if the retvalue looks like an error code
then both hexadecimal and decimal number are displayed.

In this patch, only x86 and ARM platforms are supported.

Here is example showing the error is caused by vmx_create_vcpu() and the
error code is -5 (-EIO).

with echo 1 > /sys/kernel/debug/tracing/options/funcgraph-retval

 3)               |  kvm_vm_ioctl() {
 3)               |    mutex_lock() {
 3)               |      _cond_resched() {
 3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
 3)   0.704 us    |      } /* ret=0x0 */
 3)   1.226 us    |    } /* ret=0x0 */
 3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
 3)               |    kvm_arch_vcpu_create() {
 3)               |      vmx_create_vcpu() {
 3) + 17.969 us   |        kmem_cache_alloc(); /* ret=0xffff88813a980040 */
 3) + 15.948 us   |        kmem_cache_alloc(); /* ret=0xffff88813aa99200 */
 3)   0.653 us    |        allocate_vpid.part.88(); /* ret=0x1 */
 3)   6.964 us    |        kvm_vcpu_init(); /* ret=0xfffffffb */
 3)   0.323 us    |        free_vpid.part.89(); /* ret=0x1 */
 3)   9.985 us    |        kmem_cache_free(); /* ret=0x80000000 */
 3)   9.491 us    |        kmem_cache_free(); /* ret=0x80000000 */
 3) + 69.858 us   |      } /* ret=0xfffffffffffffffb/-5 */
 3) + 70.631 us   |    } /* ret=0xfffffffffffffffb/-5 */
 3)               |    mutex_lock() {
 3)               |      _cond_resched() {
 3)   0.199 us    |        rcu_all_qs(); /* ret=0x80000000 */
 3)   0.594 us    |      } /* ret=0x0 */
 3)   1.067 us    |    } /* ret=0x0 */
 3)   0.337 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
 3) + 92.730 us   |  } /* ret=0xfffffffffffffffb/-5 */

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/trace/ftrace.rst       |  5 ++++
 arch/arm/kernel/entry-ftrace.S       |  1 +
 arch/arm64/kernel/entry-ftrace.S     |  1 +
 arch/x86/kernel/ftrace_32.S          |  1 +
 arch/x86/kernel/ftrace_64.S          |  1 +
 include/linux/ftrace.h               |  1 +
 kernel/trace/Kconfig                 |  4 +++
 kernel/trace/fgraph.c                | 17 +++++++++++-
 kernel/trace/trace.h                 |  1 +
 kernel/trace/trace_entries.h         |  1 +
 kernel/trace/trace_functions_graph.c | 39 ++++++++++++++++++++++++----
 11 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 0131df7f5968..9a4581698eb5 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1227,6 +1227,11 @@ Options for function_graph tracer:
 	only a closing curly bracket "}" is displayed for
 	the return of a function.
 
+  funcgraph-retval - At the end of each function (the return) the
+    return value the function  (though the function may not
+    really have it) is displayed in hex and negative number
+    if it looks like a error code.
+
   sleep-time
 	When running function graph tracer, to include
 	the time a task schedules out in its function.
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index 0be69e551a64..e0d049e5873d 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -263,6 +263,7 @@ ENDPROC(ftrace_graph_regs_caller)
 	.globl return_to_handler
 return_to_handler:
 	stmdb	sp!, {r0-r3}
+	mov	r1, r0			@ return value
 	mov	r0, fp			@ frame pointer
 	bl	ftrace_return_to_handler
 	mov	lr, r0			@ r0 has real ret addr
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 81b8eb5c4633..223f4ad269d4 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -202,6 +202,7 @@ ENTRY(return_to_handler)
 	stp x4, x5, [sp, #32]
 	stp x6, x7, [sp, #48]
 
+	mov	x1, x0			// return value
 	mov	x0, x29			//     parent's fp
 	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
 	mov	x30, x0			// restore the original return address
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 4c8440de3355..02e84d39b0a0 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -234,6 +234,7 @@ END(ftrace_graph_caller)
 return_to_handler:
 	pushl	%eax
 	pushl	%edx
+	movl	%eax, %edx
 #ifdef CC_USING_FENTRY
 	movl	$0, %eax
 #else
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 75f2b36b41a6..d8247971b251 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -327,6 +327,7 @@ ENTRY(return_to_handler)
 	movq %rax, (%rsp)
 	movq %rdx, 8(%rsp)
 	movq %rbp, %rdi
+	movq %rax, %rsi
 
 	call ftrace_return_to_handler
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 730876187344..e6d688f7fba1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -744,6 +744,7 @@ struct ftrace_graph_ret {
 	unsigned long overrun;
 	unsigned long long calltime;
 	unsigned long long rettime;
+	unsigned long retval;
 	int depth;
 } __packed;
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fa8b1fe824f3..a5c456ec63e4 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -24,6 +24,9 @@ config HAVE_FUNCTION_GRAPH_TRACER
 	help
 	  See Documentation/trace/ftrace-design.rst
 
+config HAVE_FTRACE_RETVAL
+	bool
+
 config HAVE_DYNAMIC_FTRACE
 	bool
 	help
@@ -160,6 +163,7 @@ config FUNCTION_GRAPH_TRACER
 	depends on HAVE_FUNCTION_GRAPH_TRACER
 	depends on FUNCTION_TRACER
 	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
+	select HAVE_FTRACE_RETVAL if (X86 || ARM)
 	default y
 	help
 	  Enable the kernel to trace a function at both its return
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8dfd5021b933..df27fe3a35f9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -206,13 +206,15 @@ static struct notifier_block ftrace_suspend_notifier = {
  * Send the trace to the ring-buffer.
  * @return the original return address.
  */
-unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+static unsigned long _ftrace_return_to_handler(unsigned long frame_pointer,
+					       unsigned long retval)
 {
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 	trace.rettime = trace_clock_local();
+	trace.retval = retval;
 	ftrace_graph_return(&trace);
 	/*
 	 * The ftrace_graph_return() may still access the current
@@ -232,6 +234,19 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	return ret;
 }
 
+#if defined(CONFIG_HAVE_FTRACE_RETVAL)
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer,
+				       unsigned long retval)
+{
+	return _ftrace_return_to_handler(frame_pointer, retval);
+}
+#else
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+{
+	return _ftrace_return_to_handler(frame_pointer, 0);
+}
+#endif
+
 /**
  * ftrace_graph_get_ret_stack - return the entry of the shadow stack
  * @task: The task to read the shadow stack from
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 08900828d282..eb79c257cd13 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -859,6 +859,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_TAIL          0x80
 #define TRACE_GRAPH_SLEEP_TIME		0x100
 #define TRACE_GRAPH_GRAPH_TIME		0x200
+#define TRACE_GRAPH_PRINT_RETVAL	0x400
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 06bb2fd9a56c..695c2b528188 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -98,6 +98,7 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_desc(	unsigned long,	ret,		func	)
 		__field_desc(	unsigned long long, ret,	calltime)
 		__field_desc(	unsigned long long, ret,	rettime	)
+		__field_desc(	unsigned long,	ret,		retval	)
 		__field_desc(	unsigned long,	ret,		overrun	)
 		__field_desc(	int,		ret,		depth	)
 	),
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c2af1560e856..a66a573923d7 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -66,6 +66,11 @@ static struct tracer_opt trace_opts[] = {
 	{ TRACER_OPT(graph-time, TRACE_GRAPH_GRAPH_TIME) },
 #endif
 
+#ifdef CONFIG_HAVE_FTRACE_RETVAL
+	/* Display return value of function */
+	{ TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
+#endif
+
 	{ } /* Empty entry */
 };
 
@@ -608,6 +613,18 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 	trace_seq_puts(s, "|  ");
 }
 
+static void print_graph_retval(struct trace_seq *s, unsigned long val, bool comment)
+{
+	if (comment)
+		trace_seq_printf(s, " /* ");
+	if (IS_ERR_VALUE(val))
+		trace_seq_printf(s, "ret=0x%lx/%ld", val, val);
+	else
+		trace_seq_printf(s, "ret=0x%lx", val);
+	if (comment)
+		trace_seq_printf(s, " */");
+}
+
 /* Case of a leaf function on its call entry */
 static enum print_line_t
 print_graph_entry_leaf(struct trace_iterator *iter,
@@ -652,7 +669,10 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%ps();\n", (void *)call->func);
+	trace_seq_printf(s, "%ps();", (void *)call->func);
+	if (flags & TRACE_GRAPH_PRINT_RETVAL)
+		print_graph_retval(s, graph_ret->retval, true);
+	trace_seq_puts(s, "\n");
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -933,10 +953,19 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 	 * belongs to, write out the function name. Always do
 	 * that if the funcgraph-tail option is enabled.
 	 */
-	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
-		trace_seq_puts(s, "}\n");
-	else
-		trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
+	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL)) {
+		trace_seq_puts(s, "}");
+		if (flags & TRACE_GRAPH_PRINT_RETVAL)
+			print_graph_retval(s, trace->retval, true);
+		trace_seq_puts(s, "\n");
+	} else {
+		trace_seq_printf(s, "} /* %ps", (void *)trace->func);
+		if (flags & TRACE_GRAPH_PRINT_RETVAL) {
+			trace_seq_puts(s, ", ");
+			print_graph_retval(s, trace->retval, false);
+		}
+		trace_seq_puts(s, " */\n");
+	}
 
 	/* Overrun */
 	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
