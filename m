Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAA1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:17:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5A92083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tNhWs/U+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xsx+2Mkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5A92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XKIkqO9ZNxbvzoSyuN6s6DKIfZyIvCzkj+uVG3sUeog=; b=tNhWs/U+w4kwbxGHHZXnyCnXXV
	c6N7vkYrG70rwiQ9djda5bYCFT/SlXvgGz9RgX+Nv5Z+M1atFKotP2Kp785hMnCzjDXKf07XxhwYJ
	v0qU4K7pzJBD1w1NV3shZc4A3mT6kLmAfZmGg9s1IgH/PwgGSAgi1hM9Ou2LF//rO1KMt3p7030rC
	euIkSaJL1lbKdQuBRp+sJJBE3YdYLy/lzFqDZak72sF2DGnDf7b7bwVfyokQ45l+oBsJ5ZirEwVOx
	Fbw7+FVSlqYyEqtqNOhnx8ke9rLtdocWbb6rk2sL+fzzOZV2SHf8e906CeRU2ZNTd+Iw0aDVsfjS+
	axJlsk2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnUH-0007Zp-DE; Mon, 04 Feb 2019 23:17:13 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnTR-0006k2-1b
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:16:34 +0000
Received: by mail-pg1-x542.google.com with SMTP id n2so607882pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 15:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l2ed/3/mPo7eGVi+/XTD6G8oylS839DTYEu+KI40Uu8=;
 b=Xsx+2MkhAOjXwm5rpcX8Rf2VRrmnzqWZGYXUWGrJsA6Ji5TqP7q9lmqJQHVd3ALXQr
 FyZxTHPtMOFiXzJSawKIfdgNGPhQPXI1IwSyH6j1J+vcn6PHz3HEHmHCyn1mGF/IlwlG
 NctqFpoX0UMJi8DnALc4B4H9R57xXxgA4ENpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l2ed/3/mPo7eGVi+/XTD6G8oylS839DTYEu+KI40Uu8=;
 b=bcnNus0ziqDPAIf2o4mQDIzaXHLerLuTcYRT9R4IaKqNLjsd3MI6I4/h5frW3HfYii
 OopN9EzejoPABMdprQrDpZaGakL5Tx33532rUsANUIDnnCJ/fa5ZwouIz9BsCnzbJB8a
 NX/tcrJoxcu72onwg6ThYW5a9t/rAVEGpsupnshyT7nHJC1qileVCgVb7njwWem2xkD6
 vX8J8TC8Rce/KMITVDPIzZ7HqIf5SCSJ4hsOFSsYhpa+h30nXy7pFBOeWrcnt7pIENuO
 EXzG7Xubpdy3CKnvPY61bFZTIyefOZmbYlkvg54jI/N4Ia5utU617NzdvFHdrsX2VIpA
 KGgA==
X-Gm-Message-State: AHQUAublDgYI9RLSrDfAkd9MAyV/9gT7PJwEwkkmMInz1ht6kaXWroA3
 PdGSDDh7sFrPTy6WgAT7TICKfg==
X-Google-Smtp-Source: AHgI3IZ2idSToR+7X3967oDxJ6RBeCVIKdL199Z8UDM1NkZXafo40vDyiGzzhjnB3flQVoO9YOMACw==
X-Received: by 2002:a62:30c3:: with SMTP id w186mr1852814pfw.39.1549322180384; 
 Mon, 04 Feb 2019 15:16:20 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 15:16:19 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 4/8] i2c: iproc: add polling support
Date: Mon,  4 Feb 2019 15:15:50 -0800
Message-Id: <20190204231554.87666-5-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_151621_318119_ACF10131 
X-CRM114-Status: GOOD (  26.61  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add polling support to the iProc I2C driver. Polling mode is
activated when the driver fails to obtain an interrupt ID from device
tree

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 298 ++++++++++++++++++-----------
 1 file changed, 181 insertions(+), 117 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 775b3d89a9c4..073e5a8888ad 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -373,95 +373,115 @@ static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
 	}
 }
 
