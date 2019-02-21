Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5949C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C20C2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LpjzI5Zp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M0jp9B3T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEWm26ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C20C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZQL8To3PTBXzkOrMaZXQ2U9i5vXYZ+6jKKSJqc19tK8=; b=LpjzI5ZpowX+rV
	jI87vYN2cm8E26zg2Z/FoW6XkcK2wJToOiul5dVOu5qja+rYdTE58fqoan2a5rXhq/3VMGKuAJSoE
	R/I7FCjEPXMdtLKr/AohfLnspGBWxyQiTagQotLqKB5NbW5V8bC8jbaKodQjX1YIutd+8qgkPT3W4
	FydzWiq2Av1sR8hjmg2X523H3sArzGwGKYw+7y90yl4VMN9cjEfFKRl4cmgMFOPerpdHh9J/0ILP5
	ryDg52AS0bN4GKomjVh9jLg+QtdDOWFaIe+UufM7U1JInbyUY1LocrTdMfit0R+kdLg5AzlpbTPte
	EOL4YTwnbWPBpM7s+gcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqw6-0005od-Vq; Thu, 21 Feb 2019 16:10:59 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqvt-0005aI-Ah
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qa5OdEXYMr9IGIMIfuO/mzJWw8VwU8/eAeeOD8rGlrg=; b=M0jp9B3T6XB/6OZklHhUMwxvt0
 1so0DWIjoci/euf6wRYFesOVciWuskH6ni0YIAUIyDC3vM4pvONZMcVo2jPX+TbrN4Ga32g68IgT1
 iqfzcb8Ws2J1oGdE2O4asPUO42xcyzDGPpsjNIDrLGSqLxz36FZ9csF1AQPKuB3JpGDBjHNVUVMo4
 B6Ii6ZZ8mrrXvEPYN3GLjmMvYbBs9orY4ZaTLtrLStsdHXG+NVKgZrJXJWwqFhTlZM/ReCl3jBIi5
 4SZrxvaHykyNUBClV2u9oFyAEMnTDUukOPYi69ui6b2eQsiNbg72I+cV5pBiB5Zfb+yrE7faaugi8
 zjbK7FUQ==;
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqY5-0002An-6a
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:09 +0000
Received: by mail-lf1-x141.google.com with SMTP id g12so11101346lfb.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qa5OdEXYMr9IGIMIfuO/mzJWw8VwU8/eAeeOD8rGlrg=;
 b=UEWm26ss9NOF4kbW07S6Wp4jtzR4cjkl9QWbeWuwFk9zFmvl3To9gsV4l0yYaMXW+C
 3mMsR6DyxUSv8U89N/mPuI3ltT18Zlchul0j8nCs0a5yzAV5X28bHNiyPzVFqQcMJIUB
 javYdCaXodBxvtQZDq4A6qfQr1L+x/AMloDTqH2hjRW7QDLyMVCxCZT/D8INKSS9p8ll
 TjG6LP4qRUcCAvHROcrZ7dpelEKhFe1sKjjcI7ElvGFWMZs07Ehuh8nLsUErZri+2bh8
 1dBpduzOu9i9E6d5qltnBIguupptDJhDUGXWxfxFBm/fTyz06R1q9RIQVwfFfBMWh1Be
 QnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qa5OdEXYMr9IGIMIfuO/mzJWw8VwU8/eAeeOD8rGlrg=;
 b=V+UtJqB2ArK2DVptqdYAOnfgHN4bDxYPHdHUjN7bhBfQoFGN6scbNbpxDnPCBmkttB
 XmbMGRnDXW74kbVK2/368SFkQ6DdO6dVaQQf3stm2zAFBhbH5aanQ6XjGYILwyzOS63X
 CuIaFdvSLV0BYlv5eSOSQyknWgCClooShUkPndMKKK6tZF4Suhir70/4XWH2N7vae+Yb
 W9zIdoMFl9Tq3EvPispudWhbmJkxjTGatXH5IH6DDhe7WMF2YVOlhezJIP9roYqvuOj6
 9P8VI/CYQmhlhc1r42kZ1z1Ld7PK8B2wihFJoDTRFb/XUJR5NK3UCjdssxF6p/x5s+ox
 pWYw==
