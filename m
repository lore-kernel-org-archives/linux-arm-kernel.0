Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C664C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:02:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAA320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCxO7t33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAA320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g/8xWFKBKjnem6XJ5SDag5Z2wh1maM6eOjgc3rCrpYY=; b=uCxO7t33j6P19Q
	Z+iX6Am2+xmROrSXn+KClN9kkqm8NZfBidRhH2LNjwtT5GckGpZ+lOdl3gSdyrhcMTjD83/Q/Z0t2
	okw4d18t2N67f4NLzCf+UxGqK6mhf4UyEBSyxZ9ZlC7LTnAW+MCxjcRof0t53ey5zCkw6kWnPzwi8
	uSeP3DCT+vYUQwV7NveRQwHBWL1g9uaeW7mD1srNnvx2b/k2FJwEMBCVjrFR5UW+lTZ4vzDtl7oDO
	FNeRdFm3JP7VmAivlgee9c4MeTOjK3qdJl8B6PKKmPFc6EwvCs8NtISI7rabHtSiebhiUKBIYej17
	OD7wV46KmB+14JvU3q9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQot-0002hc-Np; Mon, 10 Dec 2018 19:02:19 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQoq-0002gm-3o
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:02:18 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 2896B6732D; Mon, 10 Dec 2018 20:02:00 +0100 (CET)
Date: Mon, 10 Dec 2018 20:02:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: dma_declare_coherent_memory on main memory
Message-ID: <20181210190159.GA30648@lst.de>
References: <20181207153432.GA24917@lst.de>
 <20181210072648.ore6xttedsgpndi4@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210072648.ore6xttedsgpndi4@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_110216_451430_03437E74 
X-CRM114-Status: GOOD (  21.20  )
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
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 08:26:48AM +0100, Sascha Hauer wrote:
> > the ARM imx27/31 ports and various sh boards use
> > dma_declare_coherent_memory on main memory taken from the memblock
> > allocator.
> > 
> > Is there any good reason these couldn't be switched to CMA areas?
> > Getting rid of these magic dma_declare_coherent_memory area would
> > help making the dma allocator a lot simpler.
> 
> At least for i.MX27/31 I'd say this predates CMA support, so historical
> reasons.

Ok.  Do you still have test hardware for i.MX?  If so I'd love to see
if the patch below works.  Note that this is the brute force approach,
just having a global CMA pool might be a little more elegant.

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 8661dd9b064a..88852e7e5e7e 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -185,3 +185,5 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
+CONFIG_CMA=y
+CONFIG_DMA_CMA=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1ad5736c8fa6..16c8d717316c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -444,3 +444,5 @@ CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
+CONFIG_CMA=y
+CONFIG_DMA_CMA=y
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 5169dfba9718..2339a50d5459 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cma.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
@@ -35,6 +36,7 @@
 #include <linux/platform_data/asoc-mx27vis.h>
 #include <media/soc_camera.h>
 #include <sound/tlv320aic32x4.h>
+#include <asm/dma-contiguous.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -245,6 +247,7 @@ static phys_addr_t mx2_camera_base __initdata;
 static void __init visstrim_analog_camera_init(void)
 {
 	struct platform_device *pdev;
+	struct cma *cma;
 
 	gpio_set_value(TVP5150_PWDN, 1);
 	ndelay(1);
@@ -257,9 +260,10 @@ static void __init visstrim_analog_camera_init(void)
 	if (IS_ERR(pdev))
 		return;
 
-	dma_declare_coherent_memory(&pdev->dev, mx2_camera_base,
-				    mx2_camera_base, MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+	if (cma_init_reserved_mem(mx2_camera_base, MX2_CAMERA_BUF_SIZE, 0,
+			"visstrim-cam", &cma))
+		return;
+	dma_contiguous_early_fixup(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
 }
 
 static void __init visstrim_reserve(void)
@@ -440,13 +444,16 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 static void __init visstrim_coda_init(void)
 {
 	struct platform_device *pdev;
+	struct cma *cma;
 
 	pdev = imx27_add_coda();
-	dma_declare_coherent_memory(&pdev->dev,
-				    mx2_camera_base + MX2_CAMERA_BUF_SIZE,
-				    mx2_camera_base + MX2_CAMERA_BUF_SIZE,
-				    MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+	if (IS_ERR(pdev))
+		return;
+	if (cma_init_reserved_mem(mx2_camera_base + MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE, 0, "visstrim-coda", &cma))
+		return;
+	dma_contiguous_early_fixup(mx2_camera_base + MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE);
 }
 
 /* DMA deinterlace */
@@ -459,21 +466,22 @@ static void __init visstrim_deinterlace_init(void)
 {
 	int ret = -ENOMEM;
 	struct platform_device *pdev = &visstrim_deinterlace;
+	struct cma *cma;
 
 	ret = platform_device_register(pdev);
 
-	dma_declare_coherent_memory(&pdev->dev,
-				    mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
-				    mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
-				    MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+	if (cma_init_reserved_mem(mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE, 0, "visstrim-deinterlace", &cma))
+		return;
+	dma_contiguous_early_fixup(mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE);
 }
 
 /* Emma-PrP for format conversion */
 static void __init visstrim_emmaprp_init(void)
 {
 	struct platform_device *pdev;
-	int ret;
+	struct cma *cma;
 
 	pdev = imx27_add_mx2_emmaprp();
 	if (IS_ERR(pdev))
@@ -483,12 +491,12 @@ static void __init visstrim_emmaprp_init(void)
 	 * Use the same memory area as the analog camera since both
 	 * devices are, by nature, exclusive.
 	 */
-	ret = dma_declare_coherent_memory(&pdev->dev,
-				mx2_camera_base, mx2_camera_base,
-				MX2_CAMERA_BUF_SIZE,
-				DMA_MEMORY_EXCLUSIVE);
-	if (ret)
+	if (cma_init_reserved_mem(mx2_camera_base, MX2_CAMERA_BUF_SIZE, 0,
+			"visstrim-emmaprp", &cma)) {
 		pr_err("Failed to declare memory for emmaprp\n");
+		return;
+	}
+	dma_contiguous_early_fixup(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
 }
 
 /* Audio */
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 643a3d749703..1c0705ec0ccd 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/cma.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
 #include <linux/gpio.h>
@@ -37,6 +38,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
+#include <asm/dma-contiguous.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -466,6 +468,7 @@ static int __init mx31moboard_init_cam(void)
 {
 	int ret;
 	struct platform_device *pdev;
+	struct cma *cma;
 
 	imx31_add_ipu_core();
 
@@ -473,18 +476,18 @@ static int __init mx31moboard_init_cam(void)
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
-	ret = dma_declare_coherent_memory(&pdev->dev,
-					  mx3_camera_base, mx3_camera_base,
-					  MX3_CAMERA_BUF_SIZE,
-					  DMA_MEMORY_EXCLUSIVE);
+	ret = cma_init_reserved_mem(mx3_camera_base, MX3_CAMERA_BUF_SIZE, 0,
+			"mx31cam", &cma);
 	if (ret)
-		goto err;
+		goto out_device_put;
+	dma_contiguous_early_fixup(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
 
 	ret = platform_device_add(pdev);
 	if (ret)
-err:
-		platform_device_put(pdev);
-
+		goto out_device_put;
+	return 0;
+out_device_put:
+	platform_device_put(pdev);
 	return ret;
 
 }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
