From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 6 Mar 2017 12:19:59 -0500
Subject: [PATCH v6 0/4] drm/dp: Implement CRC debugfs API
In-Reply-To: <20170303133936.14964-1-tomeu.vizoso@collabora.com>
References: <20170303133936.14964-1-tomeu.vizoso@collabora.com>
Message-ID: <20170306171959.GA20329@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 02:39:32PM +0100, Tomeu Vizoso wrote:
> Hi,
> 
> this series builds up on the API for exposing captured CRCs through
> debugfs.
> 
> It adds new DP helpers for starting and stopping CRC capture and gets
> the Rockchip driver to use it.
> 
> With these patches, tests in IGT such as kms_pipe_crc_basic and
> kms_plane do pass on RK3288.
> 
> In this v6, the backpointer in drm_dp_aux becomes drm_crtc instead of
> drm_connector, following discussion with Sean Paul.
> 
> Thanks,

Thanks for respinning this, Tomeu.

Applied to -misc

Sean

> 
> Tomeu
> 
> 
> Tomeu Vizoso (4):
>   drm/dp: add crtc backpointer to drm_dp_aux
>   drm/dp: add helpers for capture of frame CRCs
>   drm/bridge: analogix_dp: add helpers for capture of frame CRCs
>   drm/rockchip: Implement CRC debugfs API
> 
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  22 ++++
>  drivers/gpu/drm/drm_dp_helper.c                    | 126 +++++++++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  41 +++++++
>  include/drm/bridge/analogix_dp.h                   |   3 +
>  include/drm/drm_dp_helper.h                        |   9 ++
>  5 files changed, 201 insertions(+)
> 
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
