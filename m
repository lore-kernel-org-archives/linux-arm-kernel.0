From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 7 Jun 2016 08:57:30 +0800
Subject: [PATCH 1/2] drm/rockchip: vop: add uv_vir register field for
 RK3036 VOP
In-Reply-To: <1465199912-20932-1-git-send-email-ykk@rock-chips.com>
References: <1465199912-20932-1-git-send-email-ykk@rock-chips.com>
Message-ID: <57561BFA.5030000@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?06?06? 15:58, Yakir Yang wrote:
> The WIN0 of RK3036 VOP could support YUV data format, but driver
> forget to add the uv_vir register field for it.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 3166b46..7da2311 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -210,6 +210,7 @@ static const struct vop_win_phy rk3036_win0_data = {
>   	.yrgb_mst = VOP_REG(RK3036_WIN0_YRGB_MST, 0xffffffff, 0),
>   	.uv_mst = VOP_REG(RK3036_WIN0_CBR_MST, 0xffffffff, 0),
>   	.yrgb_vir = VOP_REG(RK3036_WIN0_VIR, 0xffff, 0),
> +	.uv_vir = VOP_REG(RK3036_WIN0_VIR, 0x1fff, 16),
>   };
>   
>   static const struct vop_win_phy rk3036_win1_data = {

Thanks for this fix, Applied to my drm-fixes.

-- ?ark Yao
