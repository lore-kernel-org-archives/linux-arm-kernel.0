From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Mon, 28 Aug 2017 17:18:38 +0530
Subject: [PATCH v2 09/20] rpmsg: glink: Fix default case while handling
 received commands
In-Reply-To: <1503559302-3744-10-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-10-git-send-email-sricharan@codeaurora.org>
Message-ID: <474616a7-5c90-c30a-1692-4c2dc66d1caf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/24/2017 12:51 PM, Sricharan R wrote:
> Currently if we receive a command that we still do not
> support, then its simply discarded. While doing so, the
> RX FIFO pointer also needs to be incremented. Fixing this.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Acked-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Regards,
Arun N
> ---
>   drivers/rpmsg/qcom_glink_native.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 50a8008..9a58925 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -541,6 +541,7 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>   			ret = 0;
>   			break;
>   		default:
> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>   			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>   			ret = -EINVAL;
>   			break;
