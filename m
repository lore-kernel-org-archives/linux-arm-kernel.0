Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B74C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:01:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE07B214DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UDp4yEya";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPZ0I44B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE07B214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=45F4aZ/K+1WSy5Hr2DqJaxBL43uyFTTW8yt/v66xfjU=; b=UDp4yEyah9oz76
	m2TW/quwHU5nDo2Ee8V7lSsKUYQznREfaOXP2JIn+YgCRTyLNhxS4hCia6Nyn6QyWgp3wV+Y32ykx
	KuNzjnjQvMIO1lJq4c+Aac26AsD9W9ys7URk60b0v4GlzUSjCVpfYHshg+14nUjpcWfeFcFU9WQmG
	tigd9qDHb01o5uUTAGQB90lhnfjkgARWBD3bxWH47EC83seUgYTYqExldasR5OfkhzjPRKjucw6yK
	tgr/nXyQxZ4XzLPlL22NJ2SVPdSQtI473Ijd+u1GSj5DKel5AXiSHB5CCtfuFI9Sag/RfcgReqXNf
	qWRBqMXC0zVKrmQoManw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw5B-0005Q2-6K; Thu, 06 Dec 2018 16:00:57 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw4A-00039v-Ix
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:59:58 +0000
Received: by mail-wm1-x344.google.com with SMTP id s14so1514924wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ufilkC4KXT597IQ5zu2bEqK9cc/hF4PdgqYxBckPn68=;
 b=QPZ0I44ByTCjuk9ePqJIX5NJL9ZGtQMKSitalKgY/UpP53/+9EfqvnX2MxcuN5M1eZ
 oq5oh0fNXmM1AGdxRQIiea69X3ReBymxkcjUr+xacjQzoSXYvUFMVFF+y4/GgLJnNdov
 fsOZZX2NsvdRupkKw+hdtAqBCOTmpJ81eN47U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ufilkC4KXT597IQ5zu2bEqK9cc/hF4PdgqYxBckPn68=;
 b=LRds494x6SjDepw2jGPJCZsv6aonNPWOVM7w5O/20RjxCG3WXbtteZCkNJO9NW7KMm
 S548WjPOXBeJ+42R1JqqWoVhQp/kenG7tYKH4uK6rKjwrgGLZ7PYuvOVq72t6Ri4E1ev
 Gh53iaL7NOZiN9A64LcYO4x+GyCs/Ht0XTgiHhO3MFjwYl7FVbB6/C1pCBjOa3C/XYtd
 ZitivEqIeBmFmxtZYw1GOlHiLcTsejc0fjcn6SzfUtgi2rgxEeKQ04ANFgN+lykLiMxd
 QLDFWL3u4AFtNKsmr35FOY5LejT6wLyFprv3WSDIOxN4jb4KOrl9gQOsfyrB8WwXh/xZ
 M7Qg==
X-Gm-Message-State: AA+aEWaCkHDNhlHJ6TDDGV6HdYmSfxiBT3xFSoomJRI5T6vtlK9zFTrs
 NhUlIG9JIvf4dD/FhHz0RvdLFg==
X-Google-Smtp-Source: AFSGD/UpOC1+Ql9cFbvSXU1dUcizLSdW+Lw0XAv5Zt1dbmURZDeJfY0eSLDp/TiHZPUIAmYRqOGQ5Q==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr20340663wmi.61.1544111982823; 
 Thu, 06 Dec 2018 07:59:42 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 07:59:41 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64/alternative_cb: move callback reference into
 replacements section
Date: Thu,  6 Dec 2018 16:57:35 +0100
Message-Id: <20181206155739.20229-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075954_677159_25232E6A 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In preparation of permitting callback type alternatives patching
routines to use any number of alternative instructions, move the
relative reference to the callback routine out of the primary
'struct alt_instr' data structure, where we are currently overloading
the 'alt_offset' member depending on the feature id. Instead, put
a relative reference to the callback at the start of the alternative
sequence.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/alternative.h | 39 +++++++++-----------
 arch/arm64/kernel/alternative.c      | 11 ++++--
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 4b650ec1d7dd..77da798e888b 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -24,6 +24,11 @@ struct alt_instr {
 	u8  alt_len;		/* size of new instruction(s), <= orig_len */
 };
 
+struct alt_instr_cb {
+	s32 cb_offset;		/* offset to callback handler */
+	__le32 insn[];		/* sequence of alternative instructions */
+};
+
 typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
