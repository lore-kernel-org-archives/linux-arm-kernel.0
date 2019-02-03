Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0223CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE53B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ruM8X6Tb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxyK9F5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE53B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S52XIWqU6lI+AbZuBiXi2oIqjdDw9Lxxli+5Jrvvyjk=; b=ruM8X6Tb5XJOqR
	tRQOqqAIsak7Cy0QTR+TdA68RKpeS+S8L4cZNGD18CLuTMGwugOTEPuvD2SvPTQlZ7OFc63baC9qV
	DSH840PHpNrkZCFqQ48kSZsuEc+fjPh7N3jly1HUJqDLl5Np9aL2i9TyI8zkJT0WQcjk4aDWPkl0/
	4nt3x4OdbK9mQGYRZ3+33sDe9/Fk9BQSIrRkTF0WlJnPXqh0gHOL/9Fk3DDTmR2Rz2fgukLjJkgWM
	h+HGTXaOnbpxnmYQqeLy8uhRvH3NGG765OH3MO5IplzmVMBFLPo50mKVItUt6NAHQN9GAw3N95NTJ
	0c8w6mJl0X+kO31RV3aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPZv-0003sA-MM; Sun, 03 Feb 2019 21:45:27 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXM-00007Y-R7
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:07 +0000
Received: by mail-lf1-x141.google.com with SMTP id z13so8858532lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fI+ex956WHoMlyFnL7Jf5Xw0TukESR90ONxOvxvshFo=;
 b=gxyK9F5Lz5422JR447jnS/XKtTiTBkeQZLSGio5YzMM6FGYyZQDr+0xGK0032gCD24
 +PHiwdTXgJ51Ol/di/D5Zl6BvcbYGgJreOCB3B+OwAv7yd1YRssitJ+hDPGmmdNgRQF1
 C6r/KHeHrk3Z8FI5sj1ZLaMBux/m9/lNRNz8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fI+ex956WHoMlyFnL7Jf5Xw0TukESR90ONxOvxvshFo=;
 b=BPXrG/f1Ckk9AQyg8cuVmvXGCCoKIUk2CA37ZMU5Sc9IddRk+7AX1wbOXAW2m6hPU4
 d1iJ8Kgf5BFXrhZsyfClVQI57iy34T493tWro6B0Mw5c3tK1UShkfpwv5wDcCqizaKVb
 PzIGbuA1+SyClNCSqO6e5itrm/dIFvnxn0WU7ToEz2J1hJ3mb0R9RDkh/Oc8/gbYKv+z
 8q5nuXXowNON9J+DdaIpYPPzPifCFGuVP1yF78gL08h3EJrfreyQqBlsoUUS76uTMorO
 PcF2mZmwfa3o6vZx1BTHQuyumlZwgRftxIJHu5VOttpBmqSMOztFUpYJidw0qJyJBDU1
 Rflg==
X-Gm-Message-State: AHQUAubTbQgmN3rLBO0Gpm/VIrzoTsmhlohyBhbdt/T3FDCiH1j9yy8i
 NqYbFH1vYs0PSzuWxttDjvrnPDasGXs=
X-Google-Smtp-Source: AHgI3IZHnPvIz1reRWsbQndNu6quBQUaoqkviH1OU3ZWj9e3fg3qctgwk1xOuDSMJ1E0OUgHiVTXRQ==
X-Received: by 2002:a19:e601:: with SMTP id d1mr3991141lfh.71.1549230166618;
 Sun, 03 Feb 2019 13:42:46 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:45 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 12/17 v1] clocksource/drivers/ixp4xx: Add OF initialization
 support
Date: Sun,  3 Feb 2019 22:42:00 +0100
Message-Id: <20190203214205.13594-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134249_543637_87C558BD 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Tim Harvey <tharvey@gateworks.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Olof Johansson <olof@lixom.net>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for setting up the IXP4xx timer driver from
device tree.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource/timer maintainers: I am requesting an ACK for
this once you're happy with the driver, as I intend to
merge all of this IXP4xx rework through ARM SoC.
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
