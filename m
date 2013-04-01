From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 01 Apr 2013 10:49:42 -0600
Subject: [PATCHv3 1/6] of: Add support for reading a u32 from a multi-value
 property.
In-Reply-To: <1364451049-2981-2-git-send-email-linux@prisktech.co.nz>
References: <1364451049-2981-1-git-send-email-linux@prisktech.co.nz>
 <1364451049-2981-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <5159BAA6.50706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 12:10 AM, Tony Prisk wrote:
> This patch adds an of_property_read_u32_index() function to allow
> reading a single indexed u32 value from a property containing multiple
> u32 values.

> diff --git a/drivers/of/base.c b/drivers/of/base.c

> +int of_property_read_u32_index(const struct device_node *np,

> +	if ((index * sizeof(*out_value)) > prop->length)
> +		return -EOVERFLOW;

I think that if should be:

	if (((index + 1) * sizeof(*out_value)) > prop->length)

since the code should check if the last byte of the u32 is out-of-range,
not whether the first byte is.

Aside from that, this patch,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
