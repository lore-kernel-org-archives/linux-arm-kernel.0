Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121CFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:40:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CFD2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s4M1aPuo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kfw4LKUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CFD2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SnEI+PCzM+kfrghpMvPnNEp0dPZWPNGbZzTIiHK5XQ=; b=s4M1aPuo5l1s2d
	mmFGKaRl/ars2W+1KyEqMAXNdMMaejRiMQytENiHbEwyZxc6oVppaBEquRdkVj3z6SfR8A9LskULR
	h9zWwhAveS10/o0rrtfiTZNEmbsWb2uvvfog7ZLt65TY0I9ZyQbxMKog5I+vRSsGAN8OOtQo1xn+T
	UvOil+NBIQXC0LETGC+Mu4OtkVDUE14ZHgLSL1UXRWJid+OinJX8K+DWx0GL98xbHw2k1/ItG+O0L
	XNUo29OAQeo/itiWA2ueS2Fby9nHw9gOqEI+7X6s2n1WZkx/dFaoB8i5bm+4Ytt5tpj/MmJc8CWbg
	jCYkx27GXTTZjuK6UmIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA8d-0004hC-Pq; Fri, 08 Feb 2019 17:40:31 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3g-0007HX-HT
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:43 +0000
Received: by mail-wm1-x342.google.com with SMTP id f16so4302764wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=kfw4LKUkinrqgKxn2J44QnZKv+b6P2k6DkxPKpM4H+AERpC2TM6nRzevACIsMZM3mj
 zGwHnvvpXxN28iUD50IcevhBfr6YWw++gbGBemLYfTNIsZ/9ljKroNt1g5hJQiSCnTxH
 YK/2wf/f6JRjiBkJtwlEtadEZZ8ZKwz4KWTrJ0G+JGvi4BmXXnCvnYDiYm01hQuSrUp3
 YLALrTl/sp52XGyBbyYy6aWiZ3JnvQeNrLj3qyH8O6rv9rtXjZ/x5c4/WlaaVXzZ449C
 svgQgVdoY6zTLDABAfLAoagmBJ/FQyijjGUHd1huohVIHl55NXn5CDMRzoTHX960ZGdv
 2o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=IwvS1m2H554/VQ4+yC3jRDe7jw9OrhrrgpLTCQEGX+pKlQKHHsmi48kQG9AKP8Nvgq
 mVSQ9469526L46Xfqd5ojcb1TyeM739MrhN+Y0ghLXZwLXOKw/xW553mxnZXS+0hJAo+
 BaZAA/3VnOY3vk3iV1hPaOZOjHRxvfOG8kaxL3zd7dmL2kLdyHL3sZOv6xud8aOPfSfS
 AlTCHqRVq5hKfJCfS0dG0ijwYEgH/foF91wR9/esQtv4hyZ1+eT8ENwZJmGCFF2myNVB
 VwIcZWHDJtIC9nwo8qYdt6d/2rcdEvzytQaIMzr9ipFg8Smp4UEkZGOnzlCNAsPTJbDv
 3+JA==
X-Gm-Message-State: AHQUAuaz9Ykjo4IxGO7p+lEQh6DXmY8j/VsEKz0ifm6NSbg9MHhLZpmU
 kuW1lVpizM7ENfDg2zA/ZfPotQ==
X-Google-Smtp-Source: AHgI3Iah1Osavlul5DJpnUgS8LEdiyOze9kT8ZYuPBJcRdxjOb0Uv2+91dgBg3DzBcH3z0WPJdLu3w==
X-Received: by 2002:a1c:c4c4:: with SMTP id u187mr7528513wmf.114.1549647323182; 
 Fri, 08 Feb 2019 09:35:23 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:22 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 14/33] irqchip: davinci-aintc: add a new config structure
Date: Fri,  8 Feb 2019 18:34:39 +0100
Message-Id: <20190208173458.4801-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093525_263162_1019C9FE 
X-CRM114-Status: GOOD (  14.29  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
