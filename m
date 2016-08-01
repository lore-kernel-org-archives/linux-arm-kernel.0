From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 1 Aug 2016 11:17:19 -0400
Subject: [PATCH 0/7] drm/mediatek: cleaning up and refine
In-Reply-To: <1469783054-54567-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1469783054-54567-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <CAOw6vbKvnLiBfHLRvCp3GAzZ8N8cT0iEEDiGi_54vyTDLF8ZWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 5:04 AM, Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
> These patches based on 4.7-rc1 to clean up unused function & variable
> and use drm core function instead.
>
> The following patches are needed to cleanly apply on top of v4.7-rc1:
>  - https://patchwork.kernel.org/patch/8044001/
>    (drm: Deal with rotation in drm_plane_helper_check_update())
>  - https://patchwork.kernel.org/patch/9248373/
>    (drm: Warn about negative sizes when calculating scale factor)
>  - https://patchwork.kernel.org/patch/9248371/
>    (drm: Store clipped src/dst coordinatee in drm_plane_state)
>  - https://patchwork.kernel.org/patch/9248363/
>    (drm/plane-helper: Add drm_plane_helper_check_state())
>  - https://patchwork.kernel.org/patch/9248361/
>    (drm/mediatek: Use drm_plane_helper_check_state())
>
> Bibby Hsieh (2):
>   drm/mediatek: Use drm_atomic destroy_state helpers
>   drm/mediatek: Fix mtk_atomic_complete for runtime_pm
>
> Daniel Kurtz (5):
>   drm/mediatek: Remove mtk_drm_crtc_check_flush
>   drm/mediatek: plane: Remove plane zpos/index
>   drm/mediatek: Remove mtk_drm_plane
>   drm/mediatek: plane: Merge mtk_plane_enable into
>     mtk_plane_atomic_update
>   drm/mediatek: plane: Use FB's format's cpp to compute x offset
>


The whole set looks good to me.


Reviewed-by: Sean Paul <seanpaul@chromium.org>


>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |   21 ++++----
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h  |    1 -
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   |   17 ++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c |   80 +++++++++++-------------------
>  drivers/gpu/drm/mediatek/mtk_drm_plane.h |   15 +-----
>  5 files changed, 56 insertions(+), 78 deletions(-)
>
> --
> 1.7.9.5
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
