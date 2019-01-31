Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737D8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C8320869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mqu8sfMB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JcruZhx5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZGCCYjok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C8320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r18lC/spfIxHruEEUt1jHEa5O/hKo4P1JrehNoKZcO8=; b=Mqu8sfMBcVAH9K
	8Ay9wV13TziANYXSIEZUd5X+iQPNxjDXyzcmY9BjASZ6TVYYDS9maCl51lPpLTrY54xPnifv8/iYd
	dmuPwhgK/kxUccufWHCDfNcOL0ilb74nVE3YKLPXHUWS6xGacuX01rhIZ3m7wa0RbpVsRjR24pg1S
	/VNnKq0VTroR0FHiXRFaDQMuYJb1/tNmnhxjoGLLbSkbw5dfV99pK269sTUlBEMjGDx5PG8/olFK6
	Ht/ppCNwTKDZoy4g7FnLjry6L+pf/zdjmCttjHT+u5P3K54UwvRvFMNWPozOnWO0wJ/oPrEXmWtmc
	enkTtKUa5uULBBVG4joA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCsC-0003Kn-Mj; Thu, 31 Jan 2019 13:59:20 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCqu-0002L9-2J
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYTaet1Bgd+3TjusLrnLJTwwFR4I7lsLwRcAysaeRos=; b=JcruZhx5CrwKGDusc33kHojLch
 PAPHOPnC+OOELnYUPXoeFnu6seQRsVLmVfb6KJz6l/gWmoYVhpsXd5qs3easDI2r6FyJ6QiNGom8u
 Fs5Wdzjt7w32q8O/H+ZhllGN73d2qogAD7pCeb/edoc9PNyttsAi1WEUOnswuBXD97RYIXNxOXT2u
 za6SLB0arB3b/1MbI9ya+sUwU2SC9+q3Gzn+enU5WX/cpO4QJE8kpi3PgkaivvnYKfmUV7fvgUc7R
 GkQPkAPxoaHFTRKh2djH6LPHb4b4SHC1D2ZSIxBngJlEvWlYQr9m5bDy2r3modWvmjmjq5JY0uLiQ
 t7Qpb1Ww==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZe-000678-QF
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:11 +0000
Received: by mail-wm1-x343.google.com with SMTP id p6so2604233wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rYTaet1Bgd+3TjusLrnLJTwwFR4I7lsLwRcAysaeRos=;
 b=ZGCCYjokBLcG5+KDM3mpQsBIIl1KK0uLF3aZDEa40VBxsh7Wg1y3Nj9MV3VJyEbulz
 4Utd1wYLRAhicO1NU8j6De7dOoG7f00tKpmAAx0fmE4BePp6IO0n4YMs1w+/OrtKQHQN
 efVendyAQfiJFg0cdvLQPsSGw6wC+C7T/hvpMd7jhf8dmDgwyaQqMTCKbLfeuNxRoaZc
 fJh8fQ0B2tQsereO+uRmwNXO49LbNZHC6DHpIgPtn7zzcUywJ4OSO92+yazh/UpNbf/n
 2cG2BKvuhjhQ3fh0/wIEoeWJqNMx70iDsW5rEd0AKx9DWAtLh7ySLwL7BuNN40SREWpp
 gLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rYTaet1Bgd+3TjusLrnLJTwwFR4I7lsLwRcAysaeRos=;
 b=TFupalBpCWQlj+50BpOZuzPijEsJPBp+Ft5cxCBHa0Y8okXfCWrjnVRVmHVbWb/hsi
 SC6n81g3uuQNoJp3RJZrP4nY+Izogl6HW6T2wlFoB2sNtY3HQQLtb4KeVJ0rDedTFsn5
 W6qFJs4MIjXS2DnjIMfHgsu2zqpvGjbtUFAfwxJfLZUrUJyAdLYpxKUlx8nL4rSqLC7N
 cdDu6FwiBsZwzU3pRBzY52yN84swD24RjYksKa78HJrtCDMRz65DHKTQC0rgE7tV1V6U
 rn9ESYEvRmC7AOjwDkf+T5IQcrOVtJjS5OErarGIHZlxW571N7FOhO0kpmZonbgKn+uy
 lJig==
X-Gm-Message-State: AJcUukc+qceaFbdaQypWlENTKent0J0T4WEeBhymLYoqfdSx8yeopBwj
 H9AqoADN21QFhUtvjy56LMCjJw==
X-Google-Smtp-Source: ALg8bN4LVGdrNflpToPu7R9czul7RQOtNw9JpZEVkxbcEEd1feqZh6dBdnAJ+ilPRgPQUdhEiEUylw==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr29676094wmc.0.1548942006556; 
 Thu, 31 Jan 2019 05:40:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 21/35] ARM: davinci: cp-intc: add a new config structure
Date: Thu, 31 Jan 2019 14:39:14 +0100
Message-Id: <20190131133928.17985-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084010_873175_BB76D35E 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a config structure that will be used by cp-intc-based platforms.
It contains the register range resource and the number of interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqchip/irq-davinci-cp-intc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
new file mode 100644
index 000000000000..9b0c7d6189eb
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-cp-intc.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
+#define _LINUX_IRQ_DAVINCI_CP_INTC_
+
+#include <linux/ioport.h>
+
+struct davinci_cp_intc_config {
+	struct resource reg;
+	unsigned int num_irqs;
+};
+
+#endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
