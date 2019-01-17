Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B7AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:28:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF4820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gDny1ZoM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c/GIolUk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="otvSQucU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF4820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bTsxNF/q0J8hlbmf/GgRBEFoRr3qj7aZ4tv9wjMFhTM=; b=gDny1ZoMbfOi9bP4bBlZx4BcBG
	KixB3d+lUMkZxe+8iFcI8fMunxdMsmga2B6vz8Vuxa9klohZVsBQc9CSO2fDWonxT4qehNY/D/IPD
	EXD11xxGI9V+VGw/B2ZiiD5Amj7VKKIGcsczoNG6SEIBJrLOJb1LKdm0IAqRe/t4lQVh17I1XRRSN
	ErJx9466P3JCPNLAdag94LV5lostkqDYatT716/mpIydEgwq34/s8SSbNiagn79i7ceD1N5oQ4ToH
	TyBb3dEYgxeHxd4s4h6UIogMlxhsYzaQckL1VzjQcwMVtFr8RB0mhAE0MZc/D6iztS4LttbJyg0me
	h26gssVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk3y0-0007cg-Id; Thu, 17 Jan 2019 09:28:04 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk3xb-0007EU-Cy
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:27:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E944060928; Thu, 17 Jan 2019 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547717258;
 bh=1FOuaIwqoqh+sAAt199GtzaQ16QwThY29t1r7ojLmQ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c/GIolUkQ5uk5aM6g7ktmM8nHhrKT0v8OPrfgsvrbz+tlG/ULPIqBbfuQCRI/sHsi
 bA5/xA/8/Ptyv6HVShLWj/q/i4HohwESJiPPoBVfd/wlw9qjm2Pb28owH5sBO4YvhG
 S0//5aN1KS+YvOEHXqd4umwKs1aibJ9NM8qyhSjw=
Received: from blr-ubuntu-41.ap.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D8587608BA;
 Thu, 17 Jan 2019 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547717256;
 bh=1FOuaIwqoqh+sAAt199GtzaQ16QwThY29t1r7ojLmQ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=otvSQucUmuvrM8TuHoI7I6qfkjj5smG15AC8ybFKkCvJPyaCkL128EgrUfwfag2rv
 2Hg9MYvjLEDAg6m7ck8cPRRRdQ7McJpuaGhe4Fcws3RDMKe899rrCW5jahvXmnVW9t
 AuRL+GwYrgo23GIYbLfBZqKfQ+EnepgGmBbDyV18=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8587608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page table
 mappings
Date: Thu, 17 Jan 2019 14:57:18 +0530
Message-Id: <20190117092718.1396-3-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_012740_227624_D1D365B6 
X-CRM114-Status: GOOD (  12.65  )
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

Adding a device tree option for arm smmu to enable non-cacheable
memory for page tables.
We already enable a smmu feature for coherent walk based on
whether the smmu device is dma-coherent or not. Have an option
to enable non-cacheable page table memory to force set it for
particular smmu devices.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index af18a7e7f917..7ebbcf1b2eb3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -188,6 +188,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_PGTBL_NON_COHERENT (1 << 1)
 	u32				options;
 	enum arm_smmu_arch_version	version;
 	enum arm_smmu_implementation	model;
@@ -273,6 +274,7 @@ static bool using_legacy_binding, using_generic_binding;
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ ARM_SMMU_OPT_PGTBL_NON_COHERENT, "arm,smmu-pgtable-non-coherent" },
 	{ 0, NULL},
 };
 
@@ -902,6 +904,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
+	/* Non coherent page table mappings only for Stage-1 */
+	if (smmu->options & ARM_SMMU_OPT_PGTBL_NON_COHERENT &&
+	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_COHERENT;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
