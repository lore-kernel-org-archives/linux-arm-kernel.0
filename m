Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3442087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VfZES4KW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sc/CJeeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3442087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qfA3OyyoV1SLWsUKXthodAYh6wxpijU68yrumuipFYE=; b=VfZES4KWv+82Dp
	F1qCwoJXlnY/72iSABDpB6lP+vtWOBd6d3RM3DhgWRZcmkhwsNdnzpZi/z7Lbo+IzXXiiDn3RHSz8
	/AWAbImkDPldLw/RAnmmxIphvX/LZlkFISZS8NBIAOkkj68lnopIfOAMzTZdEbEoUNvOT2Bk+1ybx
	GUYQADi2NWKcdKvsyvvngWpBml/DmMvKpHl24+7Ba4222wrb6J/aRXOgvjwvOrGdtUtFNX6dQ+d10
	ATlzM86gfQ5heXEAuY61AzfRHpa1JkO3MoyghuNT9VTIqFi81jEmy4zg1nBgi7ndfsNv5CEhvXH1b
	vC1vzyvr8M5En8EnDnYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggjuh-00039D-Gb; Tue, 08 Jan 2019 05:26:55 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggjuH-0002gr-Lq
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 05:26:36 +0000
Received: by mail-pl1-x642.google.com with SMTP id e5so1300250plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 21:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C46Uqvm+G7ta78uPMlL83SagrUl8BS0SadWc35W3RLM=;
 b=Sc/CJeePNEUaJ02CkuyyXnk2ka4wLe7PJMN4FjfPsT70HFJdDV7bTw2FhWGa4q9U00
 XwACq5Zh23Y2V7gEcC+SsnLQOB6DUPQ8nQVKEfFKhk45d4UEQNCmibxxg1NoVUCREZbI
 Mn0/uZskqAQgc91+ywCrSaPodNq1qBg7VjRxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C46Uqvm+G7ta78uPMlL83SagrUl8BS0SadWc35W3RLM=;
 b=sxridoB4xWKz0vA9rMmOlbY2+ZNZUwX0VgAQuUEIC0PbjEpyefkzvHbcige8nYEMR7
 v9qtlJQ4+ouXRHW5vGxmOLxvubbD5DoKmWtVAcji8ECei/VZXmZ1CpCKmJssygsXZtAL
 H5fD8rVKD1j2aNGHI+cst8e3TC52U5LPoYcO5INzdPHD7exGzlERyXhD1HRXisIlIqxc
 cDL79rEIwY41StKlRmkwAd9zJBcAW9VsC3jNhSVvrIa0B5SXihqnQPnc5GfnHPnoMlr2
 WdEe48RKOErav1yqZ7jF1tjAI9PAgJejNB7kDelPbnrh1dREDyX593Vtu4kvRbtqxQEn
 sXJg==
X-Gm-Message-State: AJcUukcTR9ZmEDCuub3UHjbiJ+aOdp1/DYwT1GMbREjIqwVTP2B6axfx
 eijd7cuhySUxFz1d7q1eYzf/tw==
X-Google-Smtp-Source: ALg8bN6hOlA5q3Jsy+2wRqxKnVwtdcGIwvDCAPrIpuubYzrg2bSV1moJIwELZyWglDp6/Lb1PA8DxQ==
X-Received: by 2002:a17:902:9006:: with SMTP id
 a6mr385678plp.334.1546925188404; 
 Mon, 07 Jan 2019 21:26:28 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id 64sm88106874pff.101.2019.01.07.21.26.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 21:26:27 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [RFC v2 3/6] remoteproc: move IPI interface into separate file.
Date: Tue,  8 Jan 2019 13:26:03 +0800
Message-Id: <20190108052606.59426-4-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108052606.59426-1-pihsun@chromium.org>
References: <20190108052606.59426-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_212630_028308_6BA2322C 
X-CRM114-Status: GOOD (  23.09  )
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

Move the IPI interface into a separate file mtk_scp_ipi.c, so the things
that use the interface only can depend on the module only.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v1:
 - Resolved conflict because of change in Patch 2.
