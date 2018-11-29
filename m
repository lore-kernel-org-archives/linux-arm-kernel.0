Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EE7C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:08:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C1F20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PDVKH/Fp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWuPb2Nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C1F20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTlwC0D3Vk2/TeZqNeYsygX33Fr0gf/+e70686NYmrU=; b=PDVKH/Fp8lLysL
	M2PI4YEQSRBJ869l0AlVi5Vs7zMIjxAJJgWA2I/OzY1VxQ5b8CK79klWkV4HeKZEcY64G3WXGriV8
	6Y8/OAWe4ZGNPd69btFAPivky5II819wh0TMALnL+7dFYnaYp4xGMjzHwwNtDWykP3T9+3hIqpVVX
	1FROlmouicSUgbrWRJTHcEZFWwKey/lu5Oej+7f7bXyN2eJiRSHv0AxkEUlN8hGFaGAVXet766a00
	LqEZQ3UGHwJm0/bA/9LdipTPE5dQAdAXKW7kYx+iBzqo2mVr9rT0K81B9LXMsNrtKNnKq3d0x9yYK
	RmZyHMOVZ/2skKfNurMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPnV-0002QM-Si; Thu, 29 Nov 2018 17:08:17 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPlr-0000xJ-Mf
 for linux-arm-kernel@bombadil.infradead.org; Thu, 29 Nov 2018 17:06:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1SE/JB99Zpf75zYGBdGBhJR/pjraPIF3TS0rfuV7Ljo=; b=rWuPb2NcvYawb9jx1Eqsno2Gj+
 /w9GWK0yZLZzAt3aQZW0HvjWSL6ZOlYQmi1/MMCtX00WsbOtZmug8PGLMRbyd8Q6HL8/wIrnEOGJZ
 hLg+6q7kPmNJwTGcqUBPME0Gfz2vxTOzDk7OG5sJlPX9bUYWgxCmQ0QnQDqUz4KERbn9k7Qx5szRP
 rYX+9OEB9rD5qwQ0o4E5f2dx2HAxuU6pUQM7C+NLPLpceqMjBbNxGYXXSNH9cIffb0pdxY/YZQ/bm
 k9xg92okXK1Mc4ZGHr9TsNWBisbBc7RiDSrgbUdrj4DFB2p/nEu3oGS53FgtOjNytef181ZDladDX
 CA8a2FdQ==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPln-0002ys-Gy
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:06:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEFA15AB;
 Thu, 29 Nov 2018 09:06:23 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 984363F59C;
 Thu, 29 Nov 2018 09:06:21 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 12/28] arm64: compat: Add KUSER_HELPERS config option
Date: Thu, 29 Nov 2018 17:05:14 +0000
Message-Id: <20181129170530.37789-13-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_120631_750022_26A76A78 
X-CRM114-Status: GOOD (  26.29  )
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

When kuser helpers are enabled the kernel maps the relative code at
a fixed address (0xffff0000). Making configurable the option to disable
them means that the kernel can remove this mapping and any access to
this memory area results in a sigfault.

This patch adds a KUSER_HELPERS config option that can be used to
disable the mapping when it is turned off.

This option can be turned off if and only if the applications are
designed specifically for the platform and they do not make use of the
kuser helpers code.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig          | 21 +++++++++++++++++++++
 arch/arm64/kernel/Makefile  |  3 ++-
 arch/arm64/kernel/kuser32.S |  7 +++----
 arch/arm64/kernel/vdso.c    | 15 +++++++++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 71ca1995a088..2c7d447401b5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1333,6 +1333,27 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config KUSER_HELPERS
+	bool "Enable kuser helpers page for compatibility with 32 bit applications."
+	depends on COMPAT
+	default y
+	help
+	  Enables kuser helpers to be mapped in a special purpose page at a fixed
+	  address to maintain independence from the type of CPU present in the SoC.
+	  This feature is provided for compatibility reasons in fact allows 32 bit
+	  applications compliant with ARMv4 up to ARMv8 to run without any
+	  modification.
+
+	  Warning: Being always mapped at a fixed address makes it easier to create
+	  exploits based on ROP type of attacks.
+
+	  As a consequence of this, this feature is made configurable but be aware that
+	  it can be turned off if and only if the binaries and the libraries running on
+	  a specific platform are designed to do not make use of these helpers, otherwise
+	  should be left on.
+
+	  See Documentation/arm/kernel_user_helpers.txt for details.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 6bd4f619732a..2fcba6b87829 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,8 +27,9 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o			\
 					   sigreturn32.o sys_compat.o
+arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index f19e2b015097..7d38633bf33f 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -5,10 +5,9 @@
  * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
  * Copyright (C) 2012-2018 ARM Ltd.
  *
- * Each segment is 32-byte aligned and will be moved to the top of the high
- * vector page.  New segments (if ever needed) must be added in front of
- * existing ones.  This mechanism should be used only for things that are
- * really small and justified, and not be abused freely.
+ * The kuser helpers below are mapped at a fixed address by
+ * aarch32_setup_additional_pages() ad are provided for compatibility
+ * reasons with 32 bit (aarch32) applications that need them.
  *
  * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
  */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index cee7205eefc5..8903087cca4c 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -74,6 +74,7 @@ static const struct vm_special_mapping aarch32_vdso_spec[2] = {
 	},
 };
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_alloc_kuser_vdso_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
@@ -95,6 +96,12 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	return 0;
 }
+#else
+static int aarch32_alloc_kuser_vdso_page(void)
+{
+	return 0;
+}
+#endif /* CONFIG_KUSER_HELPER */
 
 static int aarch32_alloc_sigreturn_vdso_page(void)
 {
@@ -126,6 +133,7 @@ static int __init aarch32_alloc_vdso_pages(void)
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
@@ -138,6 +146,13 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
+#else
+static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
+{
+	/* kuser helpers not enabled */
+	return 0;
+}
+#endif /* CONFIG_KUSER_HELPERS */
 
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
