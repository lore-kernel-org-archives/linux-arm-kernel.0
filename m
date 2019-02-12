Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA99AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFC420863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vBDjC7K4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EPlsrLlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFC420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t1AG5DKq3AWUSAq1zDGpxm1LLcmySCrGnyCVnLJJeF8=; b=vBDjC7K4iGCS2q
	4mtMSuoGSGkH5wV3L1zJ3DpMtV0Xh6JdiqBNLAsCaPnnKPYvBZIhpba2hE2dYd63RpiAK1FsieZau
	3BpSdHXVRNJaYb+EHJrl903jEzAhnPEeADDn2B1/axCg0gzHLKrc62l9Eup4TJ9PZMgxjhcvMrHlp
	ZJ6cfTxNN0Zc0sa1iBNX8FQpsPgduHfhQc3cuK5zlYnTn9ngiNBCR2Ky3h8OItaDcPi8jcNn6qZq9
	lpFM6MRAcOBgAPODgzqWlDc4hLgLGyV4oZGGsJ++0boVcJ/qR6Y+QYzqvygn0jznQ2/mCLEZMd8zz
	WAGVhSTH1Ks/Gr7fOsIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVYF-0003hg-ND; Tue, 12 Feb 2019 10:44:31 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTM-0006Kg-1a
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:48 +0000
Received: by mail-wr1-f65.google.com with SMTP id o17so2110738wrw.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=EPlsrLlwIM5eQ6qCbBM/iLWsiNRq1swEAhorrsdQfx5Nz7e9/7PIzUL39IrYxQG/cP
 VQVS28KgHXP9Azk2pU5hxDSOi8GnHfaSFmcbuxpTf2evpuaVUCO01JF79PV3CzCFlmOa
 /CKumZ5ZdyTuwh2Q5pLkbskmGRaYpXBVJ8+Nb3TP55db2tno4A3ML9lqqMRnJ5UWZ4MC
 YfJimjI4/n6N4aGczwo+aEAf3iPM3V80mma8+jXkHS712XIhb//qFjCu0PQjRFOh8h5B
 8cyxZe+/ncF/jxiS1baSZxc2hMpp5XHW+tMug5qB3fhYtLpi7l2jIuyUPhebQs8B6MgO
 r45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=rgZS73WbLY/qXvfvRlUKMgMlOegEOkiwUZdd7TK8+ndU3fWGj9wYksjhPqwAIKjYNS
 aGRURx3qXqmondLercnFKHWJJk02kydJHtnzYPMun6dpdPaN+vBsNWA1enpjM6xaDqR9
 yhHsyS/e7EdY3jhnUphpzCWoHykfkCj3CPo4DjCe5DJSMZDqnaZU0IAheAXn9Z1yPtfu
 39xQ7RK/LEXUItjo47pUBLDT8VloejCdf6JyRltzPyQ+z/guNvc+JOpy2L17h2qU2smf
 FCOg5BB7f3gaDY1g4kpJQCKFNecNub/Bcu0q9bEyRd86/Lxgw1VqwwMnVdCBOT9zLfbg
 wS1Q==
X-Gm-Message-State: AHQUAubCRgsTkCOVW/DoIo2txBJp1yDtbcPWR0Q9jPvD5nDyMGA0G9nw
 eFLtWmJ+A4IZMyRrq841YObs7w==
X-Google-Smtp-Source: AHgI3IaHYJQXAFGCW6IoU/bSVxGT/oCXiB6qrYsPXsWCvUatBlekF+zInG72x6L84+RgvwAbRGoNug==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr2318947wrn.13.1549967966020;
 Tue, 12 Feb 2019 02:39:26 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 25/37] irqchip: davinci-cp-intc: add a new config structure
Date: Tue, 12 Feb 2019 11:38:23 +0100
Message-Id: <20190212103835.7768-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023929_011614_E0AFB656 
X-CRM114-Status: GOOD (  13.96  )
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
