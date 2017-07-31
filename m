From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 31 Jul 2017 09:02:49 +0800
Subject: [PATCH v6 0/7] drm/rockchip: add all full framework vop support
In-Reply-To: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <597E81B9.20408@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Pushed to drm-misc-next.

Thanks Sean Paul, Jeffy Chen's review, Heiko's test and Rob's ack.

Best regards.

On 2017?07?26? 14:18, Mark Yao wrote:
> These patches try to make all current rockchip full framework vop works
> on drm, fill missing vop on full framework.
> Vop Full framework now has following vops:
> IP version    chipname
>        3.1           rk3288
>        3.2           rk3368
>        3.4           rk3366
>        3.5           rk3399 big
>        3.6           rk3399 lit
>        3.7           rk3228
>        3.8           rk3328
>
> Group the vop register, it would make register  definition clearer and
> more easily to reuse same group register define for difference vops.
>
> Tested on rk3399 excavator board with kernel 4.13-rc1.
>
> And other chips tested on rockchip kernel 4.4:
>     https://github.com/rockchip-linux/kernel/tree/release-4.4/drivers/gpu/drm/rockchip
>
> Changes in v6:
> - fix some patches complie error
> - fix rk3036 display blank
>
> Changes in v5:
> - clean document commit title
> - move changes description out of docummit commit msg
>
> Changes in v4:
> - rebase to newest torvalds kernel, fix merge conflict
>
> Changes in v3:
> - group vop register instead using VOP_REG_VER mechanism
> - Explain more on patch commit message
> - move write_relaxed flags to vop registers
> - fix rk3328 overlay abnormal
>
> Changes in v2:
> - rename rk322x to rk3228
> - correct some vop registers define
>
> Mark Yao (7):
>    drm/rockchip: vop: initialize registers directly
>    drm/rockchip: vop: move write_relaxed flags to vop register
>    drm/rockchip: vop: move line_flag_num to interrupt registers
>    drm/rockchip: vop: group vop registers
>    drm/rockchip: vop: add a series of vop support
>    dt-bindings: display: rockchip: fill Documents for vop series
>    drm/rockchip: vop: rk3328: fix overlay abnormal
>
>   .../bindings/display/rockchip/rockchip-vop.txt     |   4 +
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 109 ++-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |  81 +-
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c        | 375 ++++++---
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.h        | 905 ++++++++++++++++-----
>   5 files changed, 1075 insertions(+), 399 deletions(-)
>


-- 
?ark Yao
