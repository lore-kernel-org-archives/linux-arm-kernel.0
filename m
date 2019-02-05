Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF98C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:37:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E53720818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jo7BU26a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E53720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CtlKFykwlg6O2Oty0k4BoZ8jTMFccRBctt+wgNeR3zQ=; b=Jo7BU26aayfcZ1
	GWBCIEdPnqjyShsjQ2S/ITgz1hwPQiv82/RHjwbHaHRWQdx93YxEgR/jDveJv9ARgP1xnhrZzknDR
	m3ol9iJeG4BBFDlNyLE0WR0ufWBqi34afYEj8EnINzqnUZgVumy0IxCUy7XAzb/HrSttUzMob6hhx
	bQS24qTkqLXJYP4K7w2Me9NysoSfESKRYjALYI2qQ+SrcD6gwfdbht0paYYDHO8uAAGLaCcPajwsR
	NgglykwpbWaVkq/ZjBXb+GuEBCHkbztSCK+PBKnuJNTo9Wq74xR68yTOxAQC8bT9FzD/ni1U5f8So
	LCPv4LB56CZzC5Bcw8Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3j9-00007Y-OJ; Tue, 05 Feb 2019 16:37:39 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3j5-000078-Rp; Tue, 05 Feb 2019 16:37:37 +0000
Received: by mail-ot1-f65.google.com with SMTP id k98so6773107otk.3;
 Tue, 05 Feb 2019 08:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HBle8rJYyyt01ATizJJrNAmYdunnvDGlqA15wX+Mvo0=;
 b=iVsmbFiVazZ9O5+/PZkEiwixAvTFRMPd6rgIFijuXR6mulnKYtpv0QhVqlnKkLQ8NP
 W29Uvq/+NzXHlxTiKwJ3ptvhqjKxeCjA6bb9/2Gt9gWJkLR6/7owxPn5EjIXtWAUBRoW
 mAUxl5JoCyrTrrVzkfrtr3J6l2jq4skdJWw8SLClxKmoOGfCrVaSZYStFGNfFZDhgQoG
 zn17UJo116XrGhJDs7PFCMGR08966aDKBGpcXcd9M+dLhkPmGhrD1kng0hzz60wWxxA9
 x9ef65I1BtlOKLnhBcjB3oIvT0Pt6qqwqAnFiK1VnhE8gL6HWFTrMxT0BCS3i7zwBPpB
 SVcA==
X-Gm-Message-State: AHQUAuaU3OTzlrzz53d8uazbe/nfghJfjRjRQKA1evP2bQQshLpC5eOb
 dwyCH+K1axKX30TwFGKnlw==
X-Google-Smtp-Source: AHgI3IaE9wj865XsCg1zKNXJlTzg3XklIHlEQvlgM4uI9+q2fh5fiLbj7fCyFd7gWXw+knGd/3ZPvw==
X-Received: by 2002:aca:5053:: with SMTP id e80mr160510oib.334.1549384653183; 
 Tue, 05 Feb 2019 08:37:33 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id r9sm9312678otq.81.2019.02.05.08.37.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 08:37:32 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Allow io-pgtable to be used outside of drivers/iommu/
Date: Tue,  5 Feb 2019 10:37:31 -0600
Message-Id: <20190205163731.17864-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_083735_895566_B8C65162 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Clark <robdclark@gmail.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
use the ARM page table library. Specifically, some ARM Mali GPUs use the
ARM page table formats.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
This will be needed for an in-progress Mali GPU DRM driver. It's using 
the page table lib, but is not a full IOMMU driver.

It's going to be a few cycles I'd guess before the DRM driver is 
anywhere close to merging. So I can carry this if preferred, but release 
early, release often.

