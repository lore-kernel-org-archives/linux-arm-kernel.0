Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F56C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F190217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="joLGkz28";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hTmg+DGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F190217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hIbUyF+JlsGVLSeNNhi3+Gn9oV2Hw1WUMS9TkjHEhLc=; b=joLGkz28VeIgen
	6ptCC28V+2hZ2k17JQh66iewtQlFPXGOVfgjadbm9ch5+lpfBWvtNr3lLnwsmeWLs+3pDmtAPbADR
	LeN/4ODEv3YUnqZ+g0PMc12U0LWmplYX7nz5RQV7AzlkPrHAWKDWjMpAjK9YUV6koTz20GAPIwkon
	oh4oAKkLsBbzwfnThskRlrVF/BVpGdyQeuAHOa8IfCwwZJYl12ff0DU9Lt021ydKaVMhPbCUN+Nam
	SARAUGbFLZNhQo0aTDfXfXLGvGCxYlkoWfyhRuow+N9G2drE13lGpNESWGhYr4MCztwem5P+DQBIs
	oScOx32Vs1PZOHE9K/jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf80X-0007vH-Qe; Thu, 03 Jan 2019 18:46:17 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7zo-00076A-0Y
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:45:37 +0000
Received: by mail-wr1-x442.google.com with SMTP id r10so34464793wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=loqk+YaJssCyhGzAFNinnRGb50LrNU13L8MGywEfc18=;
 b=hTmg+DGuRIQF2vlqz/Vhl1D+/+mvgPMsjqLDHi0P1rk+WOre7zmTu5qqGxv3MuZCCE
 UmLGhAKFZbzdsd4JMY8pdmgI4HYcHr4YnHntxG+Gt//m4C9Qndntnz8PKfjmfZeLTDpd
 K0fspUq1NKHV5A284NV0qPwtJ8DdvroBOj8kdD2qczrMK2lmGiPk5KVZxusGtbJdfqwR
 UUZxn2Qs6thHtP1o2ZG8BwsnsoATqNMckkznlYwnbdZQ8C3QDsxrTRM76uXF0vMqJHwb
 NV6DgqPzaJ4SZY9nrBP+8lLvzwTIs4vFYaq5Eyd/Nw+pUV8pY0KTWdZ5qFjegRMm8Ha4
 w6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=loqk+YaJssCyhGzAFNinnRGb50LrNU13L8MGywEfc18=;
 b=h7G50NRynDMPVPZFqhmDheaw8he1e+Zu25tZNcMmcD7fYtMciYc+jfWm6uvjn6vhD2
 OL89P1BV4SjBNZqyUxHUjZVWW5kuTx6HUN5lUPw3WrHIlHnE/HBvG3jJ4kcrxNL5ydup
 O9gXzrozgGWIpspaQNtHX22Auwmbms+AqjHyIIcoPgyalRR3d2vtpB/jgFjKxyYYSBag
 QJlmN6+DELZpcp9DL5zjt0riGFUDdhUNVaJ9RTBvRiKG1yEr90Q9QkZEXwsyW73kFtCp
 FdxJPzNN8It5WFCBsc9MsWmPBNw7X+UWXW63wN8qZ81ZEXDywWuG/hfrXoEjNj7QIAUS
 kspw==
X-Gm-Message-State: AJcUukeVGPcFhzCSuvq2nifoZ1z4DEtNhHsc48UDGZoX1wTmCDqKGFEl
 jdHBHgxHsxZxES4et5106QqmvA==
X-Google-Smtp-Source: ALg8bN4jM3MVHQyzwSzizLWeommEZcTAUOfqxGGPUDgiXkfn7dghhnI866UT0Yj3Z9dcwdbzSDIU7w==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr39771740wrj.91.1546541130566; 
 Thu, 03 Jan 2019 10:45:30 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 10:45:29 -0800 (PST)
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
Subject: [PATCH v3 3/3] kasan: fix krealloc handling for tag-based mode
Date: Thu,  3 Jan 2019 19:45:21 +0100
Message-Id: <bb2a71d17ed072bcc528cbee46fcbd71a6da3be4.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546540962.git.andreyknvl@google.com>
References: <cover.1546540962.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_104532_467785_9F692B8C 
X-CRM114-Status: GOOD (  22.01  )
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

Right now tag-based KASAN can retag the memory that is reallocated via
krealloc and return a differently tagged pointer even if the same slab
object gets used and no reallocated technically happens.

