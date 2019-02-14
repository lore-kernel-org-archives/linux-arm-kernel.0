Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52750C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2C5222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gjAatZX5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yzUxjsg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2C5222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c0plHwRJifhltmv6wdim9fQx91t31OXu+eFILJFtFn0=; b=gjAatZX5cW6aTt
	O87lT8/KBymln2p2L6vxjEXD1ND1saJ3/6F8bf/wWbeNUUo98YWODKKE6wRenW47X74+lDIjhLBAG
	tb2tqYMao57r3ENbmDJkZhbMfs8MzQm61eP6bA0Ft/h8jER5LdWWA1JAiYdaJozsW5H2ATvqVg2Ml
	KDoJt64xDWWbIscfsvhV+c0eT/DlDVJGKfZ53jDQ+ihO0hpWU1QYrdc80mqmi7MTllLbHOKFb25Fo
	aIu1+S8m+WmPrvHZVMdvGVWNsWuJiiKV2p3k1/PlU3cXgY6tnDFJt6hUaI2dSpqVCSdkcsxyTUmcF
	6RHrnDGIouFeX3SmhVDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIPO-0006t1-0y; Thu, 14 Feb 2019 14:54:38 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINl-000512-Gt
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:06 +0000
Received: by mail-wm1-x343.google.com with SMTP id x7so6563507wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u9dKzUN0x8BEK+hLj1N43VcW29DmtNXABd9m5s3FHFI=;
 b=yzUxjsg0PXCLM6f2MQmdG9tMyhaiz6TXLaALYvv5xJu/+2Jf1D+qiY/WxYs9O27nmn
 J6MVULBtZkIq3TFTwgSkiSWvZMBiM6/oPD0rdtxmvBqHIDNqIET8bYMIz0pHPVTkVEiS
 dOg6TCvveuvTzTX4S1jAShMtOwLGE3nj43Gl9Z23DxOGa+LVAj1cSIKyXOCCPGfd89sT
 Nl94OYUKJDh4No4lK2cEZucjbLlGSZ1Ntu8nL+NKWgDIqUT7EuzzpUfSFD/CYxuB57W/
 qjpxlRtL68XtJEr4xgjSMS0SSyWWeGKNxnCYhjHcc/XuUuII24n03t0WD7WKe6qBNeAv
 yUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u9dKzUN0x8BEK+hLj1N43VcW29DmtNXABd9m5s3FHFI=;
 b=NngWqJV0rtPZFjgePrar/CmTAWONRv9P9a2Aasrcct2glt5QUY4swGkkN8nkDFYKYM
 fqgcHfwN+xQh5MxocjsXL+1Oz2dmCMvUUsvlqyrx7e5BjiW7D6zuVVDEgaTWw/cpu8aU
 i6usNO9FOA14M2aUTuLpebnrVH3TnR92kj4sou5mjjiY3KNR2kDSZ0Qypj0mHGdWdFyj
 ZaPBDje3keIWmBZJPdgtlo18e64LBQ7Xu36buYpfMmCZTxWJd0mQ9uhjP5iFMuTwnZ9u
 ZrnXsmbehJuZFIQ4ECVPX+BJVaZqGjvBVQkNaRRjvUBBvFMCtc75SMRglq38V7QvoB6Y
 BOPA==
X-Gm-Message-State: AHQUAub4UP+NE2B8cujhsBoleWMPN6BDxzbsYkxYS/E4KI1BG1dNXX2P
 nXm9OQrQiTIX6pzLad4aspBMGA==
X-Google-Smtp-Source: AHgI3IYR+SXRf9TzAeOX2bGGhgWchFh/KpSjG36EntHwvVCiC9YHGIhIwAW0Y+zeKfLh6ApRNzN8yg==
X-Received: by 2002:a1c:2856:: with SMTP id o83mr3272724wmo.45.1550155976136; 
 Thu, 14 Feb 2019 06:52:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 11/37] ARM: davinci: aintc: wrap davinci_irq_init() with a
 helper
Date: Thu, 14 Feb 2019 15:52:05 +0100
Message-Id: <20190214145231.8750-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065258_023045_C68CEFA5 
X-CRM114-Status: GOOD (  14.56  )
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

We're going to extend the davinci_irq_init() function with a config
structure so we can drop the intc-related fields from davinci_soc_info.

