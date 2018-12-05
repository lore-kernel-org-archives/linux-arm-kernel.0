Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BBFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AFB206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m9HQ8RaI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJSBonDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AFB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dMQ3l5L0e1sRbGQbbqJcHlTA8NiE2iPJ8M69FeOA14A=; b=m9HQ8RaILJuJBW
	9q4S7HK2ja+OYsrskOpqYsx8WYXkj11ZOhei3YrQbftNX8kgcQ3xdqs0dMtXSDwj/PRwp7zD7ys4V
	UzGHpttb6UVjFqCwr1n++lfizd5R8w0XDK8LVHeyotaGC4iUTmfP+pKWONMFpZzqxrnq0qjKwbL6r
	BskHBMYSQH/J1/Oh0Rzetiig1MYFB7IcJhJg6YU0NY3E3ju4ju8RZQlW3kO8x47kNmAIKFpwFtGr5
	YRTsSgrKODEYh/GldHzA2/ZBLEqYfIvhBLpheAOEar+TN4+I7bmeq+Dc3YEhL7pxvCQkSH39VZX+p
	s879/yJwemrNsvks5Xzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQ3q-0006QT-5f; Wed, 05 Dec 2018 05:49:26 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQ3Q-000656-RX
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 05:49:02 +0000
Received: by mail-pf1-x442.google.com with SMTP id h3so9464943pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 21:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mtj+5lLpDKXzv34oRdlikvP0Q/L3pkB7CbeDcaUQ2ak=;
 b=RJSBonDDmVEWs69m9HOjZuGuqOpCHmEu3NrRrK9BUoJUXpNKmfFBa/K9sBDN9HQqGh
 2ZMUshSZxpFyy3R/xn0fNdnzD/OwClqvrwVW7yxt56sC7V8w/aBqcc+M6P6ZdmJBInbV
 xpbXCfLfeacU+cokjOF3Z/mV3EHPLT5eakXq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mtj+5lLpDKXzv34oRdlikvP0Q/L3pkB7CbeDcaUQ2ak=;
 b=K7YkMze1bLDDG0nvlCPaluDNyH2oNvZM8dQeiFpmEu8rs5Wn2xgnGnvrLGrNzYfE/Y
 G0YxsDTpqCcKCZPZLGxLXtEib+7XSHj4qWt0l/k1WF26CffabEUTKexNDPDEYKVdWmFG
 3VMlW+RzsavdltdJi3CXunaXzQh1bueuBehGiK2gka5IheOeIORJohXDQWbTiGfEMYvA
 eETE3+Ct3fYeIWZrdqXvNMgwijj0QwoPAggIzYIDf3qdkV49HcDTBX0od82Vd9eIWipR
 ud9xRQTF2YDhulqvTttA4ZMcjo6ICmqhOqFT7A93ezmmQbs/R3hdOF9Zu0UNlSENPjZR
 qAJg==
X-Gm-Message-State: AA+aEWbkokM6dxyHewMn8ZY5TkicNZcGTmN+J/tkoPx/DjCeXH9KcgnQ
 m/rq+TSx1FO+OUQ7yrKcoFnI2A==
X-Google-Smtp-Source: AFSGD/XIZbASUT86Hq6bBLcbgIr8yOKCqq/M0hjDPq1OmQpZfK1rdsqT2OjTw5YTsOUmsgwtOM+HyQ==
X-Received: by 2002:a62:7dcb:: with SMTP id
 y194mr23238987pfc.113.1543988930153; 
 Tue, 04 Dec 2018 21:48:50 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id 4sm30806513pfq.10.2018.12.04.21.48.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 21:48:49 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 1/3] mm: slab/slub: Add check_slab_flags function to check
 for valid flags
Date: Wed,  5 Dec 2018 13:48:26 +0800
Message-Id: <20181205054828.183476-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181205054828.183476-1-drinkcat@chromium.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_214900_896848_D416AB1F 
X-CRM114-Status: GOOD (  15.37  )
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

Remove duplicated code between slab and slub, and will make it
easier to make the test more complicated in the next commits.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 mm/internal.h | 18 ++++++++++++++++--
 mm/slab.c     |  8 +-------
 mm/slub.c     |  8 +-------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index f0c9ccde3bdb9e..a2ee82a0cd44ae 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -33,8 +33,22 @@
 /* Control allocation cpuset and node placement constraints */
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
 
-/* Do not use these with a slab allocator */
-#define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
+/* Check for flags that must not be used with a slab allocator */
+static inline gfp_t check_slab_flags(gfp_t flags)
+{
+	gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+
+	if (unlikely(flags & bug_mask)) {
+		gfp_t invalid_mask = flags & bug_mask;
+
+		flags &= ~bug_mask;
+		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+				invalid_mask, &invalid_mask, flags, &flags);
+		dump_stack();
+	}
+
+	return flags;
+}
 
 void page_writeback_init(void);
 
diff --git a/mm/slab.c b/mm/slab.c
index 73fe23e649c91a..65a774f05e7836 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2643,13 +2643,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = check_slab_flags(flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slub.c b/mm/slub.c
index c229a9b7dd5448..21a3f6866da472 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1685,13 +1685,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = check_slab_flags(flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
