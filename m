Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD9C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763FA2064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eSgiYRd7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijv+q4uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763FA2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=im9h0JDDfIy1Squ2yUSlBM7DKkrjgd+IpfW9Sa+D9lE=; b=eSgiYRd7qB//cg
	w+7R9YasEgnINxa4I79FZDFAQ2phKCc1vMaVL2cm5CW1N7OszxAZDTOcaAUWKMsMKgOrIajGXK4xr
	HakxbpRRehro+wS/JyXTciMklA0IfZ/iXwdj+KFcX6Hf20tdTJQoaK2EU3RoV4MWL64jeF9s75T7o
	ddenXGmVno5MRBEc/7CVxG1+Jaf5w24fL8bmnJcJaZIhuY0C7kp34WeeyFuZXNaJvpcftcxP3wUgZ
	vPw6aE2+k+vZsmqJaZRg6V1CS57waU7Q1NXJaVUIIiAHVAA2Hyhzhu1Cfa6/J7YcOerbXFrbWoNif
	VuS/VfEhhz+VmR32aNYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWAAx-0005jq-AE; Mon, 10 Dec 2018 01:15:59 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWAAZ-0005Ft-1R
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 01:15:42 +0000
Received: by mail-pf1-x442.google.com with SMTP id y126so4549784pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v53ohYgIFcKZc+mDiZ2r46NylU67jRR5KKW/neccYeA=;
 b=ijv+q4uFF8KDF+QVUFKj4U7gDtHtuEMw2oXVDmRjV9m90MMKozoV1SK3nr52Wfp0/J
 ajATJ4LwgXlkyBvI59+Xz/whZ5lXnl1xFMyxaVDC48lOag5w3FEwkupx/cXvgovw0NEw
 a4MdWfhyHdW1vGax/L6Sp9Y541uDVzZX/hMKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v53ohYgIFcKZc+mDiZ2r46NylU67jRR5KKW/neccYeA=;
 b=gw3uctfOd/LwrwqXaHKNtuYWFh6tixFniNCNrcZLjp4AN6jQRzBejrVCeEH6Ev7fW7
 Zb4CJ7t8puQq+VYihs29R+80cs+f7Tey58VTcuQTrKeiKEKNjNrg2udTnLGTqrkBE1zH
 PMkjmXTQXKKFcoG6p807Zlry87yJ/11ap3XXhvbNpXcEpK7fR4e36x5MwubMYV1SmIcG
 F+/ikJ9QSdfk7lAH5nWKQ1kaKF22HUj6dkLF1ij96l3n3CFWT1GV9wZ9OizL5mN1213c
 tj4nzvTCL2UebWfBI/3u7N9t7DrjWfeQPjH5RGEdJx03ohmbk5T3QxVJC7ahWmQf2yPF
 6VAw==
X-Gm-Message-State: AA+aEWYrlJ378nxxUOytjiw6551PqirQERY9+UcvSt5q2ioLbp5snHKV
 RQ55T/N+vXf4gHe5JulCh41pFA==
X-Google-Smtp-Source: AFSGD/XQbPEpb5m4zF9JWDJwwHdQG1vS8O1vSqI9U4Qq0Ub4rwSWo9QtX4mH9YSjDkYW879bfhIqJw==
X-Received: by 2002:a63:194f:: with SMTP id 15mr9299413pgz.192.1544404524069; 
 Sun, 09 Dec 2018 17:15:24 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id b10sm16516336pfj.183.2018.12.09.17.15.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 17:15:23 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 1/3] mm: Add support for kmem caches in DMA32 zone
Date: Mon, 10 Dec 2018 09:15:02 +0800
Message-Id: <20181210011504.122604-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181210011504.122604-1-drinkcat@chromium.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_171536_198735_4BD54D1C 
X-CRM114-Status: GOOD (  19.25  )
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
 Mike Rapoport <rppt@linux.vnet.ibm.com>, hsinyi@chromium.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

IOMMUs using ARMv7 short-descriptor format require page tables
to be allocated within the first 4GB of RAM, even on 64-bit systems.
On arm64, this is done by passing GFP_DMA32 flag to memory allocation
functions.

For IOMMU L2 tables that only take 1KB, it would be a waste to allocate
a full page using get_free_pages, so we considered 3 approaches:
 1. This patch, adding support for GFP_DMA32 slab caches.
 2. genalloc, which requires pre-allocating the maximum number of L2
    page tables (4096, so 4MB of memory).
 3. page_frag, which is not very memory-efficient as it is unable
    to reuse freed fragments until the whole page is freed.

This change makes it possible to create a custom cache in DMA32 zone
using kmem_cache_create, then allocate memory using kmem_cache_alloc.

We do not create a DMA32 kmalloc cache array, as there are currently
no users of kmalloc(..., GFP_DMA32). These calls will continue to
trigger a warning, as we keep GFP_DMA32 in GFP_SLAB_BUG_MASK.

This implies that calls to kmem_cache_*alloc on a SLAB_CACHE_DMA32
kmem_cache must _not_ use GFP_DMA32 (it is anyway redundant and
unnecessary).

Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---

Changes since v2:
 - Clarified commit message
 - Add entry in sysfs-kernel-slab to document the new sysfs file

(v3 used the page_frag approach)

Changes since v4:
 - Added details to commit message
 - Dropped change that removed GFP_DMA32 from GFP_SLAB_BUG_MASK:
   instead we can just call kmem_cache_*alloc without GFP_DMA32
   parameter. This also means that we can drop PATCH 1/3, as we
   do not make any changes in GFP flag verification.
 - Dropped hunks that added cache_dma32 sysfs file, and moved
   the hunks to PATCH 3/3, so that maintainer can decide whether
   to pick the change independently.

(no change since v5)

 include/linux/slab.h | 2 ++
 mm/slab.c            | 2 ++
 mm/slab.h            | 3 ++-
 mm/slab_common.c     | 2 +-
 mm/slub.c            | 5 +++++
 5 files changed, 12 insertions(+), 2 deletions(-)

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
diff --git a/mm/slab.c b/mm/slab.c
index 73fe23e649c91a..124f8c556d27fb 100644
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
index c229a9b7dd5448..4caadb926838ef 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3583,6 +3583,9 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (s->flags & SLAB_CACHE_DMA)
 		s->allocflags |= GFP_DMA;
 
+	if (s->flags & SLAB_CACHE_DMA32)
+		s->allocflags |= GFP_DMA32;
+
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
@@ -5671,6 +5674,8 @@ static char *create_unique_id(struct kmem_cache *s)
 	 */
 	if (s->flags & SLAB_CACHE_DMA)
 		*p++ = 'd';
+	if (s->flags & SLAB_CACHE_DMA32)
+		*p++ = 'D';
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		*p++ = 'a';
 	if (s->flags & SLAB_CONSISTENCY_CHECKS)
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
