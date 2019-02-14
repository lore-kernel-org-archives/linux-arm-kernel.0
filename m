Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23CAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA362229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RViukR3E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pwZNtwDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA362229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SnEI+PCzM+kfrghpMvPnNEp0dPZWPNGbZzTIiHK5XQ=; b=RViukR3EAKHIDL
	D3+3XqrN5czb8CJ/diafUx6N1v47G24ouK6AmZmZ5nMmo/gOThoqYBhBJ048pzzVMi+qrSfZuccMt
	4W7kRH123mQ8Yu5+bF10ChX6nt7NbaYUSv0LkzeExfnoQYBpzWpVjcPByccb5piVk4zjUzqrATiwR
	hzi0z751fw2bwgBkgrbc1gkexUNYnP+bv/Ac39Afmbm+Fkx9JiB67EotJV2PTnn2GV7XegOjCWvwZ
	y7fqd5+YVvMDh8rEBychukClqSDU6H5laTw5QF538XUVw0UvT2L7MP0vsfgPmw1WZ5t9tj07f0DsI
	Ba8AQCwZM5D+hD9oYGsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIQ9-0000gy-OK; Thu, 14 Feb 2019 14:55:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINq-00056q-Gv
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:18 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so6788530wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=pwZNtwDVFgskTDLFLLn0oLkO162MiONw1Ekf4vyO6UTr70McE4oM3hncY+QtoO0cHn
 slTCyXK4aqSNKvAFSzyyFBc7ij6E3fj/5sReIfZfYUAsIkyktqmUuli1hhr3igJu2WsG
 nhBFUDtKJxZRAjFsH0rmx3uiurmK38wrC8X56zCkz1A0rfWfZpIg0w60t1BOHYndrurg
 IHI9TrG8uzmhYrrlhnoZbjc/kDzEc3UXeycA2M2M3wZWr/PImq+08XB/pl7vtYU/Y58W
 uH+dWi71LUjpwhKwTyU7cEwZNH7Fb0zigoE2E9DDpZ8YZzdo8BBVQwAcvacab2Owc5RT
 qaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=bz27A9eB4Cttm538qP+k9jboZuNsXxgXZV6pPSBEHvot9dY9LB1xmSq+JexFVLnbO0
 r/L/J+lXiRuhwngiKdnBdUG1FFua8KQ7+TtDyV0tjrAVLbu/lOPOSZzHKQmh6Jr9VjYL
 bcOPkDxmbEqt/915AvNxBirb3fz3NNDuTY0NyXdz6tFaWL2d95OiOgtgY68ZLkRYwGJt
 hyZtzHgPFrKnTDNixHLnUxCVEKQzlIgHtrrVjbNqtzkfx7WRU5vo3mJ86HEAZdNQkbuu
 Ixlp9s2ltRgOUho2G9jOa7F96yeOiDB1iNMLGUnfT41W5XpGMuXfsna2bsmle386DxE0
 IpyA==
X-Gm-Message-State: AHQUAuY6iSPym5PPAXAnkHHy+b9xukimDQCvrdR6Mn6tEFLyT0U/WbSy
 zftJXdIhc+PcI8Q6ERdjXK10Jw==
X-Google-Smtp-Source: AHgI3Ia8dUSUh5YPbFOWFhMJK7tp8/x/zq3leoFs4A/qCwpv8bC1qot0/UE6SEaCofMVgAgvjeDZyQ==
X-Received: by 2002:adf:f011:: with SMTP id j17mr3204903wro.166.1550155981250; 
 Thu, 14 Feb 2019 06:53:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 15/37] irqchip: davinci-aintc: add a new config structure
Date: Thu, 14 Feb 2019 15:52:09 +0100
Message-Id: <20190214145231.8750-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065302_999643_C6F5D7F4 
X-CRM114-Status: GOOD (  13.71  )
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
 include/linux/irqchip/irq-davinci-aintc.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h

diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
new file mode 100644
index 000000000000..2b2ace3c1b22
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-aintc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_AINTC_
+#define _LINUX_IRQ_DAVINCI_AINTC_
+
+#include <linux/ioport.h>
+
+/**
+ * struct davinci_aintc_config - configuration data for davinci-aintc driver.
+ *
+ * @reg: register range to map
+ * @num_irqs: number of HW interrupts supported by the controller
+ * @prios: an array of size num_irqs containing priority settings for
+ *         each interrupt
+ */
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
