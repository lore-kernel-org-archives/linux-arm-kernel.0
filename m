Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A4C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3AF2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FZ7TGDyb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BebHWrUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3AF2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kGWRzIOqfe8m4KIuo1Y5KE7KZC7FOcEPdvROKkZSsjg=; b=FZ7TGDybZuzMEb
	Rrxvx/ky2cPXWZ4g92F91183g5lBsTIkhA8ldFd/GMl94Ga6WBmgTYBKQNrh9yAkhI53WZ058SeC3
	albgoDSzEAiBexU7lAeFV059/O5xCB47112CiA9nPtYaZLBzwpmShOSYUM2lv22NOFN2QMsTjU8RH
	H2x/HjAmZccEc1VVbkX9Y2ddoG5Boa0S27/gkE4wIgEkA0HdefewBRIGvlFFPAF0+5tYa9kdZg6zA
	iZGRxUn8Z20Z9I2nuFTtMtHfUlFdMLq21fgCeyGoGq1wMxCIk4HxTYFHEWiJzm9Rj8GEYyffFBszB
	hfawZKWSQgy3O9xBGVmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf4et-0004ad-IK; Thu, 03 Jan 2019 15:11:43 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf4eX-0004BU-5m
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:11:24 +0000
Received: by mail-wm1-x342.google.com with SMTP id p6so30558093wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o1Rscmkgo5Aw/dFvuBDumO5U7Ea+GbZdlw4mBIcmRFs=;
 b=BebHWrUJYrV09TqDySy/CNMzu8SepgKotsI0sYvoiGaB924gKKB+E8sBEvW6FsmEXM
 SvgukRJzroS6wifqcT11XSq+rqT6IAyng+aLZNcmxXL1ZY/D5qpLFGDipJYnlfeOyrWK
 KFsETquV8t01ehjZmggMe9mXfvTjn077kkdmc9MX8kbVzhLIfcylWsqJeqwVWJZMHZc4
 bbpo4W8hEQQUxpYeKHXHy0KhjE5EkdEOclouFQgkwvX+grjyobYY53tdCuuOmzrrrGoR
 +5nfWlspWgG/Ioiffj5blMOONMLlHDfRloD4sIpjakzJKhRhiCKASOVp3suV22vEhFZc
 Zf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o1Rscmkgo5Aw/dFvuBDumO5U7Ea+GbZdlw4mBIcmRFs=;
 b=KwBpF7fVueG0h42gKaagGtgfQAX5HvDKVVmVfe6ngfLLQuvjUOXo7x3p+A0kJpI4Pb
 UKX+YhlEVoMJic2HzM+87LkN3UhP64o4NFSLUV5saP99ZKJ1kVFd6t5jdnUv5kxR/NIa
 O9L6fGe2ntAz4QHQYKz0bZoU7SNccJMT6XBgPFGgbQAwpdbywUOdNsqRLZT8tn2spMjn
 a8M1IvBZ8Pq0IONKI7uLVJnQYak8kzuqIxgtSKwH6DZc6OsHsdaPmlNNN1mwl5yEsPDR
 V9DKUhsNYtjGuvP0GVdM/3TyA9lQaXy6Ej4a1XPZgDSgu00MaYns/LXIw/Zgn+e+3/Al
 p33g==
X-Gm-Message-State: AJcUukdoiTrcHnzkFw9tD08KQJbNNFBSr3BIvkOCZEbm8Kjhc8rC6J6U
 yWGSlnSBKr3wDUZfDTmAJm6YVQ==
X-Google-Smtp-Source: AFSGD/VyKL1kRSsVJEg0ns79V2gz1O2GLmJIV9/g/Yv2Y4St2M7M0zHBJC4uXlv20/uVgNDHAXtLiQ==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr36793535wmc.43.1546528279497; 
 Thu, 03 Jan 2019 07:11:19 -0800 (PST)
Received: from debian-brgl.baylibre.local
 (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
 by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 07:11:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 3/5] ARM: davinci: dm355-evm: fix label names in GPIO lookup
 entries
Date: Thu,  3 Jan 2019 16:11:02 +0100
Message-Id: <20190103151104.11839-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_071121_589564_BD788155 
X-CRM114-Status: GOOD (  12.02  )
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
 arch/arm/mach-davinci/board-dm355-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f53a461a606f..f7fa960c23e3 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -117,9 +117,9 @@ static struct platform_device davinci_nand_device = {
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SDA_PIN, "sda",
+		GPIO_LOOKUP("davinci_gpio", DM355_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SCL_PIN, "scl",
+		GPIO_LOOKUP("davinci_gpio", DM355_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
