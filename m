Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9FAC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:43:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBFD2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r2HB0Bap";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QVzASKGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBFD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JJul28wQ45JXejE5Cd+fLndVpiI+vbLT3AKHGPNNw88=; b=r2HB0BapvxcsYy
	9vD8tw4kISEWP0OBaqj9uQ00zKXPMNiLlfbJLkFYToUrnddnPEfDQukTizKk+MakzmE7T63QsLV82
	uIWR6l4yRkdxtg5fdCBnDS502eeuROErueqEX5KINd9ClDw+um6OIDNT/HI2YBzbYut2+FKiirwXx
	R8KtLu4q4buQuZmDgQY0escVurpSZcbMF50ue5w/58a8u6Pu9/NY8f65YXYxGhTOzLsoGzSR8MP1s
	xR3mG9JjuYyuTq7nDlMIbSMg8MswJ53FlO5OecoxFgeZXtmR9G4m9RUjr9Ny5zWReFKIo4pqj8Yf+
	v+ADUe7d6xB29ey42nRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCcR-0000Nc-L7; Thu, 31 Jan 2019 13:43:03 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZS-0004lY-PP
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id p7so3381248wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/c5hDVe0InyzBLUgsdtqzMSd06Nl7+tp8C6D2lOYhko=;
 b=QVzASKGeM2ZFTiubzM53pWGi1midPBvfiEoRwa3CAychzozVuwi0MKky/mGeLNmnYE
 E5UU+snYpAp12nQC/vsaneIYe9jwtiyjwjSZIgkcPF6nCnD4U9w3hxMyuoGFv9APxJbI
 rkBpsug97GrsEvf/4ak1sXW65tag2xyf9UiqT1DTaWfi7GwRkgcjfWSFPvoz3+xDwm/2
 UCEFJ2B/z5usBwM8wDeL7OsfKRWAJfWLIYuHlOVUwC0JKea+FXcGJHcROXfu0J/tHxz7
 bUZzfrwGAAMiBOB1QU/oGLIU0RBkggwHwuWgBPGpNcZSrYStWf8A4zFBZQneps8XfWPz
 ckWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/c5hDVe0InyzBLUgsdtqzMSd06Nl7+tp8C6D2lOYhko=;
 b=mFeKDEukZ5ddpcQRrLzX8P86M/RRN55y5SpLmWTqjfFDYSZrkhjv4R/rTO98zlnIoE
 Afh+3bmoZxow+cPGKquHXKsZk7g1Bp9oEkVJ+wmzptooeqKtwsZXzhmFgMuTrEaBlNzr
 wNs9ummk/2vuxShUQcyvibWwZcd8T6XtNwfLg+VEpbdbDImeiqDXJ+OhbY0grmQcLmp6
 ykXte19xWShXx992VhTVC9dAk4pUfECotgAaEOLgrlS5cJR5rR3B3lBvbnCrf6/FSkId
 xMcNsVeiyoNQZRKe0VlD5Wb6zeNKSrZeTNE1QulDT0/W7olRw6YohK1TXrYdBOSuUKxw
 XTtg==
X-Gm-Message-State: AJcUukf7FgMDkk9R4qYaATyKjX25zZ7+LsxAP5CY5JGqzhcP0/0WD1ME
 edIGU+eaLGWrmG89uM8D9sIW9g==
X-Google-Smtp-Source: ALg8bN4df9GfK9msIhWH5NZz/P0rVnlqXTC1yDU1fQTVRgIetUMUVgVZ40ySMrE9AmG4wkTFSo/5jg==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr33635178wrt.63.1548941997359; 
 Thu, 31 Jan 2019 05:39:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 13/35] ARM: davinci: aintc: add a new config structure
Date: Thu, 31 Jan 2019 14:39:06 +0100
Message-Id: <20190131133928.17985-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053959_393566_A96AFA5C 
X-CRM114-Status: GOOD (  12.50  )
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

Add a config structure that will be used by aintc-based platforms.
It contains the register range resource, number of interrupts and
a list of priorities.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqchip/irq-davinci-aintc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h

diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
new file mode 100644
index 000000000000..d488e798bbef
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-aintc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_AINTC_
+#define _LINUX_IRQ_DAVINCI_AINTC_
+
+#include <linux/ioport.h>
+
+struct davinci_aintc_config {
+	struct resource reg;
+	unsigned int num_irqs;
+	u8 *prios;
+};
+
+#endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
