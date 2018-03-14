From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 14 Mar 2018 11:45:06 +0530
Subject: [PATCH v5 14/36] drm/bridge: analogix_dp: Extend hpd check time
 to 100ms
In-Reply-To: <20180309222327.18689-15-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-15-enric.balletbo@collabora.com>
Message-ID: <7a95aaf7-f692-c476-e4b6-822a6923951a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> There was a 1ms delay to detect the hpd signal, which is too short to
> detect a short pulse. This patch extends this delay to 100ms.
> 

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: St?phane Marchesin <marcheu@chromium.org>
> Cc: ?? ? <wzz@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 3a222e7e46ee..6cbde8473f58 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -76,7 +76,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
>   			return 0;
>   
>   		timeout_loop++;
> -		usleep_range(10, 11);
> +		usleep_range(1000, 1100);
>   	}
>   
>   	/*
> 
