From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Aug 2018 09:33:39 +0100
Subject: [PATCH v2 05/29] nvmem: remove the name field from struct
 nvmem_device
In-Reply-To: <20180810080526.27207-6-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-6-brgl@bgdev.pl>
Message-ID: <c54df79b-2491-61b0-6a91-12798a7ba3e0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/18 09:05, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This field is never set and is only used in a single error message.
> Remove the field and use nvmem_dev_name() instead.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
Looks good to me!

>   drivers/nvmem/core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 31df2e6d6f72..ab3ced2d9a84 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -26,7 +26,6 @@
>   #include <linux/slab.h>
>   
>   struct nvmem_device {
> -	const char		*name;
>   	struct module		*owner;
>   	struct device		dev;
>   	int			stride;
> @@ -712,7 +711,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
>   	if (!try_module_get(nvmem->owner)) {
>   		dev_err(&nvmem->dev,
>   			"could not increase module refcount for cell %s\n",
> -			nvmem->name);
> +			nvmem_dev_name(nvmem));
>   
>   		mutex_lock(&nvmem_mutex);
>   		nvmem->users--;
> 
