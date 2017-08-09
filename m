From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 9 Aug 2017 09:38:34 -0400
Subject: [PATCH 0/6] drm/rockchip: Some fixes
In-Reply-To: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAOw6vbJr5Ya5Lyd3MqhSZd=mPaKzCwcBeSGfJLtv=kFUDvXbhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 5:49 AM, Mark Yao <mark.yao@rock-chips.com> wrote:
> Here are some fixes port from rockchip_linux project[0],
>
> Tested on rk3399 and rk3288 board.
>
> [0]: https://github.com/rockchip-linux/kernel
>
> Mark Yao (6):
>   drm/rockchip: vop: no need wait vblank on crtc enable
>   drm/rockchip: vop: fix iommu page fault when resume
>   drm/rockchip: vop: fix NV12 video display error
>   drm/rockchip: vop: round_up pitches to word align
>   drm/rockchip: vop: report error when check resource error
>   drm/rockchip: fix race with kms hotplug and fbdev


Hi Mark,
I noticed you applied this set to both -misc-next and -misc-fixes. In
the future, please do not apply patches in both places.

Instead, consult the flowchart under "Where Do I Apply My Patch?" at
https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
and choose the most appropriate place. If you are unsure, please reach
out to a -misc maintainer.

Thank you,

Sean

>
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 77 ++++++++---------------------
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  3 ++
>  3 files changed, 24 insertions(+), 58 deletions(-)
>
> --
> 1.9.1
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
