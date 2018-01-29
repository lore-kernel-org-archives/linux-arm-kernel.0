From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 29 Jan 2018 09:53:52 +0800
Subject: [PATCH v2 13/19] drm/sun4i: backend: Set a default zpos in our
 reset hook
In-Reply-To: <b6a183234f0ad5a9a58c780c9cabbe29cbf40888.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
 <b6a183234f0ad5a9a58c780c9cabbe29cbf40888.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64Ps0=vz0-Sg+UvpKABG7qjLKZ+QLV8EGUhpP+7co=WEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 6:35 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The our plane state zpos value will be set only if there's an existing

      ^^^ extra word

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> state attached to the plane when creating the property.
>
> However, this is not the case during the probe, and we therefore need to
> put our default value in our reset hook.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_layer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index c448cb6b9fa9..03549646528a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -28,6 +28,7 @@ struct sun4i_plane_desc {
>
>  static void sun4i_backend_layer_reset(struct drm_plane *plane)
>  {
> +       struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
>         struct sun4i_layer_state *state;
>
>         if (plane->state) {
> @@ -43,6 +44,7 @@ static void sun4i_backend_layer_reset(struct drm_plane *plane)
>         if (state) {
>                 plane->state = &state->state;
>                 plane->state->plane = plane;
> +               plane->state->zpos = layer->id;
>         }
>  }
>
> --
> git-series 0.9.1
