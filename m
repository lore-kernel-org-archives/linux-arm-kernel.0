From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Oct 2011 08:19:50 -0500
Subject: [PATCH] dt: add empty of_alias_get_id() for non-dt builds
In-Reply-To: <1319706448-1664-1-git-send-email-nicolas.ferre@atmel.com>
References: <1319706448-1664-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4EAAABF6.50803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2011 04:07 AM, Nicolas Ferre wrote:
> Add function of_alias_get_id() reporting -ENOSYS
> for non-dt builds, so that drivers migrating to dt
> can save some '#ifdef CONFIG_OF'.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
> Hi Grant,
> 
> Another empty function for non-dt builds. Can we consider
> queuing it for 3.1?
> 
> Best regards,
> 
>  include/linux/of.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 92c40a1..34d8338 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -302,6 +302,11 @@ static inline struct device_node *of_parse_phandle(struct device_node *np,
>  	return NULL;
>  }
>  
> +static inline int of_alias_get_id(struct device_node *np, const char *stem)
> +{
> +	return -ENOSYS;
> +}
> +
>  #define of_match_ptr(_ptr)	NULL
>  #define of_match_node(_matches, _node)	NULL
>  #endif /* CONFIG_OF */
