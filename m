Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:51:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B4E218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QHVvKxoY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XKnTc2qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B4E218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qevjtPfv9V8411+An18d8RRi2bs4SgmnBREU4TnYLB4=; b=QHVvKxoYpkx3Ld
	sr4Waf6PCcMdhbbcH0ftP4k3DP78CJtnAr1PQmeC9sorKP5c2hJcXIuxGHJOD0f4h6ZaJ60KvVPWQ
	U0nCTS/APxWN6PgO7CIBj3HAkSawb6nPCS072lTrTZQoMNx/0OqM4nTlZWtTT88qD0n2HHUxyWvsG
	xtV2VjoKqNTAu42uEMlB48gwsrxccinmfnPYWFyCbWXNB0nSLDGyjOEWYeY+Bab43JE/rLcr89HyA
	OMr5psS9SP+limdvRzUp2jyPlcKcct1O37T8D7zea/iNFPIlbAM6/jVnMEMra6XkNqsXK62QV019F
	OQ2uIdJU0PAtZ0vggNkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gelbn-0005pR-WA; Wed, 02 Jan 2019 18:51:16 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gelbj-0005ob-1K
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 18:51:13 +0000
Received: by mail-pl1-x644.google.com with SMTP id y1so14834797plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 10:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9HKfEMnbHSewczzLJZOpgSyzV+WfqxvtlV1fTobNlf4=;
 b=XKnTc2qUAm+sCV7kK4NKXgSyuqPV1e5GiKvz+NemSyIzAra40nrc/k1rxC42ZPfY5n
 ZXOLM/7sdPYDYGzn451hL0jzau1BHQjsctrODfAq28QVgetdr61j4q9ZOtOoR6PnlE2R
 0sw2TrTjrtnSjSyadvTvgYT2EKxZ74A2JNoc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9HKfEMnbHSewczzLJZOpgSyzV+WfqxvtlV1fTobNlf4=;
 b=Lk/okBeu2mplaw948eGzqHJTzKZuASt0d8hL8T8PdWRhJh6eZ621txbf5VJ8Ok1An8
 tu7/1e5EhtFV+4c7KkTY3+Ackj6/kiVyLP2g+74T8YbPE7tHlPUdGT3YoYUqis8CjzqD
 bDh0W+/GYBmvnQDqb/diUx0Ex8jff+Lzos4kJxySLD+6YG5+ioBIZBqWulJ5gId1gEb1
 8Bq2zcUzN0CgdvkoVONC1oPaYzIPSJgGsKY+2O5E/sezngb8DOQuF2yDr9Q8VGYLIknO
 CNiaOy+6KgXagj5oK/ieahEXu1XWIW39fG5/TT0oUCUgMcS9WPYwgR9NjyYiHswEpCyp
 Oftg==
X-Gm-Message-State: AJcUukePHQImL3V89xRjqshM98vDfgnqc3S8VrmTlMDs8Sj0yDrpMSvt
 dKh7yKXbzV16xxduk/9HNaDHKfzZGYCLFQ==
X-Google-Smtp-Source: ALg8bN5no1yyoBihkGJA9F0mZVUp6PXHb/nR8kM7g7OL0ckcxVQi06jhMcP1bZX40gyQP26tOdWhUg==
X-Received: by 2002:a17:902:9047:: with SMTP id
 w7mr44696541plz.270.1546455068444; 
 Wed, 02 Jan 2019 10:51:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id c7sm78250800pfa.24.2019.01.02.10.51.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 10:51:07 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: robh@kernel.org
Subject: [PATCH v3] driver core: platform: Add an error message to
 platform_get_irq*()
Date: Wed,  2 Jan 2019 10:51:06 -0800
Message-Id: <20190102185106.56913-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_105111_108108_9CF8C6E3 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 javierm@redhat.com, linux-kernel@vger.kernel.org, a.hajda@samsung.com,
 andy.shevchenko@gmail.com, broonie@kernel.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A grep of the kernel shows that many drivers print an error message if
they fail to get the irq they're looking for. Furthermore, those drivers
all decide to print the device name, or not, and the irq they were
requesting, or not, etc. Let's consolidate all these error messages into
the API itself, allowing us to get rid of the error messages in each
driver.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2:
 * Don't refactor platform_get_irq(), just wrap it

Changes from v1:
 * Update error text to indicate irq index instead of IRQn, use %u

 drivers/base/platform.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..388461306dd4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,12 +79,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-/**
- * platform_get_irq - get an IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+static int __platform_get_irq(struct platform_device *dev, unsigned int num)
 {
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
@@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	return r ? r->start : -ENXIO;
 #endif
 }
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	int ret;
+
+	ret = __platform_get_irq(dev, num);
+	if (ret < 0 && ret != -EPROBE_DEFER)
+		dev_err(&dev->dev, "IRQ index %u not found\n", num);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
 /**
@@ -142,7 +153,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -195,7 +206,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	dev_err(&dev->dev, "IRQ %s not found\n", name);
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
