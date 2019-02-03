Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F3D20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sTR4lvnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F3D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=onEFQEbQIld3SKzDpN8WeJqwkijO2UuCp9H/Jqayeq0=; b=sTR4lvnlXHdhLY
	LCP5rKbOo2y/ANQrHtahPiuB1INr3C4NX1uiNrdgpYWWdgegcDdW0Pgc4lewJLrkSaCtJQQJZcAfN
	ffdJeG23CUUGekq5GRP/QxQBtpbDXNqkfmmqf0+Idt+YN4frQshfFMFCPKnV8dxQoGtjIwx8P6Ce1
	99G9eumD79ABHsyBfSyl3dRGN8iU76wfrwblgGZXxLdXSgsUivvNfYERoB59ehk088M0EUxiSThpX
	l7QPmZhsWFNKJOwou/8ekis1IJbKIK/ZHPOYMhQc4Hdfv1Iwo+BxOKrrRhcxnCeTqpl1hF6hYCQJo
	NQC4eaFvTr8Rayw/DROQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqKGA-0004cR-GY; Sun, 03 Feb 2019 16:04:42 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqKFX-0003xQ-64
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 16:04:06 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id A7ED85FD40; Mon,  4 Feb 2019 00:04:01 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 2/3] media: sun6i: Add support for RGB565 formats
Date: Mon,  4 Feb 2019 00:03:57 +0800
Message-Id: <20190203160358.21050-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203160358.21050-1-wens@csie.org>
References: <20190203160358.21050-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_080403_490000_43E456BD 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CSI controller can take raw data from the data bus and output RGB565
format. The controller does not distinguish between RGB565 LE and BE.
Instead this is determined by the media bus format, i.e. the format or
order the sensor is sending data in.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 19 +++++++++++++++++--
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  2 ++
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 332cf81a7ecf..969762db30dd 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -143,6 +143,12 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
 			break;
 		}
 		break;
+
+	case V4L2_PIX_FMT_RGB565:
+		return (mbus_code == MEDIA_BUS_FMT_RGB565_2X8_LE);
+	case V4L2_PIX_FMT_RGB565X:
+		return (mbus_code == MEDIA_BUS_FMT_RGB565_2X8_BE);
+
 	default:
 		dev_dbg(sdev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
 		break;
@@ -198,8 +204,8 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_dev *sdev,
 					       u32 mbus_code, u32 pixformat)
 {
-	/* bayer */
-	if ((mbus_code & 0xF000) == 0x3000)
+	/* non-YUV */
+	if ((mbus_code & 0xF000) != 0x2000)
 		return CSI_INPUT_FORMAT_RAW;
 
 	switch (pixformat) {
@@ -268,6 +274,11 @@ static enum csi_output_fmt get_csi_output_format(struct sun6i_csi_dev *sdev,
 	case V4L2_PIX_FMT_YUV422P:
 		return buf_interlaced ? CSI_FRAME_PLANAR_YUV422 :
 					CSI_FIELD_PLANAR_YUV422;
+
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_RGB565X:
+		return buf_interlaced ? CSI_FRAME_RGB565 : CSI_FIELD_RGB565;
+
 	default:
 		dev_warn(sdev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
 		break;
@@ -279,6 +290,10 @@ static enum csi_output_fmt get_csi_output_format(struct sun6i_csi_dev *sdev,
 static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_dev *sdev,
 					    u32 mbus_code, u32 pixformat)
 {
+	/* Input sequence does not apply to non-YUV formats */
+	if ((mbus_code & 0xF000) != 0x2000)
+		return 0;
+
 	switch (pixformat) {
 	case V4L2_PIX_FMT_HM12:
 	case V4L2_PIX_FMT_NV12:
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 0bb000712c33..585cd9669417 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -117,6 +117,8 @@ static inline int sun6i_csi_get_bpp(unsigned int pixformat)
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
 	case V4L2_PIX_FMT_YUV422P:
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_RGB565X:
 		return 16;
 	case V4L2_PIX_FMT_RGB24:
 	case V4L2_PIX_FMT_BGR24:
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index b04300c3811f..bff6fe832803 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -56,6 +56,8 @@ static const u32 supported_pixformats[] = {
 	V4L2_PIX_FMT_NV16,
 	V4L2_PIX_FMT_NV61,
 	V4L2_PIX_FMT_YUV422P,
+	V4L2_PIX_FMT_RGB565,
+	V4L2_PIX_FMT_RGB565X,
 };
 
 static bool is_pixformat_valid(unsigned int pixformat)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
