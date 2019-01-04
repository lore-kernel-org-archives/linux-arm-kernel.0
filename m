Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191DDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:57:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8085206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ia1h+JSb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvSEP/K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8085206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=D5SdtqDJkaPygJPi22fWj8zYQTQcTpXYw0Zmh+txOuE=; b=ia1h+JSbz9qAJTAJPIlsWWXREU
	9NMnF5bDS02AmzEVmWtQme81q6vJY2HORC6Iyc48Sg15O65MiQaoxnT7tvFO1RhJxm2RMJQHkIvod
	phagrlQBnAfF4OyfGmRut6hyPWe/GTAkr2MMq0OuqNUimcV+bXx2tyEQk2j0PEgqGaKmycwPwrpaQ
	DoJqZxb+MNUemID/h5vCGtdja7edfcK/lV/rsh5ljMp+E+2ipQFap91jbceR9oO/xWG/y7FdGxWfw
	dRuw3Nc35tYJtTqdftlkcSaQhVHz0gMtYF8pWx3+qMZnS6KU3lTexf9he4gaeR55H0xIwh8f9Av68
	c8/BDk/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLHq-00011P-6T; Fri, 04 Jan 2019 08:57:02 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLGC-0007Zg-Bw
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:55:38 +0000
Received: by mail-pl1-x643.google.com with SMTP id u18so17152617plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xRXc/XwU+0JK+tTKqDimxoIXZnhU9RFFAnNgcWVG9mA=;
 b=lvSEP/K+omY4BY0Ld25k59kJSSur3J2dCgRgr+6yby9CvFFfsgXTOn3+D1aJsvNalY
 eTPJapgS5iRWe8Q3VJfTJ0Bthyr9frF7QnBsGgTCvldicoKf7P4ofSI8pZ09IAgB4oJH
 S57zVxQI3vvPDAKwm0oQsJsa4UNZsPZkF0t/oCsc/oq0RtM8Bl0af8yVHC4PZOGlv3vr
 xk5+cqM8Wco6xLzbT7VEmWSN2LwGnGl4YyFdTsgfVbY6uz3M5hvZsFc6A91Yr6tdVH+Z
 ElpfqsR5cbQQTFpFgingD74oF7Tm329wgchjSs/dW+HIz+j+Txq5ZkJoxgkX4QVwmqbB
 /xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xRXc/XwU+0JK+tTKqDimxoIXZnhU9RFFAnNgcWVG9mA=;
 b=OqejjTUTTJPDNi8VsGHL5fJLR9FQgDsYI9vn5DjTupQ+0F2HRrZRkIi7jzwsfRaLpP
 Pmya4Lrq9DqYGhvmvC4JiiQQHO1NlSYoakMW5QRdSZ3t1wVGvGRQE6j4HeKoB0RlaeJP
 xVpgddz9Eg5rPzIJC6b1Tqqn9kHMa7rlg/CejJgzABLgw8uYnvYRsa9Jz6IY/n9wDUEP
 VmszznVrPyAK3YeRQtzK2gDY9KmYCxKnafB8lRKvC0F2+niV49+6I7Nb8VYCIMICgQL7
 6NxNhdaxUFfXqL+wdIpn1XEh6yYJwOAPV5YXQhDY+lKTQF5ZRtNTwiMgc4qJ69Sx9bOr
 S5bQ==
X-Gm-Message-State: AJcUukevdE3hvcdTmjWaXeRTBYwjEk8k4Z2jmUoYPARwLUGdaU26WtcS
 mx/IGT0mOVxraVeQOw5HZQg=
X-Google-Smtp-Source: ALg8bN6SD6ySHgduF3UiOSRUnfYBNpkE+dVu9pEO0AqBi2lbwhCbWkSW6krUk3+TRsHaKT0HX3RnDg==
X-Received: by 2002:a17:902:2b84:: with SMTP id
 l4mr50247049plb.191.1546592119875; 
 Fri, 04 Jan 2019 00:55:19 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:19 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 8/11] KVM: Make kvm_arch_mmu_enable_log_dirty_pt_masked()
 return value
Date: Fri,  4 Jan 2019 16:54:02 +0800
Message-Id: <20190104085405.40356-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005520_724829_4D6211B4 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, benh@kernel.crashing.org,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to make kvm_arch_mmu_enable_log_dirty_pt_masked() return value
and caller can use it to determine whether tlb flush is necessary.
kvm_get_dirty_log_protect() and kvm_clear_dirty_log_protect() use the return
value of kvm_arch_mmu_enable_log_dirty_pt_masked() to populate flush
parameter.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/mips/kvm/mmu.c      |  5 ++++-
 arch/x86/kvm/mmu.c       |  6 +++++-
 include/linux/kvm_host.h |  2 +-
 virt/kvm/arm/mmu.c       |  5 ++++-
 virt/kvm/kvm_main.c      | 10 ++++------
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 97e538a8c1be..f36ccb2d43ec 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -437,8 +437,10 @@ int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
  *
  * Walks bits set in mask write protects the associated pte's. Caller must
  * acquire @kvm->mmu_lock.
+ *
+ * Returns: Whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		gfn_t gfn_offset, unsigned long mask)
 {
@@ -447,6 +449,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	gfn_t end = base_gfn + __fls(mask);
 
 	kvm_mips_mkclean_gpa_pt(kvm, start, end);
+	return true;
 }
 
 /*
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 6d4f7dfeaa57..9d8ee6ea02db 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1676,8 +1676,10 @@ EXPORT_SYMBOL_GPL(kvm_mmu_clear_dirty_pt_masked);
  *
  * Used when we do not need to care about huge page mappings: e.g. during dirty
  * logging we do not have any such mappings.
+ *
+ * Return value means whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,
 				gfn_t gfn_offset, unsigned long mask)
 {
@@ -1686,6 +1688,8 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				mask);
 	else
 		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
+
+	return true;
 }
 
 /**
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..e86b8c38342b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -759,7 +759,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush);
 
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
 					gfn_t gfn_offset,
 					unsigned long mask);
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 3053bf2584f8..232007ff3208 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1564,12 +1564,15 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
  *
  * It calls kvm_mmu_write_protect_pt_masked to write protect selected pages to
  * enable dirty logging for them.
+ *
+ * Return value means whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		gfn_t gfn_offset, unsigned long mask)
 {
 	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
+	return true;
 }
 
 static void clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e75dbb15fd09..bcbe059d98be 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1202,13 +1202,12 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			if (!dirty_bitmap[i])
 				continue;
 
-			*flush = true;
 			mask = xchg(&dirty_bitmap[i], 0);
 			dirty_bitmap_buffer[i] = mask;
 
 			offset = i * BITS_PER_LONG;
-			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-								offset, mask);
+			*flush = kvm_arch_mmu_enable_log_dirty_pt_masked(kvm,
+							memslot, offset, mask);
 		}
 		spin_unlock(&kvm->mmu_lock);
 	}
@@ -1275,9 +1274,8 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
 		 * a problem if userspace sets them in log->dirty_bitmap.
 		*/
 		if (mask) {
-			*flush = true;
-			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-								offset, mask);
+			*flush = kvm_arch_mmu_enable_log_dirty_pt_masked(kvm,
+					memslot, offset, mask);
 		}
 	}
 	spin_unlock(&kvm->mmu_lock);
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
