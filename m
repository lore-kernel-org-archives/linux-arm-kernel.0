Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CD3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:23:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EAE2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ShtmMnAl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIjArO+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EAE2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IiueBQFnHwunevK1ABqahkt2pGQhEzf68DWAFNTcSxQ=; b=ShtmMnAlqtvsiE
	ZgUhLQwg3zTE7UbsXB6Y0n7fQ/jHIboUghgqy5zy6q+vvOqoztsLlA6v+tyZPXsnbs+jVGi45JfQv
	kfr/9YsqhWzq3k4RZzBVwYUBma+xeu0fzXxr8JwWscncr1rTjdi/eHvDdoDGicqypJ6vYeFIx0hHB
	7975/Ps7vxg1alB4rnuSjekBvBORaZuKIE4E5+fJLOYSEVERRrVVXlqoX00VycwTHC8l6CcMR8nG4
	iGvIcMALZsTMaapXA1C3CkOJrV330C+y0JoNkTCm0jVGg239FiIc/CGb9jignw3LFnJXV5yYDisDZ
	1XcGre8j0mDk9iidYXwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5zZ-0004NR-WB; Tue, 04 Dec 2018 08:23:42 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5zW-0004M2-JO
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:23:40 +0000
Received: by mail-pg1-x542.google.com with SMTP id t13so7016185pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 00:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BC2yXIgwrgbb+vp2SoDp3a5EYKg+hZ4W2JytOoK4K4A=;
 b=TIjArO+kHpXg+DvsilBuxqhzyDTY0F589DL9ubB2vO/d22duhswOs4v1PKAYnn3RID
 QDXhFfuefgwzAaYIO51TU+12aJAh7kSt/oge38mwE2FktiwNt6CouZE9kec7ZQpDkong
 P/9qkf/AYCBd5sZFs/zAZWHRF2jL4PgO8ZF2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BC2yXIgwrgbb+vp2SoDp3a5EYKg+hZ4W2JytOoK4K4A=;
 b=Vd2CpE7nqe7HRLaI1iv7JJsz47h/c3eWeEeYZVuDZ63fa5TZf2rOVxf5XPefbnoyEd
 4Khy0nuv/q7RIvXsFsTs2eiykxQpfLGbVjXCYWeAMOXqSCa87lvFqEonAVEJ0RzClgR7
 So7q6Szkf9B2pDkB/V3nqANK1jzH40zWRcBAHrM+C/+cCiloOlmijFPFG1l0yawdep5r
 L0iKpU2wW+NvsqK6F650+zHL0zECTDvTCLyqxS7oIO5QYE81bIdE0auzPmBpkiflsKIH
 ZtLn/Gs3mQHS0D3l0XgkLQd33u0h9wZsNq3bnG3thqjvRVhRUd2m9IAXRlkVjnGz8g4Q
 10WQ==
X-Gm-Message-State: AA+aEWYZc7i9m3FRsHtfRy3HUy7PHKOHeAmZvXE0g2ywWgs1IgYCfuzp
 2AhTycmIS0SJX+SmggHBxPT8YA==
X-Google-Smtp-Source: AFSGD/VpTQsU4DiTZ31xNf7o/qoPM2bSEhhvzRB/WoSeJt9tmOMRs+2XyBTMAtmWqbQpg1/GbsZAbw==
X-Received: by 2002:a62:c613:: with SMTP id m19mr19435575pfg.207.1543911807270; 
 Tue, 04 Dec 2018 00:23:27 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id y6sm44911418pfd.104.2018.12.04.00.23.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 00:23:26 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3,
 RFC] iommu/io-pgtable-arm-v7s: Use page_frag to request DMA32 memory
Date: Tue,  4 Dec 2018 16:23:00 +0800
Message-Id: <20181204082300.95106-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_002338_638975_F6FD2F37 
X-CRM114-Status: GOOD (  19.51  )
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
Cc: hch@infradead.org, Michal Hocko <mhocko@suse.com>,
 Tomasz Figa <tfiga@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Yong Wu <yong.wu@mediatek.com>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Vlastimil Babka <vbabka@suse.cz>, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Christoph Lameter <cl@linux.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

