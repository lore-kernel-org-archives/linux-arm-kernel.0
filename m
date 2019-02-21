Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B15320823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DPcDFnjF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dq2963PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B15320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TtpRPdXuDvwwwRRbc5A+Ths9syMH+KwVqf2rHAWj36g=; b=DPcDFnjFmJarx5
	sPVJcI01fJjnARu0zUdcpDhV2+sDw26gbutLSK2s0gdZ3njXPd2pNYfm3jhNRSJ7sqhvXSbK8XqlY
	goI0hzhAvk3HzQLKuKoXtDxvKkQ+Y1oaOyWDvBKvyVuWaBrP9mznFF1GKllxoLyg377itLqT+TDg4
	9MyC0dLFvlaRGjPz6u/TD9UwPTwbKXA49llYzouNYDSsWS3pRDM73MWIRKPKnx7iUL7+dut0cYoJn
	woHAEirCl6scqLjhrGeAMr465BA6FOcCNpUCB0PyUN+ySrVyGiNBRSJczZDpk+ELl+91pJkwRfjR3
	EfOva3BVkNInUfZPIX1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqZL-0007CI-Ot; Thu, 21 Feb 2019 15:47:27 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXd-0005Iw-SL
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:02 +0000
Received: by mail-lj1-x241.google.com with SMTP id z20so23363756ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VLgcHbCjTjccbre7yEdTcWS8r6RWhpYMOJgFZ4el+Ss=;
 b=Dq2963PLtBnRq+Y38BnBc78nxzg5hN1V0t1yctrgQsU/m3Y6ozstQoKI4UZfOSpU8A
 +JLSrsa6pVQEX4bSta/9b0gaGANE6PuL4HXkhRQvGSPWoOcyrhe9bUgtaSwjmrMYU2Xy
 XKPWWo43/FogKmcC+gbzdAf14+Wp61jVGCx0+y6gQfWvqV9JtTDUsiEkVmIdlq39OIqy
 2CuvY/UkoDdbgEmWkAwsgoZCfrHx02Rf+F/Ob5kbuNjMyhW2kVXPaDMbW5P4fLeD8Qj1
 aEdDVbFBk/PFy3lr40M4YDnV32+ZOrp4udM4GCcFS0kseSry2rum5enItSlxDmhUiEad
 LBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VLgcHbCjTjccbre7yEdTcWS8r6RWhpYMOJgFZ4el+Ss=;
 b=b5b3EX6lAdujnJMOXdJsLN3Ck6ZmY2KfXW9C4uTCX04yVJFTG/FfydqMtZb6mpBCLH
 pOgGrGPk2hK07vPXPJ2MdIz493YZP9rEO5aaudN2hW123L5BbPmg+F9VZ8GugvkD5mZl
 2vyc9/c2G9qcBkfcpNF65R2Ywd8X0w1XgRf8zYBxW2BNKetUACBNTNd+ht5JfY1542N2
 ee0OJ+IIjTVD679bzUtVH+ySg2O4fMmL3scjiO8GIrdqQNLTkv06hVCSuC325SKwM4vp
 ES29rH4ItnLxUnEQasfPxTUDgYQFAfhdmvZU3djYZ57REZGCCTbnuILxQsa+kKe92y+c
 Z1QA==
X-Gm-Message-State: AHQUAubzH/y2YNNppMmWIe8jD1ccmQrgxKNS4P62hVvSyAOAPf5IaBVh
 v7+hcWR2VvWIwnPbUQja1onismhZUXI=
X-Google-Smtp-Source: AHgI3IYNprr/5xN5hHehq1f1gbx8uqiiwaz1coLLa6H1YtMcTsjaCKe7Y8cdV4jygwIz+3GGhQkvCw==
X-Received: by 2002:a2e:9c97:: with SMTP id x23mr1312649lji.13.1550763939759; 
 Thu, 21 Feb 2019 07:45:39 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:38 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 12/30 v2] clocksource/drivers/ixp4xx: Add OF initialization
 support
Date: Thu, 21 Feb 2019 16:44:40 +0100
Message-Id: <20190221154458.23763-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074542_389423_B7AB000E 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for setting up the IXP4xx timer driver from
device tree.

Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-ixp4xx.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
index fa78f80792db..404445bc11ea 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 /* Goes away with OF conversion */
 #include <linux/platform_data/timer-ixp4xx.h>
 
@@ -247,3 +249,36 @@ void __init ixp4xx_timer_setup(resource_size_t timerbase,
 	ixp4xx_timer_register(base, timer_irq, timer_freq);
 }
 EXPORT_SYMBOL_GPL(ixp4xx_timer_setup);
+
+#ifdef CONFIG_OF
+static __init int ixp4xx_of_timer_init(struct device_node *np)
+{
+	void __iomem *base;
+	int irq;
+	int ret;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_crit("IXP4xx: can't remap timer\n");
+		return -ENODEV;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("Can't parse IRQ\n");
+		ret = -EINVAL;
+		goto out_unmap;
+	}
+
+	/* TODO: get some fixed clocks into the device tree */
+	ret = ixp4xx_timer_register(base, irq, 66666000);
+	if (ret)
+		goto out_unmap;
+	return 0;
+
+out_unmap:
+	iounmap(base);
+	return ret;
+}
+TIMER_OF_DECLARE(ixp4xx, "intel,ixp4xx-timer", ixp4xx_of_timer_init);
+#endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
