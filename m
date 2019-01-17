Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD5EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CEF20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FiXw9/Aw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z0ojQWlk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUrmlBs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CEF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Cl4HHFVElPs//JjhmJctoRgBtCdtTnC7wvyXSM9/19g=; b=FiXw9/AwlgU+pkaYBmqTBasNm2
	bfmG4445qhInOt/oIiqR5QQvNqpTE+XaBXnUVl2BR0L8QzqxT+LVHndGy2r+tOMbtFQZcJ3z7f2/p
	Kt9dUaM6G1f03f+rheGP4vxX0L6MJ4FrJHlmqEnDIOT/Sl5jTuqayMbyOO+GNvS9oFIvtHUCAIOtH
	vyziJ8I1KoR3mHWsFzemmBoXZwv1PzlOVfWdjPEYgNPSrx740YZD8M9rqTRSJTjcIpSLzh3g4krcg
	9FpPsQMBjOl6ptxp38tAwsgPYxSuBp91SGDHceaoGPmrToPlWg7gu1GHyQHkiG2Jo3WYdWvAP/Yg8
	2NQfW6VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk3xm-0007Pi-QA; Thu, 17 Jan 2019 09:27:50 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk3xW-0007A6-No
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:27:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 805646086A; Thu, 17 Jan 2019 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547717254;
 bh=tZs6SWM8y2ouZDZJHYAt/F5ewfYTQq42LF1/h2NE1R0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z0ojQWlkQzAqu10ExLVytq/tYknk8xRF7XCSMgI5WiKbo/d6j0NeYfhp8jC5FREuB
 VCefbpy/UD4d/78xKnG5y+VCVdM+p1c3+W9vtYgDeSJXT5QGBCqkouubspZh29QXbO
 TXNJoqoXN5hRr1guDKUCVNtj1Gs450a0eqnc31Io=
Received: from blr-ubuntu-41.ap.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 88D2460237;
 Thu, 17 Jan 2019 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547717253;
 bh=tZs6SWM8y2ouZDZJHYAt/F5ewfYTQq42LF1/h2NE1R0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hUrmlBs8/O6HAi965dwMj1ygTc19w5qtw7NajTmfyU73BsW43Wd1EHBZvDVsp5xle
 /QXOeYFIi9j3y7XL4iEc2xvEPnBhzYFBGxEByjO0KC63qt6MQ85AGi8O761MJpuOoj
 Xr10t43G3hAvFYbAnfjXN2LsEhjdNPgpMsecR+/c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88D2460237
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] iommu/io-pgtable-arm: Add support for non-coherent page
 tables
Date: Thu, 17 Jan 2019 14:57:17 +0530
Message-Id: <20190117092718.1396-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_012735_057581_4448B215 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 tfiga@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From Robin's comment [1] about touching TCR configurations -

"TBH if we're going to touch the TCR attributes at all then we should
probably correct that sloppiness first - there's an occasional argument
for using non-cacheable pagetables even on a coherent SMMU if reducing
snoop traffic/latency on walks outweighs the cost of cache maintenance
on PTE updates, but anyone thinking they can get that by overriding
dma-coherent silently gets the worst of both worlds thanks to this
current TCR value."

We have IO_PGTABLE_QUIRK_NO_DMA quirk present, but we don't force
anybody _not_ using dma-coherent smmu to have non-cacheable page table
mappings.
Having another quirk flag can help in having non-cacheable memory for
page tables once and for all.

[1] https://lore.kernel.org/patchwork/patch/1020906/

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
 drivers/iommu/io-pgtable.h     |  6 ++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 237cacd4a62b..c76919c30f1a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -780,7 +780,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_NON_COHERENT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -788,9 +789,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/* TCR */
-	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	reg = ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_NON_COHERENT)
+		reg |= ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT |
+		       ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT;
+	else
+		reg |= ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT |
+		       ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT;
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
@@ -873,7 +879,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 
 	/* The NS quirk doesn't apply at stage 2 */
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_NON_COHERENT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 47d5ae559329..46604cf7b017 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -75,6 +75,11 @@ struct io_pgtable_cfg {
 	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
 	 *	on unmap, for DMA domains using the flush queue mechanism for
 	 *	delayed invalidation.
+	 *
+	 * IO_PGTABLE_QUIRK_NON_COHERENT: Enforce non-cacheable mappings for
+	 *      pagetables even on a coherent SMMU for cases where reducing
+	 *      snoop traffic/latency on walks outweighs the cost of cache
+	 *      maintenance on PTE updates.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -82,6 +87,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
 	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
+	#define IO_PGTABLE_QUIRK_NON_COHERENT	BIT(6)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
