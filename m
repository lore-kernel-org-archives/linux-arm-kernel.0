From: joe@perches.com (Joe Perches)
Date: Thu, 11 Feb 2016 20:32:15 -0800
Subject: [PATCH v4 2/8] Staging: rts5208: rtsx_transport.c: Align to
 open parenthesis
In-Reply-To: <1455250080-9897-3-git-send-email-shaun.ren@linux.com>
References: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
 <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
 <1455250080-9897-3-git-send-email-shaun.ren@linux.com>
Message-ID: <1455251535.13149.7.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-02-11 at 20:07 -0800, Shaun Ren wrote:
> This patch fixes the alignment issue reported by checkpatch.pl:
> 
> CHECK: Alignment should match open parenthesis
[]
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
[]
> @@ -52,12 +55,14 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
> ?		if (*offset >= scsi_bufflen(srb))
> ?			return 0;
> ?		cnt = min(buflen, scsi_bufflen(srb) - *offset);
> +
> +		unsigned char *sgbuffer = (unsigned char *)scsi_sglist(srb) +
> +			*offset;

Please don't declare variables in the middle of functions.
Variable declarations are only done at the beginning of functions.

> +
> ?		if (dir == TO_XFER_BUF)
> -			memcpy((unsigned char *) scsi_sglist(srb) + *offset,
> -					buffer, cnt);
> +			memcpy(sgbuffer, buffer, cnt);
> ?		else
> -			memcpy(buffer, (unsigned char *) scsi_sglist(srb) +
> -					*offset, cnt);
> +			memcpy(buffer, sgbuffer, cnt);
> ?		*offset += cnt;
