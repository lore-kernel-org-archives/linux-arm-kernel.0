From: seanpaul@chromium.org (Sean Paul)
Date: Fri, 7 Apr 2017 13:36:13 -0400
Subject: [PATCH v5 00/12] drm: rockchip: Fix rockchip drm unbind crash
 error
In-Reply-To: <1491481885-13775-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491481885-13775-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170407173613.bbau3xp2fasjzt2h@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 08:31:13PM +0800, Jeffy Chen wrote:
> 
> Verified on rk3399 chromebook kevin:
> 1/ stop ui && pkill -9 frecon
> 2/ unbind/bind drm
> 
> Changes in v5:
> Fix wrong git account.
> 
> Changes in v4:
> Address Andrzej Hajda <a.hajda@samsung.com>'s comments.
> 
> Changes in v3:
> Update commit message.
> Address Sean Paul <seanpaul@chromium.org>'s comments.
> Update commit message.
> Address Sean Paul <seanpaul@chromium.org>'s comments.
> Update commit message.
> Address Daniel Vetter <daniel@ffwll.ch>'s comments.
> Update commit message.
> 
> Changes in v2:
> Fix some commit messages.
> 
> Jeffy Chen (12):
>   drm: bridge: analogix: Detach panel when unbinding analogix dp
>   drm: bridge: analogix: Unregister dp aux when unbinding
>   drm: bridge: analogix: Disable clock when unbinding
>   drm: bridge: analogix: Destroy connector & encoder when unbinding
>   drm/rockchip: cdn-dp: Don't try to release firmware when not loaded
>   drm/rockchip: cdn-dp: Don't unregister audio dev when unbinding
>   drm/rockchip: vop: Enable pm domain before vop_initial
>   drm/rockchip: vop: Unprepare clocks when unbinding
>   drm/rockchip: analogix_dp: Disable clock when unbinding
>   drm/rockchip: Reoder drm bind/unbind sequence
>   drm/rockchip: Shutdown all crtcs when unbinding drm

Hi Jeffy,
I've applied the first 11 patches from this set to -misc. The last patch
is still a work in progress.

Thanks,

Sean

>   drm/drm_ioctl.c: Break ioctl when drm device not registered
> 
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  6 +++
>  drivers/gpu/drm/drm_ioctl.c                        |  2 +-
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  3 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c             | 10 +++--
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 50 ++++++++++++----------
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 33 ++++++++++----
>  6 files changed, 67 insertions(+), 37 deletions(-)
> 
> -- 
> 2.1.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
