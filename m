Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA33C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:43:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F753217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PcVi0KVL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke6t9zh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F753217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EbvFgoAoxiMHp1SxYuI8z59F+UQVkffME3J2gi4VKfg=; b=PcVi0KVLV5LMd4
	AxkC6cLyBN1HIljt5NG9WIBbzEjJGmq38m2FlxK1FaB29EAW47X0WSbDTQCYmtCuWUUq0wEtpHXtA
	bd1H0qnLBeh6NKcpM6IEe+hDCizhF+qZKR2EQPWPlKjt0IhQuAhNVTqBdWQMSLDcvSwJiFTa7p6ki
	Pf0yzOsocQ/9wCInQ3yNTJOHcoLn5rK6TSICRpuJmSI2Nb9/2Cmqaj+mNvSt/NCtkP5wmNQzy+/KC
	nG4VRpqiuFQ1vVGwo3v+HK7X/D1zxhfsCCwdvxZc4EXVpWfz2Q2SJDNfzieAQm/feu+hEqeMve1F7
	WTDlgZvKs65Apy4ifJxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPXV-0000Fu-9f; Sun, 03 Feb 2019 21:42:57 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPX0-0008B9-Pd
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:42:32 +0000
Received: by mail-lf1-x144.google.com with SMTP id l10so8861116lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Es9lmnWGPrW56PqgZ2XPTnl0t5zSduT/F6R/jNouSec=;
 b=Ke6t9zh8qK1jd7IY0zqfLIrc4Pn1O4z81Cywia5Wu0m0nckx5M2QMK/V1/iRvyv2eX
 kuRnPuhWLgZMb4nsMAA8bfVTCZZ3i13bqI8dM40Gx7RDB8LVjeZE5vCfOInkNgkP2Rvh
 uSjLs3knrAxD3nd/vYeV8PaHxxqF00n5SB1Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Es9lmnWGPrW56PqgZ2XPTnl0t5zSduT/F6R/jNouSec=;
 b=t22hFJk8jgruLb+ocbVxjg4ZiYvJ3c0nuMrJ3QEjvNRN+fP54HcJDrUQGwS/9Xyug6
 rnun+SHGdFl/VCoJeChYD+fvrDhtyqNMX+pMNT5QTuYJpOe0wDa0N2oT+plZDx75ZOQ7
 LmGks6bjcxHxHP1FFGk40IY6vYeRyOkPTvEEb66mhWZCRdQrEPj3CnIjQ2PwEd2VFrcX
 ++gByIrWw9UYMf5iKHLbodeBzFT0Pg28+MjfHU9GX+lbqaqcabFv0krswO2gOfjMYO9x
 16/wVWxJb8pr1tnxtR1fVB+rBwOZNV/EI/ThfFLJUavlMQ5K3CV+feRPvT8HAhWMrjIp
 rLnA==
X-Gm-Message-State: AHQUAuZ2PAeo1KWGtDvJFeAlGwd7yA2J27htIvOirOhXFBas/c0l21ND
 wulxUSlSJOGumQ/pgFqpo2iZrK6rpx0=
X-Google-Smtp-Source: AHgI3IbsnDf+EmGj64Z7juE27+6ttmkQw5zS+4MjTSXRfgIZlT+n+QMFn6PVfEoxzi8tKkOxdH168g==
X-Received: by 2002:a19:760a:: with SMTP id c10mr7864468lff.53.1549230144444; 
 Sun, 03 Feb 2019 13:42:24 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:23 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 02/17 v1] ARM: ixp4xx: Pass IRQ resource to beeper
Date: Sun,  3 Feb 2019 22:41:50 +0100
Message-Id: <20190203214205.13594-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134227_043330_95463618 
X-CRM114-Status: GOOD (  17.27  )
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
Cc: Olof Johansson <olof@lixom.net>, Tim Harvey <tharvey@gateworks.com>,
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

All IXP4xx devices except the beeper passes the IRQ as a
resource, augment the NSLU2 beeper to do the same.

This is a prerequisite for SPARSE_IRQ.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/nslu2-setup.c | 10 +++++++++-
 drivers/input/misc/ixp4xx-beeper.c | 20 +++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 341b263482ef..7c2b6604187e 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -125,10 +125,18 @@ static struct platform_device nslu2_i2c_gpio = {
 	},
 };
 
+static struct resource nslu2_beeper_resources[] = {
+	{
+		.start	= IRQ_IXP4XX_TIMER2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static struct platform_device nslu2_beeper = {
 	.name			= "ixp4xx-beeper",
 	.id			= NSLU2_GPIO_BUZZ,
-	.num_resources		= 0,
+	.resource		= nslu2_beeper_resources,
+	.num_resources		= ARRAY_SIZE(nslu2_beeper_resources),
 };
 
 static struct resource nslu2_uart_resources[] = {
diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 1fe149f3def2..4776273fa10b 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -30,6 +30,8 @@ MODULE_ALIAS("platform:ixp4xx-beeper");
 
 static DEFINE_SPINLOCK(beep_lock);
 
+static int ixp4xx_timer2_irq;
+
 static void ixp4xx_spkr_control(unsigned int pin, unsigned int count)
 {
 	unsigned long flags;
@@ -90,6 +92,7 @@ static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id)
 static int ixp4xx_spkr_probe(struct platform_device *dev)
 {
 	struct input_dev *input_dev;
+	int irq;
 	int err;
 
 	input_dev = input_allocate_device();
@@ -110,15 +113,22 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
 	input_dev->event = ixp4xx_spkr_event;
 
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0) {
+		err = irq;
+		goto err_free_device;
+	}
+
 	err = gpio_request(dev->id, "ixp4-beeper");
 	if (err)
 		goto err_free_device;
 
-	err = request_irq(IRQ_IXP4XX_TIMER2, &ixp4xx_spkr_interrupt,
+	err = request_irq(irq, &ixp4xx_spkr_interrupt,
 			  IRQF_NO_SUSPEND, "ixp4xx-beeper",
 			  (void *) dev->id);
 	if (err)
 		goto err_free_gpio;
+	ixp4xx_timer2_irq = irq;
 
 	err = input_register_device(input_dev);
 	if (err)
@@ -129,7 +139,7 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 	return 0;
 
  err_free_irq:
-	free_irq(IRQ_IXP4XX_TIMER2, (void *)dev->id);
+	free_irq(irq, (void *)dev->id);
  err_free_gpio:
 	gpio_free(dev->id);
  err_free_device:
@@ -146,10 +156,10 @@ static int ixp4xx_spkr_remove(struct platform_device *dev)
 	input_unregister_device(input_dev);
 
 	/* turn the speaker off */
-	disable_irq(IRQ_IXP4XX_TIMER2);
+	disable_irq(ixp4xx_timer2_irq);
 	ixp4xx_spkr_control(pin, 0);
 
-	free_irq(IRQ_IXP4XX_TIMER2, (void *)dev->id);
+	free_irq(ixp4xx_timer2_irq, (void *)dev->id);
 	gpio_free(dev->id);
 
 	return 0;
@@ -161,7 +171,7 @@ static void ixp4xx_spkr_shutdown(struct platform_device *dev)
 	unsigned int pin = (unsigned int) input_get_drvdata(input_dev);
 
 	/* turn off the speaker */
-	disable_irq(IRQ_IXP4XX_TIMER2);
+	disable_irq(ixp4xx_timer2_irq);
 	ixp4xx_spkr_control(pin, 0);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
