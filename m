From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 6 Aug 2011 18:45:19 +0100
Subject: [PATCH 2/2] arm/tegra: Delete irq_to_gpio
In-Reply-To: <1312582534-10871-2-git-send-email-swarren@nvidia.com>
References: <1312582534-10871-1-git-send-email-swarren@nvidia.com>
	<1312582534-10871-2-git-send-email-swarren@nvidia.com>
Message-ID: <20110806174519.GB31966@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 04:15:34PM -0600, Stephen Warren wrote:
> irq_to_gpio is deprecated and in the process of being removed. Make that
> happen now for ARM Tegra.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied both.  Thanks.

g.

> ---
> I assume this will go into one of arm-soc.git's branches, but it depends
> on the previous patch in this series to compile. Arnd, I see you already
> have Grant's gpio/next tree in your repo as depends/gpio, so I assume
> you'll just pick up and merge the latest version of Grant's tree before
> applying this patch?
> 
> Both patches compiled with a number of Tegra boards enable and tested on
> Harmony. All without Device Tree support.
> 
>  arch/arm/mach-tegra/include/mach/gpio.h |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
> index 196f114..b357808 100644
> --- a/arch/arm/mach-tegra/include/mach/gpio.h
> +++ b/arch/arm/mach-tegra/include/mach/gpio.h
> @@ -32,7 +32,6 @@
>  #define gpio_cansleep		__gpio_cansleep
>  
>  #define TEGRA_GPIO_TO_IRQ(gpio) (INT_GPIO_BASE + (gpio))
> -#define TEGRA_IRQ_TO_GPIO(irq) ((irq) - INT_GPIO_BASE)
>  
>  static inline int gpio_to_irq(unsigned int gpio)
>  {
> @@ -41,13 +40,6 @@ static inline int gpio_to_irq(unsigned int gpio)
>  	return -EINVAL;
>  }
>  
> -static inline int irq_to_gpio(unsigned int irq)
> -{
> -	if ((irq >= INT_GPIO_BASE) && (irq < INT_GPIO_BASE + INT_GPIO_NR))
> -		return irq - INT_GPIO_BASE;
> -	return -EINVAL;
> -}
> -
>  struct tegra_gpio_table {
>  	int	gpio;	/* GPIO number */
>  	bool	enable;	/* Enable for GPIO at init? */
> -- 
> 1.7.0.4
> 
