Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE35C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A425206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/ugc8oe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DLh7U26H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A425206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o0q+bVMgKMhmf7kwXxYlVjMLXWcg9BLIF3uouBGcpfw=; b=j/ugc8oemxly4d
	lKjSmxH9U/BVEZwm9ldN9n1vwysW+JYXoDR5xKuS9ykFKaZwm6V2fqqzlUxDUhlkkwf1SRJxN7lbL
	qlkGJoasx2saLphi7NyLfaAn5OaPVzlMm/qlzUYh8E/xrywWZIgyCm/rUpWsfxc8RDPuVY1VcyDen
	4Wlu6HtUHxkICoiTeNqvVcjc2jksbX+5/EUBxiuoVKTyKt91aydkvxL7TFuVq+1hpoq4RK452KlWZ
	JMLeJ47e5fa3A4BlBP7zqZmN4el7XZzgPalmqLtYp2ndoslji4PW/ybCJNVehN7CbLSew8JEX+k/1
	sUWhQKsAnGmX9qs5K/Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQ46-0006fq-Gh; Wed, 05 Dec 2018 05:49:42 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQ3V-00065S-7s
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 05:49:07 +0000
Received: by mail-pl1-x641.google.com with SMTP id u18so9509454plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 21:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z0BiixZmP1pDhSC3KjyxkVa455GEDPvgYqpZeuzB8Xo=;
 b=DLh7U26Hh8G7gZqeF58owtcmnf00W1CSfPGZXqTphZxw3n92e4i4vnbGd3ncbZHWLH
 cE0J5hjftyVZQmcJSYGFOheYEwkcYjcjvrUuvS1Lyc6traqdreqHNRLGzMBa0biF7mgR
 FyOgXrCBsLMKCBdyZGCjI/ds1PBLClWNXtFPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z0BiixZmP1pDhSC3KjyxkVa455GEDPvgYqpZeuzB8Xo=;
 b=EUpcbIiKdEyf4PMou7aoMW9nf1lvkDOgiBgdZe1Ocyyj/EXIGTSNbZMag5Qv/KJOOu
 10PAqpa4r0d1/E0gFrf3Or5hnnLgLnfkle5K8bmlWVLGrIZI8pgS1/Dk0lHwPXXI37VS
 IbfI8mEWuapfrCe0zVtrsPxhqUjHrex1w9pSMce1tOea4EeIoKFDyB/hnuIr3d+FiaoM
 7EhvEk8raPI4ulQteJkkaBhT5X3KozCXOaXsTA1k4BrclcEe3Zj+3M02DKi+iOQHnCML
 duEDAF9hut3bEaR74Q+iVr/u5lQ2M1746D4ET5MfXIMzRdEXLZKUrywvYcSqZsMeq8+b
 mPXw==
X-Gm-Message-State: AA+aEWZHKuOwXEhvYKTf06JiGcQ6/cYH9+iPgf1r3xpDC7nEGh6QObLw
 ucD/P0dqfhnIoeEiCUtMXyh9GQ==
X-Google-Smtp-Source: AFSGD/VrepCldjN2YYNX0nsK1ITTULAfBCyD8ySUtPTonL4vNny3UxhLTQGbUwm1epEq1bdtJ69FDw==
X-Received: by 2002:a17:902:b595:: with SMTP id
 a21mr22018831pls.120.1543988934155; 
 Tue, 04 Dec 2018 21:48:54 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id 4sm30806513pfq.10.2018.12.04.21.48.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 21:48:53 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
Date: Wed,  5 Dec 2018 13:48:27 +0800
Message-Id: <20181205054828.183476-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181205054828.183476-1-drinkcat@chromium.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_214905_489729_E40F4776 
X-CRM114-Status: GOOD (  20.40  )
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
Cc: Michal Hocko <mhocko@suse.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org, linux-arm-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Vlastimil Babka <vbabka@suse.cz>, Tomasz Figa <tfiga@google.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
data structures smaller than a page with GFP_DMA32 flag.

This change makes it possible to create a custom cache in DMA32 zone
using kmem_cache_create, then allocate memory using kmem_cache_alloc.

We do not create a DMA32 kmalloc cache array, as there are currently
no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
ensures that such calls still fail (as they do before this change).

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v2:
 - Clarified commit message
 - Add entry in sysfs-kernel-slab to document the new sysfs file

(v3 used the page_frag approach)

Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
 include/linux/slab.h                        |  2 ++
 mm/internal.h                               |  8 ++++++--
 mm/slab.c                                   |  4 +++-
 mm/slab.h                                   |  3 ++-
 mm/slab_common.c                            |  2 +-
 mm/slub.c                                   | 18 +++++++++++++++++-
 7 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index 29601d93a1c2ea..d742c6cfdffbe9 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -106,6 +106,15 @@ Description:
 		are from ZONE_DMA.
 		Available when CONFIG_ZONE_DMA is enabled.
 