Once we do it, we won't be able to use this routine directly as the
init_irq callback. Wrap the calls in additional helpers that don't
take parameters and can be assigned to init_irq.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     | 2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c | 2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    | 2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    | 4 ++--
 arch/arm/mach-davinci/board-neuros-osd2.c   | 2 +-
 arch/arm/mach-davinci/board-sffsdr.c        | 2 +-
 arch/arm/mach-davinci/davinci.h             | 4 ++++
 arch/arm/mach-davinci/dm355.c               | 5 +++++
 arch/arm/mach-davinci/dm365.c               | 5 +++++
 arch/arm/mach-davinci/dm644x.c              | 5 +++++
 arch/arm/mach-davinci/dm646x.c              | 5 +++++
 12 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f7fa960c23e3..64d81fc86f14 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -438,7 +438,7 @@ static __init void dm355_evm_init(void)
 MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.atag_offset  = 0x100,
 	.map_io	      = dm355_evm_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm355_init_irq,
 	.init_time	= dm355_init_time,
 	.init_machine = dm355_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 0fdf1d03eb11..b9e9950dd300 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -273,7 +273,7 @@ static __init void dm355_leopard_init(void)
 MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.atag_offset  = 0x100,
 	.map_io	      = dm355_leopard_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm355_init_irq,
 	.init_time	= dm355_init_time,
 	.init_machine = dm355_leopard_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e3b0b701e395..8a53e4c7944d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -834,7 +834,7 @@ static __init void dm365_evm_init(void)
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.atag_offset	= 0x100,
 	.map_io		= dm365_evm_map_io,
-	.init_irq	= davinci_irq_init,
+	.init_irq	= dm365_init_irq,
 	.init_time	= dm365_init_time,
 	.init_machine	= dm365_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index a6bc48c9ecd9..e7a6e2d1fcd9 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -891,7 +891,7 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	/* Maintainer: MontaVista Software <source@mvista.com> */
 	.atag_offset  = 0x100,
 	.map_io	      = davinci_evm_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm644x_init_irq,
 	.init_time	= dm644x_init_time,
 	.init_machine = davinci_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 26c123f35350..21d92d3c10ec 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -864,7 +864,7 @@ static __init void evm_init(void)
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm646x_init_irq,
 	.init_time	= dm646x_evm_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
@@ -874,7 +874,7 @@ MACHINE_END
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm646x_init_irq,
 	.init_time	= dm6467t_evm_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index efdaa27241c5..ce99f782811a 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -231,7 +231,7 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	/* Maintainer: Neuros Technologies <neuros@groups.google.com> */
 	.atag_offset	= 0x100,
 	.map_io		 = davinci_ntosd2_map_io,
-	.init_irq	= davinci_irq_init,
+	.init_irq	= dm644x_init_irq,
 	.init_time	= dm644x_init_time,
 	.init_machine = davinci_ntosd2_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 792bb84d5011..91f594f96189 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -153,7 +153,7 @@ static __init void davinci_sffsdr_init(void)
 MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.atag_offset  = 0x100,
 	.map_io	      = davinci_sffsdr_map_io,
-	.init_irq     = davinci_irq_init,
+	.init_irq     = dm644x_init_irq,
 	.init_time	= dm644x_init_time,
 	.init_machine = davinci_sffsdr_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index db4c95ef4d5c..56c1835c42e5 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -88,6 +88,7 @@ int davinci_init_wdt(void);
 /* DM355 function declarations */
 void dm355_init(void);
 void dm355_init_time(void);
+void dm355_init_irq(void);
 void dm355_register_clocks(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		const struct spi_board_info *info, unsigned len);
@@ -97,6 +98,7 @@ int dm355_gpio_register(void);
 
 /* DM365 function declarations */
 void dm365_init(void);
+void dm365_init_irq(void);
 void dm365_init_time(void);
 void dm365_register_clocks(void);
 void dm365_init_asp(void);
@@ -110,6 +112,7 @@ int dm365_gpio_register(void);
 
 /* DM644x function declarations */
 void dm644x_init(void);
+void dm644x_init_irq(void);
 void dm644x_init_devices(void);
 void dm644x_init_time(void);
 void dm644x_register_clocks(void);
@@ -119,6 +122,7 @@ int dm644x_gpio_register(void);
 
 /* DM646x function declarations */
 void dm646x_init(void);
+void dm646x_init_irq(void);
 void dm646x_init_time(unsigned long ref_clk_rate, unsigned long aux_clkin_rate);
 void dm646x_register_clocks(void);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index b27ea4fc1d51..6c65699cb074 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -792,6 +792,11 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+void __init dm355_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 static int __init dm355_init_devices(void)
 {
 	struct platform_device *edma_pdev;
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index d9c6ab9215a6..e1c223c6031f 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1051,6 +1051,11 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+void __init dm365_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 static int __init dm365_init_devices(void)
 {
 	struct platform_device *edma_pdev;
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b2748c82b747..2b18c134ee15 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -728,6 +728,11 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+void __init dm644x_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 void __init dm644x_init_devices(void)
 {
 	struct platform_device *edma_pdev;
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index cf210741dfe5..75a9f80317ca 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -689,6 +689,11 @@ void __init dm646x_register_clocks(void)
 	platform_device_register(&dm646x_pll2_device);
 }
 
+void __init dm646x_init_irq(void)
+{
+	davinci_irq_init();
+}
+
 static int __init dm646x_init_devices(void)
 {
 	int ret = 0;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
