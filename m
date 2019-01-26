Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C044EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:07:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D8A218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sMIjgHlD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+bujeUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D8A218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=01oLhjARk/yABiA9f2r2oBG/yaXTsa/CSLynyhgFPUE=; b=sMIjgHlDuR5Qh5
	lRH1PEI/qEt8SYCbx0CDQwd9VVXavozav4S7ZKWumcDpCaPVL3rrzDX2IwaUiKPlEIM3rnD302CFI
	jbHZUJxTesRjN/Dt6+7b/Vbk3MKDx5JOSYjN5afgNlDMKPX7aISCIxaAjl3VGD71RhQ7v9oWB3IJr
	VcqTrlUmZdbrHCUwF1/oVfZ242UdXSNOq4RggX+oSUMNJCdwMvlbQSv7rPKHq+JceGyxJt1RhS2EL
	X2GkiQ+wYJpMsgXh0KVXOYXOtqltHDgxy5pkap70lRQDK6lmxkyT/qc6Vf5qY/2MA7e2t7dSaZrNO
	HjkxVBEM3e1RONSWpM6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnFFJ-0001QU-2z; Sat, 26 Jan 2019 04:07:05 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnFFE-0001PY-LO
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 04:07:02 +0000
Received: by mail-ed1-x541.google.com with SMTP id g22so8910752edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 20:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bzGp4f5mj60UhOCZqN/eEORXWRoInqsbZGO2akYdCy0=;
 b=h+bujeUeE17D0y8QwbvANrZPFPrItuMxLv41QWHuHQe7jZxsqQoTg/QafkQp36HV8W
 r3ndwX/etR3BfSi/GkeCpKUx4ABXQ1JT74yW7aozIImuFau803R/L+J9jOGtusMEz5Pi
 Qfh95S2bYYTyy9JrT2TpZdYiAgsgbhrRNMvx602yVwUAvbM5/9qBq4TZKybXm4KBVU8X
 mIC720jVoOn/UhPRuwKPZijb4Pjpao1qToD7j4hs/cu5nuFZ5t/vW5EUhjx/eCoS4w14
 wnGMegSGGNqHcjALkFIOotIHGUoHiqcz0p7dQAMMxTH2MdbV7I4bj5hrHQavAs/LyK5K
 9uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bzGp4f5mj60UhOCZqN/eEORXWRoInqsbZGO2akYdCy0=;
 b=BnxuYKXt7+IHhzzggO/RSXlRbu/9gmYJmEXeebVwSCf6lv53OD2FVWf6NnOiwcW9WM
 vDRkM0LzMw1mHniOrAMWQuL87i06xA/R1nGONN/p6FDp6cbeP7hz6+UsvX74J20fHdsq
 HIdq8qKnhvtHfCukMqQb1paHUNywOkOFXHMLlcPgJ4+bImwR7NmNmqjpJbnd1CEEO6Ko
 fM2HRFXxhidW/lGUz9a5HJJerqu0DUU0FdPKnK+w4c5Y8Ru9og6fQQWSDgtlFRLowNaI
 lL0HdajnTdC/PKGAlzcBeUyy2fyELzTIy8B+/eud2OJk5lrIF2wd6Up+KsSwvzZazemf
 A4hA==
X-Gm-Message-State: AJcUukcQbFiQUOP5S/crURjqc9yjDsxemKmr+P0o4DgzAZ3kJXEzjkSv
 w/OvYqJsm+YwIUtoc/CTkqM=
X-Google-Smtp-Source: ALg8bN53xR6ipP+cZObsAMMommYUAv3P6GEQwW2RXGorZmvuAPPXcmhaLuts5aIImEo5svuz/9oCNw==
X-Received: by 2002:a50:8863:: with SMTP id c32mr12583176edc.156.1548475618118; 
 Fri, 25 Jan 2019 20:06:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id s46sm12047978edd.9.2019.01.25.20.06.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 20:06:57 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RESEND] ARM: Ensure that NEON code always compiles with Clang
