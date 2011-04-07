From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 7 Apr 2011 10:17:04 -0700
Subject: [patch 1/2] Add dt_compat field to struct gpio_chip
In-Reply-To: <20110407163930.GB17498@dandreoli.com>
References: <20110407163322.465935232@gmail.com>
	<20110407163930.GB17498@dandreoli.com>
Message-ID: <20110407171704.GC2455@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2011 at 06:39:30PM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <cavokz@gmail.com>
> 
> This new field allows easy creation of GPIO chips in base of struct arrays.
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
> ---
>  drivers/of/gpio.c          |    3 +++
>  include/asm-generic/gpio.h |    1 +
>  2 files changed, 4 insertions(+)
> 
> Index: b/drivers/of/gpio.c
> ===================================================================
> --- a/drivers/of/gpio.c	2011-04-07 18:19:20.000000000 +0200
> +++ b/drivers/of/gpio.c	2011-04-07 18:20:31.000000000 +0200
> @@ -212,6 +212,9 @@
>  
>  void of_gpiochip_add(struct gpio_chip *chip)
>  {
> +	if ((!chip->of_node) && (chip->dt_compat))
> +		chip->of_node = of_find_compatible_node(NULL, NULL, chip->dt_compat);
> +

Hi Domenico,

Thanks for looking at this.

However, I think there is a better way to solve this problem,
