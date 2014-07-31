From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Thu, 31 Jul 2014 10:31:37 +0200
Subject: [PATCH] videobuf2-core: simplify and unify the kernel api
In-Reply-To: <1406795295-3013-1-git-send-email-panpan1.liu@samsung.com>
References: <1406795295-3013-1-git-send-email-panpan1.liu@samsung.com>
Message-ID: <53D9FEE9.4060902@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 10:28 AM, panpan liu wrote:
> Making the kernel api more simplified and unified.
> 
> Signed-off-by: panpan liu <panpan1.liu@samsung.com>

Has been fixed already in 3.15. Always check the latest code!

Regards,

	Hans

> ---
>  drivers/media/v4l2-core/videobuf2-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 drivers/media/v4l2-core/videobuf2-core.c
> 
> diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
> old mode 100644
> new mode 100755
> index 9abb15e..71ba92c
> --- a/drivers/media/v4l2-core/videobuf2-core.c
> +++ b/drivers/media/v4l2-core/videobuf2-core.c
> @@ -1194,7 +1194,7 @@ static void __enqueue_in_driver(struct vb2_buffer *vb)
>  	for (plane = 0; plane < vb->num_planes; ++plane)
>  		call_memop(q, prepare, vb->planes[plane].mem_priv);
> 
> -	q->ops->buf_queue(vb);
> +	call_qop(q, buf_queue, vb);
>  }
> 
>  static int __buf_prepare(struct vb2_buffer *vb, const struct v4l2_buffer *b)
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
