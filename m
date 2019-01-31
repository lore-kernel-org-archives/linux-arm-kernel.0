Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAB4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:46:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC782085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="errkCxKf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EtoOyzTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC782085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9k3PQbwuLWEOE52PShsgaQZvfeBydq3B5KjlzJMRWu8=; b=errkCxKfCtB0ir
	gPq8EI64W6VKfnGibQs9x510qf9f/1uXw7kEtPRrglAd9WwOeuIPF77xnbOGWNorvVKcOPEqeCEpv
	B4tLwpog6en6+44Hy9Vk/uPVeqhyQsPCYtDhid4ezaIVuQkNw+M1xs0FMA/jhGzVIbHNXwRgXwikD
	ok5TfFxen1obdNcn38IAiGCa48NkpJG3VNgPC6B33jHmy4xZiOKfZAclgdZRz0Iy596cv6CCskHEV
	8tuJBdZ50mEWhEuzpwKkMrJYPKryPXX2BMrHbhcDzdMECTkfFWOxVwAlLp7gE9FbOEpsxBqKNgr1k
	RzbViWzy4+88VkCkbkOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCgE-0003nD-3R; Thu, 31 Jan 2019 13:46:58 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZp-0005zm-NU
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:32 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so3372872wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=padNTKocuwwxGO42WDui/BONzRUERCjnTaS+UDD+SrU=;
 b=EtoOyzTwbuKA+RAbm57od7nekqOmEc6K+qso18grAMS7Via6T2XpJ0Dypz4V9ijr+g
 rJ9Mp0J8Zlu8/M/HrnKOUL2gn+ptW/n7Zofc795yllmcCdGvpLQxVb9g6vWp1yuoCss/
 0Ru82S3/E90ktmt+dIjw47WKkApQCcquz4xMkHTSBL/tr2r5VU7Y4Bmay/K012/NTZP9
 iG74NWD6rDMDUchkVM4ajXSHVayaD8xIX05SzDd/y+Ut9h50kQUM78g7mPU9juyTRYDC
 FEB7N8h+HZN3GGH7GdxIJCX6TLXgQ2rT5h7AMstq1rNKVteDc77FJtzFZ6l+TLlRvv3i
 uspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=padNTKocuwwxGO42WDui/BONzRUERCjnTaS+UDD+SrU=;
 b=iDSXh/e3DbGRVpcL2/dGjC+OBGOhvyOyPdNR8fYZKpfz22Kej/rxMnQVZvm2QI/d/C
 3z8yAoWmruw8Ulbfee5ZMVKYqW63dDthmYkjmQ/18GuBGRcCk3locroiPCG5j2E7RJeB
 vyWHK55+CaDxwoTPNj+YLB8AQLlQ0BIWaQ4pGeWfid2bHDBnXcANT1RcqMnmESA4tmeh
 eIXdVdQXkMxTcdV1sJ6VWeKJF1bF5/9KqRr1ene91l0JANINIqVJF9K4pGolk4Xw+W4X
 KgK4lz5CfPNRkpoJo5LwKwOCQam/Qy7HmvR3cv9TzKfQFGQsGPACFmjxtd+N8ozx7xGK
 P5uA==
X-Gm-Message-State: AJcUukfS4coO/23u17COkZiaW93bewdJnaksOgE53Q+KSjWiZt+TZhue
 ROnvi4f4E4dbezQqS68+An5IEw==
X-Google-Smtp-Source: ALg8bN7wgaBd0tavK1f4G8lbe1qLagkKsMfMhZ3uqdKElNKY/4c9GZQ/FY70qUsxMtqJHeXeVlmbXg==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr35334018wrw.34.1548942020343; 
 Thu, 31 Jan 2019 05:40:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:19 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 33/35] ARM: davinci: prepare to remove mach/irqs.h
