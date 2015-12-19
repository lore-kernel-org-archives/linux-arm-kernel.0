From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 19 Dec 2015 23:42:22 +0300
Subject: [PATCH] [media] gsc-m2m: Use an unsigned data type for a variable
In-Reply-To: <5675765F.9020002@users.sourceforge.net>
References: <5675765F.9020002@users.sourceforge.net>
Message-ID: <20151219204222.GU5284@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 04:23:11PM +0100, SF Markus Elfring wrote:
> diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> index d82e717..f2c091c 100644
> --- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
> +++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> @@ -701,7 +701,7 @@ static unsigned int gsc_m2m_poll(struct file *file,
>  {
>  	struct gsc_ctx *ctx = fh_to_ctx(file->private_data);
>  	struct gsc_dev *gsc = ctx->gsc_dev;
> -	int ret;
> +	unsigned int ret;
>  
>  	if (mutex_lock_interruptible(&gsc->lock))
>  		return -ERESTARTSYS;

I'm suspect returning -ERESTARTSYS is a bug.

regards,
dan carpenter
