From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 15 Jan 2016 16:50:18 +0100
Subject: [PATCH v2 02/26] reset: Make reset_control_ops const
In-Reply-To: <1452785109-6172-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452873018.6067.79.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 14.01.2016, 16:24 +0100 schrieb Maxime Ripard:
> The ops pointer is holding a pointer to a structure that is usually not
> modified. Make it const.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  include/linux/reset-controller.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
> index ce6b962ffed4..a3a5bcdb1d02 100644
> --- a/include/linux/reset-controller.h
> +++ b/include/linux/reset-controller.h
> @@ -38,7 +38,7 @@ struct of_phandle_args;
>   * @nr_resets: number of reset controls in this reset controller device
>   */
>  struct reset_controller_dev {
> -	struct reset_control_ops *ops;
> +	const struct reset_control_ops *ops;
>  	struct module *owner;
>  	struct list_head list;
>  	struct device_node *of_node;

Applied, thanks.

regards
Philipp