+What:		/sys/kernel/slab/cache/cache_dma32
+Date:		December 2018
+KernelVersion:	4.21
+Contact:	Nicolas Boichat <drinkcat@chromium.org>
+Description:
+		The cache_dma32 file is read-only and specifies whether objects
+		are from ZONE_DMA32.
+		Available when CONFIG_ZONE_DMA32 is enabled.
+
 What:		/sys/kernel/slab/cache/cpu_slabs
 Date:		May 2007
 KernelVersion:	2.6.22
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11b45f7ae4057c..9449b19c5f107a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -32,6 +32,8 @@
 #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
 /* Use GFP_DMA memory */
 #define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
+/* Use GFP_DMA32 memory */
+#define SLAB_CACHE_DMA32	((slab_flags_t __force)0x00008000U)
 /* DEBUG: Store the last owner for bug hunting */
 #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
 /* Panic if kmem_cache_create() fails */
diff --git a/mm/internal.h b/mm/internal.h
index a2ee82a0cd44ae..fd244ad716eaf8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
 #include <linux/tracepoint-defs.h>
 
 /*
@@ -34,9 +35,12 @@
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
 
 /* Check for flags that must not be used with a slab allocator */
-static inline gfp_t check_slab_flags(gfp_t flags)
+static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
 {
-	gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+	gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+
+	if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
+		bug_mask |= __GFP_DMA32;
 
 	if (unlikely(flags & bug_mask)) {
 		gfp_t invalid_mask = flags & bug_mask;
diff --git a/mm/slab.c b/mm/slab.c
index 65a774f05e7836..2fd3b9a996cbe6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2109,6 +2109,8 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 	cachep->allocflags = __GFP_COMP;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->allocflags |= GFP_DMA;
+	if (flags & SLAB_CACHE_DMA32)
+		cachep->allocflags |= GFP_DMA32;
 	if (flags & SLAB_RECLAIM_ACCOUNT)
 		cachep->allocflags |= __GFP_RECLAIMABLE;
 	cachep->size = size;
@@ -2643,7 +2645,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	flags = check_slab_flags(flags);
+	flags = check_slab_flags(flags, cachep->flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slab.h b/mm/slab.h
index 4190c24ef0e9df..fcf717e12f0a86 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -127,7 +127,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 
 
 /* Legal flag mask for kmem_cache_create(), for various configurations */
-#define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | SLAB_PANIC | \
+#define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
+			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
 
 #if defined(CONFIG_DEBUG_SLAB)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 70b0cc85db67f8..18b7b809c8d064 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -53,7 +53,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
 		SLAB_FAILSLAB | SLAB_KASAN)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
-			 SLAB_ACCOUNT)
+			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
 
 /*
  * Merge control. If this is set then no merging of slab caches will occur.
diff --git a/mm/slub.c b/mm/slub.c
index 21a3f6866da472..6d47765a82d150 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1685,7 +1685,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	flags = check_slab_flags(flags);
+	flags = check_slab_flags(flags, s->flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
@@ -3577,6 +3577,9 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (s->flags & SLAB_CACHE_DMA)
 		s->allocflags |= GFP_DMA;
 
+	if (s->flags & SLAB_CACHE_DMA32)
+		s->allocflags |= GFP_DMA32;
+
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
@@ -5095,6 +5098,14 @@ static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
 SLAB_ATTR_RO(cache_dma);
 #endif
 
+#ifdef CONFIG_ZONE_DMA32
+static ssize_t cache_dma32_show(struct kmem_cache *s, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA32));
+}
+SLAB_ATTR_RO(cache_dma32);
+#endif
+
 static ssize_t usersize_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%u\n", s->usersize);
@@ -5435,6 +5446,9 @@ static struct attribute *slab_attrs[] = {
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
 #endif
+#ifdef CONFIG_ZONE_DMA32
+	&cache_dma32_attr.attr,
+#endif
 #ifdef CONFIG_NUMA
 	&remote_node_defrag_ratio_attr.attr,
 #endif
@@ -5665,6 +5679,8 @@ static char *create_unique_id(struct kmem_cache *s)
 	 */
 	if (s->flags & SLAB_CACHE_DMA)
 		*p++ = 'd';
+	if (s->flags & SLAB_CACHE_DMA32)
+		*p++ = 'D';
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		*p++ = 'a';
 	if (s->flags & SLAB_CONSISTENCY_CHECKS)
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
