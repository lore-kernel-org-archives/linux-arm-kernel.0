From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 29 Mar 2016 10:07:07 +0200
Subject: [PATCH 3/5] drm: Add an encoder and connector type enum for DPI.
In-Reply-To: <1458865431-30048-4-git-send-email-eric@anholt.net>
References: <1458865431-30048-1-git-send-email-eric@anholt.net>
 <1458865431-30048-4-git-send-email-eric@anholt.net>
Message-ID: <20160329080707.GJ2510@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 05:23:49PM -0700, Eric Anholt wrote:
> Right now exynos is exposing DPI as a TMDS encoder and VGA connector,
> which seems rather misleading.  This isn't just an internal detail,
> since xrandr actually exposes "VGA" as the output name.  Define some
> new enums so that vc4's DPI can have a more informative name.
> 
> I considered other names for the connector as well.  For VC4, the
> Adafruit DPI kippah takes the 28 GPIO pins and routes them to a
> standard-ish 40-pin FPC connector, but "40-pin FPC" doesn't uniquely
> identify an ordering of pins (apparently some other orderings exist),
> doesn't explain things as well for the user (who, if anything, knows
> their product is a DPI kippah/panel combo), and actually doesn't have
> to exist (one could connect the 28 GPIOs directly to something else).
> Simply "DPI" seems like a good compromise name to distinguish from the
> HDMI, DSI, and TV connectors .
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Follow-up patch to fix up existing drivers? Either way

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch> + ack for merging
through a vc4 pull request (Dave has recently okayed that I can do such
acks for non-i915 trees).

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_crtc.c  | 2 ++
>  include/uapi/drm/drm_mode.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index f619121..64bd954 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -168,6 +168,7 @@ static struct drm_conn_prop_enum_list drm_connector_enum_list[] = {
>  	{ DRM_MODE_CONNECTOR_eDP, "eDP" },
>  	{ DRM_MODE_CONNECTOR_VIRTUAL, "Virtual" },
>  	{ DRM_MODE_CONNECTOR_DSI, "DSI" },
> +	{ DRM_MODE_CONNECTOR_DPI, "DPI" },
>  };
>  
>  static const struct drm_prop_enum_list drm_encoder_enum_list[] = {
> @@ -179,6 +180,7 @@ static const struct drm_prop_enum_list drm_encoder_enum_list[] = {
>  	{ DRM_MODE_ENCODER_VIRTUAL, "Virtual" },
>  	{ DRM_MODE_ENCODER_DSI, "DSI" },
>  	{ DRM_MODE_ENCODER_DPMST, "DP MST" },
> +	{ DRM_MODE_ENCODER_DPI, "DPI" },
>  };
>  
>  static const struct drm_prop_enum_list drm_subpixel_enum_list[] = {
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 50adb46..1eb85f7 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -202,6 +202,7 @@ struct drm_mode_get_plane_res {
>  #define DRM_MODE_ENCODER_VIRTUAL 5
>  #define DRM_MODE_ENCODER_DSI	6
>  #define DRM_MODE_ENCODER_DPMST	7
> +#define DRM_MODE_ENCODER_DPI	8
>  
>  struct drm_mode_get_encoder {
>  	__u32 encoder_id;
> @@ -241,6 +242,7 @@ struct drm_mode_get_encoder {
>  #define DRM_MODE_CONNECTOR_eDP		14
>  #define DRM_MODE_CONNECTOR_VIRTUAL      15
>  #define DRM_MODE_CONNECTOR_DSI		16
> +#define DRM_MODE_CONNECTOR_DPI		17
>  
>  struct drm_mode_get_connector {
>  
> -- 
> 2.7.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
