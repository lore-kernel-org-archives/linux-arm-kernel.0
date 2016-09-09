From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 09 Sep 2016 11:48:34 +0200
Subject: [PATCH] [media] platform: constify vb2_ops structures
In-Reply-To: <1473379150-17315-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1473379150-17315-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <fe79a710-f524-a161-2211-3b536c9da255@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On 09/09/2016 01:59 AM, Julia Lawall wrote:
> Check for vb2_ops structures that are only stored in the ops field of a
> vb2_queue structure.  That field is declared const, so vb2_ops structures
> that have this property can be declared as const also.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
[...]

> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
> index 785e693..d9c07b8 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
> +++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
> @@ -2538,7 +2538,7 @@ static void s5p_jpeg_stop_streaming(struct vb2_queue *q)
>  	pm_runtime_put(ctx->jpeg->dev);
>  }
>
> -static struct vb2_ops s5p_jpeg_qops = {
> +static const struct vb2_ops s5p_jpeg_qops = {
>  	.queue_setup		= s5p_jpeg_queue_setup,
>  	.buf_prepare		= s5p_jpeg_buf_prepare,
>  	.buf_queue		= s5p_jpeg_buf_queue,
> diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
> index e967fcf..44323cb 100644
> --- a/drivers/media/platform/ti-vpe/cal.c
> +++ b/drivers/media/platform/ti-vpe/cal.c
> @@ -1379,7 +1379,7 @@ static void cal_stop_streaming(struct vb2_queue *vq)
>  	cal_runtime_put(ctx->dev);
>  }

Thanks for the patch.

For s5p-jpeg driver:

Reviewed-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski
