From: josh@joshtriplett.org (Josh Triplett)
Date: Sun, 13 Apr 2014 05:47:08 -0700
Subject: [PATCH] reset: Add of_reset_control_get to reset.h
In-Reply-To: <1397390955-22644-1-git-send-email-hdegoede@redhat.com>
References: <1397390955-22644-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140413124708.GA5092@jtriplet-mobl1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 13, 2014 at 02:09:15PM +0200, Hans de Goede wrote:
> of_reset_control_get is not declared static in drivers/reset/core.c, which
> is correct as we want to use it elsewhere too. But it does not have a
> protype declared anywhere under include/linux. Add a prototype / stub for it
> to linux/reset.h to fix this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  include/linux/reset.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index c0eda50..f1ae7ce 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -33,6 +33,9 @@ static inline struct reset_control *devm_reset_control_get_optional(
>  	return devm_reset_control_get(dev, id);
>  }
>  
> +struct reset_control *of_reset_control_get(struct device_node *node,
> +					   const char *id);
> +
>  #else
>  
>  static inline int reset_control_reset(struct reset_control *rstc)
> @@ -75,6 +78,12 @@ static inline struct reset_control *devm_reset_control_get_optional(
>  	return ERR_PTR(-ENOSYS);
>  }
>  
> +static inline struct reset_control *of_reset_control_get(
> +				struct device_node *node, const char *id)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
>  #endif /* CONFIG_RESET_CONTROLLER */
>  
>  #endif
> -- 
> 1.9.0
> 
