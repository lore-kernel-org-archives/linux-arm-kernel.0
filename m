Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD936C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:22:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C5F21B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D4AUY6UT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGKRC0b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C5F21B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HJ+XiyLxE7Tn6aTMw+TxT1tDkcVgPEk3Pef5l6OHENA=; b=D4AUY6UTxe0BMp
	Xv51pvbLX0BBqAFCVOKEKuQulJhSkaFKKQHVXZozlqEpHZloch1iKxmH+D0XowL5vHUR9LaLb55Ed
	auA6qOOYgGxvi//EChnDmwax5pGRfCynt0Vhyl3pTvsSimAkQ0adeMWHJS2qB/0cyO04UkaKS7tBS
	1UQZ3PeusjFaw9SQEo6PlmVfebKTWbYy6dMDtRxH1WBS1W9W6e8rGcoldwZFr4u3zBwsJkzEfACZi
	rzHUJC1+WwsnaIMx6OUwbAvmZp1axh86mJvIfnJEXO2I3kTjzpuJsm6AwF+AogOn1xHgwtB9Euf8w
	QMRQj50f3x8sY2VADhsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVxD-0000cU-SJ; Fri, 15 Feb 2019 05:22:27 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVlh-0003f8-Ef
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:38 +0000
Received: by mail-pg1-x541.google.com with SMTP id u9so698633pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J0Zd5pbglwpw5Die2Vji6PMd+QXXJ8XC/pUhM/WI+uc=;
 b=GGKRC0b2h2m9Ar/7VlEMTaRRpe1zbk7E/8Cn1gOiHl6nFRNa1YrjT+YngPTC2zMnqh
 sg6iaz0xoDseti+FsQnQXmNRnWVyqS8iGvBybNSUHOSDJNxBlEoHjmBLF44+ncIsfQTB
 3wbiFU+LeUKEiKGlIgCll/sd28fi2GwQfTQMqWvDZg/HpllUz7tjUdC2zyObGIy0SytD
 NmP0/FG+IOpITepoSjjuGMaoou2nQ4o4D8ntYnmSuHbjvcMWFAGJKuh901X/MC/4c5z6
 nrI6pgl6cb22TsyM/j8Zo+BGlhIOh0waQm3wZWIUZX+6YQSp7RBr9Ld8oqVYPT1oRqU3
 vpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J0Zd5pbglwpw5Die2Vji6PMd+QXXJ8XC/pUhM/WI+uc=;
 b=rsoJycXjoSDB7NZJApF5xpCBklGdSDLe1bjwFn5mXRTI3w6cJvnuTrq8N/XiL2iY2e
 Xvtq2vfYX1lUrGFZ0dkSWBc2T9M40S2Y7EhxQOn3SMhaaPHUmEe2lKM7kgNpAJhtZe5T
 idVUQ6RG+E1dIb7BRricuRrYhQCh9krUr7KomxlPOgOuejIlPhd3+A47BaS0gUROv+MS
 oHgJRwktnizq94tMgJrtwh9yZObB1P1crh0RhBCR3G2wngBDBg7mVdQs2+CEMceurknN
 ZV2YAtup0IRLp1OXv8UCToubPczJYCXQgI9JG7Mj7DokAV/WGGnQjOMm9aXxxwhfPVB8
 ZrkQ==
X-Gm-Message-State: AHQUAuZ7Jx/Q+2JZECudb+o1hS5+oPl3xJbHUmbi+fbqNXd2/mMAT8wR
 ztVL7gzaJQs5zET1WG2puRk=
X-Google-Smtp-Source: AHgI3Ia2aGQuisqtlz9PlmgBnM9NLRg1owS3bVHyLoPqiW+/AF+8oMKxi5oY6tqGekV3dGGMQJs5Cw==
X-Received: by 2002:a62:c42:: with SMTP id u63mr7831519pfi.73.1550207432771;
 Thu, 14 Feb 2019 21:10:32 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:32 -0800 (PST)
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
Subject: [PATCH v3 10/11] drm/panel: simple: Add NewEast Optoelectronics CO.,
 LTD WJFH116008A panel support
Date: Thu, 14 Feb 2019 21:09:56 -0800
Message-Id: <20190215050957.20755-11-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211033_588247_386E0F62 
X-CRM114-Status: GOOD (  16.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This commit adds support for the NewEast Optoelectronics CO., LTD
WJFH116008A 11.6" 1920x1080 TFT LCD panel.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../display/panel/neweast,wjfh116008a.txt     |  7 ++++
 drivers/gpu/drm/panel/panel-simple.c          | 39 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt

diff --git a/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
new file mode 100644
index 000000000000..d76579f9f55e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
@@ -0,0 +1,7 @@
+NewEast Optoelectronics CO., LTD WJFH116008A 11.6" 1920x1080 TFT LCD panel
+
+Required properties:
+- compatible: should be "neweast,wjfh116008a"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9a4c9dd02c6c..3edc77e49d8f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1843,6 +1843,42 @@ static const struct panel_desc netron_dy_e231732 = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode neweast_wjfh116008a_modes[] = {
+{
+	.clock = 138500,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 48,
+	.hsync_end = 1920 + 48 + 32,
+	.htotal = 1920 + 48 + 32 + 80,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 5,
+	.vtotal = 1080 + 3 + 5 + 23,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+}, {
+	.clock = 110920,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 48,
+	.hsync_end = 1920 + 48 + 32,
+	.htotal = 1920 + 48 + 32 + 80,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 5,
+	.vtotal = 1080 + 3 + 5 + 23,
+	.vrefresh = 48,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+} };
+
+static const struct panel_desc neweast_wjfh116008a = {
+	.modes = neweast_wjfh116008a_modes,
+	.num_modes = 2,
+	.size = {
+		.width = 260,
+		.height = 150,
+	},
+};
+
 static const struct drm_display_mode newhaven_nhd_43_480272ef_atxl_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -2690,6 +2726,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "netron-dy,e231732",
 		.data = &netron_dy_e231732,
+	}, {
+		.compatible = "neweast,wjfh116008a",
+		.data = &neweast_wjfh116008a,
 	}, {
 		.compatible = "newhaven,nhd-4.3-480272ef-atxl",
 		.data = &newhaven_nhd_43_480272ef_atxl,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
