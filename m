Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB550C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:59:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898CA217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZIRTm1nd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fZjAqFlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898CA217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gc0YnlADtvzOV00dwRYe7eOnlE4RjyKvlU/vWxwan/0=; b=ZIRTm1ndSVZYhi
	cpp9Uac9Gea4f+SY+MiOjgweRI2VEbB3N0FZ0e5yVQSD79xiUNnGWs36tJFPLzal0zQ3KVyDXuHOn
	p+Mu5mnVujd3/gsNjhkZanSDTC40MgLjAZYl+ukJWEwZ2cVS3UXcXhiLnNRQRrQtQu05y2ahsGWEG
	4rXRhD9TWN+locTP/0gVECq0beMEZnYTGI2ZJnsU22FOMZ3wrYuKXonysn9f1fhUWg6NH5G9sRatO
	vxK3yfh/aCGCgoY1Ap5Toj4cf7trK3FYjbP93bJ00J4/bqZftHYH++G2yW5fdHyMYjMcrm2Sy2LJz
	4xyZc57LiUtCCZbJ22/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiLP-00015I-LW; Thu, 24 Jan 2019 16:59:11 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiLB-0000rA-Tt
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:59:05 +0000
Received: by mail-ed1-x542.google.com with SMTP id x30so5178919edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RtsztvXLlPailp5EdBbJQywHawsntMUfvlxqGQH2rkw=;
 b=fZjAqFlqSg6v5+lJjSiTqeAUnP5qtmrqdWq+flkVtLaU5JN4osTx2pWVLEY/Lh67QM
 5iHmXEHqwEy+ElawGFg/v4kYJFgNEr5pMcKsqA091w2YriwD3DWspb7Hpbu8n1MC3nYy
 h6D8wM8RTDB//B07vmcSW/zsJOCEZqHad9oKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RtsztvXLlPailp5EdBbJQywHawsntMUfvlxqGQH2rkw=;
 b=S5jSXnZ7iBFNRnDfWgDNJuDzZx5FDaJQMlshURChMHajyeVUzbgFcVEXE+C953p/XC
 9OVTpPzJoSRlb2i5X6iOrB4kGGU4OlAQe0yJLdIbgps+AL/6+aJAgsBIKm4C+5Y8chC9
 ejGkxr4uA3FAvSo0SyY+NeYT/tCue+K15Lf8iKSSnJ/f29E4GOyyMuFqeZf4MhCKVyK7
 eiSHFK9Hwrede8hDrsbnf+FsoQ3jTuFJWXYEaHU0ZGdKnl7LTh0NzUGNWoytgXxXEbhs
 Tl+KAKvjrreUrWamlHELE8cAukk51NYQt1WhXMJ8P1zxgRsU6cnPpx2Ogv/KLuWC615d
 Hutw==
X-Gm-Message-State: AJcUukdjYq69yHD5su5eV7JncaXrfKixvNMbCbgVx0aYYtdzgPf7km1p
 Iehlqc4FSnceW5DIwdlau7sVlQ==
X-Google-Smtp-Source: ALg8bN6XLngT/BZgEYaXUVr0kFk6qrBU1PJ4qhynxx2maGLbkKn9LGXI6pFeyghvMMmS3LX9gqOedA==
X-Received: by 2002:a17:906:55b:: with SMTP id
 k27mr2203798eja.78.1548349135976; 
 Thu, 24 Jan 2019 08:58:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id w31sm11219233edw.82.2019.01.24.08.58.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 08:58:54 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 11/26] drm/exynos: Use drm_fb_helper_fill_info
Date: Thu, 24 Jan 2019 17:58:16 +0100
Message-Id: <20190124165831.16427-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_085859_024609_D565BBEB 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This will give the exynos fbdev a name!

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index f057082a9b30..b2018961b9cf 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -87,12 +87,10 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 		return PTR_ERR(fbi);
 	}
 
-	fbi->par = helper;
 	fbi->flags = FBINFO_FLAG_DEFAULT;
 	fbi->fbops = &exynos_drm_fb_ops;
 
-	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->format->depth);
-	drm_fb_helper_fill_var(fbi, helper, sizes->fb_width, sizes->fb_height);
+	drm_fb_helper_fill_info(fbi, helper);
 
 	nr_pages = exynos_gem->size >> PAGE_SHIFT;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
