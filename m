Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3C4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:37:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31021218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djnU1xgx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nVvVG4Td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31021218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SnEI+PCzM+kfrghpMvPnNEp0dPZWPNGbZzTIiHK5XQ=; b=djnU1xgxebm3q8
	UWb7vvO404dfN2iKhWas3I/qQAIpmEeKIGIriPsX1hGNv7v9dpZaNz+SLE94txmew9g3x6Ay0dAMP
	mRoxQaLyEpdKSCkM6h+I92y2oKxHJk8KRJdSNQFSkqMkaW/jsGGbG94pQ/rqHqV/A0PfwsmM8ZXck
	JHd8QTkd9aMDMHkd8akKgi/Nd4+D+yFKwJMihvQPa4AdBOK2xz2IXHGbtkuYZt6WZ4XpbaP/p2zvv
	mARB51x0j61TAllYjllJwm9lrc+VikpDtDkMg/inCgQsz2/0B6+VmgRIOtU9hQHCIvLqNbwOtnVzr
	cdXEO4RK3KyzfTt0qWmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtApv-0000mr-7X; Mon, 11 Feb 2019 12:37:23 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfQ-0007S2-92
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:42 +0000
Received: by mail-wm1-x343.google.com with SMTP id d15so17499023wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=nVvVG4TdBI19mw5+gd072h8J5/eCAvd5REhTqYUnyRqphAvr13PIIJ7xCwew2I6k2r
 LIOjvJcjaia0cgFjEpvr1KkbxsC3y/vs2Qssd7DhGmCg5X8GuGAMtNquHM3V/2A4Toob
 Oj8wgc5BSNxb8GqzosdwDapidLwsD4U+dHdqnEEYtrxm3SBrnKCPCmai2VUlq+QEhfWu
 ntuMItW2OgYqkznud1jQVbf8Ad63RKk3yy+AUxFCtRc2i3mjeovZGbW3JrB9UhEucEdb
 FdyUkAJBgDjnan6WEdR2Qws+2mJjGIhZr2JDCFCixTp8U8XGN84fUKAxzkkVDTV5gF2q
 p2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=fipqD6ar3vNVRAbjbiZRCgR3qcnmzN9ZKDb9e1MFxwXRDgx6WNeLKK8ycw4zI+5lyN
 ZWdWSW1VCyWkRBPl1YeBC19orLH5lq8g3VgFrGjX/dY11MvSDIO2HG2/jr5rAXvZ1XDa
 EtGevjlLjF0P1jtkiorbk1HIu9AedY7s3EAST9hl6YebmNzoT89Sk2aNEREo21n15F6Y
 AyZ19Rt17mP+xAzxXeLFRF8kRlSI6B2YrolPMrnDfednmoigpAelhLJWjxK2MBXe419i
 WvCbWm5eHaFQkAi/XlLgjuYWY3Ffnj0svHe7rU75WzNFtW+tnpHJtNaZ0hLGnUReZ99Y
 ryBQ==
X-Gm-Message-State: AHQUAuZPK2OFtuW78n6uiPpLjEdgEESJe9Uqj5CUtfWmDulbuKQVcpuR
 +E7tf13dv1W+nhwDmsEflhOqyg==
X-Google-Smtp-Source: AHgI3IZKL63zBm+2l6DD1Lj8GHJDvCr2J1MPoPleYKV2EUyok2qkRUtTQkG/z385qlx8GI8SKg4N8Q==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr7561227wmh.83.1549887990918; 
 Mon, 11 Feb 2019 04:26:30 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:30 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 14/33] irqchip: davinci-aintc: add a new config
 structure
Date: Mon, 11 Feb 2019 13:25:47 +0100
Message-Id: <20190211122606.8662-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042632_458311_050D6920 
X-CRM114-Status: GOOD (  13.88  )
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
