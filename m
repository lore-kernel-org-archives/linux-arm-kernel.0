From: sandy.huang@rock-chips.com (Sandy Huang)
Date: Fri, 4 Aug 2017 08:56:21 +0800
Subject: [PATCH 3/6] drm/rockchip: vop: fix NV12 video display error
In-Reply-To: <1501494586-6984-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
 <1501494586-6984-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <6ebc2b5f-5962-9d23-894d-873c51c79388@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi mark,

? 2017/7/31 17:49, Mark Yao ??:
> fixup the scale calculation formula on the case
> src_height == (dst_height/2).
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> index af1091f..56bbd2e 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -299,6 +299,9 @@ static inline uint16_t scl_get_bili_dn_vskip(int src_h, int dst_h,
>   
>   	act_height = (src_h + vskiplines - 1) / vskiplines;
>   
> +	if (act_height == dst_h)
> +		return GET_SCL_FT_BILI_DN(src_h, dst_h) / vskiplines;
> +
>   	return GET_SCL_FT_BILI_DN(act_height, dst_h);
>   }
>   
> 

Reviewed-by: Sandy huang <sandy.huang@rock-chips.com>
