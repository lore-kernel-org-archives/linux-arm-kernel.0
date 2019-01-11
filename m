Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E632B20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u8YZ6F8k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P4Zaqs3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E632B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X9P6omKMmqWejRaVUFfPlYzcivRgWK4m4wncfwkr2Kc=; b=u8YZ6F8kCmiXXw
	h2klHK/DSVztTWKwMe0TjgRte+6BHXfyoDivG0JQeTvzo/sPHDNEIfKPty3BPzd5PWl4yJKM/Dbdd
	w/BAksZPnRSiep8A6N7UfqrxD9xW1fYm4J8L2+aWfNGKav/umIZcpQDHxeqx9UDKhsj+DnlrA7O5k
	QoZmiQnOUNxf9QGKkVy7+IJm/mqCi0L37qo3+Dd7kdNxbO0TzaJ2Xpr+SIVlASdpiqJ5AyRfEByMr
	h5vkUEnF2IiNQJHm+Y1H+ibj1y96KKpwnFx5o5OEvstgU2UDTWCa5EZy9n4DIGqdGTOkCWDyXb9rY
	qu3prtRrMc4Y6tb84nKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0aA-0006IU-J3; Fri, 11 Jan 2019 17:26:58 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VS-0000W9-C8
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:11 +0000
Received: by mail-wm1-x342.google.com with SMTP id y139so3099583wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n0bVZLgHbmzlF03gwgM80KrrXfKmVICzK0GHI6qGu7k=;
 b=P4Zaqs3dsRMJPeYeCFa7pQy39C0RU5Nxi1+EcHbOFpAvPiWdHx5IuJl0TqhOKz4BEZ
 43n1l1P+Jzb7d9PSwCXTajQ5YVhlCDZJ/wVeIKJ25obXdtjn4x7PiuPLl0faHKyDevgg
 +kb7Uyo2vtNGi+emB8APf8bpuuGzpcY/ZAPtdqOlksIkUza0pHwvGifUt0deIJNf+OxJ
 OUjJ8H26si9xpxrFBIesEGQfEfp03dlGQFyGVO75+P4HV8tmjfz6xGMW6DvcPtkXUKXH
 JQVJobCw6GubRj8ElpNLlKosPYRC/T9wUm86JxGGyNHufj1L3b6JfJBUlJBp5PWAiJ0a
 o1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n0bVZLgHbmzlF03gwgM80KrrXfKmVICzK0GHI6qGu7k=;
 b=KDNjmRtbDQVuTxjOt8wpKcaaMb051yrT41P5cNSEWMPCVLfsxdKw9bLrdHUufZIyrB
 9Pz3sVXEF7v+H1asUOtIGrEAI7nj0+Tv+cApJnk/f11N88lCiaEnVPrO07kw4pETw+MD
 +trYhHKXh2k7hqnIVlmrVDeeVuzwaF1Dd6Sa6aDePQfl9kiJK737p8EP65laebqgaKh2
 txeiaKkDaVw1YXNF8sP74pWa103U2J/8U0OG55JuGfXQRo14MYYxspN+m9oD6Y5Qs8of
 KA63/pnYSvJ4S/7enqM01kc6KtN0Qqn+Sgkb0JZUEa5vJrLQwhKBdsBXMM/0MaUoIpdf
 47gw==
X-Gm-Message-State: AJcUukfOFSwxFz7ct/DgZ/rlH6ezreGeaF/RtcSzQ59rDrJ8cO78b7xo
 5t5ZjSq3fdrHmpUV/BBoyJMTNg==
X-Google-Smtp-Source: ALg8bN5J+hjbdWKxB7wzxjnbO+WQR5qkiW3Or0dYV5k+JRvpiMPQ8kb9bkUExWE9fXq7QNWC8PRwqQ==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr2933588wmd.151.1547227325088; 
 Fri, 11 Jan 2019 09:22:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:22:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 12/17] ARM: davinci: move timer definitions to davinci.h
Date: Fri, 11 Jan 2019 18:21:29 +0100
Message-Id: <20190111172134.30147-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092206_936478_ADA4E0F2 
X-CRM114-Status: GOOD (  12.79  )
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

Boards from the dm* family rely on register offset definitions from
arch/arm/mach-davinci/include/mach/time.h. We'll be removing this file
soon, so move the required defines to davinci.h where the rest of such
constants live.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/davinci.h           | 3 +++
 arch/arm/mach-davinci/include/mach/time.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index db4c95ef4d5c..dfd1b1ab7b59 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -60,6 +60,9 @@ void davinci_map_sysmod(void);
 #define DAVINCI_GPIO_BASE 0x01C67000
 int davinci_gpio_register(struct resource *res, int size, void *pdata);
 
+#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
+#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/include/mach/time.h b/arch/arm/mach-davinci/include/mach/time.h
index 1c971d8d8ba8..ba913736990f 100644
--- a/arch/arm/mach-davinci/include/mach/time.h
+++ b/arch/arm/mach-davinci/include/mach/time.h
@@ -11,9 +11,7 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_TIME_H
 #define __ARCH_ARM_MACH_DAVINCI_TIME_H
 
-#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
 #define DAVINCI_TIMER1_BASE		(IO_PHYS + 0x21800)
-#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
 
 enum {
 	T0_BOT,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
