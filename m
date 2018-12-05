Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD90BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0C420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J9rUZTf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0C420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=62LtHHqXTvufwby74DlU7l7iRsbXE/09w+LEgYsKnkU=; b=J9rUZTf4866kDN
	1MXQ/DxeVD88FObLryPO6TuqWPuRRO6aTvI8e+/A/Z0UMHaZAGA8IAPEweNIBeUQ/1K+JVY5NW43z
	M34UHpxk9nNvrVK5XEdYs6iZpVr8Uvf422QwtxaVrEDlGIazNBDJbt523K2nmZW8Q2IZ8CZwEtBCg
	6jf5mPtTD1usOQsEX1C4lZon00CkRZFlh/97vc3KjQGkpGvd/NzO5hXfYIkunJnHdvKvxVgxfVfCA
	hWxxygoeFSYhek8UoCS8a5yHX+yQLBvfR8XBQB4BJ4l2K8WYVT1AZOtAMV1naUBMt/tPVSJQ4UvwE
	M+6QkdWYS4UbmPxcUZDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSiM-0006Qc-AB; Wed, 05 Dec 2018 08:39:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgx-0004uH-2L
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:38:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id AB86E20A5B; Wed,  5 Dec 2018 09:37:51 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id E413520A62;
 Wed,  5 Dec 2018 09:37:27 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/22] drm/fourcc: Add definitions for Allwinner vendor and
 VPU tiled format
Date: Wed,  5 Dec 2018 09:36:52 +0100
Message-Id: <20181205083703.21488-12-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003759_515925_B0F65F5B 
X-CRM114-Status: GOOD (  10.91  )
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
