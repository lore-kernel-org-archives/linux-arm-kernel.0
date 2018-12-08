Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE769C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:41:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF4C2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GELeQiHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF4C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GABobIoMqeqcC9pfiUG4vsNY6e5haK3JO1tE0Tcy4Jc=; b=GELeQiHDY5IZ6I
	x471p5oDh9+nEaLjdhICLIy+rjEPnvzT+Z3tzUirjpC5TXArtay67bWHHwwFsRPGemMfZ7A0E6tcO
	NF6QC6aMWs+Y9xaJa3Hm6CQXpwHAwKa9yYxqXV7Om1NtHTPmdiwy9UHNDuLyhdbBu3ObHjE/sCWiO
	Fa2UZEmQTXpSsuPV7SBE8w9ec9bQG3rlDdPMe8Eu/POmrmdO0isU8p8j5pbws5zLTkTk9c1A4cAJX
	SoFqUOLTR6INu9o64SwbmC36OpZO5defbNxdTsBvnE6w1d3ns392jX+TXiik9g6W4hVU+tNkl5FAB
	olP9oFdB2CcbIUP1oLXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgby-0001Dw-9Z; Sat, 08 Dec 2018 17:41:54 +0000
Received: from [184.48.100.57] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgbM-0000Yl-Rl; Sat, 08 Dec 2018 17:41:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/6] sparc: remove no needed sbus_dma_ops methods
Date: Sat,  8 Dec 2018 09:41:10 -0800
Message-Id: <20181208174115.16237-2-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208174115.16237-1-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
MIME-Version: 1.0
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
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
 openrisc@lists.librecores.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

No need to BUG_ON() on the cache maintainance ops - they are no-ops
by default, and there is nothing in the DMA API contract that prohibits
calling them on sbus devices (even if such drivers are unlikely to
ever appear).

Similarly a dma_supported method that always returns 0 is rather
pointless.  The only thing that indicates is that no one ever calls
the method on sbus devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/ioport.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 6799c93c9f27..4b2167a0ec0b 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -391,23 +391,6 @@ static void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n,
 	mmu_release_scsi_sgl(dev, sg, n);
 }
 
-static void sbus_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-				 int n,	enum dma_data_direction dir)
-{
-	BUG();
-}
-
-static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-				    int n, enum dma_data_direction dir)
-{
-	BUG();
-}
-
-static int sbus_dma_supported(struct device *dev, u64 mask)
-{
-	return 0;
-}
-
 static const struct dma_map_ops sbus_dma_ops = {
 	.alloc			= sbus_alloc_coherent,
 	.free			= sbus_free_coherent,
@@ -415,9 +398,6 @@ static const struct dma_map_ops sbus_dma_ops = {
 	.unmap_page		= sbus_unmap_page,
 	.map_sg			= sbus_map_sg,
 	.unmap_sg		= sbus_unmap_sg,
-	.sync_sg_for_cpu	= sbus_sync_sg_for_cpu,
-	.sync_sg_for_device	= sbus_sync_sg_for_device,
-	.dma_supported		= sbus_dma_supported,
 };
 
 static int __init sparc_register_ioport(void)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
