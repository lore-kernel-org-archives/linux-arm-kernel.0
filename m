From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 01 Aug 2014 19:57:06 +0900
Subject: [PATCH] media: s5p_mfc_dec: delete the redundant code
In-Reply-To: <1406884515-3250-1-git-send-email-panpan1.liu@samsung.com>
References: <1406884515-3250-1-git-send-email-panpan1.liu@samsung.com>
Message-ID: <53DB7282.4070806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/01/2014 06:15 PM, panpan liu wrote:
> Because the api s5p_mfc_queue_setup has already realized the same function
> 
> Signed-off-by: panpan liu <panpan1.liu@samsung.com>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> 
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> @@ -544,14 +544,7 @@ static int vidioc_reqbufs(struct file *file, void *priv,
>  			mfc_err("vb2_reqbufs on capture failed\n");
>  			return ret;
>  		}
> -		if (reqbufs->count < ctx->pb_count) {
> -			mfc_err("Not enough buffers allocated\n");
> -			reqbufs->count = 0;
> -			s5p_mfc_clock_on();
> -			ret = vb2_reqbufs(&ctx->vq_dst, reqbufs);
> -			s5p_mfc_clock_off();
> -			return -ENOMEM;
> -		}
> +

As Hans said, you should always check the latest upstream kernel. Why do
you post patches based on old kernel at ML continuously?
