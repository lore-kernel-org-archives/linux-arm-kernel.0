Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1942C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:51:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6ED2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pzoAakzQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WI/Q7BBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6ED2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KZxfS3tR1IRd3m+wq8JmrzIGF6sH2ohfx0BwGk+1VWc=; b=pzoAakzQjQoSMm
	t+OHBItCbcG8++tkWYQ3lZnL3W7fOE8728YuRBaw3QcufbIUSZBEpRbWokU6+8GsAy+s81Pe05Eg7
	6UsCqgngM0kmTzC4a9iu/qUPBkQZF6eNJ24XXo9wfidd4q2vki3AZoXFACDh3Xft5h5ivHLFyb9Uf
	0XzCxe+1vY//apBb8+8OreVVqFQTfnDOnrTZWrRLtTG9WsxgoXdmrgicbPMYopJBomKP2T5ZrF5n3
	YEq1zriP9OOKXusIzA5A/x7RTMRf8npZQzz4uOORxnEoqd6qWj3Ea1z7kVQk17qA4PhVxHPPfGOxe
	KXeLDfIyMhr2imHFY+6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPg0-0006bP-ES; Sun, 03 Feb 2019 21:51:44 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXD-0008Pm-98
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:42:55 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so9987340ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4xyigNek26TekTHGb8ftZvlTWQ2gVLgDODxtCyg2nRk=;
 b=WI/Q7BBCcbJoxsNjoLE90ytOqOUYsDfFFMOtzPX502G4UjH6xHRyAV/XUIsIkVH+6p
 0pQF7SwY04Lb+Tqodn8CC5O3vXFTAATv3r5YRfiMvUXsLcSCqnatVhKsG5GaJnfITkQF
 k5eyQwOKh++ywwUPiUCbIJAWAO/UcbggVTENw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4xyigNek26TekTHGb8ftZvlTWQ2gVLgDODxtCyg2nRk=;
 b=TFFvo/3KDuPFK+UdIBopQeICrQYl8pa3dWGxdigOEuIRlBWgyz/I21MEAVXaAUgETT
 M5LkJhpVqeqHZo+0A+XzzyL56lQadDWj/wUv0W66+pb/oLvM4KZ6Z28gUI2zZ2KdsvQ/
 cfpLgoAXudZERQGSsDjG24I61bqDTY/BMjoJW1BWcmihXobQeDv2MaO+DOAWlhnKkNhc
 KIHCmh+oNfBqe/5q5SMOs7zj6Lxz2iFuD2BuSoH9f5WZnJJkma8NRPba2bdFza3GEMJG
 jwNhWeWFeyNIx5Qk7qnm2nU80y3lsT6BYUfa+PjwARuFgKKYxToSn6pwfaEtKrkI/spL
 hDmA==
X-Gm-Message-State: AJcUukfmPYK9sDY3ewJ9xoNtpQH8WmWFqGWRYUWXcYxyuNxWbDa3XwPQ
 WhurvpbxIOLHGk6eE8D09A0r43dVGuY=
X-Google-Smtp-Source: AHgI3Ia6uj+9XblfnlpXjuS8Dl2BkdpPe6l9yMmqKOZE88osx3kPgwaR3YZxE5zBbGSGMtV4GQqZqQ==
X-Received: by 2002:a2e:5356:: with SMTP id
 t22-v6mr27274473ljd.26.1549230157345; 
 Sun, 03 Feb 2019 13:42:37 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:36 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 08/17 v1] ARM: ixp4xx: Switch to use new timer driver
Date: Sun,  3 Feb 2019 22:41:56 +0100
Message-Id: <20190203214205.13594-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134240_452855_546F1F73 
X-CRM114-Status: GOOD (  18.33  )
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

This augments the IXP4xx to select and use the new
timer driver in drivers/clocksource and removes the old
code in the machine.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource/timer maintainers: here you see how I activate
this new driver. Intended to be merged through ARM SoC.
---
 arch/arm/Kconfig              |   2 +-
 arch/arm/mach-ixp4xx/common.c | 153 +---------------------------------
 2 files changed, 5 insertions(+), 150 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f6345594cef0..9f70d7e032d6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -427,7 +427,6 @@ config ARCH_IXP4XX
 	depends on MMU
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_SUPPORTS_BIG_ENDIAN
-	select CLKSRC_MMIO
 	select CPU_XSCALE
 	select DMABOUNCE if PCI
 	select GENERIC_CLOCKEVENTS
@@ -436,6 +435,7 @@ config ARCH_IXP4XX
 	select GPIOLIB
 	select HAVE_PCI
 	select IXP4XX_IRQ
+	select IXP4XX_TIMER
 	select NEED_MACH_IO_H
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 71683dfc48f9..fc4c9b21ca96 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -22,9 +22,6 @@
 #include <linux/serial_core.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
-#include <linux/time.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
 #include <linux/io.h>
 #include <linux/export.h>
 #include <linux/cpu.h>
@@ -32,6 +29,7 @@
 #include <linux/sched_clock.h>
 #include <linux/bitops.h>
 #include <linux/irqchip/irq-ixp4xx.h>
+#include <linux/platform_data/timer-ixp4xx.h>
 #include <mach/udc.h>
 #include <mach/hardware.h>
 #include <mach/io.h>
@@ -49,19 +47,6 @@
 
 #define IXP4XX_TIMER_FREQ 66666000
 
