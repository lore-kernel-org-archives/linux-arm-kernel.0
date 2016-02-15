From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 14 Feb 2016 16:41:47 -0800
Subject: [PATCH v5 2/8] Staging: rts5208: rtsx_transport.c: Align to open
 parenthesis
In-Reply-To: <1455260168-16980-1-git-send-email-shaun.ren@linux.com>
References: <1455251535.13149.7.camel@perches.com>
 <1455260168-16980-1-git-send-email-shaun.ren@linux.com>
Message-ID: <20160215004147.GA1440@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 10:56:08PM -0800, Shaun Ren wrote:
> This patch fixes the alignment issue reported by checkpatch.pl:
> 
> CHECK: Alignment should match open parenthesis
> 
> Add a unsigned char *sgbuffer in rtsx_stor_access_xfer_buffer to make the
> following memcpy logic easier to read.
> 
> Add a struct scatterlist *sg in the use_sg branch of
> rtsx_transfer_data_partial to make the parameters of the
> rtsx_transfer_sglist_adma_partial call fit in 80 character lines after
> aligning them to the open parenthesis.
> 
> Refactor memcpy logic in rtsx_stor_access_xfer_buf to make it more legible.
> 
> Signed-off-by: Shaun Ren <shaun.ren@linux.com>
> ---
>  drivers/staging/rts5208/rtsx_transport.c | 69 +++++++++++++++++++-------------
> Changes since v3
>   * Fixed misalignment of the last parameter of rtsx_stor_access_xfer_buf()
>   * Refactored memcpy in rtsx_stor_access_xfer_buf() for legibility

Where are the 7 other patches in this series?

Please resend all of them.

thanks,

greg k-h
