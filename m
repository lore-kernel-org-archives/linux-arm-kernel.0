From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Apr 2011 23:41:43 -0700
Subject: [patch 1/2] Add dt_compat field to struct s3c_gpio_chip
In-Reply-To: <20110410153312.GB27088@dandreoli.com>
References: <20110410152735.338798127@gmail.com>
	<20110410153312.GB27088@dandreoli.com>
Message-ID: <20110411064143.GC4439@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2011 at 05:33:12PM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <cavokz@gmail.com>
> 
> This new field allows easy creation of GPIO chips in base of struct arrays.
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
> ---
>  arch/arm/plat-samsung/include/plat/gpio-core.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: b/arch/arm/plat-samsung/include/plat/gpio-core.h
> ===================================================================
> --- a/arch/arm/plat-samsung/include/plat/gpio-core.h	2011-04-07 22:43:45.000000000 +0200
> +++ b/arch/arm/plat-samsung/include/plat/gpio-core.h	2011-04-10 16:00:39.000000000 +0200
> @@ -71,6 +71,9 @@
>  #ifdef CONFIG_PM
>  	u32			pm_save[4];
>  #endif
> +#ifdef CONFIG_OF_GPIO
> +	const char		*dt_compat;
> +#endif

I think you can merge this with the next patch.

g.
