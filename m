Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0581C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:58:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFB2218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AcFupJ//";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UyjIjctW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFB2218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ec6DuZdekIdWnes8kL3fD0GY+UGESTSdfLvb+opV+8Q=; b=AcFupJ//mWQTvC
	TOfr6WCEdqH+kBPO0FvZDlMKAqymWs/NUnfB+lEIuhNiuCq4V4h3j7r9WDtilD2slsatWjg+wyKfR
	EEMf2/m+hyW4IKm0hv/8mSuhPZwV3L3SJY3tmEbOUBe4iJu4wIWjawlPTgY1G9quWpsel3IEP6VYL
	UWVren/N7XplBk821yPoBSiamETzXyDXETfQkYmH+9EcK5O+l4C6wo0/h/iyjMnqaUqFT4D1dxDlX
	b1BdD0gkUMvCyZrKL9Sy1LDuicQdSyONHsuAUiOmjxco/Zz01XLotN+R5uXuWxZyTQZRsUSA4Px/Z
	AzmgdHpDvDMV4l+Iu6iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiL0-0000f7-Ef; Thu, 24 Jan 2019 16:58:46 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiKv-0000bY-Pl
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:58:43 +0000
Received: by mail-ed1-x544.google.com with SMTP id x30so5178243edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxRGPjapyeBHN2idsi07sfu0XUlyhsatL/XtHnBDJ1Q=;
 b=UyjIjctWHA4u0NpOfbFMmb98ZkgpIysCj9913XhrnW+jRnwloMc3iZFBxxfCJf1B7U
 A48XKD7/BE//P+bwysH8n03RsbxDCsZ7532ATb0ty5CRiaD6CLkJ9ApNcUxjs7TYCaWY
 gFOy3jUexAWdr1ZpFjm7YaKKpB10gX/bdezpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxRGPjapyeBHN2idsi07sfu0XUlyhsatL/XtHnBDJ1Q=;
 b=rsn7uCI9C8DP9g6l/XXGlSGBdkiYcIAUA2pPolHvsAJdHkAvDXBCeg6NPQQscr7KXs
 45pdkDeD2D9+ANfkdrxPW+s0v3N7tAg0lQSY3/gRBcBwEDYK4HvimyNzNEq7BWpdvBZE
 gypdl5o3bh7Ku1YiElqwWvonhJRPhnLkXSNOBDYbI9NTP7X0PnVQL/8/MLfW9ZGn1uBm
 I8uIvg3/Oljxx1X5SoqkvrGyVcBSF3mMeh29yNMm8/HoQeVsfZ+GVEEg6EOab9GNls84
 PT2GEM22/VLmwgLweqUY8ERp+gZ/55oy69+N24a4JarCYf8WVaXawc/lZsKXhx0MGh2f
 WAiw==
X-Gm-Message-State: AJcUukdj6kXeBpmgXhl3e8QNEHIb4P23TnMjZB8yTd8zVY2UNFq3qTnc
 zoSjt7WyZ++SthFCgVccDLWcuA==
X-Google-Smtp-Source: ALg8bN45J2W+F8q+tt4rP/5cexe8AntV5M5teTc6dDkvp2whDbKPk7otnGIHLX6c7TU85WuSuAR4mA==
X-Received: by 2002:a17:906:5ace:: with SMTP id
 x14mr6551472ejs.64.1548349119495; 
 Thu, 24 Jan 2019 08:58:39 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id w31sm11219233edw.82.2019.01.24.08.58.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 08:58:38 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 01/26] drm/irq: Don't check for DRIVER_HAVE_IRQ in
 drm_irq_(un)install
Date: Thu, 24 Jan 2019 17:58:06 +0100
Message-Id: <20190124165831.16427-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_085841_902938_38CEB33F 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: Daniel Vetter <daniel.vetter@intel.com>, linux-arm-msm@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-renesas-soc@vger.kernel.org, spice-devel@lists.freedesktop.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>, linux-amlogic@lists.infradead.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If a non-legacy driver calls these it's valid to assume there is
interrupt support. The flag is really only needed for legacy drivers.