---
 drivers/remoteproc/Makefile      |   2 +-
 drivers/remoteproc/mtk_common.h  |  73 +++++++++++++++
 drivers/remoteproc/mtk_scp.c     | 154 +------------------------------
 drivers/remoteproc/mtk_scp_ipi.c | 108 ++++++++++++++++++++++
 4 files changed, 183 insertions(+), 154 deletions(-)
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 98e3498dbbe0e2..16b3e5e7a81c8e 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,7 +10,7 @@ remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
-obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o
+obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
new file mode 100644
index 00000000000000..e97287a4eb25cc
--- /dev/null
+++ b/drivers/remoteproc/mtk_common.h
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+
+#ifndef __RPROC_MTK_COMMON_H
+#define __RPROC_MTK_COMMON_H
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+
+#define MT8183_SW_RSTN			0x0
+#define MT8183_SW_RSTN_BIT		BIT(0)
+#define MT8183_SCP_TO_HOST		0x1C
+#define MT8183_SCP_IPC_INT_BIT		BIT(0)
+#define MT8183_SCP_WDT_INT_BIT		BIT(8)
+#define MT8183_HOST_TO_SCP		0x28
+#define MT8183_HOST_IPC_INT_BIT		BIT(0)
+#define MT8183_SCP_SRAM_PDN		0x402C
+
+#define SCP_FW_VER_LEN		32
+
+struct scp_run {
+	u32 signaled;
+	s8 fw_ver[SCP_FW_VER_LEN];
+	u32 dec_capability;
+	u32 enc_capability;
+	wait_queue_head_t wq;
+};
+
+struct scp_ipi_desc {
+	scp_ipi_handler_t handler;
+	const char *name;
+	void *priv;
+};
+
+struct mtk_scp {
+	struct device *dev;
+	struct rproc *rproc;
+	struct clk *clk;
+	void __iomem *reg_base;
+	void __iomem *sram_base;
+	size_t sram_size;
+
+	struct share_obj *recv_buf;
+	struct share_obj *send_buf;
+	struct scp_run run;
+	struct mutex scp_mutex; /* for protecting mtk_scp data structure */
+	struct scp_ipi_desc ipi_desc[SCP_IPI_MAX];
+	bool ipi_id_ack[SCP_IPI_MAX];
+	wait_queue_head_t ack_wq;
+
+	void __iomem *cpu_addr;
+	phys_addr_t phys_addr;
+	size_t dram_size;
+};
+
+/**
+ * struct share_obj - SRAM buffer shared with
+ *		      AP and SCP
+ *
+ * @id:		IPI id
+ * @len:	share buffer length
+ * @share_buf:	share buffer data
+ */
+struct share_obj {
+	s32 id;
+	u32 len;
+	u8 share_buf[288];
+};
+
+#endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 6e2e17a227d018..3e84c696523436 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -13,163 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 
+#include "mtk_common.h"
 #include "remoteproc_internal.h"
 
-#define MT8183_SW_RSTN			0x0
-#define MT8183_SW_RSTN_BIT		BIT(0)
-#define MT8183_SCP_TO_HOST		0x1C
-#define MT8183_SCP_IPC_INT_BIT		BIT(0)
-#define MT8183_SCP_WDT_INT_BIT		BIT(8)
-#define MT8183_HOST_TO_SCP		0x28
-#define MT8183_HOST_IPC_INT_BIT		BIT(0)
-#define MT8183_SCP_SRAM_PDN		0x402C
-
-#define SCP_FW_VER_LEN		32
-
 #define MAX_CODE_SIZE 0x500000
 
