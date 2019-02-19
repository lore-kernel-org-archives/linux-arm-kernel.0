Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F3C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3510021903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l1Kas7Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3510021903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mhhzu22Nh388cGO0TUP089/i8JjQdVmTiGX5c3cVe2w=; b=l1Kas7Ld7v/I7w
	lTUigOCqrR+qezTm3OCvwulzqCgcfSQqcxeo9ms0qYR6pAwKRzemD7KMCVljkyVecApsRRRziOmOV
	RKr3MazI5hf+5njgsRPzOQN3UndFVrD996Y6yViO+ktI1P8JkW87ixAieyZNQqd7YsP9YDfrqzNUw
	NgBYiYbtSz7Nq116Cc0FqO6Ee1fYce7S8oqNhNZjoNhHqUC7jFbTWo9Lg/H9GhMncOKPMkMQLxVM6
	O2ptH90jRf1DDC/ymzDG1/6leEJ2Wd7fug1M+rOoZXN0mI8cuVspGk0CR6vyvE4sDh4HfZ8j07a/5
	MlTtwxezJbFMyaYMRd6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0Ht-0002YW-9D; Tue, 19 Feb 2019 07:57:57 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0HA-0001au-MI
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:57:14 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C2A23C5DFA5D557064F3;
 Tue, 19 Feb 2019 15:57:05 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:56 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel
 <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] iommu/arm-smmu-v3: add macro xxx_SIZE to replace
 xxx_DWORDS shift
Date: Tue, 19 Feb 2019 15:54:41 +0800
Message-ID: <20190219075443.17732-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_235712_906853_333D75AF 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The (STRTAB_L1_DESC_DWORDS << 3) appears more than 1 times, replace it
with STRTAB_L1_DESC_SIZE to eliminate the duplication. And the latter
seems more clear when it's used to calculate memory size. And the same is
true for STRTAB_STE_DWORDS and CTXDESC_CD_DWORDS.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c3c4ff2..5bb5dcd 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -202,10 +202,12 @@
 #define STRTAB_SPLIT			8

 #define STRTAB_L1_DESC_DWORDS		1
+#define STRTAB_L1_DESC_SIZE		(STRTAB_L1_DESC_DWORDS << 3)
 #define STRTAB_L1_DESC_SPAN		GENMASK_ULL(4, 0)
 #define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 6)

 #define STRTAB_STE_DWORDS		8
+#define STRTAB_STE_SIZE			(STRTAB_STE_DWORDS << 3)
 #define STRTAB_STE_0_V			(1UL << 0)
 #define STRTAB_STE_0_CFG		GENMASK_ULL(3, 1)
 #define STRTAB_STE_0_CFG_ABORT		0
@@ -251,6 +253,7 @@

 /* Context descriptor (stage-1 only) */
 #define CTXDESC_CD_DWORDS		8
+#define CTXDESC_CD_SIZE			(CTXDESC_CD_DWORDS << 3)
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
 #define CTXDESC_CD_0_TCR_TG0		GENMASK_ULL(7, 6)
@@ -1563,7 +1566,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)

 		if (cfg->cdptr) {
 			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
+					   CTXDESC_CD_SIZE,
 					   cfg->cdptr,
 					   cfg->cdptr_dma);

@@ -1590,7 +1593,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;

-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
+	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_SIZE,
 					 &cfg->cdptr_dma,
 					 GFP_KERNEL | __GFP_ZERO);
 	if (!cfg->cdptr) {
@@ -2176,7 +2179,7 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 			arm_smmu_init_dummy_l2_strtab(smmu, i << STRTAB_SPLIT);
 		} else {
 			arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
-			strtab += STRTAB_L1_DESC_DWORDS << 3;
+			strtab += STRTAB_L1_DESC_SIZE;
 		}
 	}

@@ -2201,7 +2204,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 			 "2-level strtab only covers %u/%u bits of SID\n",
 			 size, smmu->sid_bits);

-	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
+	l1size = cfg->num_l1_ents * STRTAB_L1_DESC_SIZE;
 	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
 				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
@@ -2228,7 +2231,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	u32 size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;

-	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
+	size = (1 << smmu->sid_bits) * STRTAB_STE_SIZE;
 	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
 				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
--
1.8.3



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
