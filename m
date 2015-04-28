From: s-anna@ti.com (Suman Anna)
Date: Tue, 28 Apr 2015 11:49:44 -0500
Subject: [PATCH V7 2/9] mailbox: Make struct mbox_controller's ops field
 const
In-Reply-To: <1430174242-29465-3-git-send-email-abrestic@chromium.org>
References: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
 <1430174242-29465-3-git-send-email-abrestic@chromium.org>
Message-ID: <553FBA28.40403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 04/27/2015 05:37 PM, Andrew Bresticker wrote:
> The mailbox controller's channel ops ought to be read-only.

We ought to change this on all the existing controllers as well.

regards
Suman

> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> ---
> No changes from v5/v6.
> New for v5.
> ---
>  include/linux/mailbox_controller.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
> index d4cf96f..68c4245 100644
> --- a/include/linux/mailbox_controller.h
> +++ b/include/linux/mailbox_controller.h
> @@ -72,7 +72,7 @@ struct mbox_chan_ops {
>   */
>  struct mbox_controller {
>  	struct device *dev;
> -	struct mbox_chan_ops *ops;
> +	const struct mbox_chan_ops *ops;
>  	struct mbox_chan *chans;
>  	int num_chans;
>  	bool txdone_irq;
> 
