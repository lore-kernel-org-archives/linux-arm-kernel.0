Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00252177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FpXUvZIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00252177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ERt2aYwiE+lelLu4pIE3kqZCQhxfG6BmfenLpz+8yb4=; b=FpXUvZIS0/4IoV
	dkOxLAjWyoo+WR9hzrFX6m92/zhrIJOaopsGWBO6fGgXvOJ9i8gYYpbH55Z7eEnSXuj/qAKNXYD/+
	R6TVR6eOW2FBiR5J61Re8M983tS1KXDjhQYoTk7a+HrYyre2Z+9OulvGSSJezaYVSdQkklw4rLDlT
	V3O/gYmaUZhItb6C/71oX5/uVEV62qaFNh4mFx/pkb1TWvMoCGY9zeYzt/VR9P0/7VUNCw3gyLMMW
	/cBPivy4Zy068xSMR+7s6vOYI5V3+a0DTw3rNRtezjeMKPX8yFTVjwhWmjoxyWxDlU166jRgyQw7R
	oO4NFGOeNaLRifKj6gEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvobd-0002qA-3T; Mon, 18 Feb 2019 19:29:33 +0000
Received: from 177.96.194.24.dynamic.adsl.gvt.net.br ([177.96.194.24]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvobJ-0002Uv-Sc; Mon, 18 Feb 2019 19:29:14 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.91)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1gvobG-0006fv-B9; Mon, 18 Feb 2019 14:29:10 -0500
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: 
Subject: [PATCH 06/14] media: platform: fix several typos
Date: Mon, 18 Feb 2019 14:29:00 -0500
Message-Id: <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
References: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
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
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Heiko Stuebner <heiko@sntech.de>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Patrice Chotard <patrice.chotard@st.com>, Andrzej Hajda <a.hajda@samsung.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 linux-samsung-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Chen-Yu Tsai <wens@csie.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-rockchip@lists.infradead.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kamil Debski <kamil@wypas.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-msm@vger.kernel.org,
 Houlong Wei <houlong.wei@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Benoit Parrot <bparrot@ti.com>,
 Jeongtae Park <jtp.park@samsung.com>, linux-mediatek@lists.infradead.org,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Yong Deng <yong.deng@magewell.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Hugues Fruchet <hugues.fruchet@st.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, Hyun Kwon <hyun.kwon@xilinx.com>,
 Jacob chen <jacob2.chen@rock-chips.com>, linux-renesas-soc@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use codespell to fix lots of typos over frontends.

Manually verified to avoid false-positives.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/platform/Kconfig                     |  2 +-
 drivers/media/platform/atmel/atmel-isi.c           |  4 ++--
 drivers/media/platform/coda/coda-jpeg.c            |  2 +-
 drivers/media/platform/davinci/isif.c              |  4 ++--
 drivers/media/platform/davinci/vpbe.c              |  2 +-
 drivers/media/platform/davinci/vpif.c              |  2 +-
 drivers/media/platform/davinci/vpif_display.c      |  4 ++--
 .../media/platform/exynos4-is/fimc-is-command.h    |  2 +-
 drivers/media/platform/exynos4-is/fimc-is-param.h  |  2 +-
 drivers/media/platform/exynos4-is/media-dev.h      |  2 +-
 drivers/media/platform/exynos4-is/mipi-csis.c      |  4 ++--
 drivers/media/platform/marvell-ccic/mmp-driver.c   |  4 ++--
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h      |  6 +++---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c |  2 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  4 ++--
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  2 +-
 .../media/platform/mtk-vcodec/vdec/vdec_h264_if.c  |  4 ++--
 .../media/platform/mtk-vcodec/vdec/vdec_vp8_if.c   |  2 +-
 drivers/media/platform/mtk-vcodec/vdec_drv_if.h    |  2 +-
 drivers/media/platform/mtk-vcodec/vdec_vpu_if.h    |  2 +-
 drivers/media/platform/omap/omap_vout.c            |  4 ++--
 drivers/media/platform/omap/omap_voutdef.h         |  4 ++--
 drivers/media/platform/omap3isp/isp.c              |  2 +-
 drivers/media/platform/omap3isp/ispccdc.c          |  4 ++--
 drivers/media/platform/omap3isp/ispcsi2.c          |  2 +-
 drivers/media/platform/pxa_camera.c                |  2 +-
 drivers/media/platform/qcom/venus/core.h           |  2 +-
 drivers/media/platform/rcar-vin/rcar-dma.c         |  2 +-
 drivers/media/platform/rcar-vin/rcar-v4l2.c        |  4 ++--
 drivers/media/platform/rockchip/rga/rga-hw.c       |  6 +++---
 drivers/media/platform/s3c-camif/camif-core.h      |  2 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.h        |  4 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h    |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c      |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c       |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c    |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c    |  4 ++--
 .../media/platform/sti/c8sectpfe/c8sectpfe-core.h  |  2 +-
 drivers/media/platform/sti/delta/delta.h           |  2 +-
 drivers/media/platform/sti/hva/hva-h264.c          |  2 +-
 drivers/media/platform/stm32/stm32-dcmi.c          |  2 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |  2 +-
 drivers/media/platform/ti-vpe/vpdma.c              | 14 +++++++-------
 drivers/media/platform/ti-vpe/vpe.c                |  2 +-
 drivers/media/platform/vsp1/vsp1_brx.c             |  4 ++--
 drivers/media/platform/xilinx/xilinx-vip.c         |  2 +-
 46 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 6cff26b29a38..4acbed189644 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -668,7 +668,7 @@ menuconfig SDR_PLATFORM_DRIVERS
 if SDR_PLATFORM_DRIVERS
 
 config VIDEO_RCAR_DRIF
