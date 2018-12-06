Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB40C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:31:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83BB20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q/G6sium";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lYPWD4dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83BB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=erkmUSbnHpH7rIvBXqxv1lf7E1jcW8mcbqSAE4oziIk=; b=q/G6siumIipOId
	oQPztDcLFN/sh0zPq3FLRD7wEfSFuaija0warZF++wvzLvZvxUAFy/ObheFdQZ1XHLe5K5+oC5JgR
	SryAbtCC4MB4JVEeh3foEqEiAoVnYJGwHWlfdoi7y2fOn+xm2hIq5J1n4PYLUzm4GG0Ir2r9XE7SE
	AJJNcunuaDcSZ5+IDHX7qt/CPvppb22gdTiY9RHfI8Qropi4/CwnpMmQNPmD2HZMqvAfI+QnNbM5u
	phoBu+So/NNBfuck9yPX4Lrq1kXgo/bQTiYB8dFOBUluC/QmimShrZ7y/iN+j47F7o3CDfGIB5Vvi
	w5gfRFYXSlv4UJUQ+eIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsoK-0002FH-Rz; Thu, 06 Dec 2018 12:31:20 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsiS-0002y2-54
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:20 +0000
Received: by mail-wr1-x441.google.com with SMTP id u3so309851wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qsCjCKV+q57Vg4Qo+ex38n8fMkQGTNd9MzBlJ42c62w=;
 b=lYPWD4dzXCyGlWApicPbPWrOJcyzUAMrHRa9ML+WypDuXdVkzJ/cNmx3Tj3z5kn0X+
 wXsJE/+j+Upc/1yIDjCHMrh4af5GeudR6utpq6u2ci47XkTpdttHYOChrnJgRCp1Jes2
 estwO/nvoxmr4u9CJvAs4fwDMRhOR3SASD46MBoLNGjCKdYhlnqD4Qy52vO72QuyB+Fb
 jiSB4eJh3TYn8dAVPZx5dk/WDuwIDlyfcLXcTABmAqAcpqSsx3o3o9xSpKnO97j6yKsd
 ROuu+YVoBACV0QzThJXynS8N/eIMhCvtBaD5xvna4tCWj53zdpp907T0luqWbFsjQUj8
 NWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qsCjCKV+q57Vg4Qo+ex38n8fMkQGTNd9MzBlJ42c62w=;
 b=akuRenYySY1UayUYikLa8BPlHvMvPyuvI1si9/YMZgoMqpgm5pYdYFaMmcRhCRvC+B
 T07Wul+R882O+83nFoY5E0WPib4nNIkYu5H+lFJD2kVhw84asPedAPZPpECm6ddlMii/
 LvOcSI8RaXw/7ptrlyH0b205xL8/pjoZ52t/5qiy74QqogiHq28Q7LymNBI7snmK6B5+
 yMJURbbDOGbTbkjjm3qEDuQgIQx7QCYFgFfHpSj6sGVpcRQnC2FGj+iBnE80+Fsm7cwi
 9uinLJHV+IFCTYitW5xlvoPYk6ehpaXR/hoYS1YXaBZZ7/pSUXDYZqFupuTKsa6GkeRe
 f/yg==
X-Gm-Message-State: AA+aEWaAdDsk307vKVIajxcubUq4143cK5iPU3rR0EmxGKx5zfBbDLln
 rZW5MxTRkUGYD9eLQj9BW+1EBg==
X-Google-Smtp-Source: AFSGD/XUku20Jyax7BJye38HG84DVpktJbYsI3QLS0+xkAhyhZ+Y+sA1HXilshs7C7kohJO9GetxgA==
X-Received: by 2002:adf:9591:: with SMTP id p17mr26240808wrp.224.1544099104494; 
 Thu, 06 Dec 2018 04:25:04 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:25:03 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v13 10/25] kasan: add tag related helper functions
Date: Thu,  6 Dec 2018 13:24:28 +0100
Message-Id: <f6c6437bb8e143bc44f42c3c259c62e734be7935.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042516_733237_317E4A9F 
X-CRM114-Status: GOOD (  20.28  )
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
Cc: Vishwath Mohan <vishwath@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Jann Horn <jannh@google.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Mark Brand <markbrand@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This commit adds a few helper functions, that are meant to be used to
work with tags embedded in the top byte of kernel pointers: to set, to
get or to reset the top byte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h  |  8 +++++--
 arch/arm64/include/asm/memory.h | 12 +++++++++++
 arch/arm64/mm/kasan_init.c      |  2 ++
 include/linux/kasan.h           | 13 ++++++++++++
 mm/kasan/kasan.h                | 31 +++++++++++++++++++++++++++
 mm/kasan/tags.c                 | 37 +++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 8758bb008436..b52aacd2c526 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -4,12 +4,16 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_KASAN
