From: joe@perches.com (Joe Perches)
Date: Tue, 12 Jul 2016 07:06:58 -0700
Subject: [PATCH] media: s5p-mfc Fix misspelled error message and
 checkpatch errors
In-Reply-To: <1468276740-1591-1-git-send-email-shuahkh@osg.samsung.com>
References: <1468276740-1591-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <1468332418.8745.11.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-07-11 at 16:39 -0600, Shuah Khan wrote:
> Fix misspelled error message and existing checkpatch errors in the
> error message conditional.
[]
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
[]
> @@ -775,11 +775,11 @@ static int vidioc_g_crop(struct file *file, void *priv,
> ?	u32 left, right, top, bottom;
> ?
> ?	if (ctx->state != MFCINST_HEAD_PARSED &&
> -	ctx->state != MFCINST_RUNNING && ctx->state != MFCINST_FINISHING
> -					&& ctx->state != MFCINST_FINISHED) {
> -			mfc_err("Cannont set crop\n");
> -			return -EINVAL;
> -		}
> +	????ctx->state != MFCINST_RUNNING && ctx->state != MFCINST_FINISHING
> +	????&& ctx->state != MFCINST_FINISHED) {
> +		mfc_err("Can not get crop information\n");
> +		return -EINVAL;
> +	}

is it a set or a get?

It'd be nicer for humans to read if the alignment was consistent

	if (ctx->state !=?MFCINST_HEAD_PARSED &&
	? ? ctx->state !=?MFCINST_RUNNING &&
	? ? ctx->state !=?MFCINST_FINISHING &&
	? ? ctx->state !=?MFCINST_FINISHED) {
		mfc_err("Can not get crop information\n");
		return -EINVAL;
	}
