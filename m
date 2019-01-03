Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D9DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:12:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A1C2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lbH2Nqz1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mzkfy880"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A1C2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FgC8dq2Qwc1Iyxx/Vh2XY28t7An/TTaarpIzHyFLgSU=; b=lbH2Nqz1FdVxjm
	pr83R5Ad3JxO1by8nhpjrDn7J9F2pvStQXdAuCQYfIc+daUq77edrlUsNimh1KMWvJPabOx+IPNHP
	RT1o0d14S3H8dWseyfbqeDzKcnc3EF7T00LKmcz9r52ulV2wvzMgSaMigYawk+sEv7ED+tXX2pA46
	7JowpKMpt9JIqKQ9mhZqVzlUJETEZI4sBFjKMJ4VSGGMlz1aHiYlmjVmIyBcCp+AuBHlzULjWZwjg
	rK8YaE7XAisc81USi7SfFX4MQXnA76Oc5qgUK33MK+03jfqH1sN6Vk0ooWtFfJQAKwPDPb0HBMKME
	S24FP3Tes/uoaQsCD8EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf4fe-0005Nf-SO; Thu, 03 Jan 2019 15:12:30 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf4ea-0004Eu-Df
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:11:29 +0000
Received: by mail-wr1-x441.google.com with SMTP id u4so33847552wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bztX5GLS2nM4tEUX9wPl/F9/kiH0XADSVNwoqijTUcw=;
 b=mzkfy880idbgY3ZUEea+GPENXKJ/TXULVloJe+8AyryH52ArrckmLgkUWCSEIcR2Cr
 AS4JOUFnnTSUddkvGMNZNA5dNaOUI4AfOHt2OM0nXe/aCKsuHVtRCbdDDmv+VzjoPGI/
 TSnFVMbie9Y8fdFwvnbkYW/1eQc3CTLbzRMKK6MQzqe2mjfKDbvFM3nAatN/LTFXkxvT
 yS/kmRO+Pgnq3MdlxIjpUG0KZlm0DlL4C5ZvPsvpL1KlwqtdwiJLA/68PSgEEdjOatnI
 7lobECsUugLr/mp21OiOeou1GORuHiQT1ziTnMqR2AqcYYunspLauznMRUdeW/G/GjOg
 cbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bztX5GLS2nM4tEUX9wPl/F9/kiH0XADSVNwoqijTUcw=;
 b=CmyxZM5dhqrldBQau6G8AgEogfI8Q+Wjc/wp8y0LSJQxc69e7Us6lWZaOMvuxaifJ/
 ftkr2XSvZOV+X0sQh+THRZBUvZpswN7Hs8dAJkxDEoSaQNUljpTppQCy+HLCMVB+EpCc
 vVvzruaRZrO9PF0PmBxS4jTq4kBkfc+KWIUVKo3ulKDfSdtQHQuhvQNOpe1pi2jNmUb/
 QAVs8NwhuUdfs3hHQE0E622BHtVTEum5ibg/5zoN+wcDG1pJLJFzH6fO+1L9U1QQEwH4
 zq01JbIHfJ7md7hgcg9M57GxnqoW+uhajsTLof0Vx1FLBR3R/B69ZX/3MirxaLSQMIAd
 KE1Q==
X-Gm-Message-State: AJcUukfSykgDrxdfpsxrB1R7KL9Ouu9VricHZFug9kiV/3fGzh8q1XOw
 IAOBw66yNdqBHQcXs9oDzwEE7A==
X-Google-Smtp-Source: ALg8bN4MS1F0pPVMMusxIxLPyNFMi2QrKOzGGvKYF1CAUk3gvLf/sDvc4gX4d4nfIr3mCR/jjHLvzg==
X-Received: by 2002:adf:f649:: with SMTP id x9mr40385684wrp.247.1546528282696; 
 Thu, 03 Jan 2019 07:11:22 -0800 (PST)
Received: from debian-brgl.baylibre.local
 (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
 by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 07:11:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 5/5] ARM: davinci: omapl138-hawk: fix label names in GPIO
 lookup entries
Date: Thu,  3 Jan 2019 16:11:04 +0100
Message-Id: <20190103151104.11839-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_071124_989181_BD706FAF 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 8e8d51f4a276..94c4f126ef86 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -134,9 +134,9 @@ static const short hawk_mmcsd0_pins[] = {
 static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA850_HAWK_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA850_HAWK_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_LOW),
 	},
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
