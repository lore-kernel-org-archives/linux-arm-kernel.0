Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC19C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:57:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C76D20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B+fhL9YA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyA5ubV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C76D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sTLihTl4yBGnRC1auaNMwUVVCnoGfYF/krue4cnDyYc=; b=B+fhL9YACwB4GR
	+wLXT8XSHunOM6HUKTvmJfT3puZEKXsht+532lz4vruywlO62Hkt8exiQsbeFDxxQ4a8DzuHrdzbK
	+NG0/cxuRXQ5v3sbhJQw0A99Jq/OeTCjpq3JpZGsnU6YjRA13LTLmAkvd4vokZ0cm0XBf7fd8ycvF
	LSGlDyQ91wN0KiXGUUBHEhcd57Ar4Ql2fT+qUlbi+/vMlNebx4JuD7Y1AOarf9wGqZH7io87BuwTh
	2mXpCggs1CxQ+5vm4UnZjFfjhN9P8Z4+hoD5nB8uR6RPiywtsiuhS7GxJcpekbkjs23RdPKoPvZMX
	847zm0rpNQ0kMkMs9PrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT5mM-0003Lm-AE; Sat, 01 Dec 2018 13:57:54 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT5mI-0003Ka-Sn
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 13:57:52 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so7889796wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 05:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XxiimY0gr4YDeirMrKYe/v+XoLjzCYTEu0YOXegIwGI=;
 b=EyA5ubV8jgfvQjkgxF2AOfF+Wkc1Nnb6noZhdACtSk76DUOt7sW9yAt20CtZrSHFD1
 9MD0c2JYuKVL69b9AlQpAlwaMNZxeSlip+LQOzquh3GcpNv9nc8BQa368CXG0mn3M0qV
 B4yCc/07GsCFJ5CU4m0nUo9RbfkZL4BNkDLVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XxiimY0gr4YDeirMrKYe/v+XoLjzCYTEu0YOXegIwGI=;
 b=IwKsnNEnIIP9WfC/e1MVrLhZuFbMf2Fd05FEuuvPVGw1PoHgCYuipEa4PcUX0+PwQS
 1T8GvYpIcLfLSkFqGwrWk/6KLt8bHn/G2CfwcW+hQbgmaDvg4ar6fy9vp384BK6HslFK
 m3+aeAjacblM2atPexId8SdhdTRPwSQRFA1+KltzpHR7sR+TgVUaCeh67c8Y7n4SPEqa
 Xla8mPg2WmPP2tg61PWnf5H/FgQd0jYL8nAiVD3HOjADHS2qTLUv5u0ixpzCNcVImhQn
 xzKDJ/L0m/1SghSdGt1JsqnGPk6z0kMh2atNmAu1U3lQDPduALjorvXrTthRviBvYwe7
 HYiA==
X-Gm-Message-State: AA+aEWYO7RSYhAipU2tF7vgflhmGv31KkSdbh+1ecldKT2fFyI6hnyrS
 cJbgEvyjCcL1c5mWfVn5HkN8oyaIiOw=
X-Google-Smtp-Source: AFSGD/Wl29zZcgmVzMHwsSt9HJlbrIy5Gbz/Tq2jPvKbSO67EEFpUgaTzngqX6d2nAi5t2cwjfnTWw==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr8914790wrr.285.1543672658835; 
 Sat, 01 Dec 2018 05:57:38 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:edfb:24ff:63d6:53d9])
 by smtp.gmail.com with ESMTPSA id x136sm2067164wme.0.2018.12.01.05.57.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 05:57:37 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH] arm64: add support for building the KASLR kernel with
 LLVM lld
Date: Sat,  1 Dec 2018 14:57:34 +0100
Message-Id: <20181201135734.10060-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_055750_943931_AC6FE1CA 
X-CRM114-Status: GOOD (  15.21  )
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

Work around some differences in the behavior of ld.lld as compared
to lb.bfd:
- pass the -z notext and -z norelro options to convince the linker to
  permit text relocations, and relro sections that are non-adjacent
  (both of which are irrelevant for bare metal executables such as the
  kernel)
- move the definition of some __efistub_ decorated section markers to
  the linker script, which permits us to assign them as relative
  quantities (since using an intermediate assignment loses the section
  relative property when using ld.lld)
- handle .eh_frame and .gnu.hash sections to avoid them from being
  emitted between .head.text and .text, screwing up the section layout.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Smith <peter.smith@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

With this patch and [0] applied on top of today's arm64/for-next/core [1],
I can create a working KASLR kernel using ld.lld (using LLD 6 from
Debian Buster)

[0] https://marc.info/?l=linux-arm-kernel&m=154366528003912
[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core

 arch/arm64/Makefile             |  2 +-
 arch/arm64/kernel/image.h       |  5 -----
 arch/arm64/kernel/vmlinux.lds.S | 10 ++++++++++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7221494bcf60..8978f60779c4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -18,7 +18,7 @@ ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
 # for relative relocs, since this leads to better Image compression
 # with the relocation offsets always being zero.
-LDFLAGS_vmlinux		+= -shared -Bsymbolic \
+LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext -z norelro \
 			$(call ld-option, --no-apply-dynamic-relocs)
 endif
 
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 8da289dc843a..628c2fbf8939 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -73,8 +73,6 @@
 
 #ifdef CONFIG_EFI
 
-__efistub_stext_offset = stext - _text;
-
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
  * isolate it from the kernel proper. The following symbols are legally
@@ -102,9 +100,6 @@ __efistub___memmove		= __pi_memmove;
 __efistub___memset		= __pi_memset;
 #endif
 
-__efistub__text			= _text;
-__efistub__end			= _end;
-__efistub__edata		= _edata;
 __efistub_screen_info		= screen_info;
 
 #endif
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 9ba4016090b1..cf3ad76f339f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -98,12 +98,15 @@ SECTIONS
 		EXIT_CALL
 		*(.discard)
 		*(.discard.*)
+		*(.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
 
 	.head.text : {
 		_text = .;
+		PROVIDE(__efistub__text = .);
+
 		HEAD_TEXT
 	}
 	.text : {			/* Real text segment		*/
@@ -206,6 +209,9 @@ SECTIONS
 	.hash : {
 		*(.hash)
 	}
+	.gnu.hash : {
+		*(.gnu.hash)
+	}
 	__rela_offset	= ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
 	__rela_size	= SIZEOF(.rela.dyn);
 #endif
@@ -239,6 +245,7 @@ SECTIONS
 	PECOFF_EDATA_PADDING
 	__pecoff_data_rawsize = ABSOLUTE(. - __initdata_begin);
 	_edata = .;
+	PROVIDE(__efistub__edata = .);
 
 	BSS_SECTION(0, 0, 0)
 
@@ -249,12 +256,15 @@ SECTIONS
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
+	PROVIDE(__efistub__end = .);
 
 	STABS_DEBUG
 
 	HEAD_SYMBOLS
 }
 
+PROVIDE(__efistub_stext_offset = stext - _text);
+
 #ifdef CONFIG_RELOCATABLE
 VERSION {
 	/* mark all symbols as local so they are not listed in .dynsym */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
