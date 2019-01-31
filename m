Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7F9C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:40:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBB620869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jhSkOXiV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="z9ErIdVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBB620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6tBXQE+0BhfZ8Yi1GnXbaYEfkwMn10jQNVKyqs1pxyE=; b=jhS
	kOXiVSas+URxq5yfRccMFSAcwRgbrB8dU5TIpBXgy23qYRGnDM5GYf16dPpc8LB7uBp2QKLDq+aKi
	sIXrJpubdMschI5OGekLx8dIyxEvXipkaPn70Xzdo6lrkFtO3DuLND4Cp/E8BHMgsGD8VXHbF5JWL
	Pn0seVsoKtKHGPwPMGZbAO8xvELFw1B7mu8Zqrrj2LiPQxQC5YrGOqzVJm7igTkkbMtkR7TfZqJYT
	tBW6GRrCndxjl5Q99dHds1hN/YZIjwXtXZfakJvIkMsad7OozVyGFX2fVoHaHV9+/VyE4GA/Qzgsu
	v2k079xEMWfwhw5KnqaeAS2uANE0lTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpK4P-0000Dg-1A; Thu, 31 Jan 2019 21:40:25 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpK4J-0000D2-OT
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 21:40:23 +0000
Received: by mail-pl1-x641.google.com with SMTP id gn14so2064359plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ettus-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=kLPQZAP8sKNPEi/JN93GiHRxgd2Jho3MJQZztOwRylY=;
 b=z9ErIdVyix7DZl5Nzh8SSLTyRUT3q6vyk/4zKvWlpk7Fl5SEhLIlIIl5hnRDIP8svp
 hpU1SWTeWGkIRo2gK+oNAw9ibUz1uHErbt4aSPSsxUeI/w1am8PlA8Z3k0ti/9aoSBRc
 Q5ar3JE9i7+GFZRA71FNE4CAjFJboXMLnxL7xyJzhPDPSzCnR2WZRrSlDSSpHJ/Zfljm
 NrL4Vnl3mP6hviUjONRoEsyIe3PTu8XoZfyuz03DacQs42cNzfJLV+Za22ZL0SQ/DsZi
 2nqMi3Ov1JpHWxngP/Y7zukK9OjS2DHrLErUOtNVSDwEuVTp6tCbCb6XvGZTQriwlUNK
 Xopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kLPQZAP8sKNPEi/JN93GiHRxgd2Jho3MJQZztOwRylY=;
 b=DfzPot8DFwZgSoeydLYVewzu5n59AmEl1ViWQqOIDqhatBJ4o6PHZZ/DhBCUC8pNML
 rppUiQ9cYRloY0+xK+0KxkdQg+kzrqCbeC4882Y7F3DeUOhUBduRD4Pz/8ZB87njSX92
 pGdAyS9jZohElkzJ0ArbOwUT7AIlYGJJdF3DZXuGxtuS6QUbTShGcSb97t6pBy552OJQ
 fX0ugeOq+8Lihwi7b/APbOVxmI+Lmr+NqZBmyb/QX9Q1mpeBW5Vv/lp0rI8elGyoXq78
 N9iJs0Ok8OhOgY9W2KAgRKjk7Q9G2K9RStHsaUTChGSKuaWBVgiY9R/6bEtkdTRQ9afx
 I1iw==
X-Gm-Message-State: AJcUukfgu1JjLSaPigyzmN7LJNMPXhnby+t6L4ptJftA+HPeRbykSfcD
 uVfCjOUF4Uas8EJvuAGPuMpCqA==
X-Google-Smtp-Source: ALg8bN75qUUcpT7m1NKgdVllNdkzDsj305svI+DIIaH730iYwO9IlGmcA7e8WrdcF7NlXoqwbTCY5w==
X-Received: by 2002:a17:902:680f:: with SMTP id
 h15mr35953809plk.40.1548970818787; 
 Thu, 31 Jan 2019 13:40:18 -0800 (PST)
Received: from localhost.localdomain (cpe-76-176-152-96.san.res.rr.com.
 [76.176.152.96])
 by smtp.gmail.com with ESMTPSA id 78sm7313495pft.184.2019.01.31.13.40.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 13:40:17 -0800 (PST)
From: alex.williams@ettus.com
To: mical.simek@xilinx.com
Subject: [PATCH] i2c: cadence: Handle transfer_size rollover
Date: Thu, 31 Jan 2019 13:39:57 -0800
Message-Id: <20190131213957.11568-1-alex.williams@ettus.com>
X-Mailer: git-send-email 2.14.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_134019_798260_763CA095 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Alex Williams <alex.williams@ni.com>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Alex Williams <alex.williams@ni.com>

Under certain conditions, Cadence's I2C controller's transfer_size
register will roll over and generate invalid read transactions. Before
this change, the ISR relied solely on the RXDV bit to determine when to
write more data to the user's buffer. The invalid read data would cause
overruns, smashing stacks and worse.

This change stops the buffer writes to the requested boundary and
reports the error. The controller will be reset so normal transactions
may resume.

Signed-off-by: Alex Williams <alex.williams@ni.com>
---
 drivers/i2c/busses/i2c-cadence.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..64e1d9e888c3 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -213,6 +213,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 
 	isr_status = cdns_i2c_readreg(CDNS_I2C_ISR_OFFSET);
 	cdns_i2c_writereg(isr_status, CDNS_I2C_ISR_OFFSET);
+	id->err_status = 0;
 
 	/* Handling nack and arbitration lost interrupt */
 	if (isr_status & (CDNS_I2C_IXR_NACK | CDNS_I2C_IXR_ARB_LOST)) {
@@ -246,10 +247,17 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 			    !id->bus_hold_flag)
 				cdns_i2c_clear_bus_hold(id);
 
-			*(id->p_recv_buf)++ =
-				cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
-			id->recv_count--;
-			id->curr_recv_count--;
+			if (id->recv_count > 0) {
+				*(id->p_recv_buf)++ =
+					cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
+				id->recv_count--;
+				id->curr_recv_count--;
+			} else {
+				dev_err(id->adap.dev.parent,
+					"xfer_size reg rollover. xfer aborted!\n");
+				id->err_status |= CDNS_I2C_IXR_TO;
+				break;
+			}
 
 			if (cdns_is_holdquirk(id, hold_quirk))
 				break;
@@ -347,7 +355,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	}
 
 	/* Update the status for errors */
-	id->err_status = isr_status & CDNS_I2C_IXR_ERR_INTR_MASK;
+	id->err_status |= isr_status & CDNS_I2C_IXR_ERR_INTR_MASK;
 	if (id->err_status)
 		status = IRQ_HANDLED;
 
-- 
2.14.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
