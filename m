Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF9C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:32:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1447C20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I22IfDUA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="jI91dIFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1447C20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=IsXxt4Bzj3krWA+nU7rg+7rjifGM+897fSrQwyT2r3c=; b=I22
	IfDUAXGXZnQ2XLcJq2iICMqppgaVCLSOFA6Pz5xXkCBtRJCbOoMc55uW7Kx/lzrZITzdiYLioRqKE
	P0z1sdsqn3LC8S1QRaqp7TfFkZFzAB5rtXhjwx5xh4UWVuQ9yCFx8Rg/HP4wfw6cmf/grDqoudoOV
	6u+24tI2uzMg6AurLZVQUwhUmKThkhoOX40pPZ+FnKJUOoCNZxdtSX3e3pKt4u3/xdf6ZpkeWKq5T
	v5icllr08Jnlc99/5FADdFgQ/JflmqSi2y15sXrwScydbekV7f9FfFBuRZzjdVlilZ/s/3etEuqPf
	cpa2WAr3nZXPJb9k6MlZ4JiUiXciO1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqY3-0004UI-HT; Tue, 22 Jan 2019 07:32:39 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqY0-0004Is-Gg
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 07:32:38 +0000
Received: from localhost (unknown [IPv6:2001:bb8:4008:ff:21a:64ff:fe97:f62])
 by plaes.org (Postfix) with ESMTPSA id 4366E40377;
 Tue, 22 Jan 2019 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1548142354; bh=B1Qep9dESQIpSgo3ifGmlcmiBpGPcpysADD3kbecHoI=;
 h=From:To:Cc:Subject:Date:From;
 b=jI91dIFhE51RhvSc3Ns5QVancwYQOppbWroe3RREntyxrC4DxKFTEr8gG6nnCEmUj
 1hc0Rzd5hD8t/5jP5h5vqJOSF/bb7zwp795niUohEZU+rsQOX0UZ7FLSbh3455mdzn
 iyY+64aNn8zKfZXqTKux4ezUbGhkWt0ciw1Pc/Tdkc0a3ZIiqHKp9tJM/j3HtEijiL
 TphNjOzZAy2XoUta3m4/j+7O7NP62NxBWSQBIPgtnVm1xgI9Wskzo5UnaqysdTOb4q
 yrpOv/yRbTee1HQbK3M90L/StNDW2vfwbUlM3c6E1Cds+9VhpL5VZhiffIjuHPz8E5
 L+uY1yvHoEoMw==
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: hdmi: Fix usage of TMDS clock
Date: Tue, 22 Jan 2019 09:32:32 +0200
Message-Id: <20190122073232.7240-1-plaes@plaes.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_233236_768809_FDE6AB16 
X-CRM114-Status: UNSURE (   7.95  )
X-CRM114-Notice: Please train this message.
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
Cc: Priit Laes <priit.laes@paf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Priit Laes <priit.laes@paf.com>

Although TMDS clock is required for HDMI to properly function,
nobody called clk_prepare_enable(). This fixes reference counting
issues and makes sure clock is running when it needs to be running.

Due to TDMS clock being parent clock for DDC clock, TDMS clock
was turned on/off for each EDID probe, causing spurious failures
for certain HDMI/DVI screens.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")

Signed-off-by: Priit Laes <priit.laes@paf.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 061d2e0d9011..25f4d676fd82 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -92,6 +92,8 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
 	val = readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
 	val &= ~SUN4I_HDMI_VID_CTRL_ENABLE;
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
+
+	clk_disable_unprepare(hdmi->tmds_clk);
 }
 
 static void sun4i_hdmi_enable(struct drm_encoder *encoder)
@@ -112,6 +114,8 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
 
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
+
+	clk_prepare_enable(hdmi->tmds_clk);
 }
 
 static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
