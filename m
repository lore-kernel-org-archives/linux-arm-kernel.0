From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Mon, 16 Mar 2015 13:15:01 +0100
Subject: [PATCH 1/1] ARM: dts: don't make DP a consumer of DISP1 on
 Exynos5250
In-Reply-To: <1426320716-28137-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1426320716-28137-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <5506C945.5030603@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.03.2015 um 09:11 schrieb Javier Martinez Canillas:
> By making the DP controller a consumer of DISP1, the PD is powered
> off when the exynos-dp probe is deferred and powered on again when
> the exynos-drm driver is probed.
> 
> But this causes the exynos-dp driver failing to obtain the stream
> clock since the FIMD has been powered off with the DISP1 PD:
> 
> exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
> exynos-dp 145b0000.dp-controller: unable to config video
> 
> The Exynos5250 documentation doesn't mention that the Display Port
> Transmitter module is included in the DISP1 PD so the device should
> not have a reference to this Power Domain.
> 
> This patch fixes video display on an Exynos5250 Snow Chromebook.
> 
> Fixes: 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250")
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Hello Andrzej and Marek,
> 
> I need this patch to have display working on an Snow Chromebook

Tested-by: Andreas F?rber <afaerber@suse.de>

This fixes the display on the Spring Chromebook as well!

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
