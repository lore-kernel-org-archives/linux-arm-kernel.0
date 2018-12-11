Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:35:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C900720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mD2Lf9Y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C900720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BWsBVb9bvgOPUoempNxKLUOJ/v7Udorvqwup/DFNrpY=; b=mD2Lf9Y4w/bg01
	9pq1FMT5ZGE+FstgOgldSWYNiJR5bf0HMozzp224lZPFaMI7cmTPJDzTQXkKsUfPwSJ/XzyXj+llG
	T4Cy45xYM0FUbNf4LMZvuuJaxg8EudSOhDGFqiumaR1JL4At/xMPQWsRRCDHwHOc+xlgNZS3qRVC0
	O1OXavDWTT687A1bPcpT97AO6dVvbM5TJKach2BjGz/mp3pK1WRnZUf4aPlDPBTJySijsU2RViCwp
	Hnj6zVT12CS0tifN1OdZrq7XKonLz4Kvcq4wdVVSNgIPtplBv+bTO8EKhCNcJaaQzOJ6gvCkmJc2d
	wMVsA/uQ7WwY/iU5h4aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWk3n-0003MQ-MR; Tue, 11 Dec 2018 15:34:59 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWk3i-0003LK-R1; Tue, 11 Dec 2018 15:34:56 +0000
Received: from p5b127a5a.dip0.t-ipconnect.de ([91.18.122.90]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gWk3P-0006zm-U2; Tue, 11 Dec 2018 16:34:35 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.20] Revert "drm/rockchip: Allow driver to be
 shutdown on reboot/kexec"
Date: Tue, 11 Dec 2018 16:34:35 +0100
Message-ID: <2584922.nx44hha6lV@phil>
In-Reply-To: <20181205181657.177703-1-briannorris@chromium.org>
References: <20181205181657.177703-1-briannorris@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_073455_018096_94EBC634 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: Vicente Bergas <vicencb@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Sandy Huang <hjc@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Sean Paul <seanpaul@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
 Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 5. Dezember 2018, 19:16:57 CET schrieb Brian Norris:
> This reverts commit 7f3ef5dedb146e3d5063b6845781ad1bb59b92b5.
> 
> It causes new warnings [1] on shutdown when running the Google Kevin or
> Scarlet (RK3399) boards under Chrome OS. Presumably our usage of DRM is
> different than what Marc and Heiko test.
> 
> We're looking at a different approach (e.g., [2]) to replace this, but
> IMO the revert should be taken first, as it already propagated to
> -stable.
> 
> [1] Report here:
> http://lkml.kernel.org/lkml/20181205030127.GA200921@google.com
> 
> WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x294
> ...
>  Call trace:
>   drm_mode_config_cleanup+0x1c4/0x294
>   rockchip_drm_unbind+0x4c/0x8c
>   component_master_del+0x88/0xb8
>   rockchip_drm_platform_remove+0x2c/0x44
>   rockchip_drm_platform_shutdown+0x20/0x2c
>   platform_drv_shutdown+0x2c/0x38
>   device_shutdown+0x164/0x1b8
>   kernel_restart_prepare+0x40/0x48
>   kernel_restart+0x20/0x68
> ...
>  Memory manager not clean during takedown.
>  WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mm.c:950 drm_mm_takedown+0x34/0x44
> ...
>   drm_mm_takedown+0x34/0x44
>   rockchip_drm_unbind+0x64/0x8c
>   component_master_del+0x88/0xb8
>   rockchip_drm_platform_remove+0x2c/0x44
>   rockchip_drm_platform_shutdown+0x20/0x2c
>   platform_drv_shutdown+0x2c/0x38
>   device_shutdown+0x164/0x1b8
>   kernel_restart_prepare+0x40/0x48
>   kernel_restart+0x20/0x68
> ...
> 
> [2] https://patchwork.kernel.org/patch/10556151/
>     https://www.spinics.net/lists/linux-rockchip/msg21342.html
>     [PATCH] drm/rockchip: shutdown drm subsystem on shutdown
> 
> Fixes: 7f3ef5dedb14 ("drm/rockchip: Allow driver to be shutdown on reboot/kexec")
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Vicente Bergas <vicencb@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@chromium.org>

So, I've applied this revert to drm-misc-fixes now, so it should still
land in 4.20-rc.

I'll resurrect Vicentes patch for a later regular inclusion as well,
but with more testing involved.


Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
