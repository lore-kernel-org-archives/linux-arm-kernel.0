From: liviu.dudau@arm.com (Liviu Dudau)
Date: Fri, 28 Jul 2017 17:45:56 +0100
Subject: [PATCH 5/8] drm: Nuke drm_atomic_helper_plane_set_property
In-Reply-To: <20170725080122.20548-6-daniel.vetter@ffwll.ch>
References: <20170725080122.20548-1-daniel.vetter@ffwll.ch>
 <20170725080122.20548-6-daniel.vetter@ffwll.ch>
Message-ID: <20170728164556.GL970@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 10:01:19AM +0200, Daniel Vetter wrote:
> It's dead code, the core handles all this directly now. This also
> allows us to unexport drm_atomic_helper_plane_set_property.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Brian Starkey <brian.starkey@arm.com>
> Cc: Mali DP Maintainers <malidp@foss.arm.com>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: Yannick Fertre <yannick.fertre@st.com>
> Cc: Philippe Cornu <philippe.cornu@st.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: "Ville Syrj?l?" <ville.syrjala@linux.intel.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Eric Engestrom <eric@engestrom.ch>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: intel-gfx at lists.freedesktop.org
> Cc: nouveau at lists.freedesktop.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/arm/malidp_planes.c             |  1 -
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c |  1 -
>  drivers/gpu/drm/drm_atomic.c                    |  3 +-
>  drivers/gpu/drm/drm_atomic_helper.c             | 55 -------------------------
>  drivers/gpu/drm/exynos/exynos_drm_plane.c       |  1 -
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  |  1 -
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  1 -
>  drivers/gpu/drm/i915/intel_display.c            |  2 -
>  drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c       |  2 -
>  drivers/gpu/drm/nouveau/nv50_display.c          |  1 -
>  drivers/gpu/drm/omapdrm/omap_plane.c            |  1 -
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c         |  1 -
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c           |  1 -
>  drivers/gpu/drm/sti/sti_cursor.c                |  1 -
>  drivers/gpu/drm/sti/sti_gdp.c                   |  1 -
>  drivers/gpu/drm/sti/sti_hqvdp.c                 |  1 -
>  drivers/gpu/drm/stm/ltdc.c                      |  1 -
>  drivers/gpu/drm/tilcdc/tilcdc_plane.c           |  1 -
>  include/drm/drm_atomic.h                        |  3 --
>  include/drm/drm_atomic_helper.h                 |  3 --
>  20 files changed, 1 insertion(+), 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 600fa7bd7f52..0f0f8234fe21 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -128,7 +128,6 @@ static void malidp_plane_atomic_print_state(struct drm_printer *p,
>  static const struct drm_plane_funcs malidp_de_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.destroy = malidp_de_plane_destroy,
>  	.reset = malidp_plane_reset,
>  	.atomic_duplicate_state = malidp_duplicate_plane_state,

For mali-dp changes:
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

I'm assuming the series goes through drm-next tree.

Thanks,
Liviu

> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index b5bd9b005225..9cd9e23e75c6 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -1052,7 +1052,6 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
>  static struct drm_plane_funcs layer_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.destroy = atmel_hlcdc_plane_destroy,
>  	.reset = atmel_hlcdc_plane_reset,
>  	.atomic_duplicate_state = atmel_hlcdc_plane_atomic_duplicate_state,
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 0fd14aff7add..395438a7a576 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -713,7 +713,7 @@ EXPORT_SYMBOL(drm_atomic_get_plane_state);
>   * RETURNS:
>   * Zero on success, error code on failure
>   */
> -int drm_atomic_plane_set_property(struct drm_plane *plane,
> +static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		struct drm_plane_state *state, struct drm_property *property,
>  		uint64_t val)
>  {
> @@ -770,7 +770,6 @@ int drm_atomic_plane_set_property(struct drm_plane *plane,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(drm_atomic_plane_set_property);
>  
>  /**
>   * drm_atomic_plane_get_property - get property value from plane state
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 22245aa8b1aa..0482e39a7889 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2968,61 +2968,6 @@ int drm_atomic_helper_resume(struct drm_device *dev,
>  EXPORT_SYMBOL(drm_atomic_helper_resume);
>  
>  /**
> - * drm_atomic_helper_plane_set_property - helper for plane properties
> - * @plane: DRM plane
> - * @property: DRM property
> - * @val: value of property
> - *
> - * Provides a default plane set_property handler using the atomic driver
> - * interface.
> - *
> - * RETURNS:
> - * Zero on success, error code on failure
> - */
> -int
> -drm_atomic_helper_plane_set_property(struct drm_plane *plane,
> -				    struct drm_property *property,
> -				    uint64_t val)
> -{
> -	struct drm_atomic_state *state;
> -	struct drm_plane_state *plane_state;
> -	int ret = 0;
> -
> -	state = drm_atomic_state_alloc(plane->dev);
> -	if (!state)
> -		return -ENOMEM;
> -
> -	/* ->set_property is always called with all locks held. */
> -	state->acquire_ctx = plane->dev->mode_config.acquire_ctx;
> -retry:
> -	plane_state = drm_atomic_get_plane_state(state, plane);
> -	if (IS_ERR(plane_state)) {
> -		ret = PTR_ERR(plane_state);
> -		goto fail;
> -	}
> -
> -	ret = drm_atomic_plane_set_property(plane, plane_state,
> -			property, val);
> -	if (ret)
> -		goto fail;
> -
> -	ret = drm_atomic_commit(state);
> -fail:
> -	if (ret == -EDEADLK)
> -		goto backoff;
> -
> -	drm_atomic_state_put(state);
> -	return ret;
> -
> -backoff:
> -	drm_atomic_state_clear(state);
> -	drm_atomic_legacy_backoff(state);
> -
> -	goto retry;
> -}
> -EXPORT_SYMBOL(drm_atomic_helper_plane_set_property);
> -
> -/**
>   * drm_atomic_helper_connector_set_property - helper for connector properties
>   * @connector: DRM connector
>   * @property: DRM property
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> index 611b6fd65433..5e686ee74900 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> @@ -173,7 +173,6 @@ static struct drm_plane_funcs exynos_plane_funcs = {
>  	.update_plane	= drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
>  	.destroy	= drm_plane_cleanup,
> -	.set_property	= drm_atomic_helper_plane_set_property,
>  	.reset		= exynos_drm_plane_reset,
>  	.atomic_duplicate_state = exynos_drm_plane_duplicate_state,
>  	.atomic_destroy_state = exynos_drm_plane_destroy_state,
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 54a4542a40f1..0bbd3c3480ee 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -150,7 +150,6 @@ static const u32 channel_formats1[] = {
>  static struct drm_plane_funcs hibmc_plane_funcs = {
>  	.update_plane	= drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.destroy = drm_plane_cleanup,
>  	.reset = drm_atomic_helper_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 961551135a39..8df42fddd8f7 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -889,7 +889,6 @@ static const struct drm_plane_helper_funcs ade_plane_helper_funcs = {
>  static struct drm_plane_funcs ade_plane_funcs = {
>  	.update_plane	= drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.destroy = drm_plane_cleanup,
>  	.reset = drm_atomic_helper_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index b4d0c5298a53..e908982f6864 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -12649,7 +12649,6 @@ const struct drm_plane_funcs intel_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = intel_plane_destroy,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.atomic_get_property = intel_plane_atomic_get_property,
>  	.atomic_set_property = intel_plane_atomic_set_property,
>  	.atomic_duplicate_state = intel_plane_duplicate_state,
> @@ -12784,7 +12783,6 @@ static const struct drm_plane_funcs intel_cursor_plane_funcs = {
>  	.update_plane = intel_legacy_cursor_update,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = intel_plane_destroy,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.atomic_get_property = intel_plane_atomic_get_property,
>  	.atomic_set_property = intel_plane_atomic_set_property,
>  	.atomic_duplicate_state = intel_plane_duplicate_state,
> diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c
> index fe3a4de1a433..a60750b66b47 100644
> --- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c
> @@ -246,7 +246,6 @@ static const struct drm_plane_funcs mdp5_plane_funcs = {
>  		.update_plane = drm_atomic_helper_update_plane,
>  		.disable_plane = drm_atomic_helper_disable_plane,
>  		.destroy = mdp5_plane_destroy,
> -		.set_property = drm_atomic_helper_plane_set_property,
>  		.atomic_set_property = mdp5_plane_atomic_set_property,
>  		.atomic_get_property = mdp5_plane_atomic_get_property,
>  		.reset = mdp5_plane_reset,
> @@ -259,7 +258,6 @@ static const struct drm_plane_funcs mdp5_cursor_plane_funcs = {
>  		.update_plane = mdp5_update_cursor_plane_legacy,
>  		.disable_plane = drm_atomic_helper_disable_plane,
>  		.destroy = mdp5_plane_destroy,
> -		.set_property = drm_atomic_helper_plane_set_property,
>  		.atomic_set_property = mdp5_plane_atomic_set_property,
>  		.atomic_get_property = mdp5_plane_atomic_get_property,
>  		.reset = mdp5_plane_reset,
> diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
> index aa6fc525c539..e2029f05bf7b 100644
> --- a/drivers/gpu/drm/nouveau/nv50_display.c
> +++ b/drivers/gpu/drm/nouveau/nv50_display.c
> @@ -1055,7 +1055,6 @@ nv50_wndw = {
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = nv50_wndw_destroy,
>  	.reset = nv50_wndw_reset,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.atomic_duplicate_state = nv50_wndw_atomic_duplicate_state,
>  	.atomic_destroy_state = nv50_wndw_atomic_destroy_state,
>  };
> diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
> index 2160f64548e0..c29b66a36907 100644
> --- a/drivers/gpu/drm/omapdrm/omap_plane.c
> +++ b/drivers/gpu/drm/omapdrm/omap_plane.c
> @@ -235,7 +235,6 @@ static const struct drm_plane_funcs omap_plane_funcs = {
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.reset = omap_plane_reset,
>  	.destroy = omap_plane_destroy,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
>  	.atomic_set_property = omap_plane_atomic_set_property,
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> index dcde6288da6c..985ce332eb0a 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> @@ -698,7 +698,6 @@ static const struct drm_plane_funcs rcar_du_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.reset = rcar_du_plane_reset,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.destroy = drm_plane_cleanup,
>  	.atomic_duplicate_state = rcar_du_plane_atomic_duplicate_state,
>  	.atomic_destroy_state = rcar_du_plane_atomic_destroy_state,
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> index f870445ebc8d..caa82f2f2567 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> @@ -383,7 +383,6 @@ static const struct drm_plane_funcs rcar_du_vsp_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.reset = rcar_du_vsp_plane_reset,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.destroy = drm_plane_cleanup,
>  	.atomic_duplicate_state = rcar_du_vsp_plane_atomic_duplicate_state,
>  	.atomic_destroy_state = rcar_du_vsp_plane_atomic_destroy_state,
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> index 5b3a41f74f21..9baa5e62a8e5 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -348,7 +348,6 @@ static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = sti_cursor_destroy,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.reset = sti_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> index 5ee0503945c8..66c5224011d2 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -895,7 +895,6 @@ static const struct drm_plane_funcs sti_gdp_plane_helpers_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = sti_gdp_destroy,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.reset = sti_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 53a46dda8bd5..bec3ccfec3b5 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -1276,7 +1276,6 @@ static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = sti_hqvdp_destroy,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.reset = sti_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 04cc66d6b96f..76820bcbfed0 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -697,7 +697,6 @@ static const struct drm_plane_funcs ltdc_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = drm_plane_cleanup,
> -	.set_property = drm_atomic_helper_plane_set_property,
>  	.reset = drm_atomic_helper_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> index ba0d66c0d8ac..7667b038ae7f 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> @@ -28,7 +28,6 @@ static struct drm_plane_funcs tilcdc_plane_funcs = {
>  	.update_plane	= drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
>  	.destroy	= drm_plane_cleanup,
> -	.set_property	= drm_atomic_helper_plane_set_property,
>  	.reset		= drm_atomic_helper_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 7cd0f303f5a3..1f6a2c768e4b 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -315,9 +315,6 @@ int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  struct drm_plane_state * __must_check
>  drm_atomic_get_plane_state(struct drm_atomic_state *state,
>  			   struct drm_plane *plane);
> -int drm_atomic_plane_set_property(struct drm_plane *plane,
> -		struct drm_plane_state *state, struct drm_property *property,
> -		uint64_t val);
>  struct drm_connector_state * __must_check
>  drm_atomic_get_connector_state(struct drm_atomic_state *state,
>  			       struct drm_connector *connector);
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index e5c835d94540..a62aeb816dd8 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -124,9 +124,6 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>  int drm_atomic_helper_resume(struct drm_device *dev,
>  			     struct drm_atomic_state *state);
>  
> -int drm_atomic_helper_plane_set_property(struct drm_plane *plane,
> -					struct drm_property *property,
> -					uint64_t val);
>  int drm_atomic_helper_connector_set_property(struct drm_connector *connector,
>  					struct drm_property *property,
>  					uint64_t val);
> -- 
> 2.13.3
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
