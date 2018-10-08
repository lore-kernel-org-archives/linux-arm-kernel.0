From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 8 Oct 2018 17:48:03 +0200
Subject: [PATCH] staging: bcm2835-camera: remove extraneous setting of
 dev->colourfx.enable
In-Reply-To: <20181008145012.31312-1-colin.king@canonical.com>
References: <20181008145012.31312-1-colin.king@canonical.com>
Message-ID: <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

Am 08.10.2018 um 16:50 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently dev->colourfx.enable is being set twice, hence the first
> occurrance is redundant and can be removed, so remove it. This minor
> issue was introduced by commit 7b3ad5abf027 ("staging: Import the
> BCM2835 MMAL-based V4L2 camera driver.").
>
> Detected by CoverityScan CID#1419711 ("Unused value")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/controls.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index a2c55cb2192a..99831dd4365d 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -588,7 +588,6 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
>  
>  	control = &dev->component[MMAL_COMPONENT_CAMERA]->control;
>  
> -	dev->colourfx.enable = (ctrl->val & 0xff00) >> 8;
>  	dev->colourfx.enable = ctrl->val & 0xff;
>  
>  	ret = vchiq_mmal_port_parameter_set(dev->instance, control,

as long as the current behavior is correct, i'm okay with this patch.
But the byte masking looks suspicious, so i hope Dave can clarify that.

Thanks Stefan
