From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 16 Jul 2018 13:18:59 +0100
Subject: [PATCH v4 02/18] Documentation: nvmem: document lookup entries
In-Reply-To: <20180629094039.7543-3-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-3-brgl@bgdev.pl>
Message-ID: <d5c1a83c-7c63-32ab-1d41-8e9bf4cdd6b7@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/06/18 10:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Describe the usage of nvmem cell lookup tables.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   Documentation/nvmem/nvmem.txt | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
> index 8d8d8f58f96f..9d5e3ca2b4f3 100644
> --- a/Documentation/nvmem/nvmem.txt
> +++ b/Documentation/nvmem/nvmem.txt
> @@ -58,6 +58,34 @@ static int qfprom_probe(struct platform_device *pdev)
>   It is mandatory that the NVMEM provider has a regmap associated with its
>   struct device. Failure to do would return error code from nvmem_register().
>   
> +Additionally it is possible to create nvmem cell lookup entries and register
> +them with the nvmem framework from machine code as shown in the example below:
> +
> +static struct nvmem_cell_lookup foobar_lookup = {
> +	.info = {
> +		.name = "mac-address",
> +		.offset = 0xd000,
> +		.bytes = ERH_ALEN,
> +	},
> +	.nvmem_name = "foobar",
> +};
> +
> +static void foobar_register(void)
> +{
> +	...
> +	nvmem_add_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
> +A lookup entry table can be later removed if needed:
> +
> +static void foobar_fini(void)
> +{
> +	...
> +	nvmem_del_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
>   NVMEM Consumers
>   +++++++++++++++
>   
> 
