From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Thu, 09 Feb 2017 21:01:09 -0500
Subject: [PATCH] media: fix s5p_mfc_set_dec_frame_buffer_v6() to print
 buf size in hex
In-Reply-To: <20170209221051.26234-1-shuahkh@osg.samsung.com>
References: <20170209221051.26234-1-shuahkh@osg.samsung.com>
Message-ID: <1486692069.5749.1.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 09 f?vrier 2017 ? 15:10 -0700, Shuah Khan a ?crit?:
> Fix s5p_mfc_set_dec_frame_buffer_v6() to print buffer size in hex to
> be
> consistent with the rest of the messages in the routine.

Short and long descriptions are miss-leading. This patch will print the
buffer pointer as hex and keep the size as decimal. I think the patch
correctly improves consistency, the comment should match the code.

> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
> ?drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> index d6f207e..fc45980 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -497,7 +497,7 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct
> s5p_mfc_ctx *ctx)
> ?		}
> ?	}
> ?
> -	mfc_debug(2, "Buf1: %zu, buf_size1: %d (frames %d)\n",
> +	mfc_debug(2, "Buf1: %zx, buf_size1: %d (frames %d)\n",
> ?			buf_addr1, buf_size1, ctx->total_dpb_count);
> ?	if (buf_size1 < 0) {
> ?		mfc_debug(2, "Not enough memory has been
> allocated.\n");
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170209/a168cbb4/attachment.sig>