Rob

 drivers/iommu/arm-smmu-v3.c                   | 3 +--
 drivers/iommu/arm-smmu.c                      | 2 +-
 drivers/iommu/io-pgtable-arm-v7s.c            | 3 +--
 drivers/iommu/io-pgtable-arm.c                | 3 +--
 drivers/iommu/io-pgtable.c                    | 5 +++--
 drivers/iommu/ipmmu-vmsa.c                    | 3 +--
 drivers/iommu/msm_iommu.c                     | 2 +-
 drivers/iommu/mtk_iommu.h                     | 3 +--
 drivers/iommu/qcom_iommu.c                    | 2 +-
 {drivers/iommu => include/linux}/io-pgtable.h | 0
 10 files changed, 11 insertions(+), 15 deletions(-)
 rename {drivers/iommu => include/linux}/io-pgtable.h (100%)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0d284029dc73..d3880010c6cf 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -18,6 +18,7 @@
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/init.h>
@@ -32,8 +33,6 @@
 
 #include <linux/amba/bus.h>
 
-#include "io-pgtable.h"
-
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index af18a7e7f917..045d93884164 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -39,6 +39,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/init.h>
@@ -56,7 +57,6 @@
 #include <linux/amba/bus.h>
 #include <linux/fsl/mc.h>
 
-#include "io-pgtable.h"
 #include "arm-smmu-regs.h"
 
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index cec29bf45c9b..75a8273d1ae9 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -35,6 +35,7 @@
 #include <linux/atomic.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
@@ -45,8 +46,6 @@
 
 #include <asm/barrier.h>
 
-#include "io-pgtable.h"
-
 /* Struct accessors */
 #define io_pgtable_to_data(x)						\
 	container_of((x), struct arm_v7s_io_pgtable, iop)
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 237cacd4a62b..d3700ec15cbd 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -22,6 +22,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
@@ -31,8 +32,6 @@
 
 #include <asm/barrier.h>
 
-#include "io-pgtable.h"
-
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
 #define ARM_LPAE_MAX_LEVELS		4
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 127558d83667..93f2880be6c6 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -19,11 +19,10 @@
  */
 
 #include <linux/bug.h>
+#include <linux/io-pgtable.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-#include "io-pgtable.h"
-
 static const struct io_pgtable_init_fns *
 io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE
@@ -61,6 +60,7 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 
 	return &iop->ops;
 }
+EXPORT_SYMBOL_GPL(alloc_io_pgtable_ops);
 
 /*
  * It is the IOMMU driver's responsibility to ensure that the page table
@@ -77,3 +77,4 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops)
 	io_pgtable_tlb_flush_all(iop);
 	io_pgtable_init_table[iop->fmt]->free(iop);
 }
+EXPORT_SYMBOL_GPL(free_io_pgtable_ops);
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7a4529c61c19..9a380c10655e 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -35,8 +36,6 @@
 #define arm_iommu_detach_device(...)	do {} while (0)
 #endif
 
-#include "io-pgtable.h"
-
 #define IPMMU_CTX_MAX 8
 
 struct ipmmu_features {
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index fc4270733f11..ef7d1f995d6b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/io-pgtable.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -37,7 +38,6 @@
 
 #include "msm_iommu_hw-8xxx.h"
 #include "msm_iommu.h"
-#include "io-pgtable.h"
 
 #define MRC(reg, processor, op1, crn, crm, op2)				\
 __asm__ __volatile__ (							\
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 778498b8633f..62c2c3e8c5df 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -19,13 +19,12 @@
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <soc/mediatek/smi.h>
 
-#include "io-pgtable.h"
-
 struct mtk_iommu_suspend_reg {
 	u32				standard_axi_mode;
 	u32				dcm_dis;
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index d8595f0a987d..8cdd3f059513 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/kconfig.h>
@@ -42,7 +43,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#include "io-pgtable.h"
 #include "arm-smmu-regs.h"
 
 #define SMMU_INTR_SEL_NS     0x2000
diff --git a/drivers/iommu/io-pgtable.h b/include/linux/io-pgtable.h
similarity index 100%
rename from drivers/iommu/io-pgtable.h
rename to include/linux/io-pgtable.h
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
