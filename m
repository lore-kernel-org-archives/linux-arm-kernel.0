Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F70C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19FC217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qxS51UA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19FC217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mGmIecImapKnsQnR984DXpFYSjO+TMck/uzPChED+0o=; b=qxS51UA2fob6fJ
	7dgpBXEl/PhKIM7sF7LjB5sd5ulhsvJ6QzFclSdTF+Z4DbBCebGQBynSBIW0yqY5QaauyTV2yaaCm
	bNDtfyPNXyKCDMRr46LUqvaFqbyVGLkh/fO3tp05gKUqteSDM7RxrV4M48POm00MZfcBIc1eHRC8c
	romFHisQnG62+7GgJIqESQcFq1bU1Ph5Zd0XiTCprHn7C96Jc9LvEurwA4JJM7JC/enRQWmSwVHmu
	JalW8fsxxSFaUn6U1ref1TA21lvUq2VBd2PVAMy4KXWlV1CaZgL8iG5yIWr5/J3qY6KL3FJNkbIsV
	hgBr6IMqZ6CVHk24TySw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqKFx-0004Nw-Hd; Sun, 03 Feb 2019 16:04:29 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqKFX-0003xR-62
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 16:04:05 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id B2ADE5FD5E; Mon,  4 Feb 2019 00:04:01 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 3/3] media: sun6i: Add support for JPEG media bus format
Date: Mon,  4 Feb 2019 00:03:58 +0800
Message-Id: <20190203160358.21050-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203160358.21050-1-wens@csie.org>
References: <20190203160358.21050-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_080403_354022_DFBE0EE5 
X-CRM114-Status: GOOD (  11.63  )
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

The CSI controller can take raw data from the data bus and output it
directly to capture buffers. This can be used to support the JPEG media
bus format.

While the controller can report minimum and maximum bytes per line, it
has no way to report how many lines were captured in the last frame.
Thus, even when the on-bus data is framed correctly, we have no way to
accertain the actual amount of data captured, unless we scan the buffer
for JPEG EOI markers, or sequential zeros. For now we leave bytesused
alone, and leave it up to userspace applications to parse the data.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c   | 6 ++++++
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h   | 1 +
 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 969762db30dd..c06776f652c8 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -149,6 +149,9 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
 	case V4L2_PIX_FMT_RGB565X:
 		return (mbus_code == MEDIA_BUS_FMT_RGB565_2X8_BE);
 
+	case V4L2_PIX_FMT_JPEG:
+		return (mbus_code == MEDIA_BUS_FMT_JPEG_1X8);
+
 	default:
 		dev_dbg(sdev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
 		break;
@@ -279,6 +282,9 @@ static enum csi_output_fmt get_csi_output_format(struct sun6i_csi_dev *sdev,
 	case V4L2_PIX_FMT_RGB565X:
 		return buf_interlaced ? CSI_FRAME_RGB565 : CSI_FIELD_RGB565;
 
+	case V4L2_PIX_FMT_JPEG:
+		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
+
 	default:
 		dev_warn(sdev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
 		break;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 585cd9669417..f30a210e9caa 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -94,6 +94,7 @@ static inline int sun6i_csi_get_bpp(unsigned int pixformat)
 	case V4L2_PIX_FMT_SGBRG8:
 	case V4L2_PIX_FMT_SGRBG8:
 	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_JPEG:
 		return 8;
 	case V4L2_PIX_FMT_SBGGR10:
 	case V4L2_PIX_FMT_SGBRG10:
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index bff6fe832803..1fd16861f111 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -58,6 +58,7 @@ static const u32 supported_pixformats[] = {
 	V4L2_PIX_FMT_YUV422P,
 	V4L2_PIX_FMT_RGB565,
 	V4L2_PIX_FMT_RGB565X,
+	V4L2_PIX_FMT_JPEG,
 };
 
 static bool is_pixformat_valid(unsigned int pixformat)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
