Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E15D21928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fFMzp8O+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iJlnxSXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E15D21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=slyIxEv3UNcIJam4n7zY95+utt8h/poGdXg3ftMMlas=; b=fFMzp8O+dXlKow/mz4fpTqVkMs
	0jZY70owr0fsaBwGnrxFZdDOv2vfnJkjx4epKaKIgQdj+yJAm/LtChnF7eVc63n2CW1JyaOaGgP9K
	Ux3c9LgZTY2H9mOqWTaux2eyX2+x2fjF/59UAF+trrO+I9iobUi0roTeBsNqLt9MUAAb4f2obrFDw
	COfefJ2tyBBVzunAu28Ij2HMZGLCZSU9Vo6GpEP7kyO7WARJkAFU+PsUW9PFv4puQRO2LfYKf9RCz
	6HHgCz/a7bYSAmEoIq9nc1JT3SEkc7ZZuSy3+lCFvjHs8kyU9xdbqMRMcOiKflbz0Z4SFz6oSPlfQ
	2cd768GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLGo-00085A-P1; Thu, 14 Feb 2019 17:57:58 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLGc-0007ms-8x
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:57:50 +0000
Received: by mail-it1-x141.google.com with SMTP id v72so16556938itc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eMDJ3N4Coywd8ehaqLaAHj4/nVmObQyAb5JBFHqgPAM=;
 b=iJlnxSXWDH+u2DvUTAfqfPBt8KxkE364uXxBDtbdPjQIVbbl/UIj26c03LfNqfat+4
 qYh1HtXPbnMcQf3YwKZ/SgVNFLaBTFmQRug2+dS6EdrMtPewoqk3AqykXc3w+N47zk+K
 zKPNYhSELHKQoL8JgLXBsgxhTnYwQY2AmjWWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eMDJ3N4Coywd8ehaqLaAHj4/nVmObQyAb5JBFHqgPAM=;
 b=YD0jH3njjbLi8DtUxAQPvAAmxPJBWyY2srFDYDUVBgtkgePLlkWcrpD9rYJ7YLJt9v
 z9o+KV7okU9LxUn7i2XtujKA/6RD7Ro97l6Beji0HyWUrlqjngyYhbdm1tHTC40qMgO7
 IPer49fE5h7bA1ChrTiVVg1d31uWaxX5QF2TR23i0XDmKxA3T4WKRnVBl6nDr5NewkwY
 6DHLOgg0hC1hSPWKh7RTH/7YZsQtfH9R6QmSInr6s3wwI2rZj9iXtqjhECxMVayo3tDf
 t4cUBe3ZRv3fmWi4nYrFlNDkYHh0N10QT/oaZr9ow70MVNEnI0HTfLmihveXMGoSQuFP
 g5Sg==
X-Gm-Message-State: AHQUAuaFp+Qnchhewz0uTDOo7/PCVU655xy00n1WYRyf2C8d2zAZzxcQ
 91oPyCD7AhXVKA81OvKII5gGtQ==
X-Google-Smtp-Source: AHgI3Ib5pPO2nUKVy3iKWWhra1BA9QmdtQJtabrGqDGe/tF6PyNYLTWmuEv9gYHBmoviVN5Q/YeLRQ==
X-Received: by 2002:a24:de87:: with SMTP id d129mr2709056itg.110.1550167065178; 
 Thu, 14 Feb 2019 09:57:45 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:57:44 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 1/8] i2c: iproc: Extend I2C read up to 255 bytes
Date: Thu, 14 Feb 2019 09:57:18 -0800
Message-Id: <20190214175725.60462-2-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095746_517819_45391304 
X-CRM114-Status: GOOD (  20.51  )
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
Cc: devicetree@vger.kernel.org, Shreesha Rajashekar <shreesha@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Shreesha Rajashekar <shreesha@broadcom.com>

Add support to allow I2C master read transfer up to 255 bytes.

Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 98 +++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 4c8c3bc4669c..eb7339a0280e 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -80,6 +80,10 @@
 
 #define I2C_TIMEOUT_MSEC             50000
 #define M_TX_RX_FIFO_SIZE            64