-struct scp_run {
-	u32 signaled;
-	s8 fw_ver[SCP_FW_VER_LEN];
-	u32 dec_capability;
-	u32 enc_capability;
-	wait_queue_head_t wq;
-};
-
-struct scp_ipi_desc {
-	scp_ipi_handler_t handler;
-	const char *name;
-	void *priv;
-};
-
-struct mtk_scp {
-	struct device *dev;
-	struct rproc *rproc;
-	struct clk *clk;
-	void __iomem *reg_base;
-	void __iomem *sram_base;
-	size_t sram_size;
-
-	struct share_obj *recv_buf;
-	struct share_obj *send_buf;
-	struct scp_run run;
-	struct mutex scp_mutex; /* for protecting mtk_scp data structure */
-	struct scp_ipi_desc ipi_desc[SCP_IPI_MAX];
-	bool ipi_id_ack[SCP_IPI_MAX];
-	wait_queue_head_t ack_wq;
-
-	void __iomem *cpu_addr;
-	phys_addr_t phys_addr;
-	size_t dram_size;
-};
-
-/**
- * struct share_obj - SRAM buffer shared with
- *		      AP and SCP
- *
- * @id:		IPI id
- * @len:	share buffer length
- * @share_buf:	share buffer data
- */
-struct share_obj {
-	s32 id;
-	u32 len;
-	u8 share_buf[288];
-};
-
-int scp_ipi_register(struct platform_device *pdev,
-		     enum scp_ipi_id id,
-		     scp_ipi_handler_t handler,
-		     const char *name,
-		     void *priv)
-{
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
-	struct scp_ipi_desc *ipi_desc;
-
-	if (!scp) {
-		dev_err(&pdev->dev, "scp device is not ready\n");
-		return -EPROBE_DEFER;
-	}
-
-	if (WARN(id < 0 ||  id >= SCP_IPI_MAX || handler == NULL,
-	    "register scp ipi id %d with invalid arguments\n", id))
-		return -EINVAL;
-
-	ipi_desc = scp->ipi_desc;
-	ipi_desc[id].name = name;
-	ipi_desc[id].handler = handler;
-	ipi_desc[id].priv = priv;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(scp_ipi_register);
-
-int scp_ipi_send(struct platform_device *pdev,
-		 enum scp_ipi_id id,
-		 void *buf,
-		 unsigned int len,
-		 unsigned int wait)
-{
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
-	struct share_obj *send_obj = scp->send_buf;
-	unsigned long timeout;
-	int ret;
-
-	if (WARN(id <= SCP_IPI_INIT || id >= SCP_IPI_MAX ||
-	    len > sizeof(send_obj->share_buf) || !buf,
-	    "failed to send ipi message\n"))
-		return -EINVAL;
-
-	ret = clk_prepare_enable(scp->clk);
-	if (ret) {
-		dev_err(scp->dev, "failed to enable clock\n");
-		return ret;
-	}
-
-	mutex_lock(&scp->scp_mutex);
-
-	 /* Wait until SCP receives the last command */
-	timeout = jiffies + msecs_to_jiffies(2000);
-	do {
-		if (time_after(jiffies, timeout)) {
-			dev_err(scp->dev, "scp_ipi_send: IPI timeout!\n");
-			ret = -EIO;
-			mutex_unlock(&scp->scp_mutex);
-			goto clock_disable;
-		}
-	} while (readl(scp->reg_base + MT8183_HOST_TO_SCP));
-
-	memcpy(send_obj->share_buf, buf, len);
-	send_obj->len = len;
-	send_obj->id = id;
-
-	scp->ipi_id_ack[id] = false;
-	/* send the command to SCP */
-	writel(MT8183_HOST_IPC_INT_BIT, scp->reg_base + MT8183_HOST_TO_SCP);
-
-	mutex_unlock(&scp->scp_mutex);
-
-	if (wait) {
-		/* wait for SCP's ACK */
-		timeout = msecs_to_jiffies(wait);
-		ret = wait_event_timeout(scp->ack_wq,
-					 scp->ipi_id_ack[id],
-					 timeout);
-		scp->ipi_id_ack[id] = false;
-		if (WARN(!ret,
-			 "scp ipi %d ack time out !", id))
-			ret = -EIO;
-		else
-			ret = 0;
-	}
-
-clock_disable:
-	clk_disable_unprepare(scp->clk);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(scp_ipi_send);
-
 struct platform_device *scp_get_plat_device(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
new file mode 100644
index 00000000000000..3aa18a387056d3
--- /dev/null
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_data/mtk_scp.h>
+#include <linux/platform_device.h>
+
+#include "mtk_common.h"
+
+int scp_ipi_register(struct platform_device *pdev,
+		     enum scp_ipi_id id,
+		     scp_ipi_handler_t handler,
+		     const char *name,
+		     void *priv)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct scp_ipi_desc *ipi_desc;
+
+	if (!scp) {
+		dev_err(&pdev->dev, "scp device is not ready\n");
+		return -EPROBE_DEFER;
+	}
+
+	if (WARN(id < 0 ||  id >= SCP_IPI_MAX || handler == NULL,
+	    "register scp ipi id %d with invalid arguments\n", id))
+		return -EINVAL;
+
+	ipi_desc = scp->ipi_desc;
+	ipi_desc[id].name = name;
+	ipi_desc[id].handler = handler;
+	ipi_desc[id].priv = priv;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scp_ipi_register);
+
+int scp_ipi_send(struct platform_device *pdev,
+		 enum scp_ipi_id id,
+		 void *buf,
+		 unsigned int len,
+		 unsigned int wait)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct share_obj *send_obj = scp->send_buf;
+	unsigned long timeout;
+	int ret;
+
+	if (WARN(id <= SCP_IPI_INIT || id >= SCP_IPI_MAX ||
+	    len > sizeof(send_obj->share_buf) || !buf,
+	    "failed to send ipi message\n"))
+		return -EINVAL;
+
+	ret = clk_prepare_enable(scp->clk);
+	if (ret) {
+		dev_err(scp->dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	mutex_lock(&scp->scp_mutex);
+
+	 /* Wait until SCP receives the last command */
+	timeout = jiffies + msecs_to_jiffies(2000);
+	do {
+		if (time_after(jiffies, timeout)) {
+			dev_err(scp->dev, "scp_ipi_send: IPI timeout!\n");
+			ret = -EIO;
+			mutex_unlock(&scp->scp_mutex);
+			goto clock_disable;
+		}
+	} while (readl(scp->reg_base + MT8183_HOST_TO_SCP));
+
+	memcpy(send_obj->share_buf, buf, len);
+	send_obj->len = len;
+	send_obj->id = id;
+
+	scp->ipi_id_ack[id] = false;
+	/* send the command to SCP */
+	writel(MT8183_HOST_IPC_INT_BIT, scp->reg_base + MT8183_HOST_TO_SCP);
+
+	mutex_unlock(&scp->scp_mutex);
+
+	if (wait) {
+		/* wait for SCP's ACK */
+		timeout = msecs_to_jiffies(wait);
+		ret = wait_event_timeout(scp->ack_wq,
+					 scp->ipi_id_ack[id],
+					 timeout);
+		scp->ipi_id_ack[id] = false;
+		if (WARN(!ret,
+			 "scp ipi %d ack time out !", id))
+			ret = -EIO;
+		else
+			ret = 0;
+	}
+
+clock_disable:
+	clk_disable_unprepare(scp->clk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(scp_ipi_send);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek scp IPI interface");
-- 
2.20.1.97.g81188d93c3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
