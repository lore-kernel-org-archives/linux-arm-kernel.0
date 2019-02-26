Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7678C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:17:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B476D217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HVwpaNsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B476D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nis2k3NTD1jz8Do/Khh7yDpOmjeKSHvowdjJh2ZxeYc=; b=HVwpaNsNYSbt71
	a521MmqJKIRto9B5FEgnrboBGmKBOo5mTfLnzr5YWrv1RYo5m7ohqj9Iygn6nlRr5jfrznP1NhELC
	MfvyDAFyXzPxDc0sIYmzD2aaXON8lx79yyEkFrrRyXUAmxFyzlyxSfDTRg8YZZdvP7nKsZyqU6pLG
	MihZBaZM+VB/mJnvVX8/K5kpq7xD7CjjDm2jIbyvtRwtu4iNc7Kem3ndoG3uf66vULZbAlkMmtE07
	sM0JXzKMT8wiDVE1G2GZbnzd9/VIIOz9jB4ni98f8+xNy4qxyj7senBv+wH+4n07e+DaBNBkhqIro
	IifRSe7kMG13LT0UBB+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhID-00076A-QG; Tue, 26 Feb 2019 18:17:25 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhI6-00075b-WD
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:17:21 +0000
Received: by mail-oi1-f194.google.com with SMTP id b4so11145974oif.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 10:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZwOti21/AxuvRaFXoYI0Fe9oH8YvQkT9pI1cRwwj6RE=;
 b=bX+0RQSpccGqbcfwKTXRSGRFAVlleXoo1B+tG2bejbgPjqY29IOlpFShmFsyXKZJJV
 RGiexInjrPzdEtot0QMeMUVr1dzExw1fNl+85T3S2NipwT8eWzfBJgWmzZlkGXiVSLY3
 grdn0b/Ns3I6l8gn15Q1143YsyYMjG9zzKm5M7tc6sTQtzAEVF66+wEJDR4KU3OqQFqZ
 BxGUV5sSaX4n0Ag4RqXRoLgVNdDNb/bNM3bRPGIs2Tno14mJaCzVlc6wCXEIsss6degT
 B1gpCrvxg5ufhPP6RX0ReZwSH7mus7dd+UIEWNcQ0bQgA2G9w6EnR2f/a1s+2kkHvv61
 8G9w==
X-Gm-Message-State: AHQUAuYhLSkhrO2y1eZmQuoImXbH18YRC1sBnSwltKRnNptgzu3VTitM
 86dUvJtO/IzCKF96RhxePw==
X-Google-Smtp-Source: AHgI3IbI1GMMmc+FWJKIN6i2pDnjj9nFfa8KoaRi0wGBSwTkwMtA/l5/w4TozDKiZ7vuHaJVWc+NmA==
X-Received: by 2002:aca:cf4e:: with SMTP id f75mr3243002oig.129.1551205037379; 
 Tue, 26 Feb 2019 10:17:17 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id 33sm4863433otr.53.2019.02.26.10.17.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 10:17:16 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Add a quirk for ARM Mali midgard MMU
Date: Tue, 26 Feb 2019 12:17:16 -0600
Message-Id: <20190226181716.14556-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_101719_030124_703DFB8C 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 tomeu.vizoso@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARM Mali midgard GPUs have a few differences from standard 64-bit
stage 1 page tables.

The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.

The access flags are not read-only and unprivileged, but read and write.
This is similar to stage 2 entries, but the memory attributes field matches
stage 1 being an index.

The nG bit is also not set by the vendor driver, but that one doesn't
seem to matter.

Add a quirk to handle all of these differences.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/io-pgtable-arm.c | 51 ++++++++++++++++++++++------------
 include/linux/io-pgtable.h     |  4 +++
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index d3700ec15cbd..ff6b29fdf38f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -180,11 +180,6 @@
 
 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
 