+#define M_RX_FIFO_MAX_THLD_VALUE     (M_TX_RX_FIFO_SIZE - 1)
+
+#define M_RX_MAX_READ_LEN            255
+#define M_RX_FIFO_THLD_VALUE         50
 
 enum bus_speed_index {
 	I2C_SPD_100K = 0,
@@ -102,17 +106,41 @@ struct bcm_iproc_i2c_dev {
 
 	/* bytes that have been transferred */
 	unsigned int tx_bytes;
+	/* bytes that have been read */
+	unsigned int rx_bytes;
+	unsigned int thld_bytes;
 };
 
 /*
  * Can be expanded in the future if more interrupt status bits are utilized
  */
-#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT))
+#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT)\
+		| BIT(IS_M_RX_THLD_SHIFT))
+
+static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
+{
+	struct i2c_msg *msg = iproc_i2c->msg;
+
+	/* Read valid data from RX FIFO */
+	while (iproc_i2c->rx_bytes < msg->len) {
+		if (!((readl(iproc_i2c->base +
+		M_FIFO_CTRL_OFFSET) >>
+		M_FIFO_RX_CNT_SHIFT) &
+		M_FIFO_RX_CNT_MASK))
+			break;
+
+		msg->buf[iproc_i2c->rx_bytes] =
+			(readl(iproc_i2c->base + M_RX_OFFSET) >>
+			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
+		iproc_i2c->rx_bytes++;
+	}
+}
 
 static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 {
 	struct bcm_iproc_i2c_dev *iproc_i2c = data;
 	u32 status = readl(iproc_i2c->base + IS_OFFSET);
+	u32 tmp;
 
 	status &= ISR_MASK;
 
@@ -136,8 +164,6 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 
 			/* mark the last byte */
 			if (idx == msg->len - 1) {
-				u32 tmp;
-
 				val |= BIT(M_TX_WR_STATUS_SHIFT);
 
 				/*
@@ -156,6 +182,32 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 		iproc_i2c->tx_bytes += tx_bytes;
 	}
 
+	if (status & BIT(IS_M_RX_THLD_SHIFT)) {
+		struct i2c_msg *msg = iproc_i2c->msg;
+		u32 bytes_left;
+
+		bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
+		bytes_left = msg->len - iproc_i2c->rx_bytes;
+		if (bytes_left == 0) {
+			/* finished reading all data, disable rx thld event */
+			tmp = readl(iproc_i2c->base + IE_OFFSET);
+			tmp &= ~BIT(IS_M_RX_THLD_SHIFT);
+			writel(tmp, iproc_i2c->base + IE_OFFSET);
+		} else if (bytes_left < iproc_i2c->thld_bytes) {
+			/* set bytes left as threshold */
+			tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+			tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
+			tmp |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
+			writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+			iproc_i2c->thld_bytes = bytes_left;
+		}
+		/*
+		 * bytes_left >= iproc_i2c->thld_bytes,
+		 * hence no need to change the THRESHOLD SET.
+		 * It will remain as iproc_i2c->thld_bytes itself
+		 */
+	}
+
 	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
 		iproc_i2c->xfer_is_done = 1;
 		complete(&iproc_i2c->done);
@@ -253,7 +305,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 {
 	int ret, i;
 	u8 addr;
-	u32 val;
+	u32 val, tmp, val_intr_en;
 	unsigned int tx_bytes;
 	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
 
@@ -298,7 +350,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	 * transaction is done, i.e., the internal start_busy bit, transitions
 	 * from 1 to 0.
 	 */
-	val = BIT(IE_M_START_BUSY_SHIFT);
+	val_intr_en = BIT(IE_M_START_BUSY_SHIFT);
 
 	/*
 	 * If TX data size is larger than the TX FIFO, need to enable TX
@@ -307,9 +359,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	 */
 	if (!(msg->flags & I2C_M_RD) &&
 	    msg->len > iproc_i2c->tx_bytes)
-		val |= BIT(IE_M_TX_UNDERRUN_SHIFT);
-
-	writel(val, iproc_i2c->base + IE_OFFSET);
+		val_intr_en |= BIT(IE_M_TX_UNDERRUN_SHIFT);
 
 	/*
 	 * Now we can activate the transfer. For a read operation, specify the
@@ -317,11 +367,27 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	 */
 	val = BIT(M_CMD_START_BUSY_SHIFT);
 	if (msg->flags & I2C_M_RD) {
+		iproc_i2c->rx_bytes = 0;
+		if (msg->len > M_RX_FIFO_MAX_THLD_VALUE)
+			iproc_i2c->thld_bytes = M_RX_FIFO_THLD_VALUE;
+		else
+			iproc_i2c->thld_bytes = msg->len;
+
+		/* set threshold value */
+		tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
+		tmp |= iproc_i2c->thld_bytes << M_FIFO_RX_THLD_SHIFT;
+		writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+
+		/* enable the RX threshold interrupt */
+		val_intr_en |= BIT(IE_M_RX_THLD_SHIFT);
+
 		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
 		       (msg->len << M_CMD_RD_CNT_SHIFT);
 	} else {
 		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
 	}
+	writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
 	writel(val, iproc_i2c->base + M_CMD_OFFSET);
 
 	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
@@ -353,17 +419,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 		return ret;
 	}
 
-	/*
-	 * For a read operation, we now need to load the data from FIFO
-	 * into the memory buffer
-	 */
-	if (msg->flags & I2C_M_RD) {
-		for (i = 0; i < msg->len; i++) {
-			msg->buf[i] = (readl(iproc_i2c->base + M_RX_OFFSET) >>
-				      M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
-		}
-	}
-
 	return 0;
 }
 
@@ -395,9 +450,8 @@ static const struct i2c_algorithm bcm_iproc_algo = {
 	.functionality = bcm_iproc_i2c_functionality,
 };
 
-static const struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
-	/* need to reserve one byte in the FIFO for the slave address */
-	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
+static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
+	.max_read_len = M_RX_MAX_READ_LEN,
 };
 
 static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
