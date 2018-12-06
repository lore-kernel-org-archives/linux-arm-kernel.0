Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFEAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:01:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49907214DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHSvCjR4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeTiLmJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49907214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5xXs4Jmvzsib7fdrsitJqQCczOpICYKaZR8ZYMWswT4=; b=tHSvCjR4VpDVte
	oiAxoB7RNNhTda6vezLZxLsLkWsyGHLiTlnKP0XKsnqj9ArDABTaVnQav2Xfare0dz98gsny0GoXw
	HTXRrKvSXXMTVR4IWnwyrqRY84pmR19kyRFrVjPWtGqBPWFN5RMoiGdt5c2Zl/wOA77gQv9qUl5mS
	qpwoba2P3q3bpiKrTztW8w0LoTZi0wlD7iL2L+wt6s4Uh+EJKP7iYag6Q6QSw+3PBNQEFPpbrsUS1
	x6/nCOsoiCywYUNhU9VdKEAigCy+d9eJXV+TTOpvMxtnzGxh/mFBbSQF5xFlsUbbMgLwEi8FZu4PT
	0L1jtu+E0RfcQBug5o/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw5R-0005iE-Lq; Thu, 06 Dec 2018 16:01:13 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw4B-0003Ag-U9
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:00:02 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so991987wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dgSG9gChmYBffNKXbMNH/SpVS1I5j9iEUF32P6VsSNQ=;
 b=OeTiLmJb/vMVFqlou6bQKq9apgP2LUcCUWVMJEAQrfWdHhvbmur7qW30Qg1tVQ7d2L
 M8nEaUPwwxyHVyla64j+Pb81s2Trsf3uZB0cnLc2jPytOGg2K6MvthrZl/eUs3awgRtz
 BHW8jdTyEdBkCxpo+LKBm4JJ2hhbcz726b/kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dgSG9gChmYBffNKXbMNH/SpVS1I5j9iEUF32P6VsSNQ=;
 b=rZXG411hVI3FOBdkLJvb4CicHJZErzIunket87cixhou/scGlAP687pT8LjgtcrCBb
 R6P4wUjEYm8/vfu0RRf+7KfTC9hDNW9aawxYYmCG4ny1HpjBAmL+0U7ykEGeWCyyhH+z
 XlG05+DAg9jIblXtvYaNQ6nHXcIM1f2sn9nzsx6BT1epr7wY7N76ckgbjg7vxtIEUveS
 Bx1mN19Ggms4wxJ4PYu2Y5iqyH8pToQClHE5tR8I0xAk5yWHUBKelH3/862TROjyEvT7
 UDhxdCqHhIOQfHITtbjGEnDMnUZHZEEgJB576rBcIC6ji5/gjHo/VIEfRHthsu0sFMer
 lRPg==
X-Gm-Message-State: AA+aEWZeUDO1NrL0YvMB2vvUID71NdhbSLnGam5oxuYiABBrPSI9xFIR
 TjndZFIUyjyZKtoQKJtaGEYdXQ==
X-Google-Smtp-Source: AFSGD/VvKaAmAdJzJ+BUHas/Zq2Nbfy6LLOGmMa9lkWO0VLQKH4qjf5s5cxXOfmJws8qo28Il2s7jA==
X-Received: by 2002:adf:8342:: with SMTP id 60mr24344596wrd.212.1544111984136; 
 Thu, 06 Dec 2018 07:59:44 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 07:59:43 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64/alternative_cb: add nr_alts parameter to callback
 handlers
Date: Thu,  6 Dec 2018 16:57:36 +0100
Message-Id: <20181206155739.20229-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075956_053261_117D9439 
X-CRM114-Status: GOOD (  16.74  )
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

Callback handlers for alternative patching will shortly be able to
access a set of alternative instructions provided at assembly time.
So update the callback handler prototypes so we can pass this number.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/alternative.h |  4 ++--
 arch/arm64/include/asm/kvm_mmu.h     |  4 ++--
 arch/arm64/kernel/alternative.c      | 11 +++++++----
 arch/arm64/kernel/cpu_errata.c       | 10 ++++------
 arch/arm64/kvm/va_layout.c           |  8 ++++----
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 77da798e888b..987c1514183a 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -29,8 +29,8 @@ struct alt_instr_cb {
 	__le32 insn[];		/* sequence of alternative instructions */
 };
 
