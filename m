Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298A5C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA18E2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ihk6auhH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yf/kYh5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA18E2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=75DjFlSzstmt2SQQHFyZbtdPiNRYes0Arobrhm75F90=; b=ihk6auhH/xwCXS
	3SRDyBNl5hOK+84TVcFVcNridR3N53YduT6pI3HNPoOcRza+o0EfYRazZb+IQ7CLNdXDPguUTcQbz
	o74JeO4rBbZLYx4nNWx4JmHMMH1bSwglDKVqUM1JFf12oUALx6JvU23ZGJt72PT+3ouzQzq18BwFf
	B9MGJcKr4Om2GeuuiSYUIJ7Jca9JPOlbXv6f4fYFZJjlv+B/SdZmLep8/kS4qaI8aop1DyVaKUL++
	Lp8K6YFeaNYmQ/g2x9ehTYn7dYwwQECWmZ/Y7OxOle29lKmJm6u6T3QEr8Fz4m+BalsntMRZOAftl
	9qq5IwcxRXia7ClmyFAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBHl-0005Od-1D; Mon, 28 Jan 2019 18:05:29 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBH7-0003fo-0m
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:04:56 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so19138109wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qpNi8npcEuB1/go2Tg3AdjTVG+V6jYSlzX7BwF0GsfM=;
 b=Yf/kYh5BzodGUwm1cbrUVBA1KqVdS2kGmvsYG6gRA4Se+GVQx8zHtil+snbPXEvzNT
 AeovQMbgjPdfEoBVaZmz3//mXG0o4zf8FWrufwnP0F2slTgaS4qz3gnSzd/yLcOASQQU
 kQ1a1EvsZWa8w7ayuI23vIftKyAkSE/QSNAbNYOAE1cWaBB5RNGPYpLJThSuhy+o8eib
 GcDOhT+lu4X9A/jie8xBQGzseO3DPhA1+vgJ7vz5PVnhs4/M9HFVHeX1+SQ81vol2kjP
 YZ6sPvdNjfXHruCJLZFZ/KbTSGT4OxtV33ulJlfGz/hcnu6trg+bQ2aGPisvcO6Jw2fU
 yySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qpNi8npcEuB1/go2Tg3AdjTVG+V6jYSlzX7BwF0GsfM=;
 b=XkcxwT7kCvXfvCgcfkeZ/DcstIBjOSaxpeyavlLw7XYz/31jPXER9k4BTmMZcQAndu
 9RLG4T6O+Iq1SK+qmb8MYqJDW9T5zjWPytdDniuhMEQciTlik4vTNHvaOFUO+wGKhNd2
 UQrXDLHZqyuzA5OTfSxb+Rupj7iOfKXYC5OPIFlGBxl2LMPAzQho+HsSw0iEB7fnugRr
 +AA/04A/6U71afiMIuNXjrxM1us0cCp9SydbXFebNDHljPMSZbZThYKJnLDIbk+3UJl6
 G55w4lPH0WHlaufSY8dv244jUhj90UvhQiFa6nOly82PjNI3ZV22CpAZnif+0/2QRRAS
 FluA==
X-Gm-Message-State: AJcUukfsrPNbT29M6Yv4/6aBm+k0cpK4WFo078tghXoxDoWFx4w6Cb3R
 0u/f9pn8fZ5iNdAS8fsdWnWhrw==
X-Google-Smtp-Source: ALg8bN6R2RU/vwdb2lallgs6zrXDfvCKfKjNkwGfxMbyJV+hUE8OgxlmoMHX9A00qaFeyXiCvCWqrQ==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr22509938wrh.148.1548698683205; 
 Mon, 28 Jan 2019 10:04:43 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:04:42 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 01/14] clk: export some clk_hw function symbols for module
 drivers
Date: Mon, 28 Jan 2019 19:04:17 +0100
Message-Id: <20190128180430.28689-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100449_087956_294FE34F 
X-CRM114-Status: GOOD (  11.36  )
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

clk-provider.h provides clk_hw_is_prepared(), clk_hw_is_enabled() and
clk_hw_is_prepared() but these symbols are not exported for the
modules which prevents a clock driver using them to be compiled as
a module. Export them to fix the problem.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5a0551aba09e..91ae0e6e76e7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -394,16 +394,19 @@ bool clk_hw_is_prepared(const struct clk_hw *hw)
 {
 	return clk_core_is_prepared(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_is_prepared);
 
 bool clk_hw_rate_is_protected(const struct clk_hw *hw)
 {
 	return clk_core_rate_is_protected(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_rate_is_protected);
 
 bool clk_hw_is_enabled(const struct clk_hw *hw)
 {
 	return clk_core_is_enabled(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_is_enabled);
 
 bool __clk_is_enabled(struct clk *clk)
 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
