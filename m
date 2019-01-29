Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE1E2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDwRV+Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE1E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d+7/0ulcskQM2w27bvISejgR2FeDr8olJHAEJpiFANE=; b=mDwRV+QwOsaTjY
	2WW+Lz2UI+800aj06IasJwCISQOR6RehTDSJMkOrs/CW+xEQI7edj+G564ZVNLAFmUQee3nI7Gq/C
	wPGTz7baJUuKDU/oYqB1y3Wv/uTnhBI2XAYX+1Uvq45loMWzeVgWj66fid3AZXrQJMIJMWOiwIeIw
	ucO0V6+x2k/R3G43kCWJZ5Pj2fsZ4F1OUGtc+sMwyA03OXpEn1Bo3OPS5Jq5anvinovaqDmhLlTfX
	41+JoyNYh0GwSSGfO06RgftKiT1WEsSfoUHzNdaUt5w4i08TaPNo4O5pkQW4YO7M735gX41XJ4/K+
	wivT2xBfSDIsBT73kuAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYzS-0004k5-Kw; Tue, 29 Jan 2019 19:24:10 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwV-0001pt-KC
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:13 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 8716B43EF32;
 Tue, 29 Jan 2019 19:21:03 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 13/13] ARM: lpc32xx: remove platform data of ARM PL111 LCD
 controller
Date: Tue, 29 Jan 2019 21:20:49 +0200
Message-Id: <20190129192049.11223-14-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129192049.11223-1-vz@mleia.com>
References: <20190129192049.11223-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192103_572478_FA6292C2 
X-CRM114-Status: GOOD (  14.37  )
/bin/ln: failed to access
 'reaver_cache/texts/20190129_192103_572478_FA6292C2': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192103_572478_FA6292C2 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The auxilary platform data added for the LCD controller is not needed
anymore, because the controller and a connected panel are properly
described in Phytec phyCORE-LPC3250 board dts file.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-lpc32xx/phy3250.c | 77 ---------------------------------
 1 file changed, 77 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 568589e918c2..b3be60a8e467 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -45,73 +45,6 @@
 #include <mach/board.h>
 #include "common.h"
 
-/*
- * AMBA LCD controller
- */
-static struct clcd_panel conn_lcd_panel = {
-	.mode		= {
-		.name		= "QVGA portrait",
-		.refresh	= 60,
-		.xres		= 240,
-		.yres		= 320,
-		.pixclock	= 191828,
-		.left_margin	= 22,
-		.right_margin	= 11,
-		.upper_margin	= 2,
-		.lower_margin	= 1,
-		.hsync_len	= 5,
-		.vsync_len	= 2,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= (TIM2_IVS | TIM2_IHS),
-	.cntl		= (CNTL_BGR | CNTL_LCDTFT | CNTL_LCDVCOMP(1) |
-				CNTL_LCDBPP16_565),
-	.bpp		= 16,
-};
-#define PANEL_SIZE (3 * SZ_64K)
-
-static int lpc32xx_clcd_setup(struct clcd_fb *fb)
-{
-	dma_addr_t dma;
-
-	fb->fb.screen_base = dma_alloc_wc(&fb->dev->dev, PANEL_SIZE, &dma,
-					  GFP_KERNEL);
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
-		return -ENOMEM;
-	}
-
-	fb->fb.fix.smem_start = dma;
-	fb->fb.fix.smem_len = PANEL_SIZE;
-	fb->panel = &conn_lcd_panel;
-
-	return 0;
-}
-
-static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
-			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
-}
-
-static void lpc32xx_clcd_remove(struct clcd_fb *fb)
-{
-	dma_free_wc(&fb->dev->dev, fb->fb.fix.smem_len, fb->fb.screen_base,
-		    fb->fb.fix.smem_start);
-}
-
-static struct clcd_board lpc32xx_clcd_data = {
-	.name		= "Phytec LCD",
-	.check		= clcdfb_check,
-	.decode		= clcdfb_decode,
-	.setup		= lpc32xx_clcd_setup,
-	.mmap		= lpc32xx_clcd_mmap,
-	.remove		= lpc32xx_clcd_remove,
-};
-
 static struct pl08x_channel_data pl08x_slave_channels[] = {
 	{
 		.bus_id = "nand-slc",
@@ -159,7 +92,6 @@ static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
 static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", NULL),
 	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", NULL),
-	OF_DEV_AUXDATA("arm,pl110", 0x31040000, "dev:clcd", &lpc32xx_clcd_data),
 	OF_DEV_AUXDATA("arm,pl080", 0x31000000, "pl08xdmac", &pl08x_pd),
 	OF_DEV_AUXDATA("nxp,lpc3220-slc", 0x20020000, "20020000.flash",
 		       &lpc32xx_slc_data),
@@ -170,15 +102,6 @@ static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
 
 static void __init lpc3250_machine_init(void)
 {
-	u32 tmp;
-
-	/* Setup LCD muxing to RGB565 */
-	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL) &
-		~(LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_MSK |
-		LPC32XX_CLKPWR_LCDCTRL_PSCALE_MSK);
-	tmp |= LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT16;
-	__raw_writel(tmp, LPC32XX_CLKPWR_LCDCLK_CTRL);
-
 	lpc32xx_serial_init();
 
 	/* Test clock needed for UDA1380 initial init */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
