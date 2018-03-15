From: david@lechnology.com (David Lechner)
Date: Thu, 15 Mar 2018 11:35:21 -0500
Subject: [v2] ARM: davinci: fix the GPIO lookup for omapl138-hawk
In-Reply-To: <20180301103448.27233-1-brgl@bgdev.pl>
References: <20180301103448.27233-1-brgl@bgdev.pl>
Message-ID: <2641a421-9823-c0bb-93d9-ca0c64060c51@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2018 04:34 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
> mmc can correctly lookup the wp and cp gpios.
> 
> Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc pins")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v1 -> v2:
> - added the Fixes: tag
> 
>   arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index a3e78074be70..62eb7d668890 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -127,8 +127,8 @@ static struct gpiod_lookup_table mmc_gpios_table = {
>   	.dev_id = "da830-mmc.0",
>   	.table = {
>   		/* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
> -		GPIO_LOOKUP("davinci_gpio.1", 28, "cd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("davinci_gpio.1", 29, "wp", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", 28, "cd", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", 29, "wp", GPIO_ACTIVE_LOW),
>   	},
>   };
>   
> 

Does board-da830-evm.c need the same fix? It also uses "davinci_gpio.1".
