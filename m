From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jun 2016 09:56:22 +0100
Subject: [PATCH 4/7] reset: Supply *_shared variant calls when using
 *_optional APIs
In-Reply-To: <20160606155655.10860-5-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-5-lee.jones@linaro.org>
Message-ID: <20160628085622.GM6720@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp,

I need this to go into the -rcs too.

Can I add it with your Ack please?

> Consumers need to be able to specify whether they are requesting an
> 'exclusive' or 'shared' reset line no matter which API (of_*, devm_*,
> etc) they are using.  This change allows users of the optional_* API
> in particular to specify that their request is for a 'shared' line.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/reset.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index fd69240..c358106 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -141,6 +141,12 @@ static inline struct reset_control *reset_control_get_optional_exclusive(
>  	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
>  }
>  
> +static inline struct reset_control *reset_control_get_optional_shared(
> +					struct device *dev, const char *id)
> +{
> +	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 1);
> +}
> +
>  /**
>   * of_reset_control_get_exclusive - Lookup and obtain an exclusive reference
>   *                                  to a reset controller.
> @@ -270,6 +276,12 @@ static inline struct reset_control *devm_reset_control_get_optional_exclusive(
>  	return __devm_reset_control_get(dev, id, 0, 0);
>  }
>  
> +static inline struct reset_control *devm_reset_control_get_optional_shared(
> +					struct device *dev, const char *id)
> +{
> +	return __devm_reset_control_get(dev, id, 0, 1);
> +}
> +
>  /**
>   * devm_reset_control_get_exclusive_by_index - resource managed
>   *                                             reset_control_get_exclusive()

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