X-Gm-Message-State: AHQUAubyUL0ACWdDPG39YM8VUwsMOxTZdt0tYZbi9ctDuIHkvbqx0z9p
 BZnM5edHiSZc8kDm0S7MWjC6f3jVh94=
X-Google-Smtp-Source: AHgI3IZdqSdAv0QO3jJbJkECEaRmVrBAvlH8RcGzs/TdNFveMNXhvqBw+VaAPgRFeVx+Mf6JSN6ByA==
X-Received: by 2002:a19:c396:: with SMTP id
 t144mr13960818lff.127.1550763966429; 
 Thu, 21 Feb 2019 07:46:06 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:05 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 23/30 v2] soc: ixp4xx: Uninline several functions
Date: Thu, 21 Feb 2019 16:44:51 +0100
Message-Id: <20190221154458.23763-24-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_104609_265586_E1128765 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These inline functions immediately exploit the static ioremaps
for the queue manager memory region. This does not work with
multiplatform where everything need to be dynamically remapped,
so get rid of these inlines and create new exports for those
used by other drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 117 ++++++++++++++++++++++++++++
 include/linux/soc/ixp4xx/qmgr.h  | 127 ++-----------------------------
 2 files changed, 124 insertions(+), 120 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 133914e99aeb..412a346136d8 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -32,6 +32,117 @@ static void *irq_pdevs[QUEUES];
 char qmgr_queue_descs[QUEUES][32];
 #endif
 
