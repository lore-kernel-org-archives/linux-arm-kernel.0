From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 14:06:43 -0600
Subject: [RFC PATCH 3/4] drm/tegra: Request memory bandwidth for the
 display controller
In-Reply-To: <1402925713-25426-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-4-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <539F4E53.6080205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> Request it based solely on the current mode's refresh rate. More
> accurate requirements can be requested in future patches.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c

> +	bandwidth = mode->clock * window.bits_per_pixel / 8;
> +	err = tegra124_emc_reserve_bandwidth(TEGRA_EMC_CONSUMER_DISP1, bandwidth);

DISP1 shouldn't be hard-coded here; the code should use DISP1 or DISP2
based on head or DC identity. We certainly have some boards capable of
dual-head operation.
