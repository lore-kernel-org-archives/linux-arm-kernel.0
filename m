From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 3 Oct 2018 15:34:09 +0800
Subject: [PATCH 2/2] drm/sun4i: tcon: prevent tcon->panel dereference if
 null
In-Reply-To: <20181002215917.1849-2-giulio.benetti@micronovasrl.com>
References: <20181001093612.GA13672@mwanda>
 <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
 <20181002215917.1849-2-giulio.benetti@micronovasrl.com>
Message-ID: <CAGb2v66mEqBYfeX_j_pj1Uu4OUfeESBQwXmQeqoqfEHP-CW3dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2018 at 5:59 AM Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> If using tcon with VGA, tcon->panel will be null(0), this will cause
> segmentation fault when trying to dereference tcon->panel->connector.
>
> Add tcon->panel null check before calling
> sun4i_tcon0_mode_set_dithering().
>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
                      RGB565/RGB666 LCD panels")

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
