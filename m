From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Feb 2012 13:10:51 -0700
Subject: [PATCH v2 1/7] dt: add empty of_find_compatible_node function
In-Reply-To: <1329331668-30325-2-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
 <1329331668-30325-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120215201051.GF25779@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 10:47:42AM -0800, Shawn Guo wrote:
> Add empty of_find_compatible_node function for !CONFIG_OF build.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.

g.

> ---
>  include/linux/of.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a75a831..92cf6ad 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -281,6 +281,14 @@ static inline struct property *of_find_property(const struct device_node *np,
>  	return NULL;
>  }
>  
> +static inline struct device_node *of_find_compatible_node(
> +						struct device_node *from,
> +						const char *type,
> +						const char *compat)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_property_read_u32_array(const struct device_node *np,
>  					     const char *propname,
>  					     u32 *out_values, size_t sz)
> -- 
> 1.7.5.4
> 
