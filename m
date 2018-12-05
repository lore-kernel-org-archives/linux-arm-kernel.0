Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD324C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:17:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0E920892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJvoS7vY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7BtN5y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0E920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R4bRh9oYxDXpZEtH858gVGd6bxkEKJpQlQDw7vQ6ZSc=; b=XJvoS7vY7OYhvY
	e9QIexRQNShSexOHPtN3fat5jwPGInFfks5IQEljK9YkVb9vk8mpahMapsCeGigNQUzNI17F7Kuvq
	FWyTsK/F9nk9W8n3u6c+hmBbXyjCb9EUSZOUakUDwY/NN+tPzx9MQD812stpUhn6UY/ebW61BcuLO
	yHxErpgFeR2w/0TzU0Y53+t2dl93KUK/1c64KxZBSDm8GyQ/VEUeS2w1JeqPaj1dKeGvjIXsLWJr3
	E/VXDS7PPB+BDNIQ5LwFUM7MO6LQnDwxeBHiBUb4ppID+k4iKRoyN8gKZ6ZckYpETXqd7ywaTSiZt
	ovs/+KhzFUqdB0yeU/bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbje-00049x-UJ; Wed, 05 Dec 2018 18:17:22 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbja-00048g-67
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:17:20 +0000
Received: by mail-pg1-x544.google.com with SMTP id 80so9380036pge.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6vMht8+Ph9JHpETTWF5GW6LB5/gngb0kDvS5i0Ablh0=;
 b=O7BtN5y/jc8pG7n9rlH2yavCcgsXRlYXvkH6x6VfMOtfIbvE4IRjaJ6DgW625xSZ5C
 AsnvmXyNeDYZFKuYvJgpFykWxavJi7lf5tozQfx57/YlBTXQeNdSSw6Jk9aC5j+Ea/Ki
 OtgbIbl6TLsEJpDi9q/yYjUsoxJtLVFtpvIb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6vMht8+Ph9JHpETTWF5GW6LB5/gngb0kDvS5i0Ablh0=;
 b=ICH0fH1bckbcEugamh6IwUhC4NSiWDBthaiedr7Ts4l2TEue6cXq4r6W8DPLGf+Xnw
 KTTXcw6JVJcG51eORRZa83VVlirk/dXp1YB5x3GPwAZ3Jp6jUYm+Yl9uBPpPkQUqaLoi
 4sEkzxcwkYeYYKPgL20IcslBriRSekZFZ5YfdYEBNrKoYX8wMArwML96y0Z+kYerVdJP
 NVsb7bwIojd2c/MMSxtAvcZa/Uz6OH47MrHMMnfH1iiiUsBuRqZtnSxbdDXYx7wWgPBw
 RGBVdpgI48hTCryw7BGNoukF8SHYnLjwfEOYdKLIUsDiFk+kw6jOJ6T4S4A/GAEhekzU
 waXA==
X-Gm-Message-State: AA+aEWY1xl6BdN3VIwgkeqG+QQROKvCFqpFiYvS8lExypSOI7AGQQoWn
 lVlfz7rxyNlIDTfoD59d8IzZzg==
X-Google-Smtp-Source: AFSGD/UNOuP1DFWZAhtStiObktfOGcOAV8B2mnfuBvwmMAPxs4uJYKeyjgD7750wF4j4ydZKruQcaA==
X-Received: by 2002:a65:610d:: with SMTP id z13mr21601439pgu.427.1544033827360; 
 Wed, 05 Dec 2018 10:17:07 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id w88sm21061483pfk.11.2018.12.05.10.17.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 10:17:05 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>
Subject: [PATCH for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on
 reboot/kexec"
Date: Wed,  5 Dec 2018 10:16:57 -0800
Message-Id: <20181205181657.177703-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_101718_249445_0E290E37 
X-CRM114-Status: GOOD (  13.01  )
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
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Vicente Bergas <vicencb@gmail.com>,
 Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 Sean Paul <seanpaul@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
 Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit 7f3ef5dedb146e3d5063b6845781ad1bb59b92b5.

It causes new warnings [1] on shutdown when running the Google Kevin or
Scarlet (RK3399) boards under Chrome OS. Presumably our usage of DRM is
different than what Marc and Heiko test.

We're looking at a different approach (e.g., [2]) to replace this, but
IMO the revert should be taken first, as it already propagated to
-stable.

[1] Report here:
http://lkml.kernel.org/lkml/20181205030127.GA200921@google.com

WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x294
...
 Call trace:
  drm_mode_config_cleanup+0x1c4/0x294
  rockchip_drm_unbind+0x4c/0x8c
  component_master_del+0x88/0xb8
  rockchip_drm_platform_remove+0x2c/0x44
  rockchip_drm_platform_shutdown+0x20/0x2c
  platform_drv_shutdown+0x2c/0x38
  device_shutdown+0x164/0x1b8
  kernel_restart_prepare+0x40/0x48
  kernel_restart+0x20/0x68
...
 Memory manager not clean during takedown.
 WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mm.c:950 drm_mm_takedown+0x34/0x44
...
  drm_mm_takedown+0x34/0x44
  rockchip_drm_unbind+0x64/0x8c
  component_master_del+0x88/0xb8
  rockchip_drm_platform_remove+0x2c/0x44
  rockchip_drm_platform_shutdown+0x20/0x2c
  platform_drv_shutdown+0x2c/0x38
  device_shutdown+0x164/0x1b8
  kernel_restart_prepare+0x40/0x48
  kernel_restart+0x20/0x68
...

[2] https://patchwork.kernel.org/patch/10556151/
    https://www.spinics.net/lists/linux-rockchip/msg21342.html
    [PATCH] drm/rockchip: shutdown drm subsystem on shutdown

Fixes: 7f3ef5dedb14 ("drm/rockchip: Allow driver to be shutdown on reboot/kexec")
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Vicente Bergas <vicencb@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 941f35233b1f..5864cb452c5c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -448,11 +448,6 @@ static int rockchip_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
-{
-	rockchip_drm_platform_remove(pdev);
-}
-
 static const struct of_device_id rockchip_drm_dt_ids[] = {
 	{ .compatible = "rockchip,display-subsystem", },
 	{ /* sentinel */ },
@@ -462,7 +457,6 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_ids);
 static struct platform_driver rockchip_drm_platform_driver = {
 	.probe = rockchip_drm_platform_probe,
 	.remove = rockchip_drm_platform_remove,
-	.shutdown = rockchip_drm_platform_shutdown,
 	.driver = {
 		.name = "rockchip-drm",
 		.of_match_table = rockchip_drm_dt_ids,
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