Date: Fri, 25 Jan 2019 21:01:13 -0700
Message-Id: <20190126040111.9013-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181215212304.19390-1-natechancellor@gmail.com>
References: <20181215212304.19390-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_200700_729836_4D81B5EF 
X-CRM114-Status: GOOD (  17.92  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Tri Vo <trong@android.com>,
 linux-doc@vger.kernel.org, Nicolas Pitre <nico@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While building arm32 allyesconfig, I ran into the following errors:

  arch/arm/lib/xor-neon.c:17:2: error: You should compile this file with
  '-mfloat-abi=softfp -mfpu=neon'

  In file included from lib/raid6/neon1.c:27:
  /home/nathan/cbl/prebuilt/lib/clang/8.0.0/include/arm_neon.h:28:2:
  error: "NEON support not enabled"

Building V=1 showed NEON_FLAGS getting passed along to Clang but
__ARM_NEON__ was not getting defined. Ultimately, it boils down to Clang
only defining __ARM_NEON__ when targeting armv7, rather than armv6k,
which is the '-march' value for allyesconfig.

>From lib/Basic/Targets/ARM.cpp in the Clang source:

  // This only gets set when Neon instructions are actually available, unlike
  // the VFP define, hence the soft float and arch check. This is subtly
  // different from gcc, we follow the intent which was that it should be set
  // when Neon instructions are actually available.
  if ((FPU & NeonFPU) && !SoftFloat && ArchVersion >= 7) {
    Builder.defineMacro("__ARM_NEON", "1");
    Builder.defineMacro("__ARM_NEON__");
    // current AArch32 NEON implementations do not support double-precision
    // floating-point even when it is present in VFP.
    Builder.defineMacro("__ARM_NEON_FP",
                        "0x" + Twine::utohexstr(HW_FP & ~HW_FP_DP));
  }

Ard Biesheuvel recommended explicitly adding '-march=armv7-a' at the
beginning of the NEON_FLAGS definitions so that __ARM_NEON__ always gets
definined by Clang. This doesn't functionally change anything because
that code will only run where NEON is supported, which is implicitly
armv7.

Link: https://github.com/ClangBuiltLinux/linux/issues/287
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Resending with Nicolas's ack and Nick's review, to give others a chance
to pitch in with review/testing before submitting it to the patch
system (specifically Stefan, sorry I should have included you in the
previous posting).

With this patch and:
* A tip of tree LLVM build (I used apt.llvm.org)
* Clang GCOV support: https://lore.kernel.org/lkml/20190122233749.42220-1-trong@android.com/
* Two minor hacks for unrelated issues that are still being worked through:
  * https://raw.githubusercontent.com/nathanchance/patches/c313b2fa0efb/linux/build-hax/0003-DO-NOT-UPSTREAM-ARM-Don-t-select-HAVE_FUNCTION_TRACE.patch (see https://github.com/ClangBuiltLinux/linux/issues/35)
  * https://gist.githubusercontent.com/nathanchance/b2f5a4015abade1a41e78d5fc3235c5b/raw/744321882ab05511331f26896bad7c9f0056a6a5/gistfile1.txt (see https://github.com/ClangBuiltLinux/linux/issues/325)

I can build and link a little endian allyesconfig ARM kernel. This
patch alone works with GCC 8.2.0 and binutils 2.31.1.

 Documentation/arm/kernel_mode_neon.txt | 4 ++--
 arch/arm/lib/Makefile                  | 2 +-
 arch/arm/lib/xor-neon.c                | 2 +-
 lib/raid6/Makefile                     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
index 525452726d31..b9e060c5b61e 100644
--- a/Documentation/arm/kernel_mode_neon.txt
+++ b/Documentation/arm/kernel_mode_neon.txt
@@ -6,7 +6,7 @@ TL;DR summary
 * Use only NEON instructions, or VFP instructions that don't rely on support
   code
 * Isolate your NEON code in a separate compilation unit, and compile it with
-  '-mfpu=neon -mfloat-abi=softfp'
+  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
 * Put kernel_neon_begin() and kernel_neon_end() calls around the calls into your
   NEON code
 * Don't sleep in your NEON code, and be aware that it will be executed with
@@ -87,7 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
 Therefore, the recommended and only supported way of using NEON/VFP in the
 kernel is by adhering to the following rules:
 * isolate the NEON code in a separate compilation unit and compile it with
-  '-mfpu=neon -mfloat-abi=softfp';
+  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
 * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
   into the unit containing the NEON code from a compilation unit which is *not*
   built with the GCC flag '-mfpu=neon' set.
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index ad25fd1872c7..0bff0176db2c 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
+  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
   CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index 2c40aeab3eaa..c691b901092f 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -14,7 +14,7 @@
 MODULE_LICENSE("GPL");
 
 #ifndef __ARM_NEON__
-#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
+#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
 #endif
 
 /*
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 4e90d443d1b0..e723eacf7868 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -39,7 +39,7 @@ endif
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
 NEON_FLAGS := -ffreestanding
 ifeq ($(ARCH),arm)
-NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
+NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif
 CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
 ifeq ($(ARCH),arm64)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
