From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 21 Jun 2017 08:48:52 +0800
Subject: [PATCH 1/2] drm/rockchip: add const to drm_encoder_helper_funcs
 structures
In-Reply-To: <1497964080-27301-2-git-send-email-bhumirks@gmail.com>
References: <1497964080-27301-1-git-send-email-bhumirks@gmail.com>
 <1497964080-27301-2-git-send-email-bhumirks@gmail.com>
Message-ID: <5949C274.6050806@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?06?20? 21:07, Bhumika Goyal wrote:
> Add const to drm_encoder_helper_funcs structures as they are only passed
> as an argument to the function drm_encoder_helper_add and this argument
> is of type const. So, add const to these structures. Also, fix line over
> 80 characters warning while adding const.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 3 ++-
>   drivers/gpu/drm/rockchip/inno_hdmi.c            | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 9606121..96c6c10 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -252,7 +252,8 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
>   	return 0;
>   }
>   
> -static struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
> +static
> +const struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {

I don't think split static and const into two line is a good idea, it's 
ugly. I'm ok over 80 characters with good-looking.
Or split like following:
static const struct drm_encoder_helper_funcs
rockchip_dp_encoder_helper_funcs = {

>   	.mode_fixup = rockchip_dp_drm_encoder_mode_fixup,
>   	.mode_set = rockchip_dp_drm_encoder_mode_set,
>   	.enable = rockchip_dp_drm_encoder_enable,
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
> index 7d9b75e..4ab9fad 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -530,7 +530,7 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
>   	return 0;
>   }
>   
> -static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
> +static const struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
>   	.enable     = inno_hdmi_encoder_enable,
>   	.disable    = inno_hdmi_encoder_disable,
>   	.mode_fixup = inno_hdmi_encoder_mode_fixup,

Thanks

-- 
?ark Yao