Also remove all the flag usage from non-legacy drivers.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: intel-gfx@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 2 +-
 drivers/gpu/drm/arm/hdlcd_drv.c              | 2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 2 +-
 drivers/gpu/drm/drm_irq.c                    | 6 ------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c    | 2 +-
 drivers/gpu/drm/gma500/psb_drv.c             | 2 +-
 drivers/gpu/drm/i915/i915_drv.c              | 2 +-
 drivers/gpu/drm/meson/meson_drv.c            | 2 +-
 drivers/gpu/drm/msm/msm_drv.c                | 3 +--
 drivers/gpu/drm/mxsfb/mxsfb_drv.c            | 3 +--
 drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
 drivers/gpu/drm/radeon/radeon_drv.c          | 2 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c     | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c          | 2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                | 1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          | 2 +-
 drivers/staging/vboxvideo/vbox_drv.c         | 2 +-
 17 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0c22bae0c736..22502417c18c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1189,7 +1189,7 @@ amdgpu_get_crtc_scanout_position(struct drm_device *dev, unsigned int pipe,
 static struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_USE_AGP | DRIVER_ATOMIC |
-	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
+	    DRIVER_IRQ_SHARED | DRIVER_GEM |
 	    DRIVER_PRIME | DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ,
 	.load = amdgpu_driver_load_kms,
 	.open = amdgpu_driver_open_kms,
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index e68935b80917..8fc0b884c428 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -229,7 +229,7 @@ static int hdlcd_debugfs_init(struct drm_minor *minor)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver hdlcd_driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM |
+	.driver_features = DRIVER_GEM |
 			   DRIVER_MODESET | DRIVER_PRIME |
 			   DRIVER_ATOMIC,
 	.irq_handler = hdlcd_irq,
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 034a91112098..0be13eceedba 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -720,7 +720,7 @@ static void atmel_hlcdc_dc_irq_uninstall(struct drm_device *dev)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver atmel_hlcdc_dc_driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM |
+	.driver_features = DRIVER_GEM |
 			   DRIVER_MODESET | DRIVER_PRIME |
 			   DRIVER_ATOMIC,
 	.irq_handler = atmel_hlcdc_dc_irq_handler,
diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index 45a07652fa00..c5babb3e4752 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -103,9 +103,6 @@ int drm_irq_install(struct drm_device *dev, int irq)
 	int ret;
 	unsigned long sh_flags = 0;
 
-	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
-		return -EOPNOTSUPP;
-
 	if (irq == 0)
 		return -EINVAL;
 
@@ -174,9 +171,6 @@ int drm_irq_uninstall(struct drm_device *dev)
 	bool irq_enabled;
 	int i;
 
-	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
-		return -EOPNOTSUPP;
-
 	irq_enabled = dev->irq_enabled;
 	dev->irq_enabled = false;
 
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 54ace3436605..dfc73aade325 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -137,7 +137,7 @@ static irqreturn_t fsl_dcu_drm_irq(int irq, void *arg)
 DEFINE_DRM_GEM_CMA_FOPS(fsl_dcu_drm_fops);
 
 static struct drm_driver fsl_dcu_drm_driver = {
-	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET
 				| DRIVER_PRIME | DRIVER_ATOMIC,
 	.load			= fsl_dcu_load,
 	.unload			= fsl_dcu_unload,
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index ac32ab5aa002..7cf14aeb1c28 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -468,7 +468,7 @@ static const struct file_operations psb_gem_fops = {
 };
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | \
+	.driver_features = DRIVER_IRQ_SHARED | \
 			   DRIVER_MODESET | DRIVER_GEM,
 	.load = psb_driver_load,
 	.unload = psb_driver_unload,
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 337ee650d2de..550cfb945942 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -3010,7 +3010,7 @@ static struct drm_driver driver = {
 	 * deal with them for Intel hardware.
 	 */
 	.driver_features =
-	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM | DRIVER_PRIME |
+	    DRIVER_IRQ_SHARED | DRIVER_GEM | DRIVER_PRIME |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ,
 	.release = i915_driver_release,
 	.open = i915_driver_open,
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 2cbc6c7bb823..2281ed3eb774 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -94,7 +94,7 @@ static irqreturn_t meson_irq(int irq, void *arg)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver meson_driver = {
-	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM |
+	.driver_features	= DRIVER_GEM |
 				  DRIVER_MODESET | DRIVER_PRIME |
 				  DRIVER_ATOMIC,
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index d2cdc7b553fe..8747fb32a106 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1063,8 +1063,7 @@ static const struct file_operations fops = {
 };
 
 static struct drm_driver msm_driver = {
-	.driver_features    = DRIVER_HAVE_IRQ |
-				DRIVER_GEM |
+	.driver_features    = DRIVER_GEM |
 				DRIVER_PRIME |
 				DRIVER_RENDER |
 				DRIVER_ATOMIC |
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 54c8cdaeb576..967379f3f571 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -322,8 +322,7 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver mxsfb_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
-				  DRIVER_PRIME | DRIVER_ATOMIC |
-				  DRIVER_HAVE_IRQ,
+				  DRIVER_PRIME | DRIVER_ATOMIC,
 	.irq_handler		= mxsfb_irq_handler,
 	.irq_preinstall		= mxsfb_irq_preinstall,
 	.irq_uninstall		= mxsfb_irq_preinstall,
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 56f2c65969c6..44daac129205 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -243,7 +243,7 @@ static struct pci_driver qxl_pci_driver = {
 
 static struct drm_driver qxl_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
-			   DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED |
+			   DRIVER_IRQ_SHARED |
 			   DRIVER_ATOMIC,
 
 	.dumb_create = qxl_mode_dumb_create,
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 8897c3d18fbb..450a9d473c30 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -535,7 +535,7 @@ radeon_get_crtc_scanout_position(struct drm_device *dev, unsigned int pipe,
 static struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_USE_AGP |
-	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
+	    DRIVER_IRQ_SHARED | DRIVER_GEM |
 	    DRIVER_PRIME | DRIVER_RENDER,
 	.load = radeon_driver_load_kms,
 	.open = radeon_driver_open_kms,
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index 2002e7c55e80..cb821adfc321 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -127,7 +127,7 @@ static irqreturn_t shmob_drm_irq(int irq, void *arg)
 DEFINE_DRM_GEM_CMA_FOPS(shmob_drm_fops);
 
 static struct drm_driver shmob_drm_driver = {
-	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET
 				| DRIVER_PRIME,
 	.irq_handler		= shmob_drm_irq,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 13b11acd4a5e..3030af9e7b35 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -512,7 +512,7 @@ static int tilcdc_debugfs_init(struct drm_minor *minor)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver tilcdc_driver = {
-	.driver_features    = (DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET |
+	.driver_features    = (DRIVER_GEM | DRIVER_MODESET |
 			       DRIVER_PRIME | DRIVER_ATOMIC),
 	.irq_handler        = tilcdc_irq,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index f6f5cd80c04d..5fcd2f0da7f7 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -175,7 +175,6 @@ static struct drm_driver vc4_drm_driver = {
 	.driver_features = (DRIVER_MODESET |
 			    DRIVER_ATOMIC |
 			    DRIVER_GEM |
-			    DRIVER_HAVE_IRQ |
 			    DRIVER_RENDER |
 			    DRIVER_PRIME |
 			    DRIVER_SYNCOBJ),
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 25afb1d594e3..d159d0400013 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1582,7 +1582,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 };
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED |
+	.driver_features = DRIVER_IRQ_SHARED |
 	DRIVER_MODESET | DRIVER_PRIME | DRIVER_RENDER | DRIVER_ATOMIC,
 	.load = vmw_driver_load,
 	.unload = vmw_driver_unload,
diff --git a/drivers/staging/vboxvideo/vbox_drv.c b/drivers/staging/vboxvideo/vbox_drv.c
index cc6532d8c2fa..78cbcd68d4f3 100644
--- a/drivers/staging/vboxvideo/vbox_drv.c
+++ b/drivers/staging/vboxvideo/vbox_drv.c
@@ -221,7 +221,7 @@ static void vbox_master_drop(struct drm_device *dev, struct drm_file *file_priv)
 
 static struct drm_driver driver = {
 	.driver_features =
-	    DRIVER_MODESET | DRIVER_GEM | DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED |
+	    DRIVER_MODESET | DRIVER_GEM | DRIVER_IRQ_SHARED |
 	    DRIVER_PRIME | DRIVER_ATOMIC,
 	.dev_priv_size = 0,
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