-typedef void (*alternative_cb_t)(struct alt_instr *alt,
-				 __le32 *origptr, __le32 *updptr, int nr_inst);
+typedef void (*alternative_cb_t)(struct alt_instr *alt, __le32 *origptr,
+				 __le32 *updptr, int nr_inst, int nr_alts);
 
 void __init apply_alternatives_all(void);
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 658657367f2f..5e32e314b9f0 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -100,8 +100,8 @@ alternative_cb_end
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 
-void kvm_update_va_mask(struct alt_instr *alt,
-			__le32 *origptr, __le32 *updptr, int nr_inst);
+void kvm_update_va_mask(struct alt_instr *alt, __le32 *origptr,
+			__le32 *updptr, int nr_insti, int nr_alts);
 
 static inline unsigned long __kern_hyp_va(unsigned long v)
 {
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index a49930843784..f55afa0bbaa4 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -107,8 +107,8 @@ static u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr, __le32 *altinsnp
 	return insn;
 }
 
-static void patch_alternative(struct alt_instr *alt,
-			      __le32 *origptr, __le32 *updptr, int nr_inst)
+static void patch_alternative(struct alt_instr *alt, __le32 *origptr,
+			      __le32 *updptr, int nr_inst, int nr_alts)
 {
 	__le32 *replptr;
 	int i;
@@ -154,7 +154,7 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 	struct alt_instr_cb *alt_cb_insn;
 
 	for (alt = region->begin; alt < region->end; alt++) {
-		int nr_inst;
+		int nr_inst, nr_alts;
 
 		/* Use ARM64_CB_PATCH as an unconditional patch */
 		if (alt->cpufeature < ARM64_CB_PATCH &&
@@ -174,12 +174,15 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 
 		if (alt->cpufeature < ARM64_CB_PATCH) {
 			alt_cb = patch_alternative;
+			nr_alts = alt->alt_len / AARCH64_INSN_SIZE;
 		} else {
 			alt_cb_insn = ALT_REPL_PTR(alt);
 			alt_cb = offset_to_ptr(&alt_cb_insn->cb_offset);
+			nr_alts = (alt->alt_len - sizeof(*alt_cb_insn)) / AARCH64_INSN_SIZE;
+
 		}
 
-		alt_cb(alt, origptr, updptr, nr_inst);
+		alt_cb(alt, origptr, updptr, nr_inst, nr_alts);
 
 		if (!is_module) {
 			clean_dcache_range_nopatch((u64)origptr,
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6ad715d67df8..c5489b4612c5 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -305,9 +305,8 @@ static int __init ssbd_cfg(char *buf)
 }
 early_param("ssbd", ssbd_cfg);
 
-void __init arm64_update_smccc_conduit(struct alt_instr *alt,
-				       __le32 *origptr, __le32 *updptr,
-				       int nr_inst)
+void __init arm64_update_smccc_conduit(struct alt_instr *alt, __le32 *origptr,
+				       __le32 *updptr, int nr_inst, int nr_alts)
 {
 	u32 insn;
 
@@ -327,9 +326,8 @@ void __init arm64_update_smccc_conduit(struct alt_instr *alt,
 	*updptr = cpu_to_le32(insn);
 }
 
-void __init arm64_enable_wa2_handling(struct alt_instr *alt,
-				      __le32 *origptr, __le32 *updptr,
-				      int nr_inst)
+void __init arm64_enable_wa2_handling(struct alt_instr *alt, __le32 *origptr,
+				      __le32 *updptr, int nr_inst, int nr_alts)
 {
 	BUG_ON(nr_inst != 1);
 	/*
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index c712a7376bc1..db7ba73e306a 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -114,8 +114,8 @@ static u32 compute_instruction(int n, u32 rd, u32 rn)
 	return insn;
 }
 
-void __init kvm_update_va_mask(struct alt_instr *alt,
-			       __le32 *origptr, __le32 *updptr, int nr_inst)
+void __init kvm_update_va_mask(struct alt_instr *alt, __le32 *origptr,
+			       __le32 *updptr, int nr_inst, int nr_alts)
 {
 	int i;
 
@@ -154,8 +154,8 @@ void __init kvm_update_va_mask(struct alt_instr *alt,
 void *__kvm_bp_vect_base;
 int __kvm_harden_el2_vector_slot;
 
-void kvm_patch_vector_branch(struct alt_instr *alt,
-			     __le32 *origptr, __le32 *updptr, int nr_inst)
+void kvm_patch_vector_branch(struct alt_instr *alt, __le32 *origptr,
+			     __le32 *updptr, int nr_inst, int nr_alts)
 {
 	u64 addr;
 	u32 insn;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
