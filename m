Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BA1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:16:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED5F20831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pyop725s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZaJ/40Oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5F20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/bbWpnGj0f0yWWN4hh9VWwrKHy54JBU4rgpCaK7PIQY=; b=pyop725sit1BM6
	2Fc4MO4hmQtbIUTM/D/fciKsgTbPzYfyKLQ50lO4g7L+ZFS2mP9NuAM3M29iJ3wOnAOeVgZbiQjQc
	5CfaJv9zeIN36RHVyCJGXwWfBcVsEEScLbhAcAnKOtSVg4PKkU9Lb+qAuA1Smegv4fo9o31JpTm6J
	tDYna4IoKCjwd6Blu1JDpbdIePe8GbNiOes/95fI6TrN3D9Uf9+oNhUdqTy26wycEaZCskkTrvJxi
	Tb/PxTO9eQ79PFsJPTkxwfvdZOWG0v12W5YoWUG7NF+VY4YZqkpC3o8HcGHCBN++JmF5aodrEOB1f
	uGy8yIrzrbM8r2BptGsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWABM-00065S-BO; Mon, 10 Dec 2018 01:16:24 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWAAh-0005Hn-J1
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 01:15:48 +0000
Received: by mail-pg1-x542.google.com with SMTP id 17so4181683pgg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 17:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bDHo2G57TH3bcKVmO7L4FOO4ZhAAEjCAIwPeVa/m8Iw=;
 b=ZaJ/40Oor6/NtvfhwNrl5WvkSL4Td68cN+kyNER2UhZSruPtb/vPDmtN6HLOaN53Mm
 KIXG+orNtv74XskprxQ9IXcdSJhzQZxByr23Dxyhn28J8FKAfGPD78tGNaaJD+5QUP2+
 +AiJGDzaDjklmFSKfV18RUsZP12/wyZAbdo0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bDHo2G57TH3bcKVmO7L4FOO4ZhAAEjCAIwPeVa/m8Iw=;
 b=Dx/1Ajif1aW9iBSy6q2WlZ7BWsbCJOw+i0pmIfw2mXGNX7Ms6r2XtAIGzj00MPfM7p
 +Ak0DdU0SPxo4FR7g2P8Og3GZhcTbiEtyhzlcu/kN7y184ljfSGqihCgdXhnUxFyHbDw
 FZcQmSpW6MYBaRP1c8XDMFWuKYbFa3ImS98JzcMpGVp7x5rk9X5tkGC99n6Sfmafyeba
 pG+RwB2JOVtFiYkWssSqoy3tIIA2yi/6RWHXh0CP8Q7FDRVR2divUEq5ovNEsnG/uhXA
 OIqkYs+oDChBbZkGg4gZJGEiO4gY43rzcPKCVKBsHkuCB2C+TJbhO7Ji69aQX1jrG87S
 jttg==
X-Gm-Message-State: AA+aEWZohB+XZCTLglGLLtOG6xMP8/JQ4ltqRv4zBtiKKrKA/6UGVjq7
 u7TWM+efcH2MGqyvV8BF8Plupw==
X-Google-Smtp-Source: AFSGD/WiOLiNXT6YfwmG1oS8ywLxJPMqFMoEQpnRb2Y1AqFVl4LuoM2SfrAMmFDhPIekmPqTgXi5iA==
X-Received: by 2002:a63:c051:: with SMTP id z17mr9032972pgi.20.1544404532459; 
 Sun, 09 Dec 2018 17:15:32 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id b10sm16516336pfj.183.2018.12.09.17.15.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 17:15:31 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 3/3] mm: Add /sys/kernel/slab/cache/cache_dma32
Date: Mon, 10 Dec 2018 09:15:04 +0800
Message-Id: <20181210011504.122604-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181210011504.122604-1-drinkcat@chromium.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_171543_944268_69C2BCC6 
X-CRM114-Status: GOOD (  15.88  )
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

A previous patch in this series adds support for SLAB_CACHE_DMA32
kmem caches. This adds the corresponding
/sys/kernel/slab/cache/cache_dma32 entries, and fixes slabinfo
tool.

Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

There were different opinions on whether this sysfs entry should
be added, so I'll leave it up to the mm/slub maintainers to decide
whether they want to pick this up, or drop it.

No change since v5.

 Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
 mm/slub.c                                   | 11 +++++++++++
 tools/vm/slabinfo.c                         |  7 ++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

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
diff --git a/mm/slub.c b/mm/slub.c
index 4caadb926838ef..840f3719d9d543 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5104,6 +5104,14 @@ static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
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
@@ -5444,6 +5452,9 @@ static struct attribute *slab_attrs[] = {
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
 #endif
+#ifdef CONFIG_ZONE_DMA32
+	&cache_dma32_attr.attr,
+#endif
 #ifdef CONFIG_NUMA
 	&remote_node_defrag_ratio_attr.attr,
 #endif
diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 334b16db0ebbe9..4ee1bf6e498dfa 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -29,7 +29,7 @@ struct slabinfo {
 	char *name;
 	int alias;
 	int refs;
-	int aliases, align, cache_dma, cpu_slabs, destroy_by_rcu;
+	int aliases, align, cache_dma, cache_dma32, cpu_slabs, destroy_by_rcu;
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
@@ -531,6 +531,8 @@ static void report(struct slabinfo *s)
 		printf("** Hardware cacheline aligned\n");
 	if (s->cache_dma)
 		printf("** Memory is allocated in a special DMA zone\n");
+	if (s->cache_dma32)
+		printf("** Memory is allocated in a special DMA32 zone\n");
 	if (s->destroy_by_rcu)
 		printf("** Slabs are destroyed via RCU\n");
 	if (s->reclaim_account)
@@ -599,6 +601,8 @@ static void slabcache(struct slabinfo *s)
 		*p++ = '*';
 	if (s->cache_dma)
 		*p++ = 'd';
+	if (s->cache_dma32)
+		*p++ = 'D';
 	if (s->hwcache_align)
 		*p++ = 'A';
 	if (s->poison)
@@ -1205,6 +1209,7 @@ static void read_slab_dir(void)
 			slab->aliases = get_obj("aliases");
 			slab->align = get_obj("align");
 			slab->cache_dma = get_obj("cache_dma");
+			slab->cache_dma32 = get_obj("cache_dma32");
 			slab->cpu_slabs = get_obj("cpu_slabs");
 			slab->destroy_by_rcu = get_obj("destroy_by_rcu");
 			slab->hwcache_align = get_obj("hwcache_align");
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
