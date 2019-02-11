Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F7BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91033218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Idxwa4Y4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gz88jOMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91033218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t1AG5DKq3AWUSAq1zDGpxm1LLcmySCrGnyCVnLJJeF8=; b=Idxwa4Y4Sr1wOK
	tIVoWfWCvtzrnhDycfdfViOmcM43dOZVPWiTPWWIrktPNNUfHDCky8UFE1W/jy+HbhNOykxtHlHbf
	DtlAiSDOTVrMNb8iMs0wrNPmh5FlewQbZsaxMCvm04A2tho0Ct28vfSo9JD1xHd2gmZekI7+X87yP
	WZ/V42A7h9v0uZQaB1tJKFer8V9FRWsbISTV4q3GU8ODt/8sbXeCy4oJXwgRQ8WvEJADAXR9GT+Ce
	ifAjqT641et6Y859ykKIKJ9HXMrUz5FU6kLtmvyepn2r5IrmJY2qshHNIrWiu9e1rfe5E872+I/Lf
	BKFy4Az6isD/Bo061iRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAqu-0001hU-UF; Mon, 11 Feb 2019 12:38:24 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfa-0007cc-91
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:27:15 +0000
Received: by mail-wm1-f68.google.com with SMTP id y185so14459294wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=gz88jOMbltaN1A9U65rIx6+gTcaHNE17vOImT7eFqeHfroUdxJLwonPAU38uZJZwzs
 6sWGtm/47goXM6a9hEjwg0IJ6Z1OQaysbzPXLWrQe1/WMnanbI5+zKFnADuB0FiupFyK
 p9OdniyRz8AfugtkNSHmCUkNlVd9HDDLls5tUBUpP37V13A9LElADjp+EE5cdn+FpLng
 njrxYUPjlKI+cF75Uk7dAY6khu0WsOiklN3oIsNFUslF+hw1ZhrsyvTAIM8KyxtMjc57
 qSTP2OHk8jVS7YV19zV+GIdZZd+H6l6Q8qwt71Tdyigkm48pX24pCsFPlTyJWCGaF1My
 pxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=KD6e469eWOam86wL1yS1V1Hba1qFW1tyA1akoS+Lo4/C0Z39AvBdgX2tQZCsGIeq8A
 0NvR/XJ+/9capjyJ+wBdSnAouPw1X8Mm7b2ksceBLwNYFiiKYLu7IUeYxwIOiu3+QrtT
 jiP0RVtNyG8aiLyk+QGni1Yn+g/KSzCEeWbq0e87gr7N5+gZDJ1CQzyeNd3tQHOguiX7
 9//5f4eSG0lP/FEDk7Jwfy924JhmqqcqguSZliswrQCeM24ZUNKlTPd0YyuMxyP2biVa
 8kBGY4je0t4X9Fdt/Qh6MH7HzAhkMdGO6oIGhJcKJhU0oXhAYT1B3Z4lH8A/N+SWztcV
 YOgA==
X-Gm-Message-State: AHQUAuaMMIVXmAylj6Kw/HAfIwJ0toH1g+p/Di9ZMc8YotCh2FTuvRUb
 jXE7T5Rl9yKzvlWuzSX5/xXYdQ==
X-Google-Smtp-Source: AHgI3IYYEuJ2Sjdsx2Tp7Wu29UAkNxG9nEmxgIoJ5MP4ovJ9vXOrvtJbTXNc12DAsOhZm+d793BSBQ==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr8987058wmc.113.1549888000291; 
 Mon, 11 Feb 2019 04:26:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 22/33] irqchip: davinci-cp-intc: add a new config
 structure
Date: Mon, 11 Feb 2019 13:25:55 +0100
Message-Id: <20190211122606.8662-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042642_796687_0ECE8AAC 
X-CRM114-Status: GOOD (  13.52  )
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
