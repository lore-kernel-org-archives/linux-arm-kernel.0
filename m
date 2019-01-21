Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958AFC31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575EF21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pnIK3+FE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dw7WdVi/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dw7WdVi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575EF21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Qf+NGA3sV6nBsEntYpXAvxnLUH2GekEkHI4dFOODIhY=; b=pnIK3+FEVvxKvnG2pSwZC53wY1
	Xo+Eb5agUDl21Fv3q32uvKiIy4M5dNqVK/hFW+p41TSPJ4v9oHjGZFzN1PP6cJM0olGaF2I6FEDW/
	KKbnEURR7mlKejf/RKA4FwC99vGI3YlkTcEsBImAC/feG9mxSHyidTupqOH/wcZeXbZ8LAm56ZARi
	bHX49OnY4CmDOtf/DA7x2pyn1LPGyjD2DPZLslOmnZLf8bqRZz7i6bC6t922Jtm2+JArh30979P99
	4u5gxW/y1KujPXi2Yg8KXeASqUGmP7qRJ5oMFCQi5nRg5k4fc5L6aI+pIHsdnERyhSWH879/te07p
	cNwsD/sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glSXh-0001Qf-0t; Mon, 21 Jan 2019 05:54:41 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glSX3-0000oD-03
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 05:54:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 90B8760860; Mon, 21 Jan 2019 05:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548050040;
 bh=TL7zgB0m7LfWtfKkA5XH+oaFc8qMHKopAjg5Aq+3o/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dw7WdVi/8T6G7C6y8yBGXR+rj/0SdpbO7iU56HQq4m2SarCfX1sre/pQB/lQs0YlY
 rftBKz8sKcSwPqbYBJc5Lh2+4rTBn8u5SmU9ABAI6fQBuXEnGESkhXwstGrVfm1XPT
 fdVfMWQWngzNV5UEv4dc4SzmwmiB/NTkmdXNmbao=
Received: from blr-ubuntu-41.ap.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E929609BD;
 Mon, 21 Jan 2019 05:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548050040;
 bh=TL7zgB0m7LfWtfKkA5XH+oaFc8qMHKopAjg5Aq+3o/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dw7WdVi/8T6G7C6y8yBGXR+rj/0SdpbO7iU56HQq4m2SarCfX1sre/pQB/lQs0YlY
 rftBKz8sKcSwPqbYBJc5Lh2+4rTBn8u5SmU9ABAI6fQBuXEnGESkhXwstGrVfm1XPT
 fdVfMWQWngzNV5UEv4dc4SzmwmiB/NTkmdXNmbao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E929609BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 3/3] iommu/arm-smmu: Add support to use system cache
Date: Mon, 21 Jan 2019 11:23:35 +0530
Message-Id: <20190121055335.15430-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_215401_754345_13A123DB 
X-CRM114-Status: GOOD (  15.76  )
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
Cc: pdaly@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Few Qualcomm platforms, such as sdm845 have an additional outer
cache called as System cache, aka. Last level cache (LLC) that
allows non-coherent devices to upgrade to using caching.
This last level cache sits right before the DDR, and is tightly
coupled with the memory controller.
The cache is available to a number of devices - coherent and
non-coherent, present in the SoC system, and to CPUs.
The devices request their slices from this system cache, make it
active, and can then start using it.

Devices can set iommu domain attributes and page protection
while mapping the buffers to set the required memory attributes
to use system cache for buffers and page tables.
This change adds the support for iommu domain attributes and the
interaction with io page table driver.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 52b300dfc096..324f3bb54c78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -260,7 +260,8 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
-#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT	BIT(0)
+#define ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE	BIT(1)
+#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT		BIT(0)
 	unsigned int			attr;
 };
 
@@ -910,6 +911,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_COHERENT;
 
+	if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_QCOM_SYS_CACHE;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
@@ -1592,6 +1596,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			*(int *)data = !!(smmu_domain->attr &
+					  ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE);
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1633,6 +1641,16 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+			if (*(int *)data)
+				smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE;
+			else
+				smmu_domain->attr &= ~ARM_SMMU_DOMAIN_ATTR_QCOM_SYS_CACHE;
+			break;
 		default:
 			ret = -ENODEV;
 		}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
