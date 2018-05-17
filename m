From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Thu, 17 May 2018 09:43:29 +0100
Subject: [PATCH 6/8] firmware: arm_scmi: remove unnecessary bitmap_zero
In-Reply-To: <1525885634-22348-7-git-send-email-sudeep.holla@arm.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
 <1525885634-22348-7-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180517094329.000002f1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2018 18:07:12 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> kcalloc zeros the memory and it's totally unnecessary to zero the bitmap
> again using bitmap_zero. This patch just drops the unnecessary use of
> the bitmap_zero in the context.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/firmware/arm_scmi/driver.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 33d2b78af3ff..4087d6c50ecd 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -636,8 +636,6 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>  	if (!info->xfer_alloc_table)
>  		return -ENOMEM;
>  
> -	bitmap_zero(info->xfer_alloc_table, desc->max_msg);
> -
>  	/* Pre-initialize the buffer pointer to pre-allocated buffers */
>  	for (i = 0, xfer = info->xfer_block; i < desc->max_msg; i++, xfer++) {
>  		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
