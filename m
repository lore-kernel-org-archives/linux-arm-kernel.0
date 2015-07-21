From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 21 Jul 2015 16:38:05 +0900
Subject: [PATCH v2 4/5] drm/rockchip: vop: switch cursor plane to window 3
In-Reply-To: <1435313249-4549-5-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-5-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAAFQd5BTJujrzbz2u1jggfV8P9DwZtfJigoV2eiJ5Yesap=7Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I missed it originally, but if it's not too late yet...

On Fri, Jun 26, 2015 at 7:07 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
> Window 1 support scale and yuv format, it's waste use it for a
> cursor, use window 3 is enough.
>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v2: None
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index f6ef634..40107bb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -342,13 +342,14 @@ static const struct vop_reg_data vop_init_reg_table[] = {
>  /*
>   * Note: rk3288 has a dedicated 'cursor' window, however, that window requires
>   * special support to get alpha blending working.  For now, just use overlay
> - * window 1 for the drm cursor.
> + * window 3 for the drm cursor.
> + *

I guess this blank line is not necessary, as pointed on chromium review.

Best regards,
Tomasz
