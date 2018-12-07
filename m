Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796DCC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:26:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449DC20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="igyhlm/W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gkfg+veq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449DC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CMkyhGJ2Pv5UqkQo6mYiubfbRgKhlLclPZuqJ9hMmdY=; b=igyhlm/WP0mr3L
	W0S85g0zwiu9eijT+/OlYKlvhIBVvv+7qef5HRyWHLEVLuXfnIF/30yF8vukkLFXAVK3i2FAFd29r
	PMp6K30I2RGCmaIpyuvLgVrrf4XsJ2W0kbYW14MT/z1RpOqEPsxEXipvlQXYCmIvBSyam8ykBNoOq
	UYiB6LR65EuO3s9MUfjfvjS1IDdL8iTGaI/CZvSORcJmcRIAr/vDc4NOTwSE2wRmPXWzYUGkCxqhs
	mz/aT5md++CzyFNunuY8i6lbawyZwn5pw5tOLBIrAu9QPHDD+0sxoyuF5zbA8xifr/nS3NInyrWuX
	FPT6a8WArOSr2tCMmyIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV9aM-0002bO-Kl; Fri, 07 Dec 2018 06:26:02 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV9Re-0006Lc-Fy
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 06:17:08 +0000
Received: by mail-pl1-x641.google.com with SMTP id gn14so1332717plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 22:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uJoswCrlfo65GP7YSjDD5Dxde1TEKzOE1bHdE5k2YXA=;
 b=Gkfg+veq3tFoCNjzTVVK4MzF1+VxmDDREWTh7F/H38sptZ3jt6fe3ndCmar2DUe88M
 oshVn2q+niIJDMUfWeFJfKyH74cwlJzUYMUI+jek4GUAaKZJrUA5/Wt8W8OCBlnE+JYt
 uX3zOPZH8Nwsy5ulmVaJycpdrDUdwiSAerjcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uJoswCrlfo65GP7YSjDD5Dxde1TEKzOE1bHdE5k2YXA=;
 b=USBvXvbts/ZdPIMEIfDuB3q+14jZSmMihdXGsBZLLmPWCfHahjGVHBNAfxZfegu8iM
 ddB+qvBmzm7/UQiOSZ/eEVk+p/bqPlctSJryGj3v9CUirEGzYCmGhwoGqlXKdo4eH6CT
 3mh/1Eu7Nja9xN7G4jJdgrpLd5JGKKxlaPxJCGKVzIKys4El1dFVqT1bwWlw56sJVtMv
 9tJBaCiXdDzYmcoqCs1QwEwPuELoAf/eG1l7LOrHK2ykW5OWnMycfawg7h+PNufArEuV
 hcTsjPmNlLgN9Qzwr2x5Gke7zmM+6e4fpimd6h2d7Z8Ik93HpgKqCmEw74INH7NGoj6m
 I1fQ==
X-Gm-Message-State: AA+aEWb9K24L8yL6Oe2t1F7Lg3Pg3ZKy77TrXyLa6TgZdofaZXaT9KB8
 r3o3y6EZhwuoNr+7oimZKcyxDA==
X-Google-Smtp-Source: AFSGD/XZa6HFUd/c5IPU8LIhweh/OmveFRXhgV1EPw5ux8VC+DfGZoBXt4ZppI0AFEFQOSUKgZ7anw==
X-Received: by 2002:a17:902:74c1:: with SMTP id
 f1mr928632plt.273.1544163411694; 
 Thu, 06 Dec 2018 22:16:51 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id z30-v6sm2995944pfg.41.2018.12.06.22.16.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 22:16:51 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v5 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Date: Fri,  7 Dec 2018 14:16:19 +0800
Message-Id: <20181207061620.107881-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181207061620.107881-1-drinkcat@chromium.org>
References: <20181207061620.107881-1-drinkcat@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_221703_231607_3BAD6227 
X-CRM114-Status: GOOD (  15.38  )
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

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v2:
 - Commit message

(v3 used the page_frag approach)

Changes since v4:
 - Do not pass ARM_V7S_TABLE_GFP_DMA to kmem_cache_zalloc, as this
   is unnecessary, and would trigger a warning.

 drivers/iommu/io-pgtable-arm-v7s.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bde04800c..f311fe1dfa47b7 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -161,6 +161,14 @@
 
 #define ARM_V7S_TCR_PD1			BIT(5)
 
+#ifdef CONFIG_ZONE_DMA32
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
+#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
+#else
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
+#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
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
+					    ARM_V7S_TABLE_SLAB_CACHE, NULL);
 	if (!data->l2_tables)
 		goto out_free_data;
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