IOMMUs using ARMv7 short-descriptor format require page tables
(level 1 and 2) to be allocated within the first 4GB of RAM, even
on 64-bit systems.

For level 1/2 tables, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
is defined (e.g. on arm64 platforms).

For level 2 tables (1 KB), we use page_frag to allocate these pages,
as we cannot directly use kmalloc (no slab cache for GFP_DMA32) or
kmem_cache (mm/ code treats GFP_DMA32 as an invalid flag).

One downside is that we only free the allocated page if all the
4 fragments (4 IOMMU L2 tables) are freed, but given that we
usually only allocate limited number of IOMMU L2 tables, this
should not have too much impact on memory usage: In the absolute
worst case (4096 L2 page tables, each on their own 4K page),
we would use 16 MB of memory for 4 MB of L2 tables.

Also, print an error when the physical address does not fit in
32-bit, to make debugging easier in the future.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

As an alternative to the series [1], which adds support for GFP_DMA32
to kmem_cache in mm/. IMHO the solution in [1] is cleaner and more
efficient, as it allows freed fragments (L2 tables) to be reused, but
this approach does not require any core change.

[1] https://patchwork.kernel.org/cover/10677529/, 3 patches

 drivers/iommu/io-pgtable-arm-v7s.c | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..0de6a51eb6755f 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -161,6 +161,12 @@
 
 #define ARM_V7S_TCR_PD1			BIT(5)
 
+#ifdef CONFIG_ZONE_DMA32
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
+#else
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
+#endif
+
 typedef u32 arm_v7s_iopte;
 
 static bool selftest_running;
@@ -169,7 +175,7 @@ struct arm_v7s_io_pgtable {
 	struct io_pgtable	iop;
 
 	arm_v7s_iopte		*pgd;
-	struct kmem_cache	*l2_tables;
+	struct page_frag_cache	l2_tables;
 	spinlock_t		split_lock;
 };
 
@@ -198,13 +204,17 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	void *table = NULL;
 
 	if (lvl == 1)
-		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
+		table = (void *)__get_free_pages(
+			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+		table = page_frag_alloc(&data->l2_tables, size,
+				gfp | __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA);
 	phys = virt_to_phys(table);
-	if (phys != (arm_v7s_iopte)phys)
+	if (phys != (arm_v7s_iopte)phys) {
 		/* Doesn't fit in PTE */
+		dev_err(dev, "Page table does not fit in PTE: %pa", &phys);
 		goto out_free;
+	}
 	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
@@ -227,7 +237,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	if (lvl == 1)
 		free_pages((unsigned long)table, get_order(size));
 	else
-		kmem_cache_free(data->l2_tables, table);
+		page_frag_free(table);
 	return NULL;
 }
 
@@ -244,7 +254,7 @@ static void __arm_v7s_free_table(void *table, int lvl,
 	if (lvl == 1)
 		free_pages((unsigned long)table, get_order(size));
 	else
-		kmem_cache_free(data->l2_tables, table);
+		page_frag_free(table);
 }
 
 static void __arm_v7s_pte_sync(arm_v7s_iopte *ptep, int num_entries,
@@ -515,7 +525,6 @@ static void arm_v7s_free_pgtable(struct io_pgtable *iop)
 			__arm_v7s_free_table(iopte_deref(pte, 1), 2, data);
 	}
 	__arm_v7s_free_table(data->pgd, 1, data);
-	kmem_cache_destroy(data->l2_tables);
 	kfree(data);
 }
 
@@ -729,17 +738,11 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))
 			return NULL;
 
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
 
 	spin_lock_init(&data->split_lock);
-	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
-					    ARM_V7S_TABLE_SIZE(2),
-					    ARM_V7S_TABLE_SIZE(2),
-					    SLAB_CACHE_DMA, NULL);
-	if (!data->l2_tables)
-		goto out_free_data;
 
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_v7s_map,
@@ -789,7 +792,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	return &data->iop;
 
 out_free_data:
-	kmem_cache_destroy(data->l2_tables);
 	kfree(data);
 	return NULL;
 }
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
