Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0342AC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:04:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46742148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R9uB8amb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zsbih5A0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46742148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UenwRNq0eok9p8hIAXiZb8CPMndYuSA8yoUAXJrhbLw=; b=R9uB8ambDmooXP
	LPcgFn04YpByZ5nm3juQioLmoJFc17JnjE5gzLdA9R+uvzj39gzabnO1aysTtOwG2ynElmL074cG1
	p/qANRguo6Glxt4JbfJNGU0cq6K5B7XLrxhsn3vyS/zgOX0erbxwg6kf0Fn8yCcKKWg+GyDwhsmyk
	9rwuJGfiKvNNoIemAHk3r16Tlo1a0dLzrcoWWLfZJn14TaQf5wLQZynV/8EimSGPVkK2V2XkXeeXr
	A3nCzjnX6UtDMLgE5u0d7iPON12eiqfwq9kP/xx9IQR8ZyZP2ntz7z+rIzMQc5ENEmt84y6MfRjui
	f5lQToqmfx+UeWRd4Tsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBH8-0003j0-OP; Mon, 28 Jan 2019 18:04:50 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBH4-0003fr-KX
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:04:48 +0000
Received: by mail-wr1-x441.google.com with SMTP id z5so19097434wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SyqJ1ZNijojoTR5cd+qdscOqYrp/PnKLGRUwKnFmRlM=;
 b=Zsbih5A0XT1436LqD455eX3TwHSJgdMOs5dTyer3kSmE68pxW9N/15q6Wve7hhuO58
 4kNON7i+OYW7ZThzqCZtg8TaDJMY/Ytrp/CBCPR5GdEnv1gAsbPqnVVt7cHfFkXTST68
 3WB5Ol7LCzQeZeLHAZ2dksmfHJu9u75BOxP4I60de9Db00O7aiJVJmQNzthFYco4EAZR
 cM/fkxyoDEKmaLBOHxRCtoCxOk1WCUgkHdfgMh26S0iMES+syQ8ZMfjACKGGJytfg0TV
 tzuEE0kAv/jjkY7HQHcn4pJzuRQmlpH2mmuKf1BGaFIu9dUp/Xqh8QYDgW+wfOwJfpCn
 HUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SyqJ1ZNijojoTR5cd+qdscOqYrp/PnKLGRUwKnFmRlM=;
 b=uCGlMlqjyBcLL/CSrAynm+eBSvlweSgGVJ1tgKp92Bxn4Hmcg35zhVlri4oA0bm+TQ
 S5KbV2fqmckZJyqE9Ejh572ktkix6VNqZXDOR/JkgGCvElIBPrit/n0gzFxF24OZo1kt
 Bg4mual7gfMUHnE8zTNtOZ24Cq/ZwXRKF6Roa2kcOrPIeHCRwLjZ+3P5yLQ7trxaZoJJ
 RecCifvgyxkHsLXka6QnLMNB9AAIMJA3NDpyex6T3tKJrusUGyMSaQqM7ozoNoFPUMNQ
 n5iA0P2A7XLptvEQ1lNbZg8ngPH0sdnYRK/gXzCJ2IGBnTaW5qLFOGyCJtq7ySG8v4nx
 Ng8w==
X-Gm-Message-State: AJcUukdIDQka1vd2il6ZDZXrx4fUFtz99HsXfcho/Y9Lvlcf20owCcI5
 QipznXEdA+OiWf8k7WuNjAZl0w==
X-Google-Smtp-Source: ALg8bN70L5BosbEnf2iuiICAG9QvKNUPF80NJIk18dNZI4ftldt6y16V7XP2FO29oJ5/RvoO9VsXKg==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr23743080wrq.133.1548698684743; 
 Mon, 28 Jan 2019 10:04:44 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:04:44 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 02/14] clk: meson: use CONFIG_ARCH_MESON to enter meson clk
 directory
Date: Mon, 28 Jan 2019 19:04:18 +0100
Message-Id: <20190128180430.28689-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100446_726435_8205BDCC 
X-CRM114-Status: GOOD (  11.02  )
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

Use CONFIG_ARCH_MESON to let make enter the meson clock directory.
As part of a rework, CONFIG_COMMON_CLK_AMLOGIC is about to be removed.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 8a9440a97500..8d780c4390f1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
 obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
-obj-$(CONFIG_COMMON_CLK_AMLOGIC)	+= meson/
+obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-$(CONFIG_MACH_PIC32)		+= microchip/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
