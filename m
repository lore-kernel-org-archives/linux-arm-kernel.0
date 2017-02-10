From: joe@perches.com (Joe Perches)
Date: Fri, 10 Feb 2017 10:59:15 -0800
Subject: [PATCH v2] media: s5p_mfc print buf pointer in hex constistently
In-Reply-To: <20170210154053.23735-1-shuahkh@osg.samsung.com>
References: <20170210154053.23735-1-shuahkh@osg.samsung.com>
Message-ID: <1486753155.2192.13.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-10 at 08:40 -0700, Shuah Khan wrote:
> Fix s5p_mfc_set_dec_frame_buffer_v6() to print buffer pointer in hex to be
> consistent with the rest of the messages in the routine.

More curiously, why is buf_addr a size_t and not
a dma_addr_t?

> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
> 
> Fixed commit log. No code changes. Thanks for the catch.
> 
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> index d6f207e..fc45980 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -497,7 +497,7 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
>  		}
>  	}
>  
> -	mfc_debug(2, "Buf1: %zu, buf_size1: %d (frames %d)\n",
> +	mfc_debug(2, "Buf1: %zx, buf_size1: %d (frames %d)\n",
>  			buf_addr1, buf_size1, ctx->total_dpb_count);
>  	if (buf_size1 < 0) {
>  		mfc_debug(2, "Not enough memory has been allocated.\n");
