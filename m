Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A54C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:58:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98B520848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lh4Yt/pr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSMfw0Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98B520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=umP7R+ipuEaMY4hQuTMhgXZ2ylw1H+0quS6QAru9GSM=; b=lh4Yt/prwbahAh
	Yl/YJEHpThVK9yGGlIc7MAbr6WfQT58LxMF2DnFiU9oHf8mCLjyZ/ZjyEP6Vv9Eidg41NwHS7bnqF
	K8WAQGELmYWQe3NzrpIgV4QKRnnr/YEgq5yz++iCHYuJnGBRThSwK3tRknAn8VqVsjSPVtu3+on94
	Tkq1a5LKcqTXrvLTnolowDsuKdtaDvAQZNLu2MBGAxQgPLPu60Zn1Wdcoxs/nYyxneIKXyAeBcJoZ
	NLfaMhCdWR7esGHLv+yQE9ZmkCtN+cSbcV2i5x5gXmLAOyjCYWzJ9HXsWBPnb2UWUu0snC+KiCrTs
	gAuNiz2vtcrsMJfbvXMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTuMN-0004pe-62; Mon, 03 Dec 2018 19:58:27 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTuMJ-0004os-Vf
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:58:25 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so13480416wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7ueTxmVtcjNuo32upzM+sqzQd8vZuKVa59gdCK6i1b0=;
 b=jSMfw0Bm32449wfT0YSKgya0B02WG3XQUNcwAUcyMjGsl2RehQRZ4eREIr1f9cB7OZ
 mYxRjhVU7OA1o1kF9ZIP9WRbrUneT/groliAx5QqW1DMvPpZXVLSOkfjwNMpCFmGiDKj
 LHW3LaTM0xejyvpbD+GgtFLSDQGR+I9uajJP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7ueTxmVtcjNuo32upzM+sqzQd8vZuKVa59gdCK6i1b0=;
 b=FUVdx4PVBDxMWyp4mp3t5yzO0m02OP9c6h91yrvaQr13O/EJLFKdYLX1DGQ0L0HjZi
 lprl20RiShBSDqUM+nELcQtpEqqqjbJ0oC6RKG8Rdm35+lBZbnk4rPewzhCuzeydEIrw
 0sFP/nWWjB2acEt9ON88p3Vz+SC5WDLd7WKYnDWiMLWxgCoWscOqOo8JuAheXEy2r5Hy
 +WTfQARe0K+L6pAGD6bfBYBksN7Bz7EIl1Nrw2mZ5DZzokS12OtF3i5gsSdFawZT9iP6
 p11VB1iqmMFdGkHhi4GdXceSVUD1OROGozkYsM59TIvc37dq9LHsWUsjS17uQmlZF02k
 iPKw==
X-Gm-Message-State: AA+aEWZMLMZ6Q4FMWXCF6P8SGFRcsetjTJZRrUDzf+oTQJuHdILjOCcM
 K9Ul9mf4U5/w1dfTP4s/W78/t9FooADJaw==
X-Google-Smtp-Source: AFSGD/W4KTqMKzHW+xCrze7WDKA6/uE/gzhBgXzng0Oh6h6ZOlZOw7FUagM9BiA+5WuVRLTQbAHyUQ==
X-Received: by 2002:a5d:64c7:: with SMTP id y7mr15329508wrv.207.1543867091012; 
 Mon, 03 Dec 2018 11:58:11 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:90ed:187a:cfaf:c404])
 by smtp.gmail.com with ESMTPSA id e19sm35210304wrc.25.2018.12.03.11.58.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:58:09 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: relocatable: fix inconsistencies in linker script and
 options
Date: Mon,  3 Dec 2018 20:58:05 +0100
Message-Id: <20181203195805.28835-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_115824_029183_4D5F70AF 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: catalin.marinas@arm.com, Peter Smith <peter.smith@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>, will.deacon@arm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

readelf complains about the section layout of vmlinux when building
with CONFIG_RELOCATABLE=y (for KASLR):

  readelf: Warning: [21]: Link field (0) should index a symtab section.
  readelf: Warning: [21]: Info field (0) should index a relocatable section.

Also, it seems that our use of '-pie -shared' is contradictory, and
thus ambiguous. In general, the way KASLR is wired up at the moment
is highly tailored to how ld.bfd happens to implement (and conflate)
PIE executables and shared libraries, so given the current effort to
support other toolchains, let's fix some of these issues as well.

- Drop the -pie linker argument and just leave -shared. In ld.bfd,
  the differences between them are unclear (except for the ELF type
  of the produced image [0]) but lld chokes on seeing both at the
  same time.

- Rename the .rela output section to .rela.dyn, as is customary for
  shared libraries and PIE executables, so that it is not misidentified
  by readelf as a static relocation section (producing the warnings
  above).

- Pass the -z notext and -z norelro options to explicitly instruct the
  linker to permit text relocations, and to omit the RELRO program
  header (which requires a certain section layout that we don't adhere
  to in the kernel). These are the defaults for current versions of
  ld.bfd.

- Discard .eh_frame and .gnu.hash sections to avoid them from being
  emitted between .head.text and .text, screwing up the section layout.

These changes only affect the ELF image, and produce the same binary
image.

[0] b9dce7f1ba01 ("arm64: kernel: force ET_DYN ELF type for ...")

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Smith <peter.smith@linaro.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
This supersedes

[RFT PATCH] arm64: relocatable: build the kernel as a proper shared library
[RFT PATCH] arm64: add support for building the KASLR kernel with LLVM lld

 arch/arm64/Makefile             | 2 +-
 arch/arm64/kernel/vmlinux.lds.S | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..8978f60779c4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -18,7 +18,7 @@ ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
 # for relative relocs, since this leads to better Image compression
 # with the relocation offsets always being zero.
-LDFLAGS_vmlinux		+= -pie -shared -Bsymbolic \
+LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext -z norelro \
 			$(call ld-option, --no-apply-dynamic-relocs)
 endif
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 03b00007553d..7fa008374907 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -99,7 +99,8 @@ SECTIONS
 		*(.discard)
 		*(.discard.*)
 		*(.interp .dynamic)
-		*(.dynsym .dynstr .hash)
+		*(.dynsym .dynstr .hash .gnu.hash)
+		*(.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -192,12 +193,12 @@ SECTIONS
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
-	.rela : ALIGN(8) {
+	.rela.dyn : ALIGN(8) {
 		*(.rela .rela*)
 	}
 
-	__rela_offset	= ABSOLUTE(ADDR(.rela) - KIMAGE_VADDR);
-	__rela_size	= SIZEOF(.rela);
+	__rela_offset	= ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
+	__rela_size	= SIZEOF(.rela.dyn);
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__initdata_end = .;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