+void qmgr_put_entry(unsigned int queue, u32 val)
+{
+#if DEBUG_QMGR
+	BUG_ON(!qmgr_queue_descs[queue]); /* not yet requested */
+
+	printk(KERN_DEBUG "Queue %s(%i) put %X\n",
+	       qmgr_queue_descs[queue], queue, val);
+#endif
+	__raw_writel(val, &qmgr_regs->acc[queue][0]);
+}
+
+u32 qmgr_get_entry(unsigned int queue)
+{
+	u32 val;
+	val = __raw_readl(&qmgr_regs->acc[queue][0]);
+#if DEBUG_QMGR
+	BUG_ON(!qmgr_queue_descs[queue]); /* not yet requested */
+
+	printk(KERN_DEBUG "Queue %s(%i) get %X\n",
+	       qmgr_queue_descs[queue], queue, val);
+#endif
+	return val;
+}
+
+static int __qmgr_get_stat1(unsigned int queue)
+{
+	return (__raw_readl(&qmgr_regs->stat1[queue >> 3])
+		>> ((queue & 7) << 2)) & 0xF;
+}
+
+static int __qmgr_get_stat2(unsigned int queue)
+{
+	BUG_ON(queue >= HALF_QUEUES);
+	return (__raw_readl(&qmgr_regs->stat2[queue >> 4])
+		>> ((queue & 0xF) << 1)) & 0x3;
+}
+
+/**
+ * qmgr_stat_empty() - checks if a hardware queue is empty
+ * @queue:	queue number
+ *
+ * Returns non-zero value if the queue is empty.
+ */
+int qmgr_stat_empty(unsigned int queue)
+{
+	BUG_ON(queue >= HALF_QUEUES);
+	return __qmgr_get_stat1(queue) & QUEUE_STAT1_EMPTY;
+}
+
+/**
+ * qmgr_stat_below_low_watermark() - checks if a queue is below low watermark
+ * @queue:	queue number
+ *
+ * Returns non-zero value if the queue is below low watermark.
+ */
+int qmgr_stat_below_low_watermark(unsigned int queue)
+{
+	if (queue >= HALF_QUEUES)
+		return (__raw_readl(&qmgr_regs->statne_h) >>
+			(queue - HALF_QUEUES)) & 0x01;
+	return __qmgr_get_stat1(queue) & QUEUE_STAT1_NEARLY_EMPTY;
+}
+
+/**
+ * qmgr_stat_above_high_watermark() - checks if a queue is above high watermark
+ * @queue:	queue number
+ *
+ * Returns non-zero value if the queue is above high watermark
+ */
+static int qmgr_stat_above_high_watermark(unsigned int queue)
+{
+	BUG_ON(queue >= HALF_QUEUES);
+	return __qmgr_get_stat1(queue) & QUEUE_STAT1_NEARLY_FULL;
+}
+
+/**
+ * qmgr_stat_full() - checks if a hardware queue is full
+ * @queue:	queue number
+ *
+ * Returns non-zero value if the queue is full.
+ */
+int qmgr_stat_full(unsigned int queue)
+{
+	if (queue >= HALF_QUEUES)
+		return (__raw_readl(&qmgr_regs->statf_h) >>
+			(queue - HALF_QUEUES)) & 0x01;
+	return __qmgr_get_stat1(queue) & QUEUE_STAT1_FULL;
+}
+
+/**
+ * qmgr_stat_underflow() - checks if a hardware queue experienced underflow
+ * @queue:	queue number
+ *
+ * Returns non-zero value if the queue experienced underflow.
+ */
+static int qmgr_stat_underflow(unsigned int queue)
+{
+	return __qmgr_get_stat2(queue) & QUEUE_STAT2_UNDERFLOW;
+}
+
+/**
+ * qmgr_stat_overflow() - checks if a hardware queue experienced overflow
+ * @queue:	queue number
+ *
+ * Returns non-zero value if the queue experienced overflow.
+ */
+int qmgr_stat_overflow(unsigned int queue)
+{
+	return __qmgr_get_stat2(queue) & QUEUE_STAT2_OVERFLOW;
+}
+
 void qmgr_set_irq(unsigned int queue, int src,
 		  void (*handler)(void *pdev), void *pdev)
 {
@@ -375,6 +486,12 @@ module_platform_driver(ixp4xx_qmgr_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Krzysztof Halasa");
 
+EXPORT_SYMBOL(qmgr_put_entry);
+EXPORT_SYMBOL(qmgr_get_entry);
+EXPORT_SYMBOL(qmgr_stat_empty);
+EXPORT_SYMBOL(qmgr_stat_below_low_watermark);
+EXPORT_SYMBOL(qmgr_stat_full);
+EXPORT_SYMBOL(qmgr_stat_overflow);
 EXPORT_SYMBOL(qmgr_set_irq);
 EXPORT_SYMBOL(qmgr_enable_irq);
 EXPORT_SYMBOL(qmgr_disable_irq);
diff --git a/include/linux/soc/ixp4xx/qmgr.h b/include/linux/soc/ixp4xx/qmgr.h
index 4de8da536dbb..bed8ee94fa57 100644
--- a/include/linux/soc/ixp4xx/qmgr.h
+++ b/include/linux/soc/ixp4xx/qmgr.h
@@ -57,6 +57,13 @@ struct qmgr_regs {
 	u32 sram[2048];		/* 0x2000 - 0x3FFF - config and buffer */
 };
 
+void qmgr_put_entry(unsigned int queue, u32 val);
+u32 qmgr_get_entry(unsigned int queue);
+int qmgr_stat_empty(unsigned int queue);
+int qmgr_stat_below_low_watermark(unsigned int queue);
+int qmgr_stat_full(unsigned int queue);
+int qmgr_stat_overflow(unsigned int queue);
+void qmgr_release_queue(unsigned int queue);
 void qmgr_set_irq(unsigned int queue, int src,
 		  void (*handler)(void *pdev), void *pdev);
 void qmgr_enable_irq(unsigned int queue);
@@ -81,124 +88,4 @@ int __qmgr_request_queue(unsigned int queue, unsigned int len /* dwords */,
 			     nearly_full_watermark)
 #endif
 
-void qmgr_release_queue(unsigned int queue);
-
-
-static inline void qmgr_put_entry(unsigned int queue, u32 val)
-{
-	struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
-#if DEBUG_QMGR
-	BUG_ON(!qmgr_queue_descs[queue]); /* not yet requested */
-
-	printk(KERN_DEBUG "Queue %s(%i) put %X\n",
-	       qmgr_queue_descs[queue], queue, val);
-#endif
-	__raw_writel(val, &qmgr_regs->acc[queue][0]);
-}
-
-static inline u32 qmgr_get_entry(unsigned int queue)
-{
-	u32 val;
-	const struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
-	val = __raw_readl(&qmgr_regs->acc[queue][0]);
-#if DEBUG_QMGR
-	BUG_ON(!qmgr_queue_descs[queue]); /* not yet requested */
-
-	printk(KERN_DEBUG "Queue %s(%i) get %X\n",
-	       qmgr_queue_descs[queue], queue, val);
-#endif
-	return val;
-}
-
-static inline int __qmgr_get_stat1(unsigned int queue)
-{
-	const struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
-	return (__raw_readl(&qmgr_regs->stat1[queue >> 3])
-		>> ((queue & 7) << 2)) & 0xF;
-}
-
-static inline int __qmgr_get_stat2(unsigned int queue)
-{
-	const struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
-	BUG_ON(queue >= HALF_QUEUES);
-	return (__raw_readl(&qmgr_regs->stat2[queue >> 4])
-		>> ((queue & 0xF) << 1)) & 0x3;
-}
-
-/**
- * qmgr_stat_empty() - checks if a hardware queue is empty
- * @queue:	queue number
- *
- * Returns non-zero value if the queue is empty.
- */
-static inline int qmgr_stat_empty(unsigned int queue)
-{
-	BUG_ON(queue >= HALF_QUEUES);
-	return __qmgr_get_stat1(queue) & QUEUE_STAT1_EMPTY;
-}
-
-/**
- * qmgr_stat_below_low_watermark() - checks if a queue is below low watermark
- * @queue:	queue number
- *
- * Returns non-zero value if the queue is below low watermark.
- */
-static inline int qmgr_stat_below_low_watermark(unsigned int queue)
-{
-	const struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
-	if (queue >= HALF_QUEUES)
-		return (__raw_readl(&qmgr_regs->statne_h) >>
-			(queue - HALF_QUEUES)) & 0x01;
-	return __qmgr_get_stat1(queue) & QUEUE_STAT1_NEARLY_EMPTY;
-}
-
-/**
- * qmgr_stat_above_high_watermark() - checks if a queue is above high watermark
- * @queue:	queue number
- *
- * Returns non-zero value if the queue is above high watermark
- */
-static inline int qmgr_stat_above_high_watermark(unsigned int queue)
-{
-	BUG_ON(queue >= HALF_QUEUES);
-	return __qmgr_get_stat1(queue) & QUEUE_STAT1_NEARLY_FULL;
-}
-
-/**
- * qmgr_stat_full() - checks if a hardware queue is full
- * @queue:	queue number
- *
- * Returns non-zero value if the queue is full.
- */
-static inline int qmgr_stat_full(unsigned int queue)
-{
-	const struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
-	if (queue >= HALF_QUEUES)
-		return (__raw_readl(&qmgr_regs->statf_h) >>
-			(queue - HALF_QUEUES)) & 0x01;
-	return __qmgr_get_stat1(queue) & QUEUE_STAT1_FULL;
-}
-
-/**
- * qmgr_stat_underflow() - checks if a hardware queue experienced underflow
- * @queue:	queue number
- *
- * Returns non-zero value if the queue experienced underflow.
- */
-static inline int qmgr_stat_underflow(unsigned int queue)
-{
-	return __qmgr_get_stat2(queue) & QUEUE_STAT2_UNDERFLOW;
-}
-
-/**
- * qmgr_stat_overflow() - checks if a hardware queue experienced overflow
- * @queue:	queue number
- *
- * Returns non-zero value if the queue experienced overflow.
- */
-static inline int qmgr_stat_overflow(unsigned int queue)
-{
-	return __qmgr_get_stat2(queue) & QUEUE_STAT2_OVERFLOW;
-}
-
 #endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