Date: Thu, 31 Jan 2019 14:39:26 +0100
Message-Id: <20190131133928.17985-34-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054021_905564_8AAFC443 
X-CRM114-Status: GOOD (  16.83  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since we now select SPARSE_IRQ in davinci, the mach/irqs.h header is
no longer included from asm/irq.h. All interrupt numbers for devices
should be defined as platform device resources. Let's prepare for the
removal of mach/irqs.h by moving all defines that we want to keep to
relevant headers (davinci.h, common.h) and replacing others with
simple literals.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |  4 ++--
 arch/arm/mach-davinci/board-dm644x-evm.c    |  2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |  2 +-
 arch/arm/mach-davinci/da830.c               |  2 +-
 arch/arm/mach-davinci/da850.c               |  2 +-
 arch/arm/mach-davinci/davinci.h             |  2 ++
 arch/arm/mach-davinci/include/mach/common.h |  5 +++++
 arch/arm/mach-davinci/include/mach/irqs.h   | 18 ------------------
 9 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index b3a0148f7f1a..950e98e4eda5 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -488,7 +488,7 @@ static int da830_evm_ui_expander_teardown(struct i2c_client *client, int gpio,
 }
 
 static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
-	.gpio_base	= DAVINCI_N_GPIO,
+	.gpio_base	= 144,
 	.setup		= da830_evm_ui_expander_setup,
 	.teardown	= da830_evm_ui_expander_teardown,
 };
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index efc9a33da6e1..27acba6fe5f8 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -562,7 +562,7 @@ static int da850_evm_ui_expander_teardown(struct i2c_client *client,
 
 /* assign the baseboard expander's GPIOs after the UI board's */
 #define DA850_UI_EXPANDER_N_GPIOS ARRAY_SIZE(da850_evm_ui_exp)
-#define DA850_BB_EXPANDER_GPIO_BASE (DAVINCI_N_GPIO + DA850_UI_EXPANDER_N_GPIOS)
+#define DA850_BB_EXPANDER_GPIO_BASE (144 + DA850_UI_EXPANDER_N_GPIOS)
 
 enum da850_evm_bb_exp_pins {
 	DA850_EVM_BB_EXP_DEEP_SLEEP_EN = 0,
@@ -735,7 +735,7 @@ static int da850_evm_bb_expander_teardown(struct i2c_client *client,
 }
 
 static struct pca953x_platform_data da850_evm_ui_expander_info = {
-	.gpio_base	= DAVINCI_N_GPIO,
+	.gpio_base	= 144,
 	.setup		= da850_evm_ui_expander_setup,
 	.teardown	= da850_evm_ui_expander_teardown,
 	.names		= da850_evm_ui_exp,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index f23a29e5116f..d04ce0c206b6 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -310,7 +310,7 @@ static struct platform_device rtc_dev = {
  * I2C GPIO expanders
  */
 
-#define PCF_Uxx_BASE(x)	(DAVINCI_N_GPIO + ((x) * 8))
+#define PCF_Uxx_BASE(x)	(144 + ((x) * 8))
 
 
 /* U2 -- LEDs */
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index ebf07d92224e..2ddc03a95acd 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -333,7 +333,7 @@ static int evm_pcf_teardown(struct i2c_client *client, int gpio,
 }
 
 static struct pcf857x_platform_data pcf_data = {
-	.gpio_base	= DAVINCI_N_GPIO+1,
+	.gpio_base	= 145,
 	.setup		= evm_pcf_setup,
 	.teardown	= evm_pcf_teardown,
 };
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 9cf9b090efeb..74cbab153e59 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -730,7 +730,7 @@ static const struct davinci_cp_intc_config da830_cp_intc_config = {
 		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
 		.flags		= IORESOURCE_MEM,
 	},
-	.num_irqs		= DA830_N_CP_INTC_IRQ,
+	.num_irqs		= 96,
 };
 
 void __init da830_init_irqs(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b9ebdcde68eb..644f4eec8d5c 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -658,7 +658,7 @@ static const struct davinci_cp_intc_config da850_cp_intc_config = {
 		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
 		.flags		= IORESOURCE_MEM,
 	},
-	.num_irqs		= DA850_N_CP_INTC_IRQ,
+	.num_irqs		= 101,
 };
 
 void __init da850_init_irqs(void)
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 49958cc161d7..d5bffd3751f9 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -39,6 +39,8 @@
 #define DAVINCI_PLL2_BASE		0x01c40c00
 #define DAVINCI_PWR_SLEEP_CNTRL_BASE	0x01c41000
 
+#define DAVINCI_ARM_INTC_BASE		0x01c48000
+
 #define DAVINCI_SYSTEM_MODULE_BASE	0x01c40000
 #define SYSMOD_VDAC_CONFIG		0x2c
 #define SYSMOD_VIDCLKCTL		0x38
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 2b986d32049f..9526e5da0d33 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -17,6 +17,11 @@
 #include <linux/types.h>
 #include <linux/reboot.h>
 
+#include <asm/irq.h>
+
+#define DAVINCI_INTC_START		NR_IRQS
+#define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
+
 void davinci_timer_init(struct clk *clk);
 
 struct davinci_timer_instance {
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index 317cbc42e5cd..27c9f89f2a7f 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -29,12 +29,6 @@
 
 #include <asm/irq.h>
 
-/* Base address */
-#define DAVINCI_ARM_INTC_BASE 0x01C48000
-
-#define DAVINCI_INTC_START		NR_IRQS
-#define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
-
 /* Interrupt lines */
 #define IRQ_VDINT0       DAVINCI_INTC_IRQ(0)
 #define IRQ_VDINT1       DAVINCI_INTC_IRQ(1)
@@ -100,10 +94,6 @@
 #define IRQ_COMMRX       DAVINCI_INTC_IRQ(62)
 #define IRQ_EMUINT       DAVINCI_INTC_IRQ(63)
 
-#define DAVINCI_N_AINTC_IRQ	64
-
-#define ARCH_TIMER_IRQ IRQ_TINT1_TINT34
-
 /* DaVinci DM6467-specific Interrupts */
 #define IRQ_DM646X_VP_VERTINT0  DAVINCI_INTC_IRQ(0)
 #define IRQ_DM646X_VP_VERTINT1  DAVINCI_INTC_IRQ(1)
@@ -344,8 +334,6 @@
 #define IRQ_DA830_T12CMPINT6_1		DAVINCI_INTC_IRQ(88)
 #define IRQ_DA830_T12CMPINT7_1		DAVINCI_INTC_IRQ(89)
 
-#define DA830_N_CP_INTC_IRQ		96
-
 /* DA850 speicific interrupts */
 #define IRQ_DA850_MPUADDRERR0		DAVINCI_INTC_IRQ(27)
 #define IRQ_DA850_MPUPROTERR0		DAVINCI_INTC_IRQ(27)
@@ -401,10 +389,4 @@
 #define IRQ_DA850_MCBSP1RINT		DAVINCI_INTC_IRQ(99)
 #define IRQ_DA850_MCBSP1XINT		DAVINCI_INTC_IRQ(100)
 
-#define DA850_N_CP_INTC_IRQ		101
-
-/* da850 currently has the most gpio pins (144) */
-#define DAVINCI_N_GPIO			144
-/* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */
-
 #endif /* __ASM_ARCH_IRQS_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
