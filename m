Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:23:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6598F2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="If63Bd1N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTFiE5ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6598F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HnyNQzuWtTgh3as30oEwqczv8zyQnjksgaWv5oouQD8=; b=If63Bd1N0m32IK
	vXJKBPGDYaIakoUPh9OwqWoeS1YhIXbrB/SlyXQe0g6fGaO1QrPmiqczT98PqHmmckPHQ4QJ2nWXC
	U6oHvcJKmQHqWfep+3v32jZOdGm2aVEMjiklKSE8zLUqVDGuqkNUgokwjFMJQR5ehG8MPo1W8xpL/
	NfZ4btFWouRDItKMcNntNFBFdPV1s2Y0ZENx+hfzObyPbSv2LTrxnY7BLec5KjU/lV1NNKsh0tSXn
	n3oWINerbf9jGI74jl9w686ec3BALESxn5Fwng1HqJkmEeha4TJvsEm9Mj5Ro3hPXHaMsK0coHtw4
	8ysZPyRjiXa2tx6SUmqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYHPY-0004Co-Q0; Sat, 15 Dec 2018 21:23:48 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYHPU-0004Bf-OO
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 21:23:46 +0000
Received: by mail-wm1-x342.google.com with SMTP id y1so8779337wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 15 Dec 2018 13:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wbAhpvg6Y90F4G+K9k9yPIb45r9KUwGWnfc1MZxSrNc=;
 b=iTFiE5httGBQlhhpliqzt6RIalaGvHQ5HnZofy8KSyfiTQ0sCCNcKYtAS8OP6HWEW8
 RXOiiLyHRArYHwhh3usoK/8vHb6dk8S677sDGsb0CU/asDU/tWFYiloHE5VJQdAhyU+h
 3d/ljZ3QXBl2SW5hSLWj09OfZM3PqWz5P6jusr9WLL0OQ0rB+uAQYJs+Z4U+1HJb8l3b
 yYeYPlkEo7djmBLTugI4OHR15zGGo9kwrAT3IYEHzrqHJc/2SmH6ecWsdmHRX4Do6f54
 cbTmcQ9C2VOhFubPw/Dy6CaicGR1qZU0dRf7kWRGQZ3Yfff59miOF1WoKwfH4RGaQCUr
 d5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wbAhpvg6Y90F4G+K9k9yPIb45r9KUwGWnfc1MZxSrNc=;
 b=QwOeVywPXG73eFzeJRLBzDJC8QGMduAmYKpb/lzqK2MwJYnpuLRaLbEsGW7dNO5vOu
 NuNMbXZY385woMac0ozNAleGW7hcLj3q1IHmEVAVzDBuDQD5F1H2ipQx14hzrGuO9JFS
 CM4bxXaddwIs3OVGNBbToF5cXtGcs+jnCN4j6kFwsUEsRPS+EvuK/h/d0OEkzuwnYJOS
 KqXhJ6DdXts39YyjfcoVbR2kTZwEusLF5nGdm0Uq8ciPcNBa+Fy7EGC5yPQmjHBzziZh
 W8Az7RMydonyUh2VBUVUCweE5bl/jZnZKl95WjA5fztzxUiYNUHTWVRHMcagYGCoCd8B
 o6Lw==
X-Gm-Message-State: AA+aEWayHtfVpPdazwiUbC4vaFr6iGKrmNeiFslNik8UEXMMo8BTGqzE
 DvHZVilLcIxEs+rJeHNxjXo=
X-Google-Smtp-Source: AFSGD/U3GYHJ9vxsTjxnGM7T3sn2bzE1kafvlQQ04JR0u107A64ZkisPzmBUsMpKFXH5WNRtUWxyRQ==
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr7163001wmf.27.1544909011793; 
 Sat, 15 Dec 2018 13:23:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id o8sm9889931wrx.15.2018.12.15.13.23.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 15 Dec 2018 13:23:31 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] ARM: Ensure that NEON code always compiles with Clang
Date: Sat, 15 Dec 2018 14:23:05 -0700
Message-Id: <20181215212304.19390-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_132344_797472_05836046 
X-CRM114-Status: GOOD (  17.11  )
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
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <natechancellor@gmail.com>,
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

From lib/Basic/Targets/ARM.cpp in the Clang source:

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
---
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
index a6741a895189..4600b62d845f 100644
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
index 2f8b61dfd9b0..bfec7c87c61e 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -25,7 +25,7 @@ endif
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
