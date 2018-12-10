Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED331C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:29:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEADE20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RqEco8EP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xJIdGNeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEADE20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vsVFuQ4732VDaUfPbLGPLCHkok/wWxA7wUw8pu0qlMM=; b=RqEco8EPB/sd7e
	/OffmrfX3/2QVTYWN1aR78e9z9Z0k8iaN+acaJSK4ZmgJZ/dcwVDovF5Oy58D0y/DMI8WnfeAo13K
	iKaSNveVxW76Z0w0fjHHXnb8tecfkYl2twOkFEC35rpO3MPjVZJpi5xSymmiCm/9WSkRweCPj4thP
	uaggPfcqp6KVbMIIOEnFKhHsufOobN1+f9vrxNi+0nnohsB/QtsTd7fBeD68rTeBTFejZLGJFY+pA
	/SohyNn04WFO8oW4BniN69oNM8Vt/yiXxGR3iY99hBxq2ZdGVKU35POoyAtLmaAzdNiM+y3TgE57V
	PsVz+8wG2k18+mKySbaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHsP-0001Eo-V4; Mon, 10 Dec 2018 09:29:21 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHsK-0001Ci-UM
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:29:18 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so10178353wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DLy0SwLSlaGwBkl+R1noWL7/C+Z5I/Uca6dIaJcbB2c=;
 b=xJIdGNeKegPSOtQ+PEIf8lJnRNSP/2by2POqN0ozS4xMRjCrs94QlI6MkjbzxGo7/D
 6e5CdfuwmScOkQF6kKxVmeSJ4vz1n3rWiWiq9CYIZ0vUsuxp4PKEwfEOuK6AyQBlFYab
 0ccIrshx8NSYw7fgS0ncO1jXA7LZWkzHgbIpt9UqHvRPll+ObfbJB26dZB5nvstK2QRs
 xH0wPQLL9QWMirhhn0UoiMDBGRzmjxdZ54ab+H9zsvG9Dj1MoM/mFIpe6JgViqCctD6S
 YhDFtzARuwDxlTlOovCqYR40J/qyd+xWOCaPM61nwYAoIInyOq/2oGpz9623gTzcL2ry
 4QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DLy0SwLSlaGwBkl+R1noWL7/C+Z5I/Uca6dIaJcbB2c=;
 b=qEWM/P6/OgiKjMjqbph7DUbq4XCTMIE81b4DIlmAxUvyKqSIYx8IoeqlgD45jWUl90
 VZpYZ7ndrXTiq6/gLHmMKk88FD/ZW18EHgi2mH5X/TY7H4AW4O3Noa7GxNviCxrztBfk
 UD7S6zJWp93OoC+VtoVPijmNZ1jP1o2pa1PaTI3zOnZMHUYUDP/+ZBhJCdclXlpzb2Cl
 ICqJPTVSwdeMYP/g6/SyvCMP4yUF5EuLS9IsEoMYGOEYe07EsT8TeJJo4NKSLnEo36p8
 5bsWXocnhX1hTMeA6QvvxSn+54XKaNaVSzEHWpiC6w5sXZ3wxYL8gijYYVr/75vIxz0M
 D3Xg==
X-Gm-Message-State: AA+aEWbxJoiC1sckwsN57P0Z0rIrk98mCFiWNgKpzmpbVao8at9xhWdg
 9VCa58wji9+h5UFFADYNdiG4DQSWhbalNg==
X-Google-Smtp-Source: AFSGD/W8siubOMUy4gGFt2YEE32b0gn4hrwCzt6L4ZRUZsajc4Ozf6EFG5giz6Qhitltb66SY/EepA==
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr9737373wmd.111.1544434145308; 
 Mon, 10 Dec 2018 01:29:05 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id k128sm16348976wmd.37.2018.12.10.01.29.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 01:29:04 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RESEND] drm/meson: remove firmware framebuffers
Date: Mon, 10 Dec 2018 10:28:53 +0100
Message-Id: <20181210092853.13050-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_012917_038833_F8C2A3B8 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In case we are using simplefb or another conflicting framebuffer, make
the call to drm_fb_helper_remove_conflicting_framebuffers()

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index d3443125e661..afbb3d707d15 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -159,6 +159,23 @@ static void meson_vpu_init(struct meson_drm *priv)
 	writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
 }
 
+static void meson_remove_framebuffers(void)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	/* The framebuffer can be located anywhere in RAM */
+	ap->ranges[0].base = 0;
+	ap->ranges[0].size = ~0;
+
+	drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb",
+						      false);
+	kfree(ap);
+}
+
 static int meson_drv_bind_master(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -242,6 +259,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto free_drm;
 
+	/* Remove early framebuffers (ie. simplefb) */
+	meson_remove_framebuffers();
+
 	drm_mode_config_init(drm);
 	drm->mode_config.max_width = 3840;
 	drm->mode_config.max_height = 2160;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
