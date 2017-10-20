From: jeffy.chen@rock-chips.com (jeffy)
Date: Sat, 21 Oct 2017 07:14:19 +0800
Subject: [PATCH] drm/rockchip: Fix build warning in analogix_dp-rockchip.c
In-Reply-To: <20171020172557.54900-1-seanpaul@chromium.org>
References: <20171020172557.54900-1-seanpaul@chromium.org>
Message-ID: <59EA834B.4090807@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On 10/21/2017 01:25 AM, Sean Paul wrote:
> I didn't catch this before applying, just right after (of course).
>
> Fixes:
> ../drivers/gpu/drm/rockchip/analogix_dp-rockchip.c: In function
> ?rockchip_dp_of_probe?:
> ../drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:276:6: warning:
> unused variable ?ret? [-Wunused-variable]
>    int ret;
>          ^~~

sorry, i thought i fixed that, but it looks like i amended it to the 
wrong commit by mistake...
>
> Fixes: 102712a32ff5 ("drm/rockchip: analogix_dp: Remove unnecessary init
> code")
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Mark Yao <mark.yao@rock-chips.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 8cae5ad926cd..39944c0f1c0b 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -273,7 +273,6 @@ static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
>   {
>   	struct device *dev = dp->dev;
>   	struct device_node *np = dev->of_node;
> -	int ret;
>
>   	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
>   	if (IS_ERR(dp->grf)) {
>