-#define iopte_leaf(pte,l)					\
-	(l == (ARM_LPAE_MAX_LEVELS - 1) ?			\
-		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE) :	\
-		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK))
-
 struct arm_lpae_io_pgtable {
 	struct io_pgtable	iop;
 
@@ -198,6 +193,15 @@ struct arm_lpae_io_pgtable {
 
 typedef u64 arm_lpae_iopte;
 
+static inline bool iopte_leaf(arm_lpae_iopte pte, int l, unsigned long quirks)
+{
+	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) &&
+	    !(quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD))
+		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
+
+	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
+}
+
 static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 				     struct arm_lpae_io_pgtable *data)
 {
@@ -304,11 +308,14 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		pte |= ARM_LPAE_PTE_NS;
 
 	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
-		pte |= ARM_LPAE_PTE_TYPE_PAGE;
+		pte |= (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD) ?
+			ARM_LPAE_PTE_TYPE_BLOCK : ARM_LPAE_PTE_TYPE_PAGE;
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
-	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
+	if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD))
+		pte |= ARM_LPAE_PTE_AF;
+	pte |= ARM_LPAE_PTE_SH_IS;
 	pte |= paddr_to_iopte(paddr, data);
 
 	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
@@ -321,7 +328,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte = *ptep;
 
-	if (iopte_leaf(pte, lvl)) {
+	if (iopte_leaf(pte, lvl, data->iop.cfg.quirks)) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
@@ -409,7 +416,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		__arm_lpae_sync_pte(ptep, cfg);
 	}
 
-	if (pte && !iopte_leaf(pte, lvl)) {
+	if (pte && !iopte_leaf(pte, lvl, cfg->quirks)) {
 		cptep = iopte_deref(pte, data);
 	} else if (pte) {
 		/* We require an unmap first */
@@ -430,12 +437,19 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
 
-		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-			pte |= ARM_LPAE_PTE_AP_RDONLY;
+		if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD) {
+			if (prot & IOMMU_WRITE)
+				pte |= ARM_LPAE_PTE_AP_RDONLY;
 
-		if (!(prot & IOMMU_PRIV))
-			pte |= ARM_LPAE_PTE_AP_UNPRIV;
+			if (prot & IOMMU_READ)
+				pte |= ARM_LPAE_PTE_AP_UNPRIV;
+		} else {
+			if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
+				pte |= ARM_LPAE_PTE_AP_RDONLY;
 
+			if (!(prot & IOMMU_PRIV))
+				pte |= ARM_LPAE_PTE_AP_UNPRIV;
+		}
 		if (prot & IOMMU_MMIO)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
@@ -511,7 +525,7 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 	while (ptep != end) {
 		arm_lpae_iopte pte = *ptep++;
 
-		if (!pte || iopte_leaf(pte, lvl))
+		if (!pte || iopte_leaf(pte, lvl, data->iop.cfg.quirks))
 			continue;
 
 		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
@@ -602,7 +616,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
 		__arm_lpae_set_pte(ptep, 0, &iop->cfg);
 
-		if (!iopte_leaf(pte, lvl)) {
+		if (!iopte_leaf(pte, lvl, iop->cfg.quirks)) {
 			/* Also flush any partial walks */
 			io_pgtable_tlb_add_flush(iop, iova, size,
 						ARM_LPAE_GRANULE(data), false);
@@ -621,7 +635,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		}
 
 		return size;
-	} else if (iopte_leaf(pte, lvl)) {
+	} else if (iopte_leaf(pte, lvl, iop->cfg.quirks)) {
 		/*
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
@@ -669,7 +683,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 			return 0;
 
 		/* Leaf entry? */
-		if (iopte_leaf(pte,lvl))
+		if (iopte_leaf(pte,lvl, data->iop.cfg.quirks))
 			goto found_translation;
 
 		/* Take it to the next level */
@@ -779,7 +793,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 47d5ae559329..eed037423331 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -75,6 +75,9 @@ struct io_pgtable_cfg {
 	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
 	 *	on unmap, for DMA domains using the flush queue mechanism for
 	 *	delayed invalidation.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD: ARM Mali Midgard MMU has different
+	 *	mapping of access flags and PTE page bits.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -82,6 +85,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
 	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
+	#define IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD BIT(6)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