-
 #include <linux/linkage.h>
 #include <asm/memory.h>
 #include <asm/pgtable-types.h>
 
+#define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
+#define arch_kasan_reset_tag(addr)	__tag_reset(addr)
+#define arch_kasan_get_tag(addr)	__tag_get(addr)
+
+#ifdef CONFIG_KASAN
+
 /*
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
  * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e2c9857157f2..83c1366a1233 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -219,6 +219,18 @@ static inline unsigned long kaslr_offset(void)
 #define untagged_addr(addr)	\
 	((__typeof__(addr))sign_extend64((u64)(addr), 55))
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define __tag_shifted(tag)	((u64)(tag) << 56)
+#define __tag_set(addr, tag)	(__typeof__(addr))( \
+		((u64)(addr) & ~__tag_shifted(0xff)) | __tag_shifted(tag))
+#define __tag_reset(addr)	untagged_addr(addr)
+#define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
+#else
+#define __tag_set(addr, tag)	(addr)
+#define __tag_reset(addr)	(addr)
+#define __tag_get(addr)		0
+#endif
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 7a4a0904cac8..1df536bdabcb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -253,6 +253,8 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
+	kasan_init_tags();
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index c56af24bd3e7..a477ce2abdc9 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -169,6 +169,19 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 
 #define KASAN_SHADOW_INIT 0xFF
 
+void kasan_init_tags(void);
+
+void *kasan_reset_tag(const void *addr);
+
+#else /* CONFIG_KASAN_SW_TAGS */
+
+static inline void kasan_init_tags(void) { }
+
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
 #endif /* CONFIG_KASAN_SW_TAGS */
 
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 19b950eaccff..b080b8d92812 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -8,6 +8,10 @@
 #define KASAN_SHADOW_SCALE_SIZE (1UL << KASAN_SHADOW_SCALE_SHIFT)
 #define KASAN_SHADOW_MASK       (KASAN_SHADOW_SCALE_SIZE - 1)
 
+#define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
+#define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
+#define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
+
 #define KASAN_FREE_PAGE         0xFF  /* page was freed */
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
 #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
@@ -126,6 +130,33 @@ static inline void quarantine_reduce(void) { }
 static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
 #endif
 
+#ifdef CONFIG_KASAN_SW_TAGS
+
+u8 random_tag(void);
+
+#else
+
+static inline u8 random_tag(void)
+{
+	return 0;
+}
+
+#endif
+
+#ifndef arch_kasan_set_tag
+#define arch_kasan_set_tag(addr, tag)	((void *)(addr))
+#endif
+#ifndef arch_kasan_reset_tag
+#define arch_kasan_reset_tag(addr)	((void *)(addr))
+#endif
+#ifndef arch_kasan_get_tag
+#define arch_kasan_get_tag(addr)	0
+#endif
+
+#define set_tag(addr, tag)	((void *)arch_kasan_set_tag((addr), (tag)))
+#define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
+#define get_tag(addr)		arch_kasan_get_tag(addr)
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 04194923c543..1c4e7ce2e6fe 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -38,6 +38,43 @@
 #include "kasan.h"
 #include "../slab.h"
 
+static DEFINE_PER_CPU(u32, prng_state);
+
+void kasan_init_tags(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(prng_state, cpu) = get_random_u32();
+}
+
+/*
+ * If a preemption happens between this_cpu_read and this_cpu_write, the only
+ * side effect is that we'll give a few allocated in different contexts objects
+ * the same tag. Since tag-based KASAN is meant to be used a probabilistic
+ * bug-detection debug feature, this doesn't have significant negative impact.
+ *
+ * Ideally the tags use strong randomness to prevent any attempts to predict
+ * them during explicit exploit attempts. But strong randomness is expensive,
+ * and we did an intentional trade-off to use a PRNG. This non-atomic RMW
+ * sequence has in fact positive effect, since interrupts that randomly skew
+ * PRNG at unpredictable points do only good.
+ */
+u8 random_tag(void)
+{
+	u32 state = this_cpu_read(prng_state);
+
+	state = 1664525 * state + 1013904223;
+	this_cpu_write(prng_state, state);
+
+	return (u8)(state % (KASAN_TAG_MAX + 1));
+}
+
+void *kasan_reset_tag(const void *addr)
+{
+	return reset_tag(addr);
+}
+
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