-/*
- * The timer register doesn't allow to specify the two least significant bits of
- * the timeout value and assumes them being zero. So make sure IXP4XX_LATCH is
- * the best value with the two least significant bits unset.
- */
-#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, \
-				       (IXP4XX_OST_RELOAD_MASK + 1) * HZ) * \
-			(IXP4XX_OST_RELOAD_MASK + 1)
-
-static void __init ixp4xx_clocksource_init(void);
-static void __init ixp4xx_clockevent_init(void);
-static struct clock_event_device clockevent_ixp4xx;
-
 /*************************************************************************
  * IXP4xx chipset I/O mapping
  *************************************************************************/
@@ -106,37 +91,11 @@ void __init ixp4xx_init_irq(void)
 			(cpu_is_ixp46x() || cpu_is_ixp43x()));
 }
 
-/*************************************************************************
- * IXP4xx timer tick
- * We use OS timer1 on the CPU for the timer tick and the timestamp 
- * counter as a source of real clock ticks to account for missed jiffies.
- *************************************************************************/
-
-static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	/* Clear Pending Interrupt by writing '1' to it */
-	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
 void __init ixp4xx_timer_init(void)
 {
-	/* Reset/disable counter */
-	*IXP4XX_OSRT1 = 0;
-
-	/* Clear Pending Interrupt by writing '1' to it */
-	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
-
-	/* Reset time-stamp counter */
-	*IXP4XX_OSTS = 0;
-
-	ixp4xx_clocksource_init();
-	ixp4xx_clockevent_init();
+	return ixp4xx_timer_setup(IXP4XX_TIMER_BASE_PHYS,
+				  IRQ_IXP4XX_TIMER1,
+				  IXP4XX_TIMER_FREQ);
 }
 
 static struct pxa2xx_udc_mach_info ixp4xx_udc_info;
@@ -251,112 +210,8 @@ void __init ixp4xx_sys_init(void)
 			ixp4xx_exp_bus_size >> 20);
 }
 
-/*
- * sched_clock()
- */
-static u64 notrace ixp4xx_read_sched_clock(void)
-{
-	return *IXP4XX_OSTS;
-}
-
-/*
- * clocksource
- */
-
-static u64 ixp4xx_clocksource_read(struct clocksource *c)
-{
-	return *IXP4XX_OSTS;
-}
-
 unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
-static void __init ixp4xx_clocksource_init(void)
-{
-	sched_clock_register(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
-
-	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
-			ixp4xx_clocksource_read);
-}
-
-/*
- * clockevents
- */
-static int ixp4xx_set_next_event(unsigned long evt,
-				 struct clock_event_device *unused)
-{
-	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
-
-	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | opts;
-
-	return 0;
-}
-
-static int ixp4xx_shutdown(struct clock_event_device *evt)
-{
-	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
-	unsigned long osrt = *IXP4XX_OSRT1 & ~IXP4XX_OST_RELOAD_MASK;
-
-	opts &= ~IXP4XX_OST_ENABLE;
-	*IXP4XX_OSRT1 = osrt | opts;
-	return 0;
-}
-
-static int ixp4xx_set_oneshot(struct clock_event_device *evt)
-{
-	unsigned long opts = IXP4XX_OST_ENABLE | IXP4XX_OST_ONE_SHOT;
-	unsigned long osrt = 0;
-
-	/* period set by 'set next_event' */
-	*IXP4XX_OSRT1 = osrt | opts;
-	return 0;
-}
-
-static int ixp4xx_set_periodic(struct clock_event_device *evt)
-{
-	unsigned long opts = IXP4XX_OST_ENABLE;
-	unsigned long osrt = IXP4XX_LATCH & ~IXP4XX_OST_RELOAD_MASK;
-
-	*IXP4XX_OSRT1 = osrt | opts;
-	return 0;
-}
-
-static int ixp4xx_resume(struct clock_event_device *evt)
-{
-	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
-	unsigned long osrt = *IXP4XX_OSRT1 & ~IXP4XX_OST_RELOAD_MASK;
-
-	opts |= IXP4XX_OST_ENABLE;
-	*IXP4XX_OSRT1 = osrt | opts;
-	return 0;
-}
-
-static struct clock_event_device clockevent_ixp4xx = {
-	.name			= "ixp4xx timer1",
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.rating			= 200,
-	.set_state_shutdown	= ixp4xx_shutdown,
-	.set_state_periodic	= ixp4xx_set_periodic,
-	.set_state_oneshot	= ixp4xx_set_oneshot,
-	.tick_resume		= ixp4xx_resume,
-	.set_next_event		= ixp4xx_set_next_event,
-};
-
-static void __init ixp4xx_clockevent_init(void)
-{
-	int ret;
-
-	clockevent_ixp4xx.cpumask = cpumask_of(0);
-	clockevent_ixp4xx.irq = IRQ_IXP4XX_TIMER1;
-	ret = request_irq(IRQ_IXP4XX_TIMER1, ixp4xx_timer_interrupt,
-			  IRQF_TIMER, "IXP4XX-TIMER1", &clockevent_ixp4xx);
-	if (ret) {
-		pr_crit("no timer IRQ\n");
-		return;
-	}
-	clockevents_config_and_register(&clockevent_ixp4xx, IXP4XX_TIMER_FREQ,
-					0xf, 0xfffffffe);
-}
 
 void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
