Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:53:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2569720B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OU8IBa8a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="H43tLD3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2569720B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=NeekCVSPPj1qe5OhR97Yb/ZLykslFklVS9dwVNkgSAs=; b=OU8
	IBa8aJPmQv0YKvn/wJrFfzaXBQox25TCNxNLjl2zMcpaNj/xJp7asva7cJSWiqa1AXhOf4KLZzaIc
	Y0ZKokPQt61x9rSL6pmDPmfFBuxhVq/OarD37TrNGK2wBoet9waHYYh2PSZGwkPbXUUs1JntL/kHg
	pSFXS66oP1oK9W17Owgxn8a1ZBUBO1hS6KWlEGtuT6z1tbansRWRD4TAOUgegtorYOA+9OhIvjc37
	6X3zLGtSCgrT9er56IlkSajAQVTteZ1kgOXuuZs1wTOJz8g80VOOGUFwvot2JxTscWzZeLkeEmoVv
	Qnvbat4g50WBfSKXBQX+JaKvSyP49QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gduG4-0001Df-7b; Mon, 31 Dec 2018 09:53:16 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gduG1-0001DL-0y
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 09:53:14 +0000
Received: by mail-pl1-x643.google.com with SMTP id p8so12525012plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ingics-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=E4lMnMnBIfY3HmldaF9LT8SpHhqJ0ZTWep215r5bty4=;
 b=H43tLD3akUnMDiPIHdM/8yyCoN9RKIx9cUJBa2QiQmgY1FJR42vF1I4Qlvvh/CBUp/
 SOUYt892KMRLythfw0sRsB4Tk/xnAV7jMCWVZ7AFYrU4bkuDKQ++c/rF36kKpRfbDhWK
 bhPplg2uMSMSM1WDktW0tl1y2JLMmyHenM/p0yB7HJ0XdPNsaFOQkW8Bo5DlHiyAoqGZ
 aLtu4reXIqCWYaICNXeBpxMqy/ZJ6I9nUaEjqyG0BsRP7nDhIilqwkG6pUkz90sb3RfF
 5nt3r6qgbCcEvaD8J8PCRMN/McGTk8MgExpMNylp0/FZ2aOb4KC/jEUHr4yoUSTIiiF3
 jJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=E4lMnMnBIfY3HmldaF9LT8SpHhqJ0ZTWep215r5bty4=;
 b=nCZkSI98EJjf2VwIDLUGZDloz3T7LkywO7buwxo8qa41G3nrALvWxXeY/5AemnzynY
 vqagrxrJgOI3qxdJ+OzIyueo+4xOjlAJhgNyutrOmkfEyw7NYa3so+1OyVXPToEaOVGS
 o+klAj6FjFMGXBDDJewhWD3AC50250WJHjRP4ZfTM+R1Wq1STVoqL9jENP89roxA6doE
 QX5X+KBdb3Z+mhJILtXTDfjqdaxT8wjwhP9dvzL76mM5esLCu3hCOCeOps+wJ6IKYZL6
 Ks+JrDfx5jtdcAthixaB3hagbF5FVbVYHUQGfOxQVf87ozpAF9JcGBP0M/0JYbpKN6so
 20kw==
X-Gm-Message-State: AJcUukddipnHp8tuEmJIsBb0O5XknyT5fUqtz6VUO2ndf1MclKPjAn9S
 yI2FaTex20z0agWE3Iozb34cKw==
X-Google-Smtp-Source: ALg8bN6P/DjEj8Le5ivKPp6RXe+SNBnWn5+R6UvMt/536XOMog4kfu6YeOIRZI/bkhT1USi7ODKIRw==
X-Received: by 2002:a17:902:e002:: with SMTP id
 ca2mr37180135plb.103.1546249991522; 
 Mon, 31 Dec 2018 01:53:11 -0800 (PST)
Received: from localhost.localdomain (36-239-205-119.dynamic-ip.hinet.net.
 [36.239.205.119])
 by smtp.gmail.com with ESMTPSA id h74sm92060141pfd.35.2018.12.31.01.53.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 01:53:10 -0800 (PST)
From: Axel Lin <axel.lin@ingics.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT][PATCH] gpio: sama5d2-piobu: Set proper output level for
 direction_output
Date: Mon, 31 Dec 2018 17:52:56 +0800
Message-Id: <20181231095256.14814-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_015313_134152_594A1499 
X-CRM114-Status: GOOD (  12.69  )
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
 Axel Lin <axel.lin@ingics.com>,
 Andrei Stefanescu <andrei.stefanescu@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Set proper output level base on the argument of direction_output.
Also remove sama5d2_piobu_set_direction() as there is only one caller
now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Andrei,
I don't have this h/w, so please test if this patch works.

BTW, I think this change is better than just adding 
sama5d2_piobu_set(chip, pin, value); call in sama5d2_piobu_direction_output
becasue only write register once for setting direction_output.

Thanks,
Axel

 drivers/gpio/gpio-sama5d2-piobu.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
index 03a000659fa1..7d718557092e 100644
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -108,16 +108,6 @@ static int sama5d2_piobu_read_value(struct gpio_chip *chip, unsigned int pin,
 	return val & mask;
 }
 
-/**
- * sama5d2_piobu_set_direction() - mark pin as input or output
- */
-static int sama5d2_piobu_set_direction(struct gpio_chip *chip,
-				       unsigned int direction,
-				       unsigned int pin)
-{
-	return sama5d2_piobu_write_value(chip, pin, PIOBU_DIRECTION, direction);
-}
-
 /**
  * sama5d2_piobu_get_direction() - gpiochip get_direction
  */
@@ -138,7 +128,7 @@ static int sama5d2_piobu_get_direction(struct gpio_chip *chip,
 static int sama5d2_piobu_direction_input(struct gpio_chip *chip,
 					 unsigned int pin)
 {
-	return sama5d2_piobu_set_direction(chip, PIOBU_IN, pin);
+	return sama5d2_piobu_write_value(chip, pin, PIOBU_DIRECTION, PIOBU_IN);
 }
 
 /**
@@ -147,7 +137,13 @@ static int sama5d2_piobu_direction_input(struct gpio_chip *chip,
 static int sama5d2_piobu_direction_output(struct gpio_chip *chip,
 					  unsigned int pin, int value)
 {
-	return sama5d2_piobu_set_direction(chip, PIOBU_OUT, pin);
+	unsigned int val = PIOBU_OUT;
+
+	if (value)
+		val |= PIOBU_HIGH;
+
+	return sama5d2_piobu_write_value(chip, pin, PIOBU_DIRECTION | PIOBU_SOD,
+					 val);
 }
 
 /**
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
