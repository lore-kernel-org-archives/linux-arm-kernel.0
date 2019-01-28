Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CBC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A2421738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m4yLrCjz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VEzl5VWi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pAVKDPg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A2421738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tDr7rTJd8ickhjpByjLHxkDcU7f7kRlYqswspGL2qVw=; b=m4yLrCjzedMcXQ
	Kc1lE75JfSyRrPVgLe7UmaLohqEbafO1meTkkFTonqZ8lQ8f504/PGX8myRiZoHQo4TgkIl3ftdBm
	pJKtVoU1tg7MreiEoNt9a0A6e1fZI2V9DqrpB28xCZDL7mIRT27+j3jXds4Kn3P/F/GxobZK1fRAZ
	KchayqHmpgLNRA1R3F4uF0Ydqdxui7FJReCsrbLaUrGi9UITppLRIrSrQnnFKUbkLmNVzJzbnv+2U
	2epjV3h/WNASiU7oJoZsujKgbNXQzyCJan2u9QLmqSLp86FxgZPWExDQu0kFD/pqPaMbpii02Q5dT
	+8eXma/ghvTjWsC0IcAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBbG-0002pb-3R; Mon, 28 Jan 2019 18:25:38 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBar-0001gK-RG
 for linux-arm-kernel@bombadil.infradead.org; Mon, 28 Jan 2019 18:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4wf9FAXSPyYzzMogrRK8K8vMBiOAXKZiQZa3fRw2VeY=; b=VEzl5VWizX/NAuGQe6nObSECxH
 FM0PRhEVQouY9dq/M+1oiL1RG3DzzRonkfjvrXfsg0BoIbxc1komm6k4df4M8KcbwfgTI5d7jzKIN
 tKBgpQTPLZHym0svVhaTTv2QbdNESval1vqpZjwujQcdx0ukOA3uPquFgPxpMfPh5zPSrldiCcOZK
 GEXF5AHkeliHO+qNw2g80SjoRIKg5gkG5CSe3xp6cUJhJqYQiuQ9Tud0f3Jqv7Zp3TD9VxBhrPQ/F
 IPuITrGmCLy7OYy4gJuzEPVImtI7+59L+l1PjwYGUXbcAKUQC0U7/kO8Nm3AqJBmLwKLp66vILtVf
 OwmVcHJw==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBHR-0002ub-Cq
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:05:15 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so15040961wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4wf9FAXSPyYzzMogrRK8K8vMBiOAXKZiQZa3fRw2VeY=;
 b=pAVKDPg0Pm08cuC8o0hw5D/VrYpOKQ6CKzqXA6L/cQ6OzR7OMKDBtPu4Aghtl8Sx47
 RoDoP4Yh/ydPBu2tTQGJll0VfUElhArZksnOZ7/SNkJjFsJ+QHBvI02iR//UIU/Zlj92
 AijANg0jt6jMbZpvcNhTRF4fDcWlxphkLBVIFrA/fbCkM7DRbPLNnbLBqsPnvwqLOz4L
 W27uG/V+37FNXPyqp1HysQmNQXBPOFh7qkKPWCHIandCIvV5DoI87D1L/IprVTk7hkyp
 ZQY7s8ze0GnSpSPvsVjNcjIDYU3nwRXnxsXBu1EBBZQYuSnYRn+ejlquTub0LXhjfRoV
 yO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4wf9FAXSPyYzzMogrRK8K8vMBiOAXKZiQZa3fRw2VeY=;
 b=Ie/tr82WIyq7qXHN6jtVNF9NeWQHKPRn3cmwVCxHrLUg3CMdJfiQM1jdOCMjic9M/7
 n2fhzp4nJPzYMh+Vor/F8b9PUAVpBmOpaBcE+mqYxwuVGNNCtCTT5EwvnAvodmqoEm3L
 gJRYdw3tKDc8/Z53st1tB9vNyb2sLSde4K7xjLk86QHhhEIYqcNT9o1RS5zg2pjtW8jX
 J0vC0Wy027f6nKKoU9OPRRUrKQHwsXugvujsaDP2ZpQy9yOmZX84swQhNHj9B3Pygn+c
 OcCoaR2YPlXUQy2JKWOFQjbsCyUTPejOQaJb9XCRDDUFWhPbghchsMUy2sbpYYBW3gSX
 QgRw==
X-Gm-Message-State: AJcUukeF7+xUUNj8CwlKA6VexBBSIEDl0aKLs2f1wmXuh2MXcXmRJdgr
 aAtm8FjhICw7CvbxIsdSX9UyOA==
X-Google-Smtp-Source: ALg8bN75sC55jztbjVVmJDd8FxG0eY5D28u2GiTxNeyFtpJy0sKx6KZZC4T1/iMaBQT0GzM1D63dLA==
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr16745488wme.64.1548698703842; 
 Mon, 28 Jan 2019 10:05:03 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.05.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:05:03 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 13/14] clk: meson: move sclk-div out of clkc-audio
Date: Mon, 28 Jan 2019 19:04:29 +0100
Message-Id: <20190128180430.28689-14-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_130509_523271_2697ED79 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c                  | 2 +-
 drivers/clk/meson/sclk-div.c                   | 9 ++++++++-
 drivers/clk/meson/{clkc-audio.h => sclk-div.h} | 6 +++---
 3 files changed, 12 insertions(+), 5 deletions(-)
 rename drivers/clk/meson/{clkc-audio.h => sclk-div.h} (79%)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 8db0508ec6ab..7ab200b6c3bf 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -14,11 +14,11 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include "clkc-audio.h"
 #include "axg-audio.h"
 #include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-phase.h"
+#include "sclk-div.h"
 
 #define AXG_MST_IN_COUNT	8
 #define AXG_SLV_SCLK_COUNT	10
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index d3eea53945e9..3acf03780221 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -16,8 +16,11 @@
  * duty_cycle = (1 + hi) / (1 + val)
  */
 
-#include "clkc-audio.h"
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+
 #include "clk-regmap.h"
+#include "sclk-div.h"
 
 static inline struct meson_sclk_div_data *
 meson_sclk_div_data(struct clk_regmap *clk)
@@ -242,3 +245,7 @@ const struct clk_ops meson_sclk_div_ops = {
 	.init		= sclk_div_init,
 };
 EXPORT_SYMBOL_GPL(meson_sclk_div_ops);
+
+MODULE_DESCRIPTION("Amlogic Sample divider driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/sclk-div.h
similarity index 79%
rename from drivers/clk/meson/clkc-audio.h
rename to drivers/clk/meson/sclk-div.h
index 1eaf4ecac4f7..b64b2a32005f 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/sclk-div.h
@@ -4,8 +4,8 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
 
-#ifndef __MESON_CLKC_AUDIO_H
-#define __MESON_CLKC_AUDIO_H
+#ifndef __MESON_SCLK_DIV_H
+#define __MESON_SCLK_DIV_H
 
 #include <linux/clk-provider.h>
 #include "parm.h"
@@ -19,4 +19,4 @@ struct meson_sclk_div_data {
 
 extern const struct clk_ops meson_sclk_div_ops;
 
-#endif /* __MESON_CLKC_AUDIO_H */
+#endif /* __MESON_SCLK_DIV_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
