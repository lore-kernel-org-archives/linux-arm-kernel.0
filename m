From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 21 Nov 2018 10:47:10 +0100
Subject: [PATCH] drm/meson: add support for 1080p25 mode
In-Reply-To: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com>
References: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <2a9d9fa9-c9ba-c624-28da-dd3804faf438@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/2018 10:39, Christian Hewitt wrote:
> This essential mode for PAL users is missing, so add it.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index acbbad3..ab16046 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -714,6 +714,7 @@ struct meson_hdmi_venc_vic_mode {
>  	{ 5, &meson_hdmi_encp_mode_1080i60 },
>  	{ 20, &meson_hdmi_encp_mode_1080i50 },
>  	{ 32, &meson_hdmi_encp_mode_1080p24 },
> +	{ 33, &meson_hdmi_encp_mode_1080p50 },
>  	{ 34, &meson_hdmi_encp_mode_1080p30 },
>  	{ 31, &meson_hdmi_encp_mode_1080p50 },
>  	{ 16, &meson_hdmi_encp_mode_1080p60 },
> 

Exact, I forgot this mode...

Thanks for the change !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll add :
Fixes: 335e3713afb87 ("drm/meson: Add support for HDMI venc modes and settings")
when applying to drm-misc-fixes.

Neil
