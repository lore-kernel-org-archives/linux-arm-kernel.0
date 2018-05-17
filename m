From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Thu, 17 May 2018 09:41:51 +0100
Subject: [PATCH 5/8] firmware: arm_scmi: drop unused `con_priv`
 structure member
In-Reply-To: <1525885634-22348-6-git-send-email-sudeep.holla@arm.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
 <1525885634-22348-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180517094151.00002623@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2018 18:07:11 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> Initially con_priv was supposedly used for transport specific data when
> the SCMI driver had an abstraction to communicate with different mailbox
> controllers. But after some discussions, the idea was dropped but this
> variable slipped through the cracks.
> 
> This patch gets rid of this unused variable.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Curious that it never had any docs :)  I'm glad we didn't add them two patches
earlier to remove them here as that would have been silly.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/firmware/arm_scmi/common.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 41b03e46cca8..937a930ce87d 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -86,9 +86,7 @@ struct scmi_msg {
>   *	buffer for the rx path as we use for the tx path.
>   * @done: completion event
>   */
> -
>  struct scmi_xfer {
> -	void *con_priv;
>  	struct scmi_msg_hdr hdr;
>  	struct scmi_msg tx;
>  	struct scmi_msg rx;
