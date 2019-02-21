Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C38AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:49:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3758920880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J4RAZEGH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THBIdfvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3758920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iMhe8eeW5Gpl2ZhDoVxDj39wp8sCu6Zv4kTMoxQ1L9Q=; b=J4RAZEGHpsDtj1
	nlZFrLxrcmy1bwEAWQfp255ZaISKUUrwcpzqgEKu1dy4OnRItNdlkBDqLAyTIMzgkOL7BK5bLoj8a
	3PUYj8TALUhT6Ox9uMo0dUbhmSXEQU+/CxIJhregetmRybM6N9SxS1S8eRcO39sC4hUdQkYqJBOOH
	gtpEbv/xQzzjMVsOVaZBNbJsoK7NS1fEheNf8ofTbAWXx5MZDmR4Ee0LjDiUZ6TYG2QRzS97bsHBe
	I3xtHPjEXAweSjZN0u82Fa/js0qgUVSqTam9HGEK2w4U8grMeaDnS8F4cCklNpTd7j2tmtburuu5U
	G5O/jlIPniiKQK6CFh7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwk2j-0007JJ-Gn; Thu, 21 Feb 2019 08:49:21 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwk2E-0006l4-Mt
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 08:49:02 +0000
Received: by mail-pg1-x542.google.com with SMTP id m2so11184046pgl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 00:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Px+db7f7uMwYVRSzBolgafHC1+PpTUWWcoFxgLgxjKQ=;
 b=THBIdfvGqIgkoZXDdEcbKFs53SMkoTm9vQ4uyrfTScUufutz8EMNe1SKdwpPlpbKB8
 Bf25JeeVXsJ/UyVRqswePG52y+LL8aF8irCrh9gJXl1SbFUnLuTryIwoJiguEMGMwG0j
 not+b1GljwYFqiXzRZGTXoEjGz7CIlGiwnonc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Px+db7f7uMwYVRSzBolgafHC1+PpTUWWcoFxgLgxjKQ=;
 b=Z7FpgvGjezY35z1O4XcdMXJfSqA1qo1ii6Rirjg1DKQ7nuJ1RLgxNVRCy8Cu/qRoqt
 /qyIr6IuY5obmSZsn1+ZldyP5iuHG/flPd7EwETOOkujY4TC4Oq7hQLmh9p/BdjIsDkG
 G1jiDOetCBSUTtFHqa/dvlud6Ko1V5SNAK6EqrCO8ucpNhBlF7ozrAoUuI0Fb06tXmeM
 djEIzP1F+4E4/7+58SI8IW73tpqrLfl7f9OXpregrZmZg1CjAPLQJpZ37YtCBkJRNCMH
 xg242871xpxkNFbar6YCg8av/rPRruffXAajz0xRfKSkfEfcvilBOF1o9/CRDkdzPxAY
 ezMA==
X-Gm-Message-State: AHQUAuZANjuapfXl4OXiTN7Bo2CfUbIw/hl0EIh5ozGdjJ+8X0jrniwo
 4Ce1F8Y+5sDKm8Dow9H4DReEPw==
X-Google-Smtp-Source: AHgI3IYX8B/NVsuEhmhWKdh4jo4EZZoYqf//7+Hm15c4TqYnhyRw1noiVANi6V5H7dahIQlVrNnQrw==
X-Received: by 2002:a62:f51d:: with SMTP id n29mr31990636pfh.21.1550738930083; 
 Thu, 21 Feb 2019 00:48:50 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id b4sm23154027pgq.57.2019.02.21.00.48.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 00:48:49 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH v5 3/6] remoteproc: mt8183: add reserved memory manager API
Date: Thu, 21 Feb 2019 16:47:26 +0800
Message-Id: <20190221084729.101784-4-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221084729.101784-1-pihsun@chromium.org>
References: <20190221084729.101784-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_004851_097143_1B509544 
X-CRM114-Status: GOOD (  14.30  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Erin Lo <erin.lo@mediatek.com>

Add memory table mapping API for other driver to lookup
reserved physical and virtual memory

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
Changes from v4:
 - New patch.
---
 drivers/remoteproc/mtk_scp.c          | 110 ++++++++++++++++++++++++++
 include/linux/platform_data/mtk_scp.h |  20 +++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index a84d69ae6c531b..c689a8cc41f092 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -331,6 +331,112 @@ void *scp_mapping_dm_addr(struct platform_device *pdev, u32 mem_addr)
 }
 EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
 