@@ -35,13 +40,9 @@ void apply_alternatives_module(void *start, size_t length);
 static inline void apply_alternatives_module(void *start, size_t length) { }
 #endif
 
-#define ALTINSTR_ENTRY(feature,cb)					      \
+#define ALTINSTR_ENTRY(feature)						      \
 	" .word 661b - .\n"				/* label           */ \
-	" .if " __stringify(cb) " == 0\n"				      \
 	" .word 663f - .\n"				/* new instruction */ \
-	" .else\n"							      \
-	" .word " __stringify(cb) "- .\n"		/* callback */	      \
-	" .endif\n"							      \
 	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
 	" .byte 662b-661b\n"				/* source len      */ \
 	" .byte 664f-663f\n"				/* replacement len */
@@ -59,36 +60,29 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
  * but most assemblers die if insn1 or insn2 have a .inst. This should
  * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
  * containing commit 4e4d08cf7399b606 or c1baaddf8861).
- *
- * Alternatives with callbacks do not generate replacement instructions.
  */
-#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled, cb)	\
-	".if "__stringify(cfg_enabled)" == 1\n"				\
+#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature)			\
 	"661:\n\t"							\
 	oldinstr "\n"							\
 	"662:\n"							\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature,cb)					\
+	ALTINSTR_ENTRY(feature)						\
 	".popsection\n"							\
-	" .if " __stringify(cb) " == 0\n"				\
 	".pushsection .altinstr_replacement, \"a\"\n"			\
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\
-	".popsection\n\t"						\
+	".popsection\n\t"
+
+#define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)		\
+	".if "__stringify(IS_ENABLED(cfg))" == 1\n"			\
+	__ALTERNATIVE_CFG(oldinstr, newinstr, feature)			\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
 	".org	. - (662b-661b) + (664b-663b)\n"			\
-	".else\n\t"							\
-	"663:\n\t"							\
-	"664:\n\t"							\
-	".endif\n"							\
 	".endif\n"
 
-#define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
-	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
-
 #define ALTERNATIVE_CB(oldinstr, cb) \
-	__ALTERNATIVE_CFG(oldinstr, "NOT_AN_INSTRUCTION", ARM64_CB_PATCH, 1, cb)
+	__ALTERNATIVE_CFG(oldinstr, ".word " __stringify(cb) " - .\n", ARM64_CB_PATCH)
 #else
 
 #include <asm/assembler.h>
@@ -158,8 +152,11 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 .macro alternative_cb cb
 	.set .Lasm_alt_mode, 0
 	.pushsection .altinstructions, "a"
-	altinstruction_entry 661f, \cb, ARM64_CB_PATCH, 662f-661f, 0
+	altinstruction_entry 661f, 663f, ARM64_CB_PATCH, 662f-661f, 664f-663f
 	.popsection
+	.pushsection .altinstr_replacement, "ax"
+663:	.word	\cb - .
+664:	.popsection
 661:
 .endm
 
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index b5d603992d40..a49930843784 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -151,6 +151,7 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 	struct alt_region *region = alt_region;
 	__le32 *origptr, *updptr;
 	alternative_cb_t alt_cb;
+	struct alt_instr_cb *alt_cb_insn;
 
 	for (alt = region->begin; alt < region->end; alt++) {
 		int nr_inst;
@@ -161,7 +162,7 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 			continue;
 
 		if (alt->cpufeature == ARM64_CB_PATCH)
-			BUG_ON(alt->alt_len != 0);
+			BUG_ON(alt->alt_len < sizeof(*alt_cb_insn));
 		else
 			BUG_ON(alt->alt_len != alt->orig_len);
 
@@ -171,10 +172,12 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 		updptr = is_module ? origptr : lm_alias(origptr);
 		nr_inst = alt->orig_len / AARCH64_INSN_SIZE;
 
-		if (alt->cpufeature < ARM64_CB_PATCH)
+		if (alt->cpufeature < ARM64_CB_PATCH) {
 			alt_cb = patch_alternative;
-		else
-			alt_cb  = ALT_REPL_PTR(alt);
+		} else {
+			alt_cb_insn = ALT_REPL_PTR(alt);
+			alt_cb = offset_to_ptr(&alt_cb_insn->cb_offset);
+		}
 
 		alt_cb(alt, origptr, updptr, nr_inst);
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
