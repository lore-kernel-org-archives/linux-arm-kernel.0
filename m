Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F85C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74072229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="noVhIf17";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vrn+mOfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74072229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wLV2Z36UWzuz6XTLFYAsAQoMsMBx87aE3Avwmm0dgfI=; b=noVhIf17+kRqZP
	yshRL41VUqrRVLI57n1/QFAlNcoD3dvoAlKkit2tIfSeYIfnSBr7qC3LdGuINLd89oM1JvrkmVl4S
	JCJkx2wHcKgUNjCtFbjavkV3PXfhqRaPnuCBqCIaqkEZI1Hl+ndtrL7BaKptH0QvoZoRsr9uHVygZ
	Paj4rGIhmkqAIEfTbO0jEsuT2LQu3Ye+WKrlSNodD55puZUpaYWLTRaw5gcGM082x9orqo1h4iGHJ
	c/dC+/3lFlDmiLqipeXRiBwlDlgGfT0pjFCLXGpUfCwdze7yP9z0kxtI9v+eWhLoMuB/++JtCwK0t
	FlUEGO0MJG0qALXW4ziA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guINo-00053O-1U; Thu, 14 Feb 2019 14:53:00 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINZ-0004ky-1Y
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:52:47 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so6787369wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
 b=Vrn+mOfHygpz64Ntn+hDUMCf+ggClSA0JuCXlM6Y2XJ0b3j4A8sJDPZJHCV8i0tzdk
 +wHpiq6HW1FoPFuCoqRDcmMjI11bi77CdYIKaQq9EgNHqTApylUUHDCRtbPBkOB3mxlx
 fuY4MR6K2SoKb22nx5onljvScWxS7iZIlp0/01PxOvjckYyKlpQIpS5gxUuSQKopXkjq
 FNr0pR9jmNFgGhddo4bZk/1+ZHHBxyo3qRDQIDr92NZxDCVnVDCkgO4XTyAqBV7LlBje
 9G7x5uwOjdarqd7cYOs6FGuGrLUTgDAkb5UafZZMD8AvQrgWbiLJvIbkHcTPVC5FOaRG
 NI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
 b=laNIOzXycYcRd58yeXtQeF9u7UGTeWzTQd5yspIYIDi6S++XJa2K/IpSBF7Izi/gM7
 amambqFQvKRb+SRFwDnhij+hAiq9TWUjtfLRfqsyr9r9cADE1q5Z8d4uok6esiuTYhNJ
 NHmR1VAx+Yuh6IpKkSf/tc+MSwjhDC8dzQnzjTJoVi0BWDdXstlXJW1kjM9VNvkingDw
 yO0FWzQe+/3pgeKn82Oi4OLPAHaNQ32j4UC+d7kq0fwiK+0oyLRfHfdq1TIUbxmVPsoY
 eLSj3EbO/m3FTHAtnUpW0RQvtnTLsrJ1HGLE7XE64BFigBjBoNUkg/i49xlpfIB5+XLX
 M6+Q==
X-Gm-Message-State: AHQUAuYFCf/lc44nFGa6+yY1ZhLhYT87S0Wm365UG80dSen6WWSoUkn0
 DXPkmGNPSOuXN9RFz+btHSZSsQ==
X-Google-Smtp-Source: AHgI3IZpuZOE7Wb4I9LFdmI6pdHZp8xd2iDykim9YIYTPf8qjlb4qFXsJcx7B5+RWtTlHrgk0Qw+Xg==
X-Received: by 2002:adf:c543:: with SMTP id s3mr284705wrf.192.1550155963366;
 Thu, 14 Feb 2019 06:52:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 01/37] input: davinci_keyscan: remove unnecessary includes
Date: Thu, 14 Feb 2019 15:51:55 +0100
Message-Id: <20190214145231.8750-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065245_079845_53B6BD15 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
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

The mach/ and asm/ includes are not needed in davinci_keyscan, but they
will cause build problems once we make mach/irqs.h a private header for
mach-davinci.

Remove all unused header includes.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/input/keyboard/davinci_keyscan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index b20a5d044caa..b4db72f833ca 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -32,10 +32,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 
-#include <asm/irq.h>
-
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <linux/platform_data/keyscan-davinci.h>
 
 /* Key scan registers */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
