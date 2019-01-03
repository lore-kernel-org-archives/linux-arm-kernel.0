Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D25C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CA5217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q/d7E/7C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JzRV4OzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CA5217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aSUscJ3jrCuidi+qlPI+u+SfWo39XTIfEcwA3Jl6NDA=; b=q/d7E/7C+noSqK
	tRHq1HmnbCm9mKuNIUQYwoQCMlD9gnh40z55nqB5hdE5YAMpQM36UekO0Z8GP2MTnxvgHvXWXf9Ri
	uJzJkJ1FNTKhKuS7svgQZV9GVFvxUCsPvGol31SQoZg354D1Lvg6PHEtKvxPqLA16WSPZ3JcAoYHF
	KEEr9uf0yppsxVva9Dk8hHmc+PXwBHXVJ+ua+FtN95Y6nevEaHRMyPsl1d3ysQ/39FgSTUYiL1o9k
	wfvHj8ZbgJvcDwT9naLepNq/C+TqwGJzHmCYvuYNPq71uurD/mxhVIpcELVzvdiSqmxA6NqYuBDwE
	zaPSUpbPXlU0NWmUNOSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf80E-0007b4-PP; Thu, 03 Jan 2019 18:45:58 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7zm-00074y-D2
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:45:32 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so34488984wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 10:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LcZuxDuPGnY34gBBOzPjzW9RC6MdmGqedzN7uzgRX8A=;
 b=JzRV4OzU47GC2npsOEq89Allc1qgPv+Y5jsoLkXuyflZ9xTmZcqNEWdvopVB2mLN9u
 8dO+4sD19DkkXcPnobH6i4C8sPCDcTKX0Zb5bMIzj7AAWZze9z4tJvCau1rxfVHhRRRb
 jSjusOJhz6SUeB4bWg1pRK3Ec1iK+PCIbicMVihCOHNB3eu8wG57R5YW7mn3YHEbjXfG
 GoNIzVch9Hl/MBebbU2cyVjj/+ZtkiaLrajzmanxTB4cyMH9xs/7d39MOEsVTcaLg585
 xYTZJkUhlbbMrBQ3Hrw6gURwz+PJUt3SD5vFdNZwyzVNZuM8xmb9QtROaHCZOT2IPHuL
 VF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LcZuxDuPGnY34gBBOzPjzW9RC6MdmGqedzN7uzgRX8A=;
 b=gMadkfOHF7e8MSLaZZFU61TtHcekrGYDSnFlYbGujkcBfCJgliDMvmf75L7AJ4of06
 36ETpt+uZQyWKEGEoa4tMPzDgy18UZ6f5d8iDP91lKaeFZOSzOpKWXt4cuXAkE6nYMgf
 q5uILOgPv4UQ3ZaoUdwQR0lSy2mRc2fbHlp2u/tiy2Xjxr0KYnY/yqi0vq/PL90IuWII
 FU29nCcYkXP8JG8ZJ4D6NhXeEUlkKEKga96zTrGB05sSi4rk2M4ThmNeEfkO0HPly2E3
 1KwXcOjG+XM0TgxIQowo4XW/CymbYLUSot2ozIbUcAcutiBjGpX8VqALj2ukwc/qfoWL
 xHsg==
X-Gm-Message-State: AJcUukd2522Duh4GmGAwFmi72sHThIfuBDM8y46vn3P50yiFo7Lw3saI
 BJYFfL+mn8ORNc8GjoW29wyQBg==
X-Google-Smtp-Source: ALg8bN5f1SEsd4ITLAOkW46zsAXPnkQ0Kw16Q2Kzdp8Q2K31EY+gUdUwN0+RWy+mZNfdm32Jcr+xpQ==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr29524927wrr.155.1546541126907; 
 Thu, 03 Jan 2019 10:45:26 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 10:45:25 -0800 (PST)
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
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v3 1/3] kasan,
 arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
Date: Thu,  3 Jan 2019 19:45:19 +0100
Message-Id: <52ddd881916bcc153a9924c154daacde78522227.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546540962.git.andreyknvl@google.com>
References: <cover.1546540962.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_104530_444772_75E9E973 
X-CRM114-Status: GOOD (  12.48  )
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

Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.

Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/cache.h | 6 ++++++
 mm/kasan/common.c              | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 13dd42c3ad4e..eb43e09c1980 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -58,6 +58,12 @@
  */
 #define ARCH_DMA_MINALIGN	(128)
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#define ARCH_SLAB_MINALIGN	__alignof__(unsigned long long)
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 03d5d1374ca7..44390392d4c9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 	}
 
-	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
-
 	*flags |= SLAB_KASAN;
 }
 
-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
