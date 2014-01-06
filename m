From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 06 Jan 2014 18:28:04 +0100
Subject: [PATCH v4 01/15] reset: Silence warning in reset-controller.h
In-Reply-To: <1387847559-18330-2-git-send-email-sboyd@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389029284.5590.21.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 23.12.2013, 17:12 -0800 schrieb Stephen Boyd:
> If a user of <linux/reset-controller.h> doesn't include
> <linux/of.h> before including reset-controller.h they'll get a
> warning as follows:
> 
>   include/linux/reset-controller.h:44:17:
>   warning: 'struct of_phandle_args' declared inside parameter list
> 
> This is because of_phandle_args is not forward declared. Add the
> declaration to silence this warning.
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  include/linux/reset-controller.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
> index 2f61311..41a4695 100644
> --- a/include/linux/reset-controller.h
> +++ b/include/linux/reset-controller.h
> @@ -21,6 +21,7 @@ struct reset_control_ops {
>  
>  struct module;
>  struct device_node;
> +struct of_phandle_args;
>  
>  /**
>   * struct reset_controller_dev - reset controller entity that might

Since this is only a warning, I see no need for this to go through the
clock tree. On the other hand there are no merge conflicts to be
expected, so that's fine with me either way.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