There are a few issues with this approach. One is that krealloc callers
can't rely on comparing the return value with the passed argument to
check whether reallocation happened. Another is that if a caller knows
that no reallocation happened, that it can access object memory through
the old pointer, which leads to false positives. Look at nf_ct_ext_add()
to see an example.

Fix this by keeping the same tag if the memory don't actually gets
reallocated during krealloc.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 63 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 44390392d4c9..73c9cbfdedf4 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -347,28 +347,43 @@ void kasan_poison_object_data(struct kmem_cache *cache, void *object)
 }
 
 /*
- * Since it's desirable to only call object contructors once during slab
- * allocation, we preassign tags to all such objects. Also preassign tags for
- * SLAB_TYPESAFE_BY_RCU slabs to avoid use-after-free reports.
- * For SLAB allocator we can't preassign tags randomly since the freelist is
- * stored as an array of indexes instead of a linked list. Assign tags based
- * on objects indexes, so that objects that are next to each other get
- * different tags.
- * After a tag is assigned, the object always gets allocated with the same tag.
- * The reason is that we can't change tags for objects with constructors on
- * reallocation (even for non-SLAB_TYPESAFE_BY_RCU), because the constructor
- * code can save the pointer to the object somewhere (e.g. in the object
- * itself). Then if we retag it, the old saved pointer will become invalid.
+ * This function assigns a tag to an object considering the following:
+ * 1. A cache might have a constructor, which might save a pointer to a slab
+ *    object somewhere (e.g. in the object itself). We preassign a tag for
+ *    each object in caches with constructors during slab creation and reuse
+ *    the same tag each time a particular object is allocated.
+ * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can be
+ *    accessed after being freed. We preassign tags for objects in these
+ *    caches as well.
+ * 3. For SLAB allocator we can't preassign tags randomly since the freelist
+ *    is stored as an array of indexes instead of a linked list. Assign tags
+ *    based on objects indexes, so that objects that are next to each other
+ *    get different tags.
  */
-static u8 assign_tag(struct kmem_cache *cache, const void *object, bool new)
+static u8 assign_tag(struct kmem_cache *cache, const void *object,
+			bool init, bool krealloc)
 {
+	/* Reuse the same tag for krealloc'ed objects. */
+	if (krealloc)
+		return get_tag(object);
+
+	/*
+	 * If the cache neither has a constructor nor has SLAB_TYPESAFE_BY_RCU
+	 * set, assign a tag when the object is being allocated (init == false).
+	 */
 	if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
-		return new ? KASAN_TAG_KERNEL : random_tag();
+		return init ? KASAN_TAG_KERNEL : random_tag();
 
+	/* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
 #ifdef CONFIG_SLAB
+	/* For SLAB assign tags based on the object index in the freelist. */
 	return (u8)obj_to_index(cache, virt_to_page(object), (void *)object);
 #else
-	return new ? random_tag() : get_tag(object);
+	/*
+	 * For SLUB assign a random tag during slab creation, otherwise reuse
+	 * the already assigned tag.
+	 */
+	return init ? random_tag() : get_tag(object);
 #endif
 }
 
@@ -384,7 +399,8 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	__memset(alloc_info, 0, sizeof(*alloc_info));
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
-		object = set_tag(object, assign_tag(cache, object, true));
+		object = set_tag(object,
+				assign_tag(cache, object, true, false));
 
 	return (void *)object;
 }
@@ -450,8 +466,8 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
-void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
-					size_t size, gfp_t flags)
+static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
+				size_t size, gfp_t flags, bool krealloc)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
@@ -469,7 +485,7 @@ void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_SHADOW_SCALE_SIZE);
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
-		tag = assign_tag(cache, object, false);
+		tag = assign_tag(cache, object, false, krealloc);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
 	kasan_unpoison_shadow(set_tag(object, tag), size);
@@ -481,6 +497,12 @@ void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
 
 	return set_tag(object, tag);
 }
+
+void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
+				size_t size, gfp_t flags)
+{
+	return __kasan_kmalloc(cache, object, size, flags, false);
+}
 EXPORT_SYMBOL(kasan_kmalloc);
 
 void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
@@ -520,7 +542,8 @@ void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
 	if (unlikely(!PageSlab(page)))
 		return kasan_kmalloc_large(object, size, flags);
 	else
-		return kasan_kmalloc(page->slab_cache, object, size, flags);
+		return __kasan_kmalloc(page->slab_cache, object, size,
+						flags, true);
 }
 
 void kasan_poison_kfree(void *ptr, unsigned long ip)
-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
