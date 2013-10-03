From: luis.henriques@canonical.com (Luis Henriques)
Date: Thu, 03 Oct 2013 17:15:33 +0100
Subject: [PATCH] video: mxsfb: Add missing break
In-Reply-To: <1380601350-6665-1-git-send-email-marex@denx.de> (Marek Vasut's
 message of "Tue, 1 Oct 2013 06:22:30 +0200")
References: <1380601350-6665-1-git-send-email-marex@denx.de>
Message-ID: <87bo362uvu.fsf@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marex@denx.de> writes:

> Add missing break into the restore function.
>
> Upstream commit: 6d0bb818041a02be682abadb3ba35ff608f7d60a
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: stable at vger.kernel.org
>
> ---
>  drivers/video/mxsfb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 21223d4..75c5b4e 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -647,6 +647,7 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
>  		break;
>  	case 3:
>  		bits_per_pixel = 32;
> +		break;
>  	case 1:
>  	default:
>  		return -EINVAL;

Thanks, I believe this fix is applicable to all the stable kernels.
I'm queuing it for the 3.5 kernel.

Cheers,
-- 
Luis
