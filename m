Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:57:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EBC222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k2Ax1rZf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dMEIyIKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EBC222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t1AG5DKq3AWUSAq1zDGpxm1LLcmySCrGnyCVnLJJeF8=; b=k2Ax1rZfGo6ufD
	6PVVN7Zb2WaFNtsqXz37gpM92uL3Y4mS2XylfkLpZqkkszOfm1/pbVypcGFJRjHtgfSH6XOwKr3FD
	Uymt8eXO2kmVtvn6mHJAcJiv200u9XKWgXaDrBTjRPa38q+uq3Bq4sBAW83i5oCYuYb0YlR78gcQ8
	F0zsUY5p/iQJFEfWjdqxH1KHmQyoQAZNSyGQPtdlDxWXALfa7uvC6VEMKAuQrd12BiwQDW54Hz64b
	+h+GTrpkLsq9ONMDYxLOc7dBkUJD9Z5FGP0lV2bbqQdV/2lI3x3zqaIgLVfHd+48DoV43lcQOS0m6
	FLA9NuooOGbU4kQ8/RVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIRl-0002ZD-6w; Thu, 14 Feb 2019 14:57:05 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIO2-0005O7-Gs
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:36 +0000
Received: by mail-wr1-x443.google.com with SMTP id q1so6780069wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=dMEIyIKQ1+p+s2GGR8u0p1ancuKmBtnHkysDYXKQbJbqEEhAFT2VLpOaYe3RJe+Ida
 Zw4WaQTrfKHfeeZ7XruqLtI3Qr0CtLZZbJ8wYnrkSvpia4MqyyT0Uo1pq16R2AFdSD4r
 5UnFfU2dURXtZ90HC92cIPB0w+gFuu9H5RPJyD1U64l41KDZfQqyf0ET34wYXsYPDP9i
 Cg6LatVVdihDJDDgxLRKh2Ja73E7wGZlh4YzdlXInakU0MNRa/atvgEBEfOXw7t3MNo0
 egUJhKfeW2N2TX8MyZjVDv+DHGlNZJb5SwWiKSCJ/6gEQtNGvfdCOpwcEP82LTwI5QK9
 YPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=cLabDugAdaRlbjop2hsI2oWGj1YmhZ3EKtDXJoO3yX1yJw1/+oel0BrhvzIIP/0dHy
 B/pPU8xVitEfupEGsiruPwq+KnZ0HZCdptsvxbthZ+Ow2n8Ii9sHF2yQMYW7eAVFus0P
 BnR6h6xHEk5yVdhXUV0m9mWMZQRITMai4nfXL2qH3F/AKeyTtISspOkth1LNaMCZrCqk
 gqIuoILlHap0QT4D6WQYYnmoPPAh4w69sM9aN4QjOiJO8IIhknZqIkfmAc8RXuwD519S
 oKVs0c+er8BiFbRH12XlG1Wkn7npetdTcLpFZoZz1yexFG9UMkbZ6UhwjbSahMySOmf/
 nw6Q==
X-Gm-Message-State: AHQUAuZ2L1nhJz4I9T8eyLugb/9J4AvfULtWu3Ju5qh0MsoBt4nPDTWI
 aTsmCN9KIP5oJCKlJ8ROysr8rQ==
X-Google-Smtp-Source: AHgI3IagVd1vnN+m5pFUhjTDmSkTOS3BuaOxxShDaBavjQdgxYNlcYgU5yJtMIB8qQcA4ohF8C2SNA==
X-Received: by 2002:a05:6000:1287:: with SMTP id
 f7mr3298464wrx.203.1550155992764; 
 Thu, 14 Feb 2019 06:53:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:12 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 25/37] irqchip: davinci-cp-intc: add a new config structure
Date: Thu, 14 Feb 2019 15:52:19 +0100
Message-Id: <20190214145231.8750-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065314_997252_BA42C237 
X-CRM114-Status: GOOD (  13.36  )
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
 include/linux/irqchip/irq-davinci-cp-intc.h | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
new file mode 100644
index 000000000000..2270a6167b98
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-cp-intc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
+#define _LINUX_IRQ_DAVINCI_CP_INTC_
+
+#include <linux/ioport.h>
+
+/**
+ * struct davinci_cp_intc_config - configuration data for davinci-cp-intc
+ *                                 driver.
+ *
+ * @reg: register range to map
+ * @num_irqs: number of HW interrupts supported by the controller
+ */
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