-static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
+static void bcm_iproc_i2c_send(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
-	struct bcm_iproc_i2c_dev *iproc_i2c = data;
-	u32 status = readl(iproc_i2c->base + IS_OFFSET);
-	u32 tmp;
-
-
-	bool ret;
-	u32 sl_status = status & ISR_MASK_SLAVE;
-
-	if (sl_status) {
-		ret = bcm_iproc_i2c_slave_isr(iproc_i2c, sl_status);
-		if (ret)
-			return IRQ_HANDLED;
-		else
-			return IRQ_NONE;
-	}
+	struct i2c_msg *msg = iproc_i2c->msg;
+	unsigned int tx_bytes = msg->len - iproc_i2c->tx_bytes;
+	unsigned int i;
+	u32 val;
 
-	status &= ISR_MASK;
+	/* can only fill up to the FIFO size */
+	tx_bytes = min_t(unsigned int, tx_bytes, M_TX_RX_FIFO_SIZE);
+	for (i = 0; i < tx_bytes; i++) {
+		/* start from where we left over */
+		unsigned int idx = iproc_i2c->tx_bytes + i;
 
-	if (!status)
-		return IRQ_NONE;
+		val = msg->buf[idx];
 
-	/* TX FIFO is empty and we have more data to send */
-	if (status & BIT(IS_M_TX_UNDERRUN_SHIFT)) {
-		struct i2c_msg *msg = iproc_i2c->msg;
-		unsigned int tx_bytes = msg->len - iproc_i2c->tx_bytes;
-		unsigned int i;
-		u32 val;
-
-		/* can only fill up to the FIFO size */
-		tx_bytes = min_t(unsigned int, tx_bytes, M_TX_RX_FIFO_SIZE);
-		for (i = 0; i < tx_bytes; i++) {
-			/* start from where we left over */
-			unsigned int idx = iproc_i2c->tx_bytes + i;
+		/* mark the last byte */
+		if (idx == msg->len - 1) {
+			val |= BIT(M_TX_WR_STATUS_SHIFT);
 
-			val = msg->buf[idx];
-
-			/* mark the last byte */
-			if (idx == msg->len - 1) {
-				val |= BIT(M_TX_WR_STATUS_SHIFT);
+			if (iproc_i2c->irq) {
+				u32 tmp;
 
 				/*
-				 * Since this is the last byte, we should
-				 * now disable TX FIFO underrun interrupt
+				 * Since this is the last byte, we should now
+				 * disable TX FIFO underrun interrupt
 				 */
 				tmp = readl(iproc_i2c->base + IE_OFFSET);
 				tmp &= ~BIT(IE_M_TX_UNDERRUN_SHIFT);
 				writel(tmp, iproc_i2c->base + IE_OFFSET);
 			}
-
-			/* load data into TX FIFO */
-			writel(val, iproc_i2c->base + M_TX_OFFSET);
 		}
-		/* update number of transferred bytes */
-		iproc_i2c->tx_bytes += tx_bytes;
+
+		/* load data into TX FIFO */
+		writel(val, iproc_i2c->base + M_TX_OFFSET);
 	}
 
-	if (status & BIT(IS_M_RX_THLD_SHIFT)) {
-		struct i2c_msg *msg = iproc_i2c->msg;
-		u32 bytes_left;
+	/* update number of transferred bytes */
+	iproc_i2c->tx_bytes += tx_bytes;
+}
 
-		bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
-		bytes_left = msg->len - iproc_i2c->rx_bytes;
-		if (bytes_left == 0) {
+static void bcm_iproc_i2c_read(struct bcm_iproc_i2c_dev *iproc_i2c)
+{
+	struct i2c_msg *msg = iproc_i2c->msg;
+	u32 bytes_left, val;
+
+	bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
+	bytes_left = msg->len - iproc_i2c->rx_bytes;
+	if (bytes_left == 0) {
+		if (iproc_i2c->irq) {
 			/* finished reading all data, disable rx thld event */
-			tmp = readl(iproc_i2c->base + IE_OFFSET);
-			tmp &= ~BIT(IS_M_RX_THLD_SHIFT);
-			writel(tmp, iproc_i2c->base + IE_OFFSET);
-		} else if (bytes_left < iproc_i2c->thld_bytes) {
-			/* set bytes left as threshold */
-			tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-			tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
-			tmp |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
-			writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-			iproc_i2c->thld_bytes = bytes_left;
+			val = readl(iproc_i2c->base + IE_OFFSET);
+			val &= ~BIT(IS_M_RX_THLD_SHIFT);
+			writel(val, iproc_i2c->base + IE_OFFSET);
 		}
-		/*
-		 * bytes_left >= iproc_i2c->thld_bytes,
-		 * hence no need to change the THRESHOLD SET.
-		 * It will remain as iproc_i2c->thld_bytes itself
-		 */
+	} else if (bytes_left < iproc_i2c->thld_bytes) {
+		/* set bytes left as threshold */
+		val = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		val &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
+		val |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
+		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		iproc_i2c->thld_bytes = bytes_left;
 	}
+	/*
+	 * bytes_left >= iproc_i2c->thld_bytes,
+	 * hence no need to change the THRESHOLD SET.
+	 * It will remain as iproc_i2c->thld_bytes itself
+	 */
+}
 
+static void bcm_iproc_i2c_process_m_event(struct bcm_iproc_i2c_dev *iproc_i2c,
+					  u32 status)
+{
+	/* TX FIFO is empty and we have more data to send */
+	if (status & BIT(IS_M_TX_UNDERRUN_SHIFT))
+		bcm_iproc_i2c_send(iproc_i2c);
+
+	/* RX FIFO threshold is reached and data needs to be read out */
+	if (status & BIT(IS_M_RX_THLD_SHIFT))
+		bcm_iproc_i2c_read(iproc_i2c);
+
+	/* transfer is done */
 	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
 		iproc_i2c->xfer_is_done = 1;
-		complete(&iproc_i2c->done);
+		if (iproc_i2c->irq)
+			complete(&iproc_i2c->done);
+	}
+}
+
+static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c = data;
+	u32 status = readl(iproc_i2c->base + IS_OFFSET);
+	bool ret;
+	u32 sl_status = status & ISR_MASK_SLAVE;
+
+	if (sl_status) {
+		ret = bcm_iproc_i2c_slave_isr(iproc_i2c, sl_status);
+		if (ret)
+			return IRQ_HANDLED;
+		else
+			return IRQ_NONE;
 	}
 
+	status &= ISR_MASK;
+	if (!status)
+		return IRQ_NONE;
+
+	/* process all master based events */
+	bcm_iproc_i2c_process_m_event(iproc_i2c, status);
 	writel(status, iproc_i2c->base + IS_OFFSET);
 
 	return IRQ_HANDLED;
@@ -560,14 +580,71 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 }
 
+static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
+				   struct i2c_msg *msg,
+				   u32 cmd)
+{
+	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
+	u32 val, status;
+	int ret;
+
+	writel(cmd, iproc_i2c->base + M_CMD_OFFSET);
+
+	if (iproc_i2c->irq) {
+		time_left = wait_for_completion_timeout(&iproc_i2c->done,
+							time_left);
+		/* disable all interrupts */
+		writel(0, iproc_i2c->base + IE_OFFSET);
+		/* read it back to flush the write */
+		readl(iproc_i2c->base + IE_OFFSET);
+		/* make sure the interrupt handler isn't running */
+		synchronize_irq(iproc_i2c->irq);
+
+	} else { /* polling mode */
+		unsigned long timeout = jiffies + time_left;
+
+		do {
+			status = readl(iproc_i2c->base + IS_OFFSET) & ISR_MASK;
+			bcm_iproc_i2c_process_m_event(iproc_i2c, status);
+			writel(status, iproc_i2c->base + IS_OFFSET);
+
+			if (time_after(jiffies, timeout)) {
+				time_left = 0;
+				break;
+			}
+
+			cpu_relax();
+			cond_resched();
+		} while (!iproc_i2c->xfer_is_done);
+	}
+
+	if (!time_left && !iproc_i2c->xfer_is_done) {
+		dev_err(iproc_i2c->device, "transaction timed out\n");
+
+		/* flush both TX/RX FIFOs */
+		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
+		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		return -ETIMEDOUT;
+	}
+
+	ret = bcm_iproc_i2c_check_status(iproc_i2c, msg);
+	if (ret) {
+		/* flush both TX/RX FIFOs */
+		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
+		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 					 struct i2c_msg *msg)
 {
-	int ret, i;
+	int i;
 	u8 addr;
 	u32 val, tmp, val_intr_en;
 	unsigned int tx_bytes;
-	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
 
 	/* check if bus is busy */
 	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
@@ -602,7 +679,9 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	/* mark as incomplete before starting the transaction */
-	reinit_completion(&iproc_i2c->done);
+	if (iproc_i2c->irq)
+		reinit_completion(&iproc_i2c->done);
+
 	iproc_i2c->xfer_is_done = 0;
 
 	/*
@@ -647,39 +726,11 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	} else {
 		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
 	}
-	writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
-	writel(val, iproc_i2c->base + M_CMD_OFFSET);
 
-	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
+	if (iproc_i2c->irq)
+		writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
 
-	/* disable all interrupts */
-	writel(0, iproc_i2c->base + IE_OFFSET);
-	/* read it back to flush the write */
-	readl(iproc_i2c->base + IE_OFFSET);
-
-	/* make sure the interrupt handler isn't running */
-	synchronize_irq(iproc_i2c->irq);
-
-	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
-
-		/* flush FIFOs */
-		val = (1 << M_FIFO_RX_FLUSH_SHIFT) |
-		      (1 << M_FIFO_TX_FLUSH_SHIFT);
-		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-		return -ETIMEDOUT;
-	}
-
-	ret = bcm_iproc_i2c_check_status(iproc_i2c, msg);
-	if (ret) {
-		/* flush both TX/RX FIFOs */
-		val = (1 << M_FIFO_RX_FLUSH_SHIFT) |
-		      (1 << M_FIFO_TX_FLUSH_SHIFT);
-		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-		return ret;
-	}
-
-	return 0;
+	return bcm_iproc_i2c_xfer_wait(iproc_i2c, msg, val);
 }
 
 static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
@@ -781,17 +832,20 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 		return ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(iproc_i2c->device, "no irq resource\n");
-		return irq;
-	}
-	iproc_i2c->irq = irq;
+	if (irq > 0) {
+		ret = devm_request_irq(iproc_i2c->device, irq,
+				       bcm_iproc_i2c_isr, 0, pdev->name,
+				       iproc_i2c);
+		if (ret < 0) {
+			dev_err(iproc_i2c->device,
+				"unable to request irq %i\n", irq);
+			return ret;
+		}
 
-	ret = devm_request_irq(iproc_i2c->device, irq, bcm_iproc_i2c_isr, 0,
-			       pdev->name, iproc_i2c);
-	if (ret < 0) {
-		dev_err(iproc_i2c->device, "unable to request irq %i\n", irq);
-		return ret;
+		iproc_i2c->irq = irq;
+	} else {
+		dev_warn(iproc_i2c->device,
+			 "no irq resource, falling back to poll mode\n");
 	}
 
 	bcm_iproc_i2c_enable_disable(iproc_i2c, true);
@@ -811,10 +865,15 @@ static int bcm_iproc_i2c_remove(struct platform_device *pdev)
 {
 	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
 
-	/* make sure there's no pending interrupt when we remove the adapter */
-	writel(0, iproc_i2c->base + IE_OFFSET);
-	readl(iproc_i2c->base + IE_OFFSET);
-	synchronize_irq(iproc_i2c->irq);
+	if (iproc_i2c->irq) {
+		/*
+		 * Make sure there's no pending interrupt when we remove the
+		 * adapter
+		 */
+		writel(0, iproc_i2c->base + IE_OFFSET);
+		readl(iproc_i2c->base + IE_OFFSET);
+		synchronize_irq(iproc_i2c->irq);
+	}
 
 	i2c_del_adapter(&iproc_i2c->adapter);
 	bcm_iproc_i2c_enable_disable(iproc_i2c, false);
@@ -828,10 +887,15 @@ static int bcm_iproc_i2c_suspend(struct device *dev)
 {
 	struct bcm_iproc_i2c_dev *iproc_i2c = dev_get_drvdata(dev);
 
-	/* make sure there's no pending interrupt when we go into suspend */
-	writel(0, iproc_i2c->base + IE_OFFSET);
-	readl(iproc_i2c->base + IE_OFFSET);
-	synchronize_irq(iproc_i2c->irq);
+	if (iproc_i2c->irq) {
+		/*
+		 * Make sure there's no pending interrupt when we go into
+		 * suspend
+		 */
+		writel(0, iproc_i2c->base + IE_OFFSET);
+		readl(iproc_i2c->base + IE_OFFSET);
+		synchronize_irq(iproc_i2c->irq);
+	}
 
 	/* now disable the controller */
 	bcm_iproc_i2c_enable_disable(iproc_i2c, false);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
