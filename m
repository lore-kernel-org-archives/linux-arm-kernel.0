From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 6 Dec 2016 21:33:20 +0200
Subject: [PATCH] exynos-gsc: Clean up file handle in open() error path.
In-Reply-To: <1480653927-6850-1-git-send-email-shailendra.v@samsung.com>
References: <1480653927-6850-1-git-send-email-shailendra.v@samsung.com>
Message-ID: <20161206193320.GA14210@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 10:15:27AM +0530, Shailendra Verma wrote:
> The File handle is not yet added in the vfd list.So no need to call
> v4l2_fh_del(&ctx->fh) if it fails to create control.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/media/platform/exynos-gsc/gsc-m2m.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think I see this and exynos4-is patch for the third time...
1. sent in a very short time-frame (usually resending is after 2 weeks),
2. without any change log (should be after --- separator),
3. with different subjects (really...),
4. without versioning (use git format-patch -v2 etc).

Please, keep it a little bit more organized... Look at examples on
mailing lists how (and when) people are sending patches.

Best regards,
Krzysztof

> 
> diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> index 9f03b79..5ea97c1 100644
> --- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
> +++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> @@ -664,8 +664,8 @@ static int gsc_m2m_open(struct file *file)
>  
>  error_ctrls:
>  	gsc_ctrls_delete(ctx);
> -error_fh:
>  	v4l2_fh_del(&ctx->fh);
> +error_fh:
>  	v4l2_fh_exit(&ctx->fh);
>  	kfree(ctx);
>  unlock:
> -- 
> 1.7.9.5
> 
