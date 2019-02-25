Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9492213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mQE/p2li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9492213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AYbtny12fHOB4YluPr52OlFkv0r5/QZDcwa0R6XOgn8=; b=mQE/p2liTMoQbl
	MJnXkADDD7vdSjzUMfBHk1zG73WkUvFOfVUjY0yEOTKxV69uQ52lwIkYu5bYnUcRet0lDSGuX87R0
	n0fw8zQRRf/7/LFFa3mZv5HJS9OkAl8YeCwDitsjyRWZIx0Fwv/FvqUyQODMpuL1P+Rd2mcZ0K609
	UtZVzAQx1B2fcLwjqxHrXSI8HrzO8V5Xp0sD9iLw2e5I4UC7XsuksJ2SzdcyoUCT3sHhWHcHOOra9
	PIJcdIT8QCIkBigZMvjaECoPWXqyGh5oMNH84417ldIEQYcyReCa6IDFx8qUQYOXppvDRleCE+86v
	itgFGUZc6sH8cLSoKkxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyNl4-0000X5-5z; Mon, 25 Feb 2019 21:25:54 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyNkx-0000P4-Ox
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 21:25:51 +0000
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id F1E1D60007;
 Mon, 25 Feb 2019 21:25:35 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data support
Date: Mon, 25 Feb 2019 22:25:33 +0100
Message-Id: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_132548_107691_5AAFC9E3 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: linux-fbdev@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make the driver OF only as since AVR32 has been removed from the kernel,
there are only OF enabled platform using it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/video/fbdev/Kconfig       |   6 +-
 drivers/video/fbdev/atmel_lcdfb.c | 114 ++----------------------------
 2 files changed, 7 insertions(+), 113 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ae7712c9687a..f0f07d02af88 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -866,8 +866,8 @@ config FB_S1D13XXX
 	  <http://vdc.epson.com/>
 
 config FB_ATMEL
-	tristate "AT91/AT32 LCD Controller support"
-	depends on FB && HAVE_FB_ATMEL
+	tristate "AT91 LCD Controller support"
+	depends on FB && OF && HAVE_FB_ATMEL
 	select FB_BACKLIGHT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -875,7 +875,7 @@ config FB_ATMEL
 	select FB_MODE_HELPERS
 	select VIDEOMODE_HELPERS
 	help
-	  This enables support for the AT91/AT32 LCD Controller.
+	  This enables support for the AT91 LCD Controller.
 
 config FB_NVIDIA
 	tristate "nVidia Framebuffer Support"
diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 4ed55e6bbb84..b8786ff62b87 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1,5 +1,5 @@
 /*
- *  Driver for AT91/AT32 LCD Controller
+ *  Driver for AT91 LCD Controller
  *
  *  Copyright (C) 2007 Atmel Corporation
  *
@@ -99,86 +99,6 @@ static struct atmel_lcdfb_config at91sam9rl_config = {
 	.have_intensity_bit	= true,
 };
 
-static struct atmel_lcdfb_config at32ap_config = {
-	.have_hozval		= true,
-};
-
-static const struct platform_device_id atmel_lcdfb_devtypes[] = {
-	{
-		.name = "at91sam9261-lcdfb",
-		.driver_data = (unsigned long)&at91sam9261_config,
-	}, {
-		.name = "at91sam9263-lcdfb",
-		.driver_data = (unsigned long)&at91sam9263_config,
-	}, {
-		.name = "at91sam9g10-lcdfb",
-		.driver_data = (unsigned long)&at91sam9g10_config,
-	}, {
-		.name = "at91sam9g45-lcdfb",
-		.driver_data = (unsigned long)&at91sam9g45_config,
-	}, {
-		.name = "at91sam9g45es-lcdfb",
-		.driver_data = (unsigned long)&at91sam9g45es_config,
-	}, {
-		.name = "at91sam9rl-lcdfb",
-		.driver_data = (unsigned long)&at91sam9rl_config,
-	}, {
-		.name = "at32ap-lcdfb",
-		.driver_data = (unsigned long)&at32ap_config,
-	}, {
-		/* terminator */
-	}
-};
-MODULE_DEVICE_TABLE(platform, atmel_lcdfb_devtypes);
-
-static struct atmel_lcdfb_config *
-atmel_lcdfb_get_config(struct platform_device *pdev)
-{
-	unsigned long data;
-
-	data = platform_get_device_id(pdev)->driver_data;
-
-	return (struct atmel_lcdfb_config *)data;
-}
-
-#if defined(CONFIG_ARCH_AT91)
-#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
-					 | FBINFO_PARTIAL_PAN_OK \
-					 | FBINFO_HWACCEL_YPAN)
-
-static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
-					struct fb_var_screeninfo *var,
-					struct fb_info *info)
-{
-
-}
-#elif defined(CONFIG_AVR32)
-#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
-					| FBINFO_PARTIAL_PAN_OK \
-					| FBINFO_HWACCEL_XPAN \
-					| FBINFO_HWACCEL_YPAN)
-
-static void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
-				     struct fb_var_screeninfo *var,
-				     struct fb_info *info)
-{
-	u32 dma2dcfg;
-	u32 pixeloff;
-
-	pixeloff = (var->xoffset * info->var.bits_per_pixel) & 0x1f;
-
-	dma2dcfg = (info->var.xres_virtual - info->var.xres)
-		 * info->var.bits_per_pixel / 8;
-	dma2dcfg |= pixeloff << ATMEL_LCDC_PIXELOFF_OFFSET;
-	lcdc_writel(sinfo, ATMEL_LCDC_DMA2DCFG, dma2dcfg);
-
-	/* Update configuration */
-	lcdc_writel(sinfo, ATMEL_LCDC_DMACON,
-		    lcdc_readl(sinfo, ATMEL_LCDC_DMACON)
-		    | ATMEL_LCDC_DMAUPDT);
-}
-#endif
-
 static u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
 		| ATMEL_LCDC_POL_POSITIVE
 		| ATMEL_LCDC_ENA_PWMENABLE;
