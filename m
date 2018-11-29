Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C897C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:22:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0A220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OauxgiGl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAqUtdNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0A220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VOrRQQA42b6d60tq/CD4k6MULAXkkJ63V6ZFEeCYtSQ=; b=OauxgiGl6MmAB+
	pyuk0Do9SHFZn0qNnVpjXOhxDGYFhtVzPUCmCfmFXxKPb+r8gtiaLzI7wFCjUeztclaJGfzo/RwSi
	C3stvtvBOIIvV6/+Uw3R7UpZC9vKh+th4OyX/HzGAKMn2Cx+8Ov0rQpMyMPpe3/j0jZolne235P0o
	ScrbYlOO05DxLZDeAF1f1duX2zGXrJMbxWW1GtboZGggdgWmspMiN19h+btbQk965WFueq7DHAGTJ
	JJUGKqGDoGIbN9fbvgZcofiYdKpcfPXxERcTrPjd1W1mV1vi44/EdgUnqaSOOTZcJP16ZJlLlj+F9
	Ubx15/htG25daX6ZTDiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQ1T-0005l0-GO; Thu, 29 Nov 2018 17:22:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQ0g-0004s7-Px
 for linux-arm-kernel@bombadil.infradead.org; Thu, 29 Nov 2018 17:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d5vrQ62wrBggk6TT4W/562X019VFh2ntxz60HfvPGao=; b=PAqUtdNEz+CwwKDG2LnikY3/ea
 erns1g6Na8F9y1yMSEdY/obK0TsbfirPovNfPQst+9hPcUgirfO4wgVeIcolJV5QLMUZ+ze7ZTJSF
 BP7zm2it3pdQMUhzHBnzig3yUq9p0fn49yATC0BFrhhz9yJ1sk/wlSgNodUAYf7FDuK5gcxBh9XVU
 WUnoAvFHq1AM3N0Q96dETveDcsxjEtvB3Iyl/6rRZ8oWFZ2wiAnNUTqVOPknVWaZxeTdi8TE7vjSJ
 Im13IkQI43il4UIJuPGCuq4mj3gU+kcUM9BtSCYpYzoybdUvqJFqQWr29c7wW6wqX0C23qQdvdrKP
 SvEqzvmg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPly-0002qj-PH
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:06:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 603A3A78;
 Thu, 29 Nov 2018 09:06:42 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CF1B3F59C;
 Thu, 29 Nov 2018 09:06:40 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 20/28] arm64: elf: vDSO code page discovery
Date: Thu, 29 Nov 2018 17:05:22 +0000
Message-Id: <20181129170530.37789-21-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_170642_964873_682F64A1 
X-CRM114-Status: GOOD (  11.61  )
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

Like in normal vDSOs, when compat vDSOs are enabled the auxiliary
vector symbol AT_SYSINFO_EHDR needs to point at the address of the
vDSO code, to allow the dynamic linker to find it.

This patch adds the necessary code to the elf arm64 module to make this
possible.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/elf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index f2b6b486deb7..3fb46968da6a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -209,7 +209,21 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_GENERIC_COMPAT_VDSO
+#define COMPAT_ARCH_DLINFO						\
+do {									\
+	/*								\
+	 * Note that we use Elf64_Off instead of elf_addr_t because	\
+	 * elf_addr_t in compat is defined as Elf32_Addr and casting	\
+	 * current->mm->context.vdso to it triggers a cast warning of	\
+	 * cast from pointer to integer of different size.		\
+	 */								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+			(Elf64_Off)current->mm->context.vdso);		\
+} while (0)
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
