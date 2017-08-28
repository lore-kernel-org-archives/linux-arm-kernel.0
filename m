From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Mon, 28 Aug 2017 17:17:04 +0530
Subject: [PATCH v2 06/20] rpmsg: glink: Return -EAGAIN when there is no
 FIFO space
In-Reply-To: <1503559302-3744-7-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-7-git-send-email-sricharan@codeaurora.org>
Message-ID: <b69734b6-d517-35c7-91b4-4b6696721a6f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/24/2017 12:51 PM, Sricharan R wrote:
> The TX FIFO can be full, if the remote client has
> not read enough data (or) reading it slowly. So its
> nessecary to return -EAGAIN to the local client to
> enable retry.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Acked-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Regards,
Arun N
> ---
>   drivers/rpmsg/qcom_glink_native.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index a6394cd..94b79e8 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -233,7 +233,7 @@ static int qcom_glink_tx(struct qcom_glink *glink,
>   
>   	while (qcom_glink_tx_avail(glink) < tlen) {
>   		if (!wait) {
> -			ret = -ENOMEM;
> +			ret = -EAGAIN;
>   			goto out;
>   		}
>   