@@ -404,8 +324,6 @@ static void atmel_lcdfb_update_dma(struct fb_info *info,
 
 	/* Set framebuffer DMA base address and pixel offset */
 	lcdc_writel(sinfo, ATMEL_LCDC_DMABADDR1, dma_addr);
-
-	atmel_lcdfb_update_dma2d(sinfo, var, info);
 }
 
 static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info *sinfo)
@@ -978,7 +896,6 @@ static void atmel_lcdfb_stop_clock(struct atmel_lcdfb_info *sinfo)
 	clk_disable_unprepare(sinfo->lcdc_clk);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id atmel_lcdfb_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9261-lcdc" , .data = &at91sam9261_config, },
 	{ .compatible = "atmel,at91sam9263-lcdc" , .data = &at91sam9263_config, },
@@ -986,7 +903,6 @@ static const struct of_device_id atmel_lcdfb_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9g45-lcdc" , .data = &at91sam9g45_config, },
 	{ .compatible = "atmel,at91sam9g45es-lcdc" , .data = &at91sam9g45es_config, },
 	{ .compatible = "atmel,at91sam9rl-lcdc" , .data = &at91sam9rl_config, },
-	{ .compatible = "atmel,at32ap-lcdc" , .data = &at32ap_config, },
 	{ /* sentinel */ }
 };
 
@@ -1122,19 +1038,12 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	of_node_put(display_np);
 	return ret;
 }
-#else
-static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
-{
-	return 0;
-}
-#endif
 
 static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fb_info *info;
 	struct atmel_lcdfb_info *sinfo;
-	struct atmel_lcdfb_pdata *pdata = NULL;
 	struct resource *regs = NULL;
 	struct resource *map = NULL;
 	struct fb_modelist *modelist;
@@ -1159,21 +1068,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 		ret = atmel_lcdfb_of_init(sinfo);
 		if (ret)
 			goto free_info;
-	} else if (dev_get_platdata(dev)) {
-		struct fb_monspecs *monspecs;
-		int i;
-
-		pdata = dev_get_platdata(dev);
-		monspecs = pdata->default_monspecs;
-		sinfo->pdata = *pdata;
-
-		for (i = 0; i < monspecs->modedb_len; i++)
-			fb_add_videomode(&monspecs->modedb[i], &info->modelist);
-
-		sinfo->config = atmel_lcdfb_get_config(pdev);
-
-		info->var.bits_per_pixel = pdata->default_bpp ? pdata->default_bpp : 16;
-		memcpy(&info->monspecs, pdata->default_monspecs, sizeof(info->monspecs));
 	} else {
 		dev_err(dev, "cannot get default configuration\n");
 		goto free_info;
@@ -1186,7 +1080,8 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	if (IS_ERR(sinfo->reg_lcd))
 		sinfo->reg_lcd = NULL;
 
-	info->flags = ATMEL_LCDFB_FBINFO_DEFAULT;
+	info->flags = FBINFO_DEFAULT | FBINFO_PARTIAL_PAN_OK |
+		      FBINFO_HWACCEL_YPAN;
 	info->pseudo_palette = sinfo->pseudo_palette;
 	info->fbops = &atmel_lcdfb_ops;
 
@@ -1435,7 +1330,6 @@ static struct platform_driver atmel_lcdfb_driver = {
 	.remove		= __exit_p(atmel_lcdfb_remove),
 	.suspend	= atmel_lcdfb_suspend,
 	.resume		= atmel_lcdfb_resume,
-	.id_table	= atmel_lcdfb_devtypes,
 	.driver		= {
 		.name	= "atmel_lcdfb",
 		.of_match_table	= of_match_ptr(atmel_lcdfb_dt_ids),
@@ -1444,6 +1338,6 @@ static struct platform_driver atmel_lcdfb_driver = {
 
 module_platform_driver_probe(atmel_lcdfb_driver, atmel_lcdfb_probe);
 
-MODULE_DESCRIPTION("AT91/AT32 LCD Controller framebuffer driver");
+MODULE_DESCRIPTION("AT91 LCD Controller framebuffer driver");
 MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
 MODULE_LICENSE("GPL");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