-	tristate "Renesas Digitial Radio Interface (DRIF)"
+	tristate "Renesas Digital Radio Interface (DRIF)"
 	depends on VIDEO_V4L2
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select VIDEOBUF2_VMALLOC
diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index fdb255e4a956..08b8d5583080 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -110,7 +110,7 @@ struct atmel_isi {
 	bool				enable_preview_path;
 
 	struct completion		complete;
-	/* ISI peripherial clock */
+	/* ISI peripheral clock */
 	struct clk			*pclk;
 	unsigned int			irq;
 
@@ -1078,7 +1078,7 @@ static void isi_graph_notify_unbind(struct v4l2_async_notifier *notifier,
 
 	dev_dbg(isi->dev, "Removing %s\n", video_device_node_name(isi->vdev));
 
-	/* Checks internaly if vdev have been init or not */
+	/* Checks internally if vdev have been init or not */
 	video_unregister_device(isi->vdev);
 }
 
diff --git a/drivers/media/platform/coda/coda-jpeg.c b/drivers/media/platform/coda/coda-jpeg.c
index 9f899a6cefed..39a2351c1e48 100644
--- a/drivers/media/platform/coda/coda-jpeg.c
+++ b/drivers/media/platform/coda/coda-jpeg.c
@@ -103,7 +103,7 @@ static const unsigned char chroma_ac_value[162 + 2] = {
 
 /*
  * Quantization tables for luminance and chrominance components in
- * zig-zag scan order from the Freescale i.MX VPU libaries
+ * zig-zag scan order from the Freescale i.MX VPU libraries
  */
 
 static unsigned char luma_q[64] = {
diff --git a/drivers/media/platform/davinci/isif.c b/drivers/media/platform/davinci/isif.c
index 340f8218f54d..47cecd10eb9f 100644
--- a/drivers/media/platform/davinci/isif.c
+++ b/drivers/media/platform/davinci/isif.c
@@ -328,7 +328,7 @@ static void isif_config_bclamp(struct isif_black_clamp *bc)
 	if (bc->en) {
 		val = bc->bc_mode_color << ISIF_BC_MODE_COLOR_SHIFT;
 
-		/* Enable BC and horizontal clamp caculation paramaters */
+		/* Enable BC and horizontal clamp calculation parameters */
 		val = val | 1 | (bc->horz.mode << ISIF_HORZ_BC_MODE_SHIFT);
 
 		regw(val, CLAMPCFG);
@@ -358,7 +358,7 @@ static void isif_config_bclamp(struct isif_black_clamp *bc)
 			regw(bc->horz.win_start_v_calc, CLHWIN2);
 		}
 
-		/* vertical clamp caculation paramaters */
+		/* vertical clamp calculation parameters */
 
 		/* Reset clamp value sel for previous line */
 		val |=
diff --git a/drivers/media/platform/davinci/vpbe.c b/drivers/media/platform/davinci/vpbe.c
index 4766a7a23d16..8339163a5231 100644
--- a/drivers/media/platform/davinci/vpbe.c
+++ b/drivers/media/platform/davinci/vpbe.c
@@ -242,7 +242,7 @@ static int vpbe_set_output(struct vpbe_device *vpbe_dev, int index)
 		goto unlock;
 
 	/*
-	 * It is assumed that venc or extenal encoder will set a default
+	 * It is assumed that venc or external encoder will set a default
 	 * mode in the sub device. For external encoder or LCD pannel output,
 	 * we also need to set up the lcd port for the required mode. So setup
 	 * the lcd port for the default mode that is configured in the board
diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index 16352e2263d2..df66461f5d4f 100644
--- a/drivers/media/platform/davinci/vpif.c
+++ b/drivers/media/platform/davinci/vpif.c
@@ -1,7 +1,7 @@
 /*
  * vpif - Video Port Interface driver
  * VPIF is a receiver and transmitter for video data. It has two channels(0, 1)
- * that receiveing video byte stream and two channels(2, 3) for video output.
+ * that receiving video byte stream and two channels(2, 3) for video output.
  * The hardware supports SDTV, HDTV formats, raw data capture.
  * Currently, the driver supports NTSC and PAL standards.
  *
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index 3517487d9760..f4b4f2a1dfc0 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -138,7 +138,7 @@ static int vpif_buffer_queue_setup(struct vb2_queue *vq,
  * vpif_buffer_queue : Callback function to add buffer to DMA queue
  * @vb: ptr to vb2_buffer
  *
- * This callback fucntion queues the buffer to DMA engine
+ * This callback function queues the buffer to DMA engine
  */
 static void vpif_buffer_queue(struct vb2_buffer *vb)
 {
@@ -635,7 +635,7 @@ static int vpif_try_fmt_vid_out(struct file *file, void *priv,
 	struct v4l2_pix_format *pixfmt = &fmt->fmt.pix;
 
 	/*
-	 * to supress v4l-compliance warnings silently correct
+	 * to suppress v4l-compliance warnings silently correct
 	 * the pixelformat
 	 */
 	if (pixfmt->pixelformat != V4L2_PIX_FMT_YUV422P)
diff --git a/drivers/media/platform/exynos4-is/fimc-is-command.h b/drivers/media/platform/exynos4-is/fimc-is-command.h
index 0d1f52e394b1..b06b56b890d5 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-command.h
+++ b/drivers/media/platform/exynos4-is/fimc-is-command.h
@@ -18,7 +18,7 @@
 
 #define FIMC_IS_COMMAND_VER	110 /* FIMC-IS command set version 1.10 */
 
-/* Enumeration of commands beetween the FIMC-IS and the host processor. */
+/* Enumeration of commands between the FIMC-IS and the host processor. */
 
 /* HOST to FIMC-IS */
 #define HIC_PREVIEW_STILL	0x0001
diff --git a/drivers/media/platform/exynos4-is/fimc-is-param.h b/drivers/media/platform/exynos4-is/fimc-is-param.h
index 8e31f7642776..22923a3d405e 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-param.h
+++ b/drivers/media/platform/exynos4-is/fimc-is-param.h
@@ -298,7 +298,7 @@ enum isp_af_mode {
 #define ISP_FLASH_COMMAND_AUTO			2
 #define ISP_FLASH_COMMAND_TORCH			3 /* 3 sec */
 
-/* Flash red-eye commads */
+/* Flash red-eye commands */
 #define ISP_FLASH_REDEYE_DISABLE		0
 #define ISP_FLASH_REDEYE_ENABLE			1
 
diff --git a/drivers/media/platform/exynos4-is/media-dev.h b/drivers/media/platform/exynos4-is/media-dev.h
index 9f527670395a..a7c9490bbcb4 100644
--- a/drivers/media/platform/exynos4-is/media-dev.h
+++ b/drivers/media/platform/exynos4-is/media-dev.h
@@ -79,7 +79,7 @@ struct fimc_camclk_info {
 
 /**
  * struct fimc_sensor_info - image data source subdev information
- * @pdata: sensor's atrributes passed as media device's platform data
+ * @pdata: sensor's attributes passed as media device's platform data
  * @asd: asynchronous subdev registration data structure
  * @subdev: image sensor v4l2 subdev
  * @host: fimc device the sensor is currently linked to
diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/exynos4-is/mipi-csis.c
index 35cb0162085b..234e047e3e8f 100644
--- a/drivers/media/platform/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/exynos4-is/mipi-csis.c
@@ -183,7 +183,7 @@ struct csis_drvdata {
  * @index: the hardware instance index
  * @pdev: CSIS platform device
  * @phy: pointer to the CSIS generic PHY
- * @regs: mmaped I/O registers memory
+ * @regs: mmapped I/O registers memory
  * @supplies: CSIS regulator supplies
  * @clock: CSIS clocks
  * @irq: requested s5p-mipi-csis irq number
@@ -745,7 +745,7 @@ static int s5pcsis_parse_dt(struct platform_device *pdev,
 		goto err;
 	}
 
-	/* Get MIPI CSI-2 bus configration from the endpoint node. */
+	/* Get MIPI CSI-2 bus configuration from the endpoint node. */
 	of_property_read_u32(node, "samsung,csis-hs-settle",
 					&state->hs_settle);
 	state->wclk_ext = of_property_read_bool(node,
diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/media/platform/marvell-ccic/mmp-driver.c
index 70a2833db0d1..af76eb637773 100644
--- a/drivers/media/platform/marvell-ccic/mmp-driver.c
+++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
@@ -240,8 +240,8 @@ static void mmpcam_calc_dphy(struct mcam_camera *mcam)
 	 *  bit 8 ~ bit 15: HS_SETTLE
 	 *   Time interval during which the HS
 	 *   receiver shall ignore any Data Lane
-	 *   HS transistions.
-	 *   The vaule has been calibrated on
+	 *   HS transitions.
+	 *   The value has been calibrated on
 	 *   different boards. It seems to work well.
 	 *
 	 *  More detail please refer
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.h b/drivers/media/platform/mtk-mdp/mtk_mdp_core.h
index ad1cff306efd..e5abb1abb3a3 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.h
@@ -41,7 +41,7 @@
 #define MTK_MDP_CTX_ERROR		BIT(5)
 
 /**
- *  struct mtk_mdp_pix_align - alignement of image
+ *  struct mtk_mdp_pix_align - alignment of image
  *  @org_w: source alignment of width
  *  @org_h: source alignment of height
  *  @target_w: dst alignment of width
@@ -122,8 +122,8 @@ struct mtk_mdp_frame {
 /**
  * struct mtk_mdp_variant - image processor variant information
  * @pix_max:		maximum limit of image size
- * @pix_min:		minimun limit of image size
- * @pix_align:		alignement of image
+ * @pix_min:		minimum limit of image size
+ * @pix_align:		alignment of image
  * @h_scale_up_max:	maximum scale-up in horizontal
  * @v_scale_up_max:	maximum scale-up in vertical
  * @h_scale_down_max:	maximum scale-down in horizontal
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index ba619647bc10..794aba685120 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -1170,7 +1170,7 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
 	ret = vdec_if_decode(ctx, &src_mem, NULL, &res_chg);
 	if (ret || !res_chg) {
 		/*
-		 * fb == NULL menas to parse SPS/PPS header or
+		 * fb == NULL means to parse SPS/PPS header or
 		 * resolution info in src_mem. Decode can fail
 		 * if there is no SPS header or picture info
 		 * in bs
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 8aba69555b12..e7e2a108def9 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -151,9 +151,9 @@ struct mtk_q_data {
  * @intra_period: I frame period
  * @gop_size: group of picture size, it's used as the intra frame period
  * @framerate_num: frame rate numerator. ex: framerate_num=30 and
- *		   framerate_denom=1 menas FPS is 30
+ *		   framerate_denom=1 means FPS is 30
  * @framerate_denom: frame rate denominator. ex: framerate_num=30 and
- *		     framerate_denom=1 menas FPS is 30
+ *		     framerate_denom=1 means FPS is 30
  * @h264_max_qp: Max value for H.264 quantization parameter
  * @h264_profile: V4L2 defined H.264 profile
  * @h264_level: V4L2 defined H.264 level
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index d1f12257bf66..2af654240d96 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -393,7 +393,7 @@ static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
 		param->input_yuv_fmt = VENC_YUV_FORMAT_NV21;
 		break;
 	default:
-		mtk_v4l2_err("Unsupport fourcc =%d", q_data_src->fmt->fourcc);
+		mtk_v4l2_err("Unsupported fourcc =%d", q_data_src->fmt->fourcc);
 		break;
 	}
 	param->h264_profile = enc_params->h264_profile;
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
index aa3ce41898bc..02c960c63ac0 100644
--- a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
@@ -55,7 +55,7 @@ struct h264_fb {
 
 /**
  * struct h264_ring_fb_list - ring frame buffer list
- * @fb_list   : frame buffer arrary
+ * @fb_list   : frame buffer array
  * @read_idx  : read index
  * @write_idx : write index
  * @count     : buffer count in list
@@ -72,7 +72,7 @@ struct h264_ring_fb_list {
 /**
  * struct vdec_h264_dec_info - decode information
  * @dpb_sz		: decoding picture buffer size
- * @resolution_changed  : resoltion change happen
+ * @resolution_changed  : resolution change happen
  * @realloc_mv_buf	: flag to notify driver to re-allocate mv buffer
  * @reserved		: for 8 bytes alignment
  * @bs_dma		: Input bit-stream buffer dma address
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
index 3e84a761db3a..bac3723038de 100644
--- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
@@ -120,7 +120,7 @@ struct vdec_vp8_hw_reg_base {
 /**
  * struct vdec_vp8_vpu_inst - VPU instance for VP8 decode
  * @wq_hd	: Wait queue to wait VPU message ack
- * @signaled	: 1 - Host has received ack message from VPU, 0 - not recevie
+ * @signaled	: 1 - Host has received ack message from VPU, 0 - not receive
  * @failure	: VPU execution result status 0 - success, others - fail
  * @inst_addr	: VPU decoder instance address
  */
diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.h b/drivers/media/platform/mtk-vcodec/vdec_drv_if.h
index ded1154481cd..9a21591f3818 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_drv_if.h
+++ b/drivers/media/platform/mtk-vcodec/vdec_drv_if.h
@@ -80,7 +80,7 @@ void vdec_if_deinit(struct mtk_vcodec_ctx *ctx);
  * vdec_if_decode() - trigger decode
  * @ctx	: [in] v4l2 context
  * @bs	: [in] input bitstream
- * @fb	: [in] frame buffer to store decoded frame, when null menas parse
+ * @fb	: [in] frame buffer to store decoded frame, when null means parse
  *	header only
  * @res_chg	: [out] resolution change happens if current bs have different
  *	picture width/height
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
index cd37bb2a610f..79d8eac7f5e2 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
+++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
@@ -62,7 +62,7 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t *data, unsigned int len);
 /**
  * vpu_dec_end - end decoding, basically the function will be invoked once
  *               when HW decoding done interrupt received successfully. The
- *               decoder in VPU will continute to do referene frame management
+ *               decoder in VPU will continue to do reference frame management
  *               and check if there is a new decoded frame available to display.
  *
  * @vpu : instance for vdec_vpu_inst
diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index ff3de2dce5a2..37f0d7146dfa 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -1129,7 +1129,7 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *fh,
 	}
 	timing = &dssdev->panel.timings;
 
-	/* We dont support RGB24-packed mode if vrfb rotation
+	/* We don't support RGB24-packed mode if vrfb rotation
 	 * is enabled*/
 	if ((is_rotation_enabled(vout)) &&
 			f->fmt.pix.pixelformat == V4L2_PIX_FMT_RGB24) {
@@ -1147,7 +1147,7 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *fh,
 		vout->fbuf.fmt.width = timing->x_res;
 	}
 
-	/* change to samller size is OK */
+	/* change to smaller size is OK */
 
 	bpp = omap_vout_try_format(&f->fmt.pix);
 	f->fmt.pix.sizeimage = f->fmt.pix.width * f->fmt.pix.height * bpp;
diff --git a/drivers/media/platform/omap/omap_voutdef.h b/drivers/media/platform/omap/omap_voutdef.h
index 56b630b1c8b4..c740393c8509 100644
--- a/drivers/media/platform/omap/omap_voutdef.h
+++ b/drivers/media/platform/omap/omap_voutdef.h
@@ -37,7 +37,7 @@
 #define VID_MAX_WIDTH		1280	/* Largest width */
 #define VID_MAX_HEIGHT		720	/* Largest height */
 
-/* Mimimum requirement is 2x2 for DSS */
+/* Minimum requirement is 2x2 for DSS */
 #define VID_MIN_WIDTH		2
 #define VID_MIN_HEIGHT		2
 
@@ -135,7 +135,7 @@ struct omap_vout_device {
 	enum omap_color_mode dss_mode;
 
 	/* we don't allow to request new buffer when old buffers are
-	 * still mmaped
+	 * still mmapped
 	 */
 	int mmap_count;
 
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 13f2828d880d..bd57174d81a7 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1517,7 +1517,7 @@ void omap3isp_print_status(struct isp_device *isp)
  *
  * To solve this problem power management support is split into prepare/complete
  * and suspend/resume operations. The pipelines are stopped in prepare() and the
- * ISP clocks get disabled in suspend(). Similarly, the clocks are reenabled in
+ * ISP clocks get disabled in suspend(). Similarly, the clocks are re-enabled in
  * resume(), and the the pipelines are restarted in complete().
  *
  * TODO: PM dependencies between the ISP and sensors are not modelled explicitly
diff --git a/drivers/media/platform/omap3isp/ispccdc.c b/drivers/media/platform/omap3isp/ispccdc.c
index 14a1c24037c4..261ad1175f98 100644
--- a/drivers/media/platform/omap3isp/ispccdc.c
+++ b/drivers/media/platform/omap3isp/ispccdc.c
@@ -1594,7 +1594,7 @@ static int ccdc_isr_buffer(struct isp_ccdc_device *ccdc)
 		return 0;
 
 	/* We're in continuous mode, and memory writes were disabled due to a
-	 * buffer underrun. Reenable them now that we have a buffer. The buffer
+	 * buffer underrun. Re-enable them now that we have a buffer. The buffer
 	 * address has been set in ccdc_video_queue.
 	 */
 	if (ccdc->state == ISP_PIPELINE_STREAM_CONTINUOUS && ccdc->underrun) {
@@ -1712,7 +1712,7 @@ static void ccdc_vd1_isr(struct isp_ccdc_device *ccdc)
 	 * data to memory the CCDC and LSC are stopped immediately but
 	 * without change the CCDC stopping state machine. The CCDC
 	 * stopping state machine should be used only when user request
-	 * for stopping is received (SINGLESHOT is an exeption).
+	 * for stopping is received (SINGLESHOT is an exception).
 	 */
 	switch (ccdc->state) {
 	case ISP_PIPELINE_STREAM_SINGLESHOT:
diff --git a/drivers/media/platform/omap3isp/ispcsi2.c b/drivers/media/platform/omap3isp/ispcsi2.c
index 9c180f607bcb..da66ea65be5d 100644
--- a/drivers/media/platform/omap3isp/ispcsi2.c
+++ b/drivers/media/platform/omap3isp/ispcsi2.c
@@ -710,7 +710,7 @@ static void csi2_isr_ctx(struct isp_csi2_device *csi2,
 
 	/* Skip interrupts until we reach the frame skip count. The CSI2 will be
 	 * automatically disabled, as the frame skip count has been programmed
-	 * in the CSI2_CTx_CTRL1::COUNT field, so reenable it.
+	 * in the CSI2_CTx_CTRL1::COUNT field, so re-enable it.
 	 *
 	 * It would have been nice to rely on the FRAME_NUMBER interrupt instead
 	 * but it turned out that the interrupt is only generated when the CSI2
diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index 3cf3c6390cc8..4fe228752a43 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -1631,7 +1631,7 @@ static int pxa_camera_set_bus_param(struct pxa_camera_dev *pcdev)
 
 	pcdev->channels = 1;
 
-	/* Make choises, based on platform preferences */
+	/* Make choices, based on platform preferences */
 	if ((common_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) &&
 	    (common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)) {
 		if (pcdev->platform_flags & PXA_CAMERA_HSP)
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 79c7e816c706..7a3feb5cee00 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -219,7 +219,7 @@ struct venus_buffer {
 #define to_venus_buffer(ptr)	container_of(ptr, struct venus_buffer, vb)
 
 /**
- * struct venus_inst - holds per instance paramerters
+ * struct venus_inst - holds per instance parameters
  *
  * @list:	used for attach an instance to the core
  * @lock:	instance lock
diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index beb9248992a4..2207a31d355e 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -681,7 +681,7 @@ static int rvin_setup(struct rvin_dev *vin)
 		break;
 	}
 
-	/* Enable VSYNC Field Toogle mode after one VSYNC input */
+	/* Enable VSYNC Field Toggle mode after one VSYNC input */
 	if (vin->info->model == RCAR_GEN3)
 		dmr2 = VNDMR2_FTEV;
 	else
diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index 7a2851790b91..7cbdcbf9b090 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -665,7 +665,7 @@ static void rvin_mc_try_format(struct rvin_dev *vin,
 	 * The V4L2 specification clearly documents the colorspace fields
 	 * as being set by drivers for capture devices. Using the values
 	 * supplied by userspace thus wouldn't comply with the API. Until
-	 * the API is updated force fixed vaules.
+	 * the API is updated force fixed values.
 	 */
 	pix->colorspace = RVIN_DEFAULT_COLORSPACE;
 	pix->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix->colorspace);
@@ -964,7 +964,7 @@ void rvin_v4l2_unregister(struct rvin_dev *vin)
 	v4l2_info(&vin->v4l2_dev, "Removing %s\n",
 		  video_device_node_name(&vin->vdev));
 
-	/* Checks internaly if vdev have been init or not */
+	/* Checks internally if vdev have been init or not */
 	video_unregister_device(&vin->vdev);
 }
 
diff --git a/drivers/media/platform/rockchip/rga/rga-hw.c b/drivers/media/platform/rockchip/rga/rga-hw.c
index 96d1b1b3fe8e..843e50d17a72 100644
--- a/drivers/media/platform/rockchip/rga/rga-hw.c
+++ b/drivers/media/platform/rockchip/rga/rga-hw.c
@@ -256,7 +256,7 @@ static void rga_cmd_set_trans_info(struct rga_ctx *ctx)
 	}
 
 	/*
-	 * Cacluate the up/down scaling mode/factor.
+	 * Calculate the up/down scaling mode/factor.
 	 *
 	 * RGA used to scale the picture first, and then rotate second,
 	 * so we need to swap the w/h when rotate degree is 90/270.
@@ -304,7 +304,7 @@ static void rga_cmd_set_trans_info(struct rga_ctx *ctx)
 	}
 
 	/*
-	 * Cacluate the framebuffer virtual strides and active size,
+	 * Calculate the framebuffer virtual strides and active size,
 	 * note that the step of vir_stride / vir_width is 4 byte words
 	 */
 	src_vir_info.data.vir_stride = ctx->in.stride >> 2;
@@ -318,7 +318,7 @@ static void rga_cmd_set_trans_info(struct rga_ctx *ctx)
 	dst_act_info.data.act_width = dst_w - 1;
 
 	/*
-	 * Cacluate the source framebuffer base address with offset pixel.
+	 * Calculate the source framebuffer base address with offset pixel.
 	 */
 	src_offsets = rga_get_addr_offset(&ctx->in, src_x, src_y,
 					  src_w, src_h);
diff --git a/drivers/media/platform/s3c-camif/camif-core.h b/drivers/media/platform/s3c-camif/camif-core.h
index 1f5c8c94ce89..be5e7357dffc 100644
--- a/drivers/media/platform/s3c-camif/camif-core.h
+++ b/drivers/media/platform/s3c-camif/camif-core.h
@@ -260,7 +260,7 @@ struct camif_vp {
  * @clock:	  clocks required for the CAMIF operation
  * @lock:	  mutex protecting this data structure
  * @slock:	  spinlock protecting CAMIF registers
- * @io_base:	  start address of the mmaped CAMIF registers
+ * @io_base:	  start address of the mmapped CAMIF registers
  */
 struct camif_dev {
 	struct media_device		media_dev;
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.h b/drivers/media/platform/s5p-jpeg/jpeg-core.h
index 90fda4b720eb..144c102ff05f 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.h
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.h
@@ -153,7 +153,7 @@ struct s5p_jpeg_variant {
 
 /**
  * struct jpeg_fmt - driver's internal color format data
- * @name:	format descritpion
+ * @name:	format description
  * @fourcc:	the fourcc code, 0 if not applicable
  * @depth:	number of bits per pixel
  * @colplanes:	number of color planes (1 for packed formats)
@@ -193,7 +193,7 @@ struct s5p_jpeg_marker {
  * @sos:	SOS marker's position relative to the buffer beginning
  * @dht:	DHT markers' positions relative to the buffer beginning
  * @dqt:	DQT markers' positions relative to the buffer beginning
- * @sof:	SOF0 marker's postition relative to the buffer beginning
+ * @sof:	SOF0 marker's position relative to the buffer beginning
  * @sof_len:	SOF0 marker's payload length (without length field itself)
  * @components:	number of image components
  * @size:	image buffer size in bytes
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
index 20442a9b9f7a..24148020baa9 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -268,7 +268,7 @@ struct s5p_mfc_priv_buf {
  * @enc_ctrl_handler:	control framework handler for encoding
  * @pm:			power management control
  * @variant:		MFC hardware variant information
- * @num_inst:		couter of active MFC instances
+ * @num_inst:		counter of active MFC instances
  * @irqlock:		lock for operations on videobuf2 queues
  * @condlock:		lock for changing/checking if a context is ready to be
  *			processed
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
index ee7b15b335e0..9f832ba7bc8c 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
@@ -51,7 +51,7 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 	struct firmware *fw_blob;
 	int i, err = -EINVAL;
 
-	/* Firmare has to be present as a separate file or compiled
+	/* Firmware has to be present as a separate file or compiled
 	 * into kernel. */
 	mfc_debug_enter();
 
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index f4c0e3a8f27d..e111f9c47179 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -602,7 +602,7 @@ static int vidioc_querybuf(struct file *file, void *priv,
 	int i;
 
 	if (buf->memory != V4L2_MEMORY_MMAP) {
-		mfc_err("Only mmaped buffers can be used\n");
+		mfc_err("Only mmapped buffers can be used\n");
 		return -EINVAL;
 	}
 	mfc_debug(2, "State: %d, buf->type: %d\n", ctx->state, buf->type);
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
index 0913881219ff..6144e95f6425 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
@@ -1293,7 +1293,7 @@ static int s5p_mfc_run_init_dec_buffers(struct s5p_mfc_ctx *ctx)
 	 * First set the output frame buffers
 	 */
 	if (ctx->capture_state != QUEUE_BUFS_MMAPED) {
-		mfc_err("It seems that not all destination buffers were mmaped\nMFC requires that all destination are mmaped before starting processing\n");
+		mfc_err("It seems that not all destination buffers were mmapped\nMFC requires that all destination are mmapped before starting processing\n");
 		return -EAGAIN;
 	}
 	if (list_empty(&ctx->src_queue)) {
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index 7c629be43205..281699ab7fe1 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -53,7 +53,7 @@ static int s5p_mfc_alloc_dec_temp_buffers_v6(struct s5p_mfc_ctx *ctx)
 	return 0;
 }
 
-/* Release temproary buffers for decoding */
+/* Release temporary buffers for decoding */
 static void s5p_mfc_release_dec_desc_buffer_v6(struct s5p_mfc_ctx *ctx)
 {
 	/* NOP */
@@ -1928,7 +1928,7 @@ static inline int s5p_mfc_run_init_dec_buffers(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->capture_state != QUEUE_BUFS_MMAPED) {
 		mfc_err("It seems that not all destination buffers were\n"
-			"mmaped.MFC requires that all destination are mmaped\n"
+			"mmapped.MFC requires that all destination are mmapped\n"
 			"before starting processing.\n");
 		return -EAGAIN;
 	}
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.h b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.h
index 3dbb3a287cc0..c9d6021904cd 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.h
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.h
@@ -193,7 +193,7 @@ struct c8sectpfei {
 #define C8SECTPFE_SYS_ENABLE             BIT(0)
 
 /*
- * Ponter record data structure required for each input block
+ * Pointer record data structure required for each input block
  * see Table 82 on page 167 of functional specification.
  */
 
diff --git a/drivers/media/platform/sti/delta/delta.h b/drivers/media/platform/sti/delta/delta.h
index 2ba99922c05b..914556030e70 100644
--- a/drivers/media/platform/sti/delta/delta.h
+++ b/drivers/media/platform/sti/delta/delta.h
@@ -286,7 +286,7 @@ struct delta_dec {
 	 * Header parsing must be done using decode(), giving
 	 * explicitly header access unit or first access unit of bitstream.
 	 * If no valid header is found, get_streaminfo will return -ENODATA,
-	 * in this case the next bistream access unit must be decoded till
+	 * in this case the next bitstream access unit must be decoded till
 	 * get_streaminfo becomes successful.
 	 */
 	int (*get_streaminfo)(struct delta_ctx *ctx,
diff --git a/drivers/media/platform/sti/hva/hva-h264.c b/drivers/media/platform/sti/hva/hva-h264.c
index b61a5d337d2a..c34f7cf5aed2 100644
--- a/drivers/media/platform/sti/hva/hva-h264.c
+++ b/drivers/media/platform/sti/hva/hva-h264.c
@@ -626,7 +626,7 @@ static int hva_h264_prepare_task(struct hva_ctx *pctx,
 	td->frame_width = frame_width;
 	td->frame_height = frame_height;
 
-	/* set frame alignement */
+	/* set frame alignment */
 	td->window_width =  frame_width;
 	td->window_height = frame_height;
 	td->window_horizontal_offset = 0;
diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 6732874114cf..5fe5b38fa901 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1544,7 +1544,7 @@ static void dcmi_graph_notify_unbind(struct v4l2_async_notifier *notifier,
 
 	dev_dbg(dcmi->dev, "Removing %s\n", video_device_node_name(dcmi->vdev));
 
-	/* Checks internaly if vdev has been init or not */
+	/* Checks internally if vdev has been init or not */
 	video_unregister_device(dcmi->vdev);
 }
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 0bb000712c33..85f97d4f086e 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -65,7 +65,7 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi, u32 pixformat,
 int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable);
 
 /**
- * sun6i_csi_update_config() - update the csi register setttings
+ * sun6i_csi_update_config() - update the csi register settings
  * @csi:	pointer to the csi
  * @config:	see struct sun6i_csi_config
  */
diff --git a/drivers/media/platform/ti-vpe/vpdma.c b/drivers/media/platform/ti-vpe/vpdma.c
index e2cf2b90e500..1da2cb3aaf0c 100644
--- a/drivers/media/platform/ti-vpe/vpdma.c
+++ b/drivers/media/platform/ti-vpe/vpdma.c
@@ -404,7 +404,7 @@ EXPORT_SYMBOL(vpdma_map_desc_buf);
 
 /*
  * unmap descriptor/payload DMA buffer, disabling DMA access and
- * allowing the main processor to acces the data
+ * allowing the main processor to access the data
  */
 void vpdma_unmap_desc_buf(struct vpdma_data *vpdma, struct vpdma_buf *buf)
 {
@@ -501,7 +501,7 @@ void vpdma_reset_desc_list(struct vpdma_desc_list *list)
 EXPORT_SYMBOL(vpdma_reset_desc_list);
 
 /*
- * free the buffer allocated fot the VPDMA descriptor list, this should be
+ * free the buffer allocated for the VPDMA descriptor list, this should be
  * called when the user doesn't want to use VPDMA any more.
  */
 void vpdma_free_desc_list(struct vpdma_desc_list *list)
@@ -790,7 +790,7 @@ static void dump_dtd(struct vpdma_dtd *dtd)
  * append an outbound data transfer descriptor to the given descriptor list,
  * this sets up a 'client to memory' VPDMA transfer for the given VPDMA channel
  *
- * @list: vpdma desc list to which we add this decriptor
+ * @list: vpdma desc list to which we add this descriptor
  * @width: width of the image in pixels in memory
  * @c_rect: compose params of output image
  * @fmt: vpdma data format of the buffer
@@ -798,7 +798,7 @@ static void dump_dtd(struct vpdma_dtd *dtd)
  * max_width: enum for maximum width of data transfer
  * max_height: enum for maximum height of data transfer
  * chan: VPDMA channel
- * flags: VPDMA flags to configure some descriptor fileds
+ * flags: VPDMA flags to configure some descriptor fields
  */
 void vpdma_add_out_dtd(struct vpdma_desc_list *list, int width,
 		int stride, const struct v4l2_rect *c_rect,
@@ -863,14 +863,14 @@ EXPORT_SYMBOL(vpdma_rawchan_add_out_dtd);
  * append an inbound data transfer descriptor to the given descriptor list,
  * this sets up a 'memory to client' VPDMA transfer for the given VPDMA channel
  *
- * @list: vpdma desc list to which we add this decriptor
+ * @list: vpdma desc list to which we add this descriptor
  * @width: width of the image in pixels in memory(not the cropped width)
  * @c_rect: crop params of input image
  * @fmt: vpdma data format of the buffer
  * dma_addr: dma address as seen by VPDMA
  * chan: VPDMA channel
  * field: top or bottom field info of the input image
- * flags: VPDMA flags to configure some descriptor fileds
+ * flags: VPDMA flags to configure some descriptor fields
  * frame_width/height: the complete width/height of the image presented to the
  *			client (this makes sense when multiple channels are
  *			connected to the same client, forming a larger frame)
@@ -1008,7 +1008,7 @@ unsigned int vpdma_get_list_mask(struct vpdma_data *vpdma, int irq_num)
 }
 EXPORT_SYMBOL(vpdma_get_list_mask);
 
-/* clear previosuly occured list intterupts in the LIST_STAT register */
+/* clear previously occurred list interupts in the LIST_STAT register */
 void vpdma_clear_list_stat(struct vpdma_data *vpdma, int irq_num,
 			   int list_num)
 {
diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index d70871d0ad2d..207e7e76c048 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -876,7 +876,7 @@ static int set_srcdst_params(struct vpe_ctx *ctx)
 		/*
 		 * we make sure that the source image has a 16 byte aligned
 		 * stride, we need to do the same for the motion vector buffer
-		 * by aligning it's stride to the next 16 byte boundry. this
+		 * by aligning it's stride to the next 16 byte boundary. this
 		 * extra space will not be used by the de-interlacer, but will
 		 * ensure that vpdma operates correctly
 		 */
diff --git a/drivers/media/platform/vsp1/vsp1_brx.c b/drivers/media/platform/vsp1/vsp1_brx.c
index 5e50178b057d..58ad248cd7f7 100644
--- a/drivers/media/platform/vsp1/vsp1_brx.c
+++ b/drivers/media/platform/vsp1/vsp1_brx.c
@@ -296,7 +296,7 @@ static void brx_configure_stream(struct vsp1_entity *entity,
 	/*
 	 * The hardware is extremely flexible but we have no userspace API to
 	 * expose all the parameters, nor is it clear whether we would have use
-	 * cases for all the supported modes. Let's just harcode the parameters
+	 * cases for all the supported modes. Let's just hardcode the parameters
 	 * to sane default values for now.
 	 */
 
@@ -373,7 +373,7 @@ static void brx_configure_stream(struct vsp1_entity *entity,
 		vsp1_brx_write(brx, dlb, VI6_BRU_CTRL(i), ctrl);
 
 		/*
-		 * Harcode the blending formula to
+		 * Hardcode the blending formula to
 		 *
 		 *	DSTc = DSTc * (1 - SRCa) + SRCc * SRCa
 		 *	DSTa = DSTa * (1 - SRCa) + SRCa
diff --git a/drivers/media/platform/xilinx/xilinx-vip.c b/drivers/media/platform/xilinx/xilinx-vip.c
index 18f98838111b..08a825c3a3f6 100644
--- a/drivers/media/platform/xilinx/xilinx-vip.c
+++ b/drivers/media/platform/xilinx/xilinx-vip.c
@@ -166,7 +166,7 @@ EXPORT_SYMBOL_GPL(xvip_set_format_size);
  * the register, otherwise the bitmask is cleared from the register
  * when the flag @set is false.
  *
- * Fox eample, this function can be used to set a control with a boolean value
+ * Fox example, this function can be used to set a control with a boolean value
  * requested by users. If the caller knows whether to set or clear in the first
  * place, the caller should call xvip_clr() or xvip_set() directly instead of
  * using this function.
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
