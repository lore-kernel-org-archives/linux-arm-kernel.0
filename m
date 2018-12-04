Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F96C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:41:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133E120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jDT7DPEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133E120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=62LtHHqXTvufwby74DlU7l7iRsbXE/09w+LEgYsKnkU=; b=jDT7DPEWMq6z7X
	0ADy04c5B1kN+91FC/1r0p6rqygCfzFJVoovxVoc9IDICmCS5LFGK0Sp558LFL91uabFvWQ5+u1Zf
	Z1ejp320MSx/QzuPbuhAM2S7y7rfeK2SDnNMbJ5G7oitDApJOMeB4n3hvv8VbcwfwJtGtZ00/G8r+
	mEmWUpq9sGNiK5/cmIvHLXyknPlYO53xXhGFwo1AoiRMRX5H95YqRr8+hVAuyFPsUDqOiX8DIc5D5
	A97DuMQcpcyWp5vpe9PfJb7FTfiGzEbypmc3vFq2ndijj0OG5+iUQZ0Cc0PR6KIqFrITA+JRsTkQO
	W6m1GE4slnRKFiig2muQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBsj-0005QV-Iq; Tue, 04 Dec 2018 14:41:01 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBbd-0007oP-3Q
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 97B5E20E86; Tue,  4 Dec 2018 15:23:17 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4899520D23;
 Tue,  4 Dec 2018 15:22:41 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/21] drm/fourcc: Add definitions for Allwinner vendor and
 VPU tiled format
Date: Tue,  4 Dec 2018 15:22:07 +0100
Message-Id: <20181204142218.16284-11-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_062322_075562_32548329 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This introduces specific definitions for vendor Allwinner and its
associated tiled format modifier. This modifier is used for the output
format of the VPU, that can be imported directly with the display
engine hardware supported by the sun4i-drm driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/uapi/drm/drm_fourcc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 0b44260a5ee9..ea108e88ae03 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -238,6 +238,8 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
+#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -644,6 +646,20 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
 
+/*
+ * Allwinner tiled modifier
+ *
+ * This tiling mode is implemented by the VPU found on all Allwinner platforms,
+ * codenamed sunxi. It is associated with a YUV format that uses either 2 or 3
+ * planes.
+ *
+ * With this tiling, the luminance samples are disposed in tiles representing
+ * 32x32 pixels and the chrominance samples in tiles representing 32x64 pixels.
+ * The pixel order in each tile is linear and the tiles are disposed linearly,
+ * both in row-major order.
+ */
+#define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
