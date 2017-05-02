From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 2 May 2017 14:50:02 -0400
Subject: [PATCH] drm/rockchip: analogix_dp: Remove unused check and
 variables
In-Reply-To: <1493469547-2121-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1493469547-2121-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170502185002.ll3gcg4y2p5astvu@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 29, 2017 at 08:39:07PM +0800, Jeffy Chen wrote:
> Remove unused check and variables after:
> drm/rockchip: Set line flag config register in vop_crtc_enable
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> ---

Applied to -misc-next, thanks.

Sean

> 
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 9bfdbc6..1bccd82 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -104,17 +104,9 @@ static void analogix_dp_psr_work(struct work_struct *work)
>  {
>  	struct rockchip_dp_device *dp =
>  				container_of(work, typeof(*dp), psr_work);
> -	struct drm_crtc *crtc = dp->encoder.crtc;
> -	int psr_state = dp->psr_state;
> -	int vact_end;
>  	int ret;
>  	unsigned long flags;
>  
> -	if (!crtc)
> -		return;
> -
> -	vact_end = crtc->mode.vtotal - crtc->mode.vsync_start + crtc->mode.vdisplay;
> -
>  	ret = rockchip_drm_wait_vact_end(dp->encoder.crtc,
>  					 PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
>  	if (ret) {
> @@ -123,7 +115,7 @@ static void analogix_dp_psr_work(struct work_struct *work)
>  	}
>  
>  	spin_lock_irqsave(&dp->psr_lock, flags);
> -	if (psr_state == EDP_VSC_PSR_STATE_ACTIVE)
> +	if (dp->psr_state == EDP_VSC_PSR_STATE_ACTIVE)
>  		analogix_dp_enable_psr(dp->dev);
>  	else
>  		analogix_dp_disable_psr(dp->dev);
> -- 
> 2.1.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
