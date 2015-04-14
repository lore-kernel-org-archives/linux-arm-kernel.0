From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 14 Apr 2015 14:58:45 +0200
Subject: [PATCH] [media] vb2: remove unused variable
In-Reply-To: <8477099.Iv3RkyDk0C@wuerfel>
References: <8477099.Iv3RkyDk0C@wuerfel>
Message-ID: <552D0F05.9000706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-04-10 22:24, Arnd Bergmann wrote:
> A recent bug fix removed all uses of the 'fileio' variable in
> vb2_thread_stop(), which now causes warnings in a lot of
> ARM defconfig builds:
>
> drivers/media/v4l2-core/videobuf2-core.c:3228:26: warning: unused variable 'fileio' [-Wunused-variable]
>
> This removes the variable as well. The commit that introduced
> the warning was marked for 3.18+ backports, so this should
> probably be backported too.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0e661006370b7 ("[media] vb2: fix 'UNBALANCED' warnings when calling vb2_thread_stop()")
> Cc: <stable@vger.kernel.org>      # for v3.18 and up

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
> index c11aee7db884..d3f7bf0db61e 100644
> --- a/drivers/media/v4l2-core/videobuf2-core.c
> +++ b/drivers/media/v4l2-core/videobuf2-core.c
> @@ -3225,7 +3225,6 @@ EXPORT_SYMBOL_GPL(vb2_thread_start);
>   int vb2_thread_stop(struct vb2_queue *q)
>   {
>   	struct vb2_threadio_data *threadio = q->threadio;
> -	struct vb2_fileio_data *fileio = q->fileio;
>   	int err;
>   
>   	if (threadio == NULL)
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
