From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Mon, 28 Aug 2017 17:17:34 +0530
Subject: [PATCH v2 07/20] rpmsg: glink: Do a mbox_free_channel in remove
In-Reply-To: <1503559302-3744-8-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-8-git-send-email-sricharan@codeaurora.org>
Message-ID: <1e8c40a7-526f-92ce-e7f7-ee751e5502c7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/24/2017 12:51 PM, Sricharan R wrote:
> mbox_request_channel is done in probe, so free the
> channel in remove.
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
> index 94b79e8..21adde3 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1008,4 +1008,5 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
>   
>   	idr_destroy(&glink->lcids);
>   	idr_destroy(&glink->rcids);
> +	mbox_free_channel(glink->mbox_chan);
>   }
