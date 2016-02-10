From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed, 10 Feb 2016 10:51:26 +0530
Subject: [PATCH v2 2/9] Staging: rts5208: rtsx_transport.c: Align to open
 parenthesis
In-Reply-To: <1454981485-15686-3-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-3-git-send-email-shaun.ren@linux.com>
Message-ID: <20160210052126.GB27755@sudip-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 05:31:18PM -0800, Shaun Ren wrote:
> This patch fixes the alignment issue reported by checkpatch.pl:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Shaun Ren <shaun.ren@linux.com>
> ---
>  drivers/staging/rts5208/rtsx_transport.c | 61 ++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 26 deletions(-)
> 
<snip>
>  
> @@ -732,11 +739,13 @@ int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
>  	if (rtsx_chk_stat(chip, RTSX_STAT_ABORT))
>  		return -EIO;
>  
> -	if (use_sg)
> -		err = rtsx_transfer_sglist_adma_partial(chip, card,
> -				(struct scatterlist *)buf, use_sg,
> -				index, offset, (int)len, dma_dir, timeout);
> -	else
> +	if (use_sg) {
> +		struct scatterlist *sg = (struct scatterlist *)buf;

this change is not documented in commit message.	
> +
> +		err = rtsx_transfer_sglist_adma_partial(chip, card, sg, use_sg,
> +							index, offset, (int)len,
> +							dma_dir, timeout);
> +	} else

This will introduce new checkpatch warning. If you are giving braces in
the if block then you need to have braces in the else part also.

regards
sudip
