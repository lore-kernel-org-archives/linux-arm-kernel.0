Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:40:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB51420866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HuckXGV7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Zfq4RP+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB51420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WLwGAmQerw79BJSdUIscD59XPbw51+fCJzow2FZM8b8=; b=HuckXGV7juJZip
	o+szDglgLvyZRix4LgACqiqMkJhJdccHkWxApnwGyze8MNooulh/P9Oy6nHSN/gWUQiIkU06Pesrx
	PkZIbhwaVKqUPh8/6NcnZa/hddIvUFgrs9AwN48xOxYxyUS7M5jjB8q8QWhFz6IxSZL0VXlY2JV2s
	en0JP0ulQZim2jcmp/SMUeoL8Rc5Vq8ntOB111/X1FcHjk52QUuCg9lOCWoO6/4ae+DlDJN5H9JRJ
	At0u2/rBSU1xwt65WRiBENB2R4a3pacZ1bZbTPazDqF3D5gpqC5nA5BZXV3xHE7Q00x2Y2+gc1Dz3
	55RctapdrxH0FZv92cYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcnhL-000369-SM; Fri, 28 Dec 2018 08:40:51 +0000
Received: from owa.iluvatar.ai ([103.91.158.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcnhG-00034x-Ql
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 08:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
 c=relaxed/relaxed; t=1545986414; h=from:subject:to:date:message-id;
 bh=hPGTggK5mBzVng4X/eY1ndyLBHEXD2yxkrrkNdSjxi0=;
 b=Zfq4RP+jdHrA0A51NQKdLp5tsQsTocr4Or1dwH/oIl6/cFk/15xI33rESQpgeKkf542rE/7olws
 o3jnXO+UK7b2HiDiXH2CvnBZJUWEkARdP0Wym+B9sLFz1seKactB8dyfqDrOEXjqk6TNDVb9CyACa
 BYV3hS8K0Jnd3zi7h70=
Received: from localhost.localdomain (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Fri, 28 Dec 2018 16:40:13 +0800
From: Huang Shijie <sjhuang@iluvatar.ai>
To: <akpm@linux-foundation.org>
Subject: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to gen_pool_has_addr
Date: Fri, 28 Dec 2018 16:39:50 +0800
Message-ID: <20181228083950.20398-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_004047_531044_63D9B44E 
X-CRM114-Status: GOOD (  10.00  )
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
Cc: sfr@canb.auug.org.au, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Huang Shijie <sjhuang@iluvatar.ai>, iommu@lists.linux-foundation.org,
 shijie8@gmail.com, robin.murphy@arm.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Follow the kernel conventions, rename addr_in_gen_pool to
gen_pool_has_addr.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 drivers/misc/sram-exec.c  | 2 +-
 include/linux/genalloc.h  | 2 +-
 kernel/dma/remap.c        | 2 +-
 lib/genalloc.c            | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922e447c..a876101a0f82 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -563,7 +563,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 
 static bool __in_atomic_pool(void *start, size_t size)
 {
-	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
+	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
 }
 
 static int __free_from_pool(void *start, size_t size)
diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index 426ad912b441..d054e2842a5f 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -96,7 +96,7 @@ void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	if (!part)
 		return NULL;
 
-	if (!addr_in_gen_pool(pool, (unsigned long)dst, size))
+	if (!gen_pool_has_addr(pool, (unsigned long)dst, size))
 		return NULL;
 
 	base = (unsigned long)part->base;
diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index dd0a452373e7..c5e5bed82fbc 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -156,7 +156,7 @@ extern struct gen_pool *devm_gen_pool_create(struct device *dev,
 		int min_alloc_order, int nid, const char *name);
 extern struct gen_pool *gen_pool_get(struct device *dev, const char *name);
 
-bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
+extern bool gen_pool_has_addr(struct gen_pool *pool, unsigned long start,
 			size_t size);
 
 #ifdef CONFIG_OF
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 18cc09fc27b9..5022b904d7bc 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -158,7 +158,7 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 
 bool dma_in_atomic_pool(void *start, size_t size)
 {
-	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
+	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
 }
 
 void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 96b6f478d275..946bbeefec81 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -423,7 +423,7 @@ void gen_pool_for_each_chunk(struct gen_pool *pool,
 EXPORT_SYMBOL(gen_pool_for_each_chunk);
 
 /**
- * addr_in_gen_pool - checks if an address falls within the range of a pool
+ * gen_pool_has_addr - checks if an address falls within the range of a pool
  * @pool:	the generic memory pool
  * @start:	start address
  * @size:	size of the region
@@ -431,7 +431,7 @@ EXPORT_SYMBOL(gen_pool_for_each_chunk);
  * Check if the range of addresses falls within the specified pool. Returns
  * true if the entire range is contained in the pool and false otherwise.
  */
-bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
+bool gen_pool_has_addr(struct gen_pool *pool, unsigned long start,
 			size_t size)
 {
 	bool found = false;
@@ -450,7 +450,7 @@ bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
 	rcu_read_unlock();
 	return found;
 }
-EXPORT_SYMBOL(addr_in_gen_pool);
+EXPORT_SYMBOL(gen_pool_has_addr);
 
 /**
  * gen_pool_avail - get available free space of the pool
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