+#if SCP_RESERVED_MEM
+phys_addr_t scp_mem_base_phys;
+phys_addr_t scp_mem_base_virt;
+phys_addr_t scp_mem_size;
+
+static struct scp_reserve_mblock scp_reserve_mblock[] = {
+	{
+		.num = SCP_ISP_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x1400000,  /*20MB*/
+	},
+};
+
+static int scp_reserve_mem_init(struct mtk_scp *scp)
+{
+	enum scp_reserve_mem_id_t id;
+	phys_addr_t accumlate_memory_size = 0;
+
+	scp_mem_base_phys = (phys_addr_t) (scp->phys_addr + MAX_CODE_SIZE);
+	scp_mem_size = (phys_addr_t) (scp->dram_size - MAX_CODE_SIZE);
+
+	dev_info(scp->dev,
+		 "phys:0x%llx - 0x%llx (0x%llx)\n",
+		 scp_mem_base_phys,
+		 scp_mem_base_phys + scp_mem_size,
+		 scp_mem_size);
+	accumlate_memory_size = 0;
+	for (id = 0; id < SCP_NUMS_MEM_ID; id++) {
+		scp_reserve_mblock[id].start_phys =
+			scp_mem_base_phys + accumlate_memory_size;
+		accumlate_memory_size += scp_reserve_mblock[id].size;
+		dev_info(scp->dev,
+			 "[reserve_mem:%d]: phys:0x%llx - 0x%llx (0x%llx)\n",
+			 id,
+			 scp_reserve_mblock[id].start_phys,
+			 scp_reserve_mblock[id].start_phys + scp_reserve_mblock[id].size,
+			 scp_reserve_mblock[id].size);
+	}
+	return 0;
+}
+
+static int scp_reserve_memory_ioremap(struct mtk_scp *scp)
+{
+	enum scp_reserve_mem_id_t id;
+	phys_addr_t accumlate_memory_size = 0;
+
+	scp_mem_base_virt = (phys_addr_t)(size_t)ioremap_wc(scp_mem_base_phys, scp_mem_size);
+
+	dev_info(scp->dev,
+		 "virt:0x%llx - 0x%llx (0x%llx)\n",
+		(phys_addr_t)scp_mem_base_virt,
+		(phys_addr_t)scp_mem_base_virt + (phys_addr_t)scp_mem_size,
+		scp_mem_size);
+	for (id = 0; id < SCP_NUMS_MEM_ID; id++) {
+		scp_reserve_mblock[id].start_virt =
+			scp_mem_base_virt + accumlate_memory_size;
+		accumlate_memory_size += scp_reserve_mblock[id].size;
+	}
+	/* the reserved memory should be larger then expected memory
+	 * or scp_reserve_mblock does not match dts
+	 */
+	WARN_ON(accumlate_memory_size > scp_mem_size);
+#ifdef DEBUG
+	for (id = 0; id < NUMS_MEM_ID; id++) {
+		dev_info(scp->dev,
+			 "[mem_reserve-%d] phys:0x%llx,virt:0x%llx,size:0x%llx\n",
+			 id,
+			 scp_get_reserve_mem_phys(id),
+			 scp_get_reserve_mem_virt(id),
+			 scp_get_reserve_mem_size(id));
+	}
+#endif
+	return 0;
+}
+phys_addr_t scp_get_reserve_mem_phys(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	} else
+		return scp_reserve_mblock[id].start_phys;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserve_mem_phys);
+
+phys_addr_t scp_get_reserve_mem_virt(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	} else
+		return scp_reserve_mblock[id].start_virt;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserve_mem_virt);
+
+phys_addr_t scp_get_reserve_mem_size(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	} else
+		return scp_reserve_mblock[id].size;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserve_mem_size);
+#endif
+
 static int scp_map_memory_region(struct mtk_scp *scp)
 {
 	struct device_node *node;
@@ -358,6 +464,10 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 		return -EBUSY;
 	}
 
+#if SCP_RESERVED_MEM
+	scp_reserve_mem_init(scp);
+	scp_reserve_memory_ioremap(scp);
+#endif
 	return 0;
 }
 
diff --git a/include/linux/platform_data/mtk_scp.h b/include/linux/platform_data/mtk_scp.h
index dfda0505123563..7625eede2e5832 100644
--- a/include/linux/platform_data/mtk_scp.h
+++ b/include/linux/platform_data/mtk_scp.h
@@ -132,4 +132,24 @@ unsigned int scp_get_venc_hw_capa(struct platform_device *pdev);
 void *scp_mapping_dm_addr(struct platform_device *pdev,
 			  u32 mem_addr);
 
+#define SCP_RESERVED_MEM	(1)
+#if SCP_RESERVED_MEM
+/* scp reserve memory ID definition*/
+enum scp_reserve_mem_id_t {
+	SCP_ISP_MEM_ID,
+	SCP_NUMS_MEM_ID,
+};
+
+struct scp_reserve_mblock {
+	enum scp_reserve_mem_id_t num;
+	u64 start_phys;
+	u64 start_virt;
+	u64 size;
+};
+
+extern phys_addr_t scp_get_reserve_mem_phys(enum scp_reserve_mem_id_t id);
+extern phys_addr_t scp_get_reserve_mem_virt(enum scp_reserve_mem_id_t id);
+extern phys_addr_t scp_get_reserve_mem_size(enum scp_reserve_mem_id_t id);
+#endif
+
 #endif /* _MTK_SCP_H */
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
