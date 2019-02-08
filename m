Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A4320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HLb7g6H7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UYLHZ3Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A4320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Date:
	Message-Id:References:In-Reply-To:Subject:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JnFf1qDpvFei7E+520P9h8BvmtgH1PpObZWKdyuyMqg=; b=HLb7g6H7ziZtyZ2WLMWJgjhNH0
	gwnoyuwkRFGSMYr80F2iVxhua/cywOoSDbZ39Ho74OUyxTbS3Pdl+gpldmnXsndnv80j2gS9OC+VV
	rWbMZB44gTJML80keyoaTUjxGYIbwh1ceKBYVqiEHIwIbTzW9UPf/siUi0WalJL9ePGFkajgqq9jy
	l+O47sYHvWRRJH0eIB4PSScVd+I+qly0GSPjDJCWpNDgysUqXyQX0XwMj7fJE+nZyO9ZmeDZlCIpD
	CBSGsCkh32vI+s1JsaN5oYKUPpJW1OUGPFFq/WOYHZ0gVylXKzG/tEDMDE9TSugg8Hzhqo0/yXLd0
	H40ZxRQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs831-0003YZ-3d; Fri, 08 Feb 2019 15:26:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs82y-0003Ie-RW
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 15:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=From:Date:Message-Id:References:
 In-Reply-To:Subject:Cc:To:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u5deY7nIp8p0TaPc+MYTZr7jgSMktdqt0g4G4u+Z2QY=; b=UYLHZ3WhNEOUiTaI0sheSBVsP
 koXHt5NyrE+p4UNSWV2MopYSpIqKxmKtwlPhiYgDwv4NwfVGkkfI6Sywr3vlR+COZDn9O5/7odn9/
 BULvdZsDSkKNDDQScLOtl8EYFOvLBylIicyhGxwq7E0lN03hwjLqEtWRYEiFEyZ8EOJ71aIgmoWnL
 tfaZ0GPwJorIxqPEMk1gD3h/GtmTby2n32qo37rnDvCu2VHpAWtFHO95tTEyeNbFUU9ZxuKmw7yUE
 wbBrhc7Q44Q7sWKDqiSyyqvDD0zA049RCdQ/8FGUPPbJRkJckcdD+7nhKa6oYQC+40BDgWOJuTNrr
 PWZCemnLw==;
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7nO-0000P3-LL
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:10:28 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 676A168DEE; Fri,  8 Feb 2019 16:10:24 +0100 (CET)
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v8 5/5] arm64: use -fpatchable-function-entry if available
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
Message-Id: <20190208151024.676A168DEE@newverein.lst.de>
Date: Fri,  8 Feb 2019 16:10:24 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_151026_736343_8B264E9A 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Test whether gcc supports -fpatchable-function-entry and use it to promote
DYNAMIC_FTRACE to DYNAMIC_FTRACE_WITH_REGS. Amend support for the new
object section that holds the locations (__patchable_function_entries) and
define a proper "notrace" attribute to switch it off.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/Kconfig                |    2 ++
 arch/arm64/Makefile               |    5 +++++
 include/asm-generic/vmlinux.lds.h |    1 +
 include/linux/compiler_types.h    |    2 ++
 kernel/module.c                   |    7 ++++++-
 5 files changed, 16 insertions(+), 1 deletion(-)
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,8 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
+		if $(cc-option,-fpatchable-function-entry=2)
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -89,6 +89,11 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
 endif
 
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
+  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FENTRY
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -113,6 +113,7 @@
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
+			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;
 #else
 #define MCOUNT_REC()
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -112,6 +112,8 @@ struct ftrace_likely_data {
 
 #if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
+#elif defined(CC_USING_PATCHABLE_FENTRY)
+#define notrace			__attribute__((patchable_function_entry(0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3122,7 +3122,12 @@ static int find_module_sections(struct m
 #endif
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 	/* sechdrs[0].sh_size is always zero */
-	mod->ftrace_callsites = section_objs(info, "__mcount_loc",
+	mod->ftrace_callsites = section_objs(info,
+#ifdef CC_USING_PATCHABLE_FENTRY
+					     "__patchable_function_entries",
+#else
+					     "__mcount_loc",
+#endif
 					     sizeof(*mod->ftrace_callsites),
 					     &mod->num_ftrace_callsites);
 #endif

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
