Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F8C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01C62064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exLI0SiL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F4dSAwLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01C62064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MVGwzoSpJZaAJz4lYvoJFU2AZGmty7HesulndJaPM8Y=; b=exLI0SiLuMb4FU
	axHHQ+2UfN67bXLUldSrveM+Ewtr0vi5uJrleH1I17c/Xc4UuMKnwmI8FJNk3aq5QbpCqEjnyRlqQ
	Y6FvxXIBwbQw75604STso97zRK8bKaD/cFwWL52MknbBD+nIniBZF4rc9nirXNjePNJ+/jTN6OSzF
	kXK4MTaIc4Y/spcGO/2fRBZDnb3FUQV81USjwBw8DimaJZgu1QhU1ms0wzqKmSAOy3sVY0jfFpbcf
	9zIAsr+dDCZt1frS7p5wnTS+zEE2LmTqeh0rHVXjCN9Bn6nQ/TFZiS6MQ0M8EujuFWbWlvNoomvoH
	IAij4jJd0Dc51yY9yygg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWAAj-0005UP-ER; Mon, 10 Dec 2018 01:15:45 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWAAZ-0005Gn-ES
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 01:15:41 +0000
Received: by mail-pf1-x442.google.com with SMTP id h3so4552081pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 17:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3zyI5zxZwGodfMTrNuDET37rIHixML6NRWv3fhvncg0=;
 b=F4dSAwLagRa3eNfp8xVsBcj5GpG/ybNbaaAygiLhss+vwu7nAPzQ6u6tFw1OlDVwdk
 OGFjnIPRhzQSnsSC+yj3pYAIYoaIzKv8E3NvGpEVdV3OjzxbwUzEHIbS0NOPFgvoefvT
 TIA08R0lL8xmw8DW6FTHsu5otufjdV5lXsirc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3zyI5zxZwGodfMTrNuDET37rIHixML6NRWv3fhvncg0=;
 b=rpGSb2E51UO7UEn+j6kwOa3juady9DYNndqtZKezXBETlZFbK4BH/kHo6grCfka4Hl
 ZDyIhUL4TLBzPbEKwzOxmEiE0W4j1+nUpQq35a57J+6xJt3LNd8G6II3Z+/te4XwdxUs
 eLVCgVJ8GSZ+vDpatjzYLZ3xMkL3boUUaAf5V/5cBPBB1jv/e364YBySi+kPE83uoWAm
 koXredhJxOaWA4jMMkmupllI36AoZZKhpduK6DQCFy4LhLv3Xhss9YFzTPb66StNeqRV
 wS+5oGmGXfM8fC+aArIoPSKDMSGvlwzX4ALqTr/d60uR9wzMDN7Qv9kTH3raZsGR2GDf
 QeFQ==
X-Gm-Message-State: AA+aEWaS6REur7Mw1BaF3uF/FYDn1DCjXhnjjrjPAKrzfxqHazVlQfJo
 2dtfsbR2G7UnpyrvmkmJOQo2YA==
X-Google-Smtp-Source: AFSGD/UweY//RlIzHQzR4czsV/CUhCbYkqwlM4MbLxoZIZ/Pxxkz5U+J4ofgZQwt5fWHP6ylViFjDQ==
X-Received: by 2002:a63:4187:: with SMTP id o129mr8507789pga.370.1544404528270; 
 Sun, 09 Dec 2018 17:15:28 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id b10sm16516336pfj.183.2018.12.09.17.15.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 17:15:27 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Date: Mon, 10 Dec 2018 09:15:03 +0800
Message-Id: <20181210011504.122604-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181210011504.122604-1-drinkcat@chromium.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_171536_339783_BFFF3E4A 
X-CRM114-Status: GOOD (  16.00  )
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
(level 1 and 2) to be allocated within the first 4GB of RAM, even
on 64-bit systems.

For level 1/2 pages, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
is defined (e.g. on arm64 platforms).

For level 2 pages, allocate a slab cache in SLAB_CACHE_DMA32. Note
that we do not explicitly pass GFP_DMA[32] to kmem_cache_zalloc,
as this is not strictly necessary, and would cause a warning
in mm/sl*b.c, as we did not update GFP_SLAB_BUG_MASK.

Also, print an error when the physical address does not fit in
32-bit, to make debugging easier in the future.

Cc: stable@vger.kernel.org
Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v2:
 - Commit message

(v3 used the page_frag approach)

Changes since v4:
 - Do not pass ARM_V7S_TABLE_GFP_DMA to kmem_cache_zalloc, as this
   is unnecessary, and would trigger a warning.

Changes since v5:
 - Rename ARM_V7S_TABLE_SLAB_CACHE to ARM_V7S_TABLE_SLAB_FLAGS.

 drivers/iommu/io-pgtable-arm-v7s.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..d2fdb192f7610f 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -161,6 +161,14 @@
 
 #define ARM_V7S_TCR_PD1			BIT(5)
 
+#ifdef CONFIG_ZONE_DMA32
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
+#define ARM_V7S_TABLE_SLAB_FLAGS SLAB_CACHE_DMA32
+#else
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
+#define ARM_V7S_TABLE_SLAB_FLAGS SLAB_CACHE_DMA
+#endif
+
 typedef u32 arm_v7s_iopte;
 
 static bool selftest_running;
@@ -198,13 +206,16 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	void *table = NULL;
 
 	if (lvl == 1)
-		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
+		table = (void *)__get_free_pages(
+			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+		table = kmem_cache_zalloc(data->l2_tables, gfp);
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
@@ -737,7 +748,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
 					    ARM_V7S_TABLE_SIZE(2),
 					    ARM_V7S_TABLE_SIZE(2),
-					    SLAB_CACHE_DMA, NULL);
+					    ARM_V7S_TABLE_SLAB_FLAGS, NULL);
 	if (!data->l2_tables)
 		goto out_free_data;
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
