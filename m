Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC49FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:03:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEDA2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CwaRjew6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wqbqX1gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEDA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jgcOv2vUmTHkaNI+Z3kAp5PbeRg7Vph9JLrkDNDereM=; b=CwaRjew6To4ggZ
	b736sxNrH+H5f5V279m3lQhpyzTKvxCZda6Dtbm4KIic5a/1I3ZhkNDs5/X1v8yROq8Yv1mxhsXb5
	VbYs10hXO5GhjqGrAYdbGX5oCPXkje8HjADOF2PXN4uM0N0Fq5FgHGto3QC/xlprJvbRbdLnVp/4f
	x27eDjMsFdnJjY6DdPGI7nqTaIE7mqsGyEwDH9AFZ1jMMlbkcjjdJujvDqJd30HK+R4erqbheVN/j
	Hu7Lc9rA+KI3ojqskq6tvSye20XSv6tl+1VxQMO67jAzVWg2ijVmJkOgl4eBRuFysbwzSE/AYd7X7
	3/1iOYqoosQRZxWxk+OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUOp-0004vJ-H5; Thu, 13 Dec 2018 17:03:47 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUKu-00084w-9Z
 for linux-arm-kernel@bombadil.infradead.org; Thu, 13 Dec 2018 16:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v1WPdzLCPfn0P37K/jyuyPmhYPeRFjbt/cE7+PnN2yU=; b=wqbqX1gDfFCsmhgxwBjwgYCdl5
 Od7XeDK8nlJJmy06J6HQgGtFQVAEY6c3LBQTJmv4XPJoARKcEeNAOm8WeNb4ciPhyhDoVX/ZpzBYQ
 2HwYttYAXNKgkJL8N1CyI0gZuHhKJ8Oxqe62PqobcGEiR0IL3jc5+j4yahw05Tc+rA8cbZB8sA1tr
 hG7r8pmL848LS37BNvjK+UDQcb+UQAnw1CvzZhE+ZGpzZaoTWeyNMGv4wiP2wHKutyC5IZyp/zajG
 jVXeuSXZuZLeUpUc/ZK8cCz9XVDwJlKrxa7jwgW+vNQmvLAMOdsOw6S2dLRN3hJitj6iaqRiUffjb
 IdKkQITA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUKr-0005jN-84
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:59:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62FF315AB;
 Thu, 13 Dec 2018 08:59:28 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FD8C3F614;
 Thu, 13 Dec 2018 08:59:26 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 15/24] arm64: compat: vDSO setup for compat layer
Date: Thu, 13 Dec 2018 16:57:37 +0000
Message-Id: <20181213165746.56930-16-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_115941_448216_A7FEF924 
X-CRM114-Status: GOOD (  21.52  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If CONFIG_GENERIC_COMPAT_VDSO is enabled, compat vDSO are installed in a
compat (32 bit) process instead of sigpage.

This patch adds the necessary code to setup the vDSO required pages.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso.c | 60 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 7d1ad20fdb7b..e3f78875b0d4 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -41,10 +41,16 @@
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
+#ifdef CONFIG_COMPAT_VDSO
+extern char vdso32_start[], vdso32_end[];
+#endif /* CONFIG_COMPAT_VDSO */
 
 /* vdso_lookup arch_index */
 enum arch_vdso_type {
 	ARM64_VDSO = 0,
+#ifdef CONFIG_COMPAT_VDSO
+	ARM64_VDSO32 = 1,
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 struct __vdso_lookup_t {
@@ -64,6 +70,13 @@ static struct __vdso_lookup_t vdso_lookup[2] __ro_after_init = {
 		.vdso_code_start = vdso_start,
 		.vdso_code_end = vdso_end,
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "vdso32",
+		.vdso_code_start = vdso32_start,
+		.vdso_code_end = vdso32_end,
+	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 /*
@@ -179,23 +192,45 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	return __vdso_remap(ARM64_VDSO32, sm, new_vma);
+}
+#endif /* CONFIG_COMPAT_VDSO */
+
 /*
  * aarch32_vdso_pages:
  * 0 - kuser helpers
  * 1 - sigreturn code
+ * or (CONFIG_COMPAT_VDSO):
+ * 0 - kuser helpers
+ * 1 - vdso data
+ * 2 - vdso code
  */
 static struct page *aarch32_vdso_pages[2] __ro_after_init;
-static struct vm_special_mapping aarch32_vdso_spec[2] __ro_after_init = {
+static struct vm_special_mapping aarch32_vdso_spec[3] __ro_after_init = {
 	{
 		/* Must be named [vectors] for compatibility with arm. */
 		.name	= "[vectors]",
 		.pages	= &aarch32_vdso_pages[0],
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "[vvar]",
+	},
+	{
+		.name = "[vdso]",
+		.mremap = aarch32_vdso_mremap,
+	},
+#else
 	{
 		/* Must be named [sigpage] for compatibility with arm. */
 		.name	= "[sigpage]",
 		.pages	= &aarch32_vdso_pages[1],
 	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 #ifdef CONFIG_KUSER_HELPERS
@@ -227,6 +262,15 @@ static int aarch32_alloc_kuser_vdso_page(void)
 }
 #endif /* CONFIG_KUSER_HELPER */
 
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_init(void)
+{
+	vdso_lookup[ARM64_VDSO32].dm = &aarch32_vdso_spec[1];
+	vdso_lookup[ARM64_VDSO32].cm = &aarch32_vdso_spec[2];
+
+	return __vdso_init(ARM64_VDSO32);
+}
+#else
 static int aarch32_alloc_sigreturn_vdso_page(void)
 {
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
@@ -249,11 +293,16 @@ static int aarch32_alloc_sigreturn_vdso_page(void)
 	return 0;
 
 }
+#endif /* CONFIG_COMPAT_VDSO */
 
 static int __init aarch32_alloc_vdso_pages(void)
 {
 	return aarch32_alloc_kuser_vdso_page() &
+#ifdef CONFIG_COMPAT_VDSO
+	       aarch32_vdso_init();
+#else
 	       aarch32_alloc_sigreturn_vdso_page();
+#endif /* CONFIG_COMPAT_VDSO */
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
@@ -278,6 +327,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 }
 #endif /* CONFIG_KUSER_HELPERS */
 
+#ifndef CONFIG_COMPAT_VDSO
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
@@ -301,6 +351,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 out:
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_COMPAT_VDSO */
 
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
@@ -314,7 +365,14 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_COMPAT_VDSO
+	ret = __setup_additional_pages(ARM64_VDSO32,
+				       mm,
+				       bprm,
+				       uses_interp);
+#else
 	ret = aarch32_sigreturn_setup(mm);
+#endif /* CONFIG_COMPAT_VDSO */
 
 out:
 	up_write(&mm->mmap_sem);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
