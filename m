From: sandy.huang@rock-chips.com (Sandy Huang)
Date: Fri, 4 Aug 2017 08:56:43 +0800
Subject: [PATCH 4/6] drm/rockchip: vop: round_up pitches to word align
In-Reply-To: <1501494591-7034-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
 <1501494591-7034-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <3a0311c8-2db9-96d0-b241-f94040421397@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017/7/31 17:49, Mark Yao ??:
> VOP pitch register is word align, need align to word.
> 
> VOP_WIN0_VIR:
>    bit[31:16] win0_vir_stride_uv
>      Number of words of Win0 uv Virtual width
>    bit[15:0] win0_vir_width
>      Number of words of Win0 yrgb Virtual width
>      ARGB888 : win0_vir_width
>      RGB888 : (win0_vir_width*3/4) + (win0_vir_width%3)
>      RGB565 : ceil(win0_vir_width/2)
>      YUV : ceil(win0_vir_width/4)
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Sandy huang <sandy.huang@rock-chips.com>
