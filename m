From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 30 Sep 2013 20:31:05 +0200
Subject: [PATCH v2] ARM: shmobile: ape6evm: fix incorrect placement of
 __initdata tag
In-Reply-To: <1959578.PFsrHiTtYY@amdc1032>
References: <1959578.PFsrHiTtYY@amdc1032>
Message-ID: <27072275.6rIbiFzHY2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 September 2013 17:34:36 Bartlomiej Zolnierkiewicz wrote:
> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
> - use __initdata as it is OK to do it
> 
>  arch/arm/mach-shmobile/board-ape6evm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ape6evm.c
> b/arch/arm/mach-shmobile/board-ape6evm.c index 7627385..8954f55 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> @@ -86,7 +86,7 @@ static struct gpio_keys_button gpio_buttons[] = {
>  	GPIO_KEY(KEY_VOLUMEDOWN,	329,	"S21"),
>  };
> 
> -static struct __initdata gpio_keys_platform_data ape6evm_keys_pdata = {
> +static struct gpio_keys_platform_data ape6evm_keys_pdata __initdata = {
>  	.buttons	= gpio_buttons,
>  	.nbuttons	= ARRAY_SIZE(gpio_buttons),
>  };
-- 
Regards,

Laurent Pinchart
