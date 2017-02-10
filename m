From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 10 Feb 2017 08:11:32 +0100
Subject: [PATCH] media: s5p_mfc - remove unneeded io_modes initialzation in
 s5p_mfc_open()
In-Reply-To: <20170209221117.26381-1-shuahkh@osg.samsung.com>
References: <CGME20170209221122epcas4p138d5e06079a506356e8ba9dae37825c2@epcas4p1.samsung.com>
 <20170209221117.26381-1-shuahkh@osg.samsung.com>
Message-ID: <b1804acf-159f-fb01-030e-ed3eb742a9e7@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.02.2017 23:11, Shuah Khan wrote:
> Remove unneeded io_modes initialzation in s5p_mfc_open(). It gets done
> right below in vdev == dev->vfd_dec conditional.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Acked-by: Andrzej Hajda <a.hajda@samsung.com>
--
Regards
Andrzej
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index bb0a588..20beaa2 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -866,7 +866,6 @@ static int s5p_mfc_open(struct file *file)
>  	/* Init videobuf2 queue for OUTPUT */
>  	q = &ctx->vq_src;
>  	q->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> -	q->io_modes = VB2_MMAP;
>  	q->drv_priv = &ctx->fh;
>  	q->lock = &dev->mfc_mutex;
>  	if (vdev == dev->vfd_dec) {
