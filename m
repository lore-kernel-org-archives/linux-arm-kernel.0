Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AE3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:54:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388D82146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m4bmvkM6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOv3KAxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388D82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qiVQxvXOAAV5CVLaPbn17uRLN5E/KEQxFxW7/xQnkO0=; b=m4bmvkM6I3qV5i
	siFlK5YkJYr3M2lfrKGm0vgU+WHLGXY75FlXwoNqmeEspgQFZoB7RgKdAU/NXZObdp+CTky1eXalP
	ETxC57x7e+Md5/3mkbmmhXdddDvac46bVHRxHX/NXOQC3djGzThEWoDP6Tx7z4bwPntfO24B+GdFa
	Ls8uQDB8IV05oKb1uSEneBOnwx7bcq8j/+U6mcb/2+S6W1xgkXaqVUsjcptfd34xZOfh+qAqjS3Tz
	aPf4rnN9L94z5gHI3bsTofQ/E5+OIScM4ivnmcm7WusLTscSarVd6mtGhhHRjKfRO9nxAjipd3ryu
	sIt1vOc/uYOA1VxrpM5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT3qn-0005xU-Ui; Sat, 01 Dec 2018 11:54:21 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT3qk-0005x0-CI
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 11:54:19 +0000
Received: by mail-wm1-x343.google.com with SMTP id s14so1414782wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+uoJzSNA38HtSt1FqPvh9QAYPAyVJM9J0mgd2Tm+gAQ=;
 b=YOv3KAxAkXJLBEb7X5ZjtnT05TeCYZYfgo9a2Q09qUmsmHHMfa+IlJUDIQjG+a8EkM
 E4SImtE7ZCQHljrg+eJdijvSdDgdb/Zb754JZxqmmG1hAbPmRtkGWUmxNcHkYkAjmSLQ
 OXk3lt+nRNJUKzdzqKaVadxJRpGV0uz8OqJiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+uoJzSNA38HtSt1FqPvh9QAYPAyVJM9J0mgd2Tm+gAQ=;
 b=t9DIofgrwjLUsmqiUJcSmTKUq9pIFyJU3XzduNd7eFBCAwa3KbJR9JNFRt5vDlITCw
 lNFz2PY3sJT+VqZk/FZmQQUrq8YFRH/UqLf+WNSis61Rd9bqSF+d1nmoIhxs8mtfC/jS
 uBjNKS6ty7vCUWErV/n6VqLNCr2p4pQEqGsqOrrKApRQEq1fhbn0tE2mvYWlOHqsKkFy
 NP61oNVYY6sZDzcnmI+MgH6InrDq3Hcn5bq048H+JdnBCu54rJCeuBfnqaSrLeKbRrtw
 6lzh3f/na1gmEbxkeH57SjoU+HW8pJCt4bWQeJ5RNaBtx55Sq1KRyHz1bB6ccyG9NB/N
 lKiA==
X-Gm-Message-State: AA+aEWYnTrXGJBrGCfbGT6LMu4dM/S42ppnF54BNUuoyq/DZ7AP4z8XM
 FhJVp/xDlKiSSz1MIKor8rpWGgFSzbQ=
X-Google-Smtp-Source: AFSGD/V7GkkAaxZQLt7VewWwoA8mcJqw0DzjkpwR2p2kATBR/i+Rh7uwZ7MdJQMVWdMi6VpNNBxVZg==
X-Received: by 2002:a1c:93ca:: with SMTP id v193mr2160905wmd.82.1543665246195; 
 Sat, 01 Dec 2018 03:54:06 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:edfb:24ff:63d6:53d9])
 by smtp.gmail.com with ESMTPSA id q2sm7591156wru.56.2018.12.01.03.54.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 03:54:04 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH] arm64: relocatable: build the kernel as a proper shared
 library
Date: Sat,  1 Dec 2018 12:53:24 +0100
Message-Id: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_035418_416507_9173A375 
X-CRM114-Status: GOOD (  13.83  )
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
  shared libraries and PIE executables.

- Don't discard the .dynamic, .dynsym, .dynstr and .hash sections.
  Instead, make sure that they are [mostly] empty by marking all
  symbols as local, and emit them into the .init segment.

These changes only affect the ELF image, and produce the same binary
image, with the exception of a couple of bytes of .init data for the
empty .dynsym and .dynstr sections.

[0] b9dce7f1ba01 ("arm64: kernel: force ET_DYN ELF type for ...")

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Smith <peter.smith@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Makefile             |  2 +-
 arch/arm64/kernel/vmlinux.lds.S | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..7221494bcf60 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -18,7 +18,7 @@ ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
 # for relative relocs, since this leads to better Image compression
 # with the relocation offsets always being zero.
-LDFLAGS_vmlinux		+= -pie -shared -Bsymbolic \
+LDFLAGS_vmlinux		+= -shared -Bsymbolic \
 			$(call ld-option, --no-apply-dynamic-relocs)
 endif
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 03b00007553d..9ba4016090b1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -98,8 +98,6 @@ SECTIONS
 		EXIT_CALL
 		*(.discard)
 		*(.discard.*)
-		*(.interp .dynamic)
-		*(.dynsym .dynstr .hash)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -192,12 +190,25 @@ SECTIONS
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
-	.rela : ALIGN(8) {
+#ifdef CONFIG_RELOCATABLE
+	.rela.dyn : ALIGN(8) {
 		*(.rela .rela*)
 	}
-
-	__rela_offset	= ABSOLUTE(ADDR(.rela) - KIMAGE_VADDR);
-	__rela_size	= SIZEOF(.rela);
+	.dynamic : {
+		*(.dynamic)
+	}
+	.dynsym : ALIGN(8) {
+		*(.dynsym)
+	}
+	.dynstr : {
+		*(.dynstr)
+	}
+	.hash : {
+		*(.hash)
+	}
+	__rela_offset	= ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
+	__rela_size	= SIZEOF(.rela.dyn);
+#endif
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__initdata_end = .;
@@ -244,6 +255,13 @@ SECTIONS
 	HEAD_SYMBOLS
 }
 
+#ifdef CONFIG_RELOCATABLE
+VERSION {
+	/* mark all symbols as local so they are not listed in .dynsym */
+	{ local: *; };
+}
+#endif
+
 /*
  * The HYP init code and ID map text can't be longer than a page each,
  * and should not cross a page boundary.
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
