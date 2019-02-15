Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98439C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:10:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D512192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AoyB4C4Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpMxI3hH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D512192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ybnVyMv6Kkii7UmoKoQ+4tSTctIkpnbmuTyWc9xpwj4=; b=AoyB4C4Z8cgMpF
	3cHngdVemvdvi0UWIf1IsS2wD+UGMnlnmLB7rEMKaXqaDAMjuhOx2O1TkDD0fbaHU/qFfXgDsdufA
	Mef8Q6BLN0WjR6p9QoNhjFE6jzNOf4m2fzNfWi6hwqhRQt0xUcbkpwLKy8zl0RyexPbzrz/+oiVmi
	T0ePPGbBa51V3NT6RIfcuZqtp9pV4PWfAYNDMJtT9rBYK0j4xA8C6BEm9TsAH54tUc80oBQG4yaPo
	+29bxnkJrtGiG0UmHcheWnQTAByNZwCjRGgv5BWxy9exy3D0+MAnDzErkvA2gh+lb2PYL68SSJegF
	jteWI4SUfMeJAhtT3iTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVlp-0003ny-EF; Fri, 15 Feb 2019 05:10:41 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVlY-0003Uj-CF
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:25 +0000
Received: by mail-pf1-x443.google.com with SMTP id j18so4269988pfe.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PuxySVJ3fO0V9uDlWgfJutGwWKrPJy2ZOzGhtEOFHp4=;
 b=bpMxI3hHC6YYrJfMJKkwbmsUfAbnR6xftZlRebh2lRLOsWbXj9hVjXl7ZFvAFOILd2
 du11ZQDf+vR9bhlPz7EXqGQTscbsSACJCur3qVeLsQ5pTbzzfXTwFbdvP5J3zeJ0eqU6
 vX9GVhsOyauZEPUhDP+Bh3Rg81vCj0jKwuq8dbDyFoDsPvRSs09EmZep5KVchKsfXtzX
 z00HbxMkg3F5CxwU5VQIqLQeR95Cy7mcymkcTTIkqlbLKCBhkP23Q61pJ7T5O1l/Xt/U
 ClltaK7lI1gGcnv+cvc9nZj6YHcd8wnmfSMjWCFXWSpWuvmLvHJaaKHHR8rQEY7LQJ6r
 vinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PuxySVJ3fO0V9uDlWgfJutGwWKrPJy2ZOzGhtEOFHp4=;
 b=iQ5PS8wWK6s56RWb2UfHac6jm2vl/NSP33a02zIbiMjQUX27yxtVi2Pwvq7ovzsnnu
 k3npUUVjoVTIFqN6kAAQvE77ad/yT2blVyLVcG1aHBZg53CQyw6MTmxxyMZKsub5CqcT
 79SxZaspK7pEEbROeasjooRhM1r7Jfmy8SUiRSB7oP6Nh9FIlRzQBaHfOo49EngwwmON
 IoVwwgDNNpwvhdW6ZrzZ0YVlxJH+rFENqv2U2b77tJo0eJepu8xFubYmFZxkMYuuQ044
 pCXlppzUnzC0nXuxMUSfuHYNGeXHgMYR/aCy5XT008ffuiPZ8KT91shfxICRXtOuKbbl
 bzHQ==
X-Gm-Message-State: AHQUAuawTP3z0fpqLfHYgjzvBqAeSejTY8qDLRFyf2Ls/CQUmy/dzi7d
 5KlmQjixN1oRJ7TGmHPQ+n0=
X-Google-Smtp-Source: AHgI3IZziXhINa4lsS11joDk77vH9YmBHUHs8FmWRDXvq4hfZVRZILURkPqRvk8tQFacTuUEN+teDA==
X-Received: by 2002:a62:f204:: with SMTP id m4mr7897326pfh.58.1550207423586;
 Thu, 14 Feb 2019 21:10:23 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:22 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH v3 01/11] drm/bridge: move ANA78xx driver to analogix
 subdirectory
Date: Thu, 14 Feb 2019 21:09:47 -0800
Message-Id: <20190215050957.20755-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211024_414010_2AB98DA2 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

As ANA78xx chips are designed and produced by Analogix Semiconductor,
Inc, move their driver codes into analogix subdirectory.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/bridge/Kconfig                         | 10 ----------
 drivers/gpu/drm/bridge/Makefile                        |  4 ++--
 drivers/gpu/drm/bridge/analogix/Kconfig                | 10 ++++++++++
 drivers/gpu/drm/bridge/analogix/Makefile               |  1 +
 .../gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c   |  0
 .../gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h   |  0
 6 files changed, 13 insertions(+), 12 deletions(-)
 rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (100%)
 rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h (100%)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 2fee47b0d50b..4922c1ceffef 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -15,16 +15,6 @@ config DRM_PANEL_BRIDGE
 menu "Display Interface Bridges"
 	depends on DRM && DRM_BRIDGE
 
-config DRM_ANALOGIX_ANX78XX
-	tristate "Analogix ANX78XX bridge"
-	select DRM_KMS_HELPER
-	select REGMAP_I2C
-	---help---
-	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
-	  designed for portable devices. The ANX78XX transforms
-	  the HDMI output of an application processor to MyDP
-	  or DisplayPort.
-
 config DRM_CDNS_DSI
 	tristate "Cadence DPI/DSI bridge"
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 4934fcf5a6f8..a6c7dd7727ea 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
 obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
 obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
@@ -12,8 +11,9 @@ obj-$(CONFIG_DRM_SII9234) += sii9234.o
 obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
-obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
 obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
 obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
+
+obj-y += analogix/
 obj-y += synopsys/
diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index 80f286fa3a69..c4d343a2f04d 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -1,3 +1,13 @@
+config DRM_ANALOGIX_ANX78XX
+	tristate "Analogix ANX78XX bridge"
+	select DRM_KMS_HELPER
+	select REGMAP_I2C
+	help
+	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
+	  designed for portable devices. The ANX78XX transforms
+	  the HDMI output of an application processor to MyDP
+	  or DisplayPort.
+
 config DRM_ANALOGIX_DP
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
index cd4010ba6890..ce1687e60975 100644
--- a/drivers/gpu/drm/bridge/analogix/Makefile
+++ b/drivers/gpu/drm/bridge/analogix/Makefile
@@ -1,2 +1,3 @@
 analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
+obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
similarity index 100%
rename from drivers/gpu/drm/bridge/analogix-anx78xx.c
rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
similarity index 100%
rename from drivers/gpu/drm/bridge/analogix-anx78xx.h
rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
