Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD450C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:03:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CC720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2cl4UNG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bsw2Ehcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CC720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ARi05cYad2fwtdKxpfqsLVRHlfNEijVm1TVarVT91zo=; b=A2cl4UNGS0SHfLD9K9FCVGP7VU
	1Q0vcOq5NDIuTPLD2+ELhAUrIeQ91THK0WE2YA7731PHZ3zA8e3ei390uBvBDWJJf+OSCTcK8yZW5
	d5W17Tuys18fc6YNxewrOFnlNlF/SikaH68oM+X9IyzUUM22WUB/3FNgy/PDHq9zl0l3AY57xtKVS
	E910a+hRo0WO0AXQqurDs70ofvxHDEhdFsIp6gvl768PJYY1R6fFjKZbAdxCZ4JEaf+tyPvd19mQQ
	b2e1NtzxXNeRGrBNICejmedJ6PPSH+q1ScnFwApQEm6ZiNXuzsxDctiQ/TCGfDp+CHcHS9paSaK/g
	CscVR6/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPJc-0003tS-PG; Tue, 15 Jan 2019 14:03:40 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPEu-0005tJ-Et
 for linux-arm-kernel@bombadil.infradead.org; Tue, 15 Jan 2019 13:58:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=USvrnUb+XaiCOy85srZKfEq70QwtuwwoRbdPq0IylDM=; b=bsw2EhcfFvAfXv1XSEoC5bM0j
 XMpKDJifuqI0e/VBNhnAPRuvKuM/o4aktEXMcljJb6msjsNc6KxQ5hAq0Gp/wNzAv/91ydl+OHX9n
 I7bCH3lE/gZynJ9FyQXi4uu6qd0fdyeU4kLhNn8m7dh5l65X1cvczgPPJbsjA+l+1iCHHxOx/4llN
 t8uRV0A6PIvvnh7eGPgkQuDdi/pllKSCYBMpyEHRCqbHrNFL/Xf++ToenG8gXZrUz5mX2YL9uKMvb
 CWxBpLpnqOU3U1LyXWxlvyjxl7+gv0LXs/XGgh4igPnZLclbtcJTQm5MK8pPOVb/Z1JsUvFdK2Bu3
 8O2sQFUgA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPEr-0003pX-4m
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:58:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975B715BF;
 Tue, 15 Jan 2019 05:58:43 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2BC53F70D;
 Tue, 15 Jan 2019 05:58:41 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/4] uaccess: Check no rescheduling function is called in
 unsafe region
Date: Tue, 15 Jan 2019 13:58:28 +0000
Message-Id: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_085845_383302_E927FA11 
X-CRM114-Status: GOOD (  19.12  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While running a user_access regions, it is not supported to reschedule.
Add an overridable primitive to indicate whether a user_access region is
active and check that this is not the case when calling rescheduling
functions.

These checks are only performed when DEBUG_UACCESS_SLEEP is selected.

Also, add a comment clarifying the behaviour of user_access regions.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
 include/linux/kernel.h  | 11 +++++++++--
 include/linux/uaccess.h | 13 +++++++++++++
 kernel/sched/core.c     | 22 ++++++++++++++++++++++
 lib/Kconfig.debug       |  8 ++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e..73f1f82 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -237,11 +237,18 @@
 struct pt_regs;
 struct user;

+#ifdef CONFIG_DEBUG_UACCESS_SLEEP
+extern void __might_resched(const char *file, int line);
+#else
+#define __might_resched(file, line) do { } while (0)
+#endif
+
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int _cond_resched(void);
-# define might_resched() _cond_resched()
+# define might_resched() \
+	do { __might_resched(__FILE__, __LINE__); _cond_resched(); } while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() __might_resched(__FILE__, __LINE__)
 #endif

 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 37b226e..2c0c39e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -263,6 +263,15 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))

+/*
+ * user_access_begin() and user_access_end() define a region where
+ * unsafe user accessors can be used. Exceptions and interrupt shall exit the
+ * user_access region and re-enter it when returning to the interrupted context.
+ *
+ * No sleeping function should get called during a user_access region - we rely
+ * on exception handling to take care of the user_access status for us, but that
+ * doesn't happen when directly calling schedule().
+ */
 #ifndef user_access_begin
 #define user_access_begin(ptr,len) access_ok(ptr, len)
 #define user_access_end() do { } while (0)
@@ -270,6 +279,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
 #endif

+#ifndef unsafe_user_region_active
+#define unsafe_user_region_active()	false
+#endif
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void usercopy_warn(const char *name, const char *detail, bool to_user,
 		   unsigned long offset, unsigned long len);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a674c7db..b1bb7e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
 		__schedule_bug(prev);
 		preempt_count_set(PREEMPT_DISABLED);
 	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
+	    unlikely(unsafe_user_region_active())) {
+		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
+		       prev->comm, prev->pid, preempt_count());
+		dump_stack();
+	}
+
 	rcu_sleep_check();

 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
@@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 EXPORT_SYMBOL(___might_sleep);
 #endif

+#ifdef CONFIG_DEBUG_UACCESS_SLEEP
+void __might_resched(const char *file, int line)
+{
+	if (!unsafe_user_region_active())
+		return;
+
+	printk(KERN_ERR
+		"BUG: rescheduling function called from user access context at %s:%d\n",
+			file, line);
+	dump_stack();
+}
+EXPORT_SYMBOL(__might_resched);
+#endif
+
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b2..d030e31 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2069,6 +2069,14 @@ config IO_STRICT_DEVMEM

 	  If in doubt, say Y.

+config DEBUG_UACCESS_SLEEP
+	bool "Check sleep inside a user access region"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, various routines which may sleep will become very
+	  noisy if they are called inside a user access region (i.e. between
+	  a user_access_begin() and a user_access_end())
+
 source "arch/$(SRCARCH)/Kconfig.debug"

 endmenu # Kernel hacking
--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
