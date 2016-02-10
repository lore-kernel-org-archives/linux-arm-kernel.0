From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 10 Feb 2016 18:08:49 +0530
Subject: [PATCH] mfd: Provide MACRO to declare commonly defined MFD cell
 attributes
In-Reply-To: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
References: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
Message-ID: <56BB2F59.9030702@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tuesday 09 February 2016 07:57 PM, Lee Jones wrote:
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   include/linux/mfd/core.h | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index 27dac3f..dacdc49 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -16,6 +16,38 @@
>   
>   #include <linux/platform_device.h>
>   
> +#define MFD_CELL_ALL(_name, _res, _pdata, _id, _compat, _match)		\
> +	{								\
> +		.name = (_name),					\
> +		.num_resources = ARRAY_SIZE((_res)),			\
> +		.resources = (_res),					\
> +		.platform_data = (_pdata),				\
> +		.pdata_size = ARRAY_SIZE((_pdata)),			\
> +		.of_compatible = (_compat),				\
> +		.acpi_match = (_match),					\
> +		.id = _id,						\
> +	}
>

Should we add the _res_size and _pdata_size also in argument and use 
them instead of ARRA_SIZE and lets client set the size with help of 
ARRAY_SIZE based on type of data?
