Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A890C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:57:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA68D20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hbSpa2ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA68D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOKmf+MLYG/GrgwRcuFYfUIep2ESVoLUx2PIJDjGG3Y=; b=hbSpa2ZVQHb1GV
	e+D4OE7xdUaojRniUAKFt7Q5ZVnfcagnh22/KMHWJnprSSkNbptpVZl/J+ahLqS2nM0EqGkOi/seO
	5UaibGJ8yRFQOJLS9aDO0oPBqdycSkihOKbjZC5IVhireiebDCa0BIG6dLi1wnOESFQUMZaoLLDTp
	bYYMv91pQwN+Unujopcv2vklZoZ46/wM/STKTPK2mR940nRZqXRcFU+omwzoNXD3q33Qf5WKTFKD8
	Rj15Lv2N15h+tsX4QCs9NCTllt1US3/KpXVkR8x85Mef0k8meE77kY/wU5DhzSsr120A4Yo28k8Bn
	oxTiKMKHxoxqSxQD71Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGde-00007v-7S; Fri, 07 Dec 2018 13:57:54 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGc5-0006rT-Tl
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:56:27 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C6C0820CE3; Fri,  7 Dec 2018 14:56:01 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id C001F20CE8;
 Fri,  7 Dec 2018 14:55:43 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 06/10] phy: Move Allwinner A31 D-PHY driver to drivers/phy/
Date: Fri,  7 Dec 2018 14:55:33 +0100
Message-Id: <20181207135541.30901-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
References: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_055618_542393_7CC55875 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that our MIPI D-PHY driver has been converted to the phy framework,
let's move it into the drivers/phy directory.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/Kconfig                        | 10 +---------
 drivers/gpu/drm/sun4i/Makefile                       |  1 -
 drivers/phy/allwinner/Kconfig                        | 12 ++++++++++++
 drivers/phy/allwinner/Makefile                       |  1 +
 .../allwinner/phy-sun6i-mipi-dphy.c}                 |  0
 5 files changed, 14 insertions(+), 10 deletions(-)
 rename drivers/{gpu/drm/sun4i/sun6i_mipi_dphy.c => phy/allwinner/phy-sun6i-mipi-dphy.c} (100%)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 2b8db82c4bab..1dbbc3a1b763 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -45,20 +45,12 @@ config DRM_SUN6I_DSI
 	default MACH_SUN8I
 	select CRC_CCITT
 	select DRM_MIPI_DSI
-	select DRM_SUN6I_DPHY
+	select PHY_SUN6I_MIPI_DPHY
 	help
 	  Choose this option if you want have an Allwinner SoC with
 	  MIPI-DSI support. If M is selected the module will be called
 	  sun6i_mipi_dsi.
 
-config DRM_SUN6I_DPHY
-	tristate "Allwinner A31 MIPI D-PHY Support"
-	select GENERIC_PHY_MIPI_DPHY
-	help
-	  Choose this option if you have an Allwinner SoC with
-	  MIPI-DSI support. If M is selected, the module will be
-	  called sun6i_mipi_dphy.
-
 config DRM_SUN8I_DW_HDMI
 	tristate "Support for Allwinner version of DesignWare HDMI"
 	depends on DRM_SUN4I
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 1e2320d824b5..0d04f2447b01 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -34,7 +34,6 @@ ifdef CONFIG_DRM_SUN4I_BACKEND
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-frontend.o
 endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
-obj-$(CONFIG_DRM_SUN6I_DPHY)	+= sun6i_mipi_dphy.o
 obj-$(CONFIG_DRM_SUN6I_DSI)	+= sun6i_mipi_dsi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o
diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index cdc1e745ba47..fb1204bcc454 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -17,6 +17,18 @@ config PHY_SUN4I_USB
 	  This driver controls the entire USB PHY block, both the USB OTG
 	  parts, as well as the 2 regular USB 2 host PHYs.
 
+config PHY_SUN6I_MIPI_DPHY
+	tristate "Allwinner A31 MIPI D-PHY Support"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	select GENERIC_PHY
+	select GENERIC_PHY_MIPI_DPHY
+	select REGMAP_MMIO
+	help
+	  Choose this option if you have an Allwinner SoC with
+	  MIPI-DSI support. If M is selected, the module will be
+	  called sun6i_mipi_dphy.
+
 config PHY_SUN9I_USB
 	tristate "Allwinner sun9i SoC USB PHY driver"
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index 8605529c01a1..7d0053efbfaa 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
+obj-$(CONFIG_PHY_SUN6I_MIPI_DPHY)	+= phy-sun6i-mipi-dphy.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
similarity index 100%
rename from drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
rename to drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
