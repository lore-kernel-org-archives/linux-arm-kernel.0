Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B190C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:01:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265D92086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RvPOiHz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265D92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RS3bZ1+0wd6zzvh96SG0fQXlyYUbe/336OJ9Tbqqu+8=; b=RvP
	OiHz3qnHaBewpF7WgnFPW6QssCICFFfca5k3f6GEFQLaJFNWFCZwGNOhQW485MP2sjicbFjqfK0TX
	3jCYECMyGumORshI8YKLYWcXLuUTRxJLjMORXXMjLvNsi6YrER5S0unW+5FpQcrkouoBh6xYbo5HY
	7HEZ+0K9B3LDkQwPV4D0gVohd3KnpBT9pKSceH51PNcVs5Chi0KkZph4LsrhDm+jP3tpJm8pf882x
	1m2scYnUaxCyXyyOik6e/8juXlyOgGW5zdTrAFb+fnEkfYeudPIAmhwf6it0w6JianNNtAMMiKNvd
	8QpUf5hwCJ5kZqEbaQqDQThg/I0mf7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWaF-0006Rn-8x; Fri, 18 Jan 2019 16:01:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWZU-0006PJ-0i
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:00:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60AE9EBD;
 Fri, 18 Jan 2019 08:00:39 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14D63F557;
 Fri, 18 Jan 2019 08:00:36 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS macro
Date: Fri, 18 Jan 2019 16:00:27 +0000
Message-Id: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_080040_064627_CE1ED937 
X-CRM114-Status: UNSURE (   9.96  )
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
Cc: rjw@rjwysocki.net, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Steven Price <Steven.Price@arm.com>, Grant Likely <Grant.Likely@arm.com>,
 Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A common pattern found in header files is a function declaration dependent
on a CONFIG_ option being enabled, followed by an empty function for when
that option isn't enabled. This boilerplate code can often take up a lot
of space and impact code readability.

This series introduces a STUB_UNLESS macro that simplifies header files as
follows:

STUB_UNLESS(CONFIG_FOO, [body], prototype)

This evaluates to 'prototype' prepended with 'extern' if CONFIG_FOO is set
to 'y'. Otherwise it will evaluate to 'prototype' prepended with 'static
inline' followed by an empty function body. Where optional argument 'body'
is present then 'body' will be used as the function body, intended to allow
simple return statements. Using the macro results in hunks such as this:

-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-extern void hw_breakpoint_thread_switch(struct task_struct *next);
-extern void ptrace_hw_copy_thread(struct task_struct *task);
-#else
-static inline void hw_breakpoint_thread_switch(struct task_struct *next)
-{
-}
-static inline void ptrace_hw_copy_thread(struct task_struct *task)
-{
-}
-#endif
+STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
+void hw_breakpoint_thread_switch(struct task_struct *next));
+
+STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
+void ptrace_hw_copy_thread(struct task_struct *task));

This may or may not be considered as more desirable than the status quo.

This series updates arm64 and perf to use the macro as an example.

Andrew Murray (3):
  kconfig.h: abstract empty functions with STUB_UNLESS macro
  cpufreq: update headers to use STUB_UNLESS macro
  arm64: update headers to use STUB_UNLESS macro

 arch/arm64/include/asm/acpi.h           | 38 +++++++++-------------
 arch/arm64/include/asm/alternative.h    |  6 +---
 arch/arm64/include/asm/cpufeature.h     |  6 +---
 arch/arm64/include/asm/cpuidle.h        | 18 +++--------
 arch/arm64/include/asm/debug-monitors.h | 10 ++----
 arch/arm64/include/asm/fpsimd.h         | 57 +++++++++++++--------------------
 arch/arm64/include/asm/hw_breakpoint.h  | 16 +++------
 arch/arm64/include/asm/kasan.h          |  9 ++----
 arch/arm64/include/asm/numa.h           | 19 ++++-------
 arch/arm64/include/asm/ptdump.h         | 13 +++-----
 arch/arm64/include/asm/signal32.h       | 29 +++++------------
 include/linux/cpufreq.h                 | 21 ++++--------
 include/linux/kconfig.h                 | 31 ++++++++++++++++++
 13 files changed, 110 insertions(+), 163 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
