From: robherring2@gmail.com (Rob Herring)
Date: Wed, 10 Oct 2012 09:29:48 -0500
Subject: [PATCH v4 1/8] dt: add helper inline for retrieving timeout-sec
 property
In-Reply-To: <1349784251-28261-2-git-send-email-fabio.porcedda@gmail.com>
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
 <1349784251-28261-2-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <5075865C.3010606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2012 07:04 AM, Fabio Porcedda wrote:
> The first user of this function is the watchdog framework.

Who is the 2nd user because I don't see any others. I don't see this
being a widely used property.

Rob

> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  include/linux/of.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 72843b7..5870818 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -470,4 +470,15 @@ static inline int of_property_read_u32(const struct device_node *np,
>  	return of_property_read_u32_array(np, propname, out_value, 1);
>  }
>  
> +/**
> + * of_get_timeout_sec() - Helper to read the timeout_sec property
> + * @np:		device node from which the property value is to be read.
> + * @timeout:	adress of the output value
> + */
> +static inline int of_get_timeout_sec(const struct device_node *np,
> +				     u32 *timeout)
> +{
> +	return of_property_read_u32(np, "timeout-sec", timeout);
> +}
> +
>  #endif /* _LINUX_OF_H */
> 
