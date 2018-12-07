Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3554FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:00:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025892082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZlidmsFH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jiPDB+Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025892082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GZb0RMirhHQsdvBbp+YQDPjLZdPk+iTJGzpTqYm7QAs=; b=ZlidmsFHHfabCC
	ASRGj9bxwUPDhEOPSYvP5UsBTPHlr+m8P4TBrZenCNN2320Zph6AhxWMlX6dCDspt72hteKJNvQh8
	kLu8oopHBWcjUfhBfCs/cEowgakftukZxuph84dxZEug93hcAdSQJXEl7L1m81wCrZWBBP4UoRWIV
	oE6hM8Ujb28Eyu8aavKvZmXQJh7QQgVkBHjPxb1YGydXbkSWJpmRLUEbvopLlJ1mAl0F4RqrzTATu
	vaGMM3pvf2mpsTOFRwK6uGOAW2O6xRj8XoXbW6H2bGbqUusN0YXm+RP4fwLVfHcYlbqenpFHBACew
	oQgk3lPYVM3JvxqUreeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKQj-00060O-HM; Fri, 07 Dec 2018 18:00:49 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKQg-0005zb-DH
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z6UY61dNw9+CYLwpWiGaKEl/T/bwGiyQMwVS/wHOnEc=; b=jiPDB+IkhsME+kpZIDEKpJ9mT
 Z+BU3ra4LiETkt9XAcF1Sn6rq5AhdLI8zO1KOeo4X6WKnSVkR0Muq6XDVKzLIb03nEwKEW36KpMkV
 EARbCB0g2XLEf7NWksIpIdaAX6veAIqBtUPyeEdUJQY5PTjYV0AZdyXw7+YfuUtgKRF6Y=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:36773)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVKQQ-0000r8-Eu; Fri, 07 Dec 2018 18:00:30 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVKQL-0004Be-Bw; Fri, 07 Dec 2018 18:00:26 +0000
Date: Fri, 7 Dec 2018 18:00:20 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Message-ID: <20181207180020.GA9507@n2100.armlinux.org.uk>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
 <20181206180806.GV6920@n2100.armlinux.org.uk>
 <20181206221447.GM6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206221447.GM6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100046_598035_57116F8B 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

You know most of what's been going on from IRC, but here's the patch
which gets me:

1) working interrupts for networking
2) solves the stuck-wakeup problem

It also contains some of the debug bits I added.

I think what this means is that we should strip out ec0daae685b2
("gpio: omap: Add level wakeup handling for omap4 based SoCs").

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3d021f648c5d..528ffd1b9832 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -11,7 +11,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#define DEBUG
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -366,10 +366,14 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 		      trigger & IRQ_TYPE_LEVEL_LOW);
 	omap_gpio_rmw(base, bank->regs->leveldetect1, gpio_bit,
 		      trigger & IRQ_TYPE_LEVEL_HIGH);
+	/*
+	 * We need the edge detect enabled for the idle mode detection
+	 * to function on OMAP4430.
+	 */
 	omap_gpio_rmw(base, bank->regs->risingdetect, gpio_bit,
-		      trigger & IRQ_TYPE_EDGE_RISING);
+		      trigger & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH));
 	omap_gpio_rmw(base, bank->regs->fallingdetect, gpio_bit,
-		      trigger & IRQ_TYPE_EDGE_FALLING);
+		      trigger & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW));
 
 	bank->context.leveldetect0 =
 			readl_relaxed(bank->base + bank->regs->leveldetect0);
@@ -910,14 +914,16 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	if (trigger)
 		omap_set_gpio_triggering(bank, offset, trigger);
 
+	omap_set_gpio_irqenable(bank, offset, 1);
+
 	/* For level-triggered GPIOs, the clearing must be done after
-	 * the HW source is cleared, thus after the handler has run */
-	if (bank->level_mask & BIT(offset)) {
-		omap_set_gpio_irqenable(bank, offset, 0);
+	 * the HW source is cleared, thus after the handler has run.
+	 * OMAP4 needs this done _after_ enabing the interrupt to clear
+	 * the wakeup status.
+	 */
+	if (bank->level_mask & BIT(offset))
 		omap_clear_gpio_irqstatus(bank, offset);
-	}
 
-	omap_set_gpio_irqenable(bank, offset, 1);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
@@ -1520,6 +1526,10 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 	struct device *dev = bank->chip.parent;
 	u32 l1 = 0, l2 = 0;
 
+	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
+		bank->context.leveldetect0, bank->context.leveldetect1,
+		bank->context.wake_en);
+
 	if (bank->funcs.idle_enable_level_quirk)
 		bank->funcs.idle_enable_level_quirk(bank);
 
@@ -1553,6 +1563,10 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 				bank->get_context_loss_count(dev);
 
 	omap_gpio_dbck_disable(bank);
+
+	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
+		bank->context.leveldetect0, bank->context.leveldetect1,
+		bank->context.wake_en);
 }
 
 static void omap_gpio_init_context(struct gpio_bank *p);
@@ -1563,6 +1577,10 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
 	u32 l = 0, gen, gen0, gen1;
 	int c;
 
+	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
+		bank->context.leveldetect0, bank->context.leveldetect1,
+		bank->context.wake_en);
+
 	/*
 	 * On the first resume during the probe, the context has not
 	 * been initialised and so initialise it now. Also initialise
@@ -1648,6 +1666,10 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
 	}
 
 	bank->workaround_enabled = false;
+
+	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
+		bank->context.leveldetect0, bank->context.leveldetect1,
+		bank->context.wake_en);
 }
 
 static void omap_gpio_init_context(struct gpio_bank *p)
@@ -1720,6 +1742,7 @@ static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
 		error = -EBUSY;
 		goto unlock;
 	}
+	dev_dbg(dev, "%s()\n", __func__);
 	omap_gpio_idle(bank, true);
 	bank->is_suspended = true;
 unlock:
@@ -1741,6 +1764,7 @@ static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
 		error = -EBUSY;
 		goto unlock;
 	}
+	dev_dbg(dev, "%s()\n", __func__);
 	omap_gpio_unidle(bank);
 	bank->is_suspended = false;
 unlock:
@@ -1827,8 +1851,8 @@ static const struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER |
-		  OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN,
+	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER /* |
+		  OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN */,
 };
 
 static const struct of_device_id omap_gpio_match[] = {


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
