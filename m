From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 May 2014 12:46:07 +0200
Subject: [PATCH 1/6] of: align RESERVEDMEM_OF_DECLARE function callbacks to
 other callbacks
In-Reply-To: <1399587823-17701-2-git-send-email-robherring2@gmail.com>
References: <1399587823-17701-1-git-send-email-robherring2@gmail.com>
 <1399587823-17701-2-git-send-email-robherring2@gmail.com>
Message-ID: <536CB1EF.2090204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-05-09 00:23, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>
> All the parameters for RESERVEDMEM_OF_DECLARE function callbacks are
> members of struct reserved_mem, so just pass the struct ptr to callback
> functions so the function callback is more in line with other OF match
> table callbacks.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/of/of_reserved_mem.c    | 2 +-
>   include/linux/of_reserved_mem.h | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index e420eb5..632aae8 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -188,7 +188,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
>   		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
>   			continue;
>   
> -		if (initfn(rmem, rmem->fdt_node, rmem->name) == 0) {
> +		if (initfn(rmem) == 0) {
>   			pr_info("Reserved memory: initialized node %s, compatible id %s\n",
>   				rmem->name, compat);
>   			return 0;
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index 9b1fbb7..4c81b84 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -21,8 +21,8 @@ struct reserved_mem_ops {
>   				  struct device *dev);
>   };
>   
> -typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem,
> -				      unsigned long node, const char *uname);
> +typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
> +
>   
>   #ifdef CONFIG_OF_RESERVED_MEM
>   void fdt_init_reserved_mem(void);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
