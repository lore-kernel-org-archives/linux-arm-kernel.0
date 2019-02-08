Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BA2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:39:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0023217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bJVLf4Y1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwPS6xo9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R244DRLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0023217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t1AG5DKq3AWUSAq1zDGpxm1LLcmySCrGnyCVnLJJeF8=; b=bJVLf4Y1pwGUFX
	2E0o+DwtFmpx1WWhn3i4AnnCoCwk73ExpcZMVy1atDvjyIQ6CApqOxp6xgW2VJs22DHLDCIaS4wJ9
	L8XxP0G3Mm343ZK8/jZdNLBwRx6unlVEEtmljmOMxDCpLAPCSAWaqSNye7xF5+mMEibTDwFzUYgmM
	yxMMwwWnAvnRksBPsRwA41xmjsx/FsZVnM/rXdxdlx2eGRMt5Yc3DYj59P/+Zv9aZ5p8RmVQWitqH
	+mjmtKP4Jq42QSVUAnp/eMUWFAgQZNKL/G3SopjRA3476/5nnOnHJEYdB77NFYYfN38QYwaTB2QVF
	PFhx3d6bUgpRlAzgeOKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA82-00030G-TY; Fri, 08 Feb 2019 17:39:54 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3t-0007WO-N4
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 17:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=; b=ZwPS6xo9RKzRWnKwim8dJfQy5z
 3wtsWEexhJUFrdX5dFs1pkW7uYTJaLM3zSJmuo7XSQSJ/grGFBDc1Nbz+AuQKsT2BxMbEDWL0hv76
 65aKUo4fWI7COkDhjDG6JpsUgbf0B+cFSfJR0RmUrjYxtz3Xmh2aIcR5evV63T69PW2fgr8sGD/ZR
 kwUY63Pzuel67RkSx+ka1O5kefy0LzVOiF5T/uGE+vik3Ob1LSg4m6GdQGheQhKZcv8PwOGuVzEru
 p1GiDlRYTM16p6mXhuF0iYRfgVSTR5lOSF79HZhNjRFmw2BhnE1D6CwMVPbK5Xj+FbhzOtiCGKUtl
 JKle2bwQ==;
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3s-0005r7-7t
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:36 +0000
Received: by mail-wm1-x342.google.com with SMTP id y185so7333757wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=R244DRLUOHJxTKS4+02UK9t0O20yjYfjrh1rWAjC7gQH0i12FlcW5laSi7o68d2kpw
 Dge5aGYYAtnRVBfk5fFQXlp3P8LGu3mh2Dw7pv3ZqArJ3BrhKl23e02wFTaJEWx2u4wh
 69CF71cJYdd/Pe0mO78gds6VNz2afyWmOE3olAfW6QRVFKDxeEvIqpvFO3Nj3SvyOHkk
 akTqFmDSHVbdEwpgmJ93SoXceD02FeDcVTAVQgXnT9Jupr6pNJJ9qJmqHk7zPLpgWIZr
 8ih60oDd5vL8AxQCEMWxOJK+pFrmUKX1CRzmrZoMyJAUDMJaD/slSbefBzMLoYab6s3Z
 5iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
 b=TVXOejXINXKXo6vkM8Ou+X3Z5801vW5uUY6mmvU81RHJuWJSFXqNDl4QguQsO/Vbp9
 z2wscPqBJrM+ohJtRJLRRVnNUi6EG5AF0j3NEvMzGZvyojgQ71uAHRMnLPrX+/Kv60vN
 8l3ZHl4Kpmg1HuqrgO+avo+EcLSwyT8b/wKoeLLOjjYjcF8Wpe3fQBLGw4rFg/B//qtF
 1Y35fcTq9d9nRoRBudEUyUj+75eVCNi88UwIhjonOfzinUeLe9nwp+d549srR45tT8Z4
 qmon2v9F6EkMskh60t+iyaSn3VcrwaZdHhnxgEIzx7emiTGaU1DX6YiLIQcqhExUHYuc
 Vyhg==
X-Gm-Message-State: AHQUAubdpnEQ/beBG7ypoBeDI6JPi5ApwXTD7Kl3ej9XC7JQzBpm4ihP
 /LA2QexTDoyHqs0aXgrP19W3Jg==
X-Google-Smtp-Source: AHgI3IarRzyLRPIRwBmzpzMNT6mVugzKkKsXQmIL21MGbzccmL1V3cDULngxVLqpT4gh8cFCNHwKfw==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr16978676wrt.43.1549647332659; 
 Fri, 08 Feb 2019 09:35:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 22/33] irqchip: davinci-cp-intc: add a new config structure
Date: Fri,  8 Feb 2019 18:34:47 +0100
Message-Id: <20190208173458.4801-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_123536_337145_20650389 
X-CRM114-Status: GOOD (  17.31  )
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
