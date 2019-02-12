Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:43:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14D920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cxlgaEOb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fhknH9yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SnEI+PCzM+kfrghpMvPnNEp0dPZWPNGbZzTIiHK5XQ=; b=cxlgaEObz2zmMC
	mCBQu2aP789kVrEYFWamCbQ1ciMJ0EpWKjfrfcyOMvzJINg2Kl2DwYrjXrV3lFbeNM6aZoQFoto02
	tNVIDYwX0kWT9g9nxegEHQWnuhVEa8LzcmFBzyOx9wFlAtYCRq2SxgljMbhZVamabYmU4tqLtZxf4
	dBMwTvcR1j3WaPtqA/Cxr2t+P3j/oslHJcVCcsSW1meGQPf4GKI9r6UBkZJ0NqLGUke1RnQe8fXaa
	xqpZ7Sa7Q3Aby2w6qyMszfSJA9aT0VyjA2ZDlimVJrUNPymeNpKOgKMQMWtUv1IVnKubl8rRj+QXg
	cEtJ8obLxhV5+VSUi2ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVWr-0002Hr-RC; Tue, 12 Feb 2019 10:43:05 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTA-00066z-0m
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:30 +0000
Received: by mail-wr1-x442.google.com with SMTP id f14so2125038wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=fhknH9yuAz+Q8a/IDesU9QcI+GLvXcEB70qbfAc/rjRGMRsiMKiGDDea/dNOcYHIzK
 OY0UahDt6RTm6LSVSes8O4qybx+niaWBZUspAEfPiZ5jWIXlHKDM2ZlfoIxhwE1DVQXT
 lL9Gah14dVGCOBCFc+MoWpKQ92v0ejJRp0fNmVe5JA/778c2F3BawSwKQcaXH9C2vS7i
 VowCS9/ioEDavhWcMLqMsf6J5wHT17bch5AC5JsANnD/bD/tDJzA74unS+cp+8IR8Y9X
 zW0jua/3eQgonQds2e9q4YKPr5BQ+PNQi84MBeeMhSsCnkX4+7gHx70KanJ0W29byRVL
 3yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
 b=MoqJUcRLdRAMD+qokZW9TY1RbY/5cj9Bf2+3hQIxpRlD6jx18wnJkdZ4tbhmqhimVL
 A38KTM27mLmURJY4SfWGCBVo99PESyZaA4PWjboN3OXcu9hdRT0LJ/73G1uU3JGyQbUU
 ZU90KzdyRdB/1yDXY3wj2RzBMyAQlczVD1WXSlWu26Gn7qH7+DJtBfBntgHEsqvFIN3x
 /DlXVjDCkTi004iWfjZTkmK4e6txauqGCSh13cwjFtltedXf30n+/y/reOjLKR6pGtd/
 XVFEoXqtrcMTcdv1owZAQoiwAwArc3CXykNilpyNTRIOnqog4VviZDijdeZ+Mfe7J5+Z
 ZoUQ==
X-Gm-Message-State: AHQUAuavmvTru7NopepgH2yCtH5EYnqVA6fjoAjT3o0v3mbECmUgOpu4
 VHeasUKQFsxtC7TjvQ2igTt8PA==
X-Google-Smtp-Source: AHgI3IYg5zLuW/ykThLokXkS00HkbX/i7AT29xKgmi5Tf/Wt+smxEEuoS84iukeLoO/qR8bTMbSb5A==
X-Received: by 2002:adf:ba8d:: with SMTP id p13mr2447461wrg.53.1549967954645; 
 Tue, 12 Feb 2019 02:39:14 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 15/37] irqchip: davinci-aintc: add a new config structure
Date: Tue, 12 Feb 2019 11:38:13 +0100
Message-Id: <20190212103835.7768-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023916_599284_DB81C951 
X-CRM114-Status: GOOD (  14.21  )
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
