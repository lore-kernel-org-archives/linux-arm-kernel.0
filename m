From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 5 Jul 2011 23:37:00 -0600
Subject: [PATCH] ARM: tegra: gpio: Use engineering names in DT compatible
	property
In-Reply-To: <1309896918-22496-1-git-send-email-swarren@nvidia.com>
References: <1309896918-22496-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110706053700.GC9978@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 02:15:18PM -0600, Stephen Warren wrote:
> Engineering names are more stable than marketing names. Hence, use them
> for Device Tree compatible properties instead.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Grant, This patch is physically against devicetree/arm, but also makes
> sense to apply to devicetree/test. This patch will cause conflicts
> somewhere, given you previously posted a patch to move gpio.c into
> drivers/gpio.

Applied to gpio/next, Thanks!

g.

> 
>  .../devicetree/bindings/gpio/gpio_nvidia.txt       |    2 +-
>  arch/arm/mach-tegra/gpio.c                         |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> index afb3ff3..64aac39 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> @@ -1,7 +1,7 @@
>  NVIDIA Tegra 2 GPIO controller
>  
>  Required properties:
> -- compatible : "nvidia,tegra250-gpio"
> +- compatible : "nvidia,tegra20-gpio"
>  - #gpio-cells : Should be two. The first cell is the pin number and the
>    second cell is used to specify optional parameters (currently unused).
>  - gpio-controller : Marks the device node as a GPIO controller.
> diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
> index 13afb88..747eb40 100644
> --- a/arch/arm/mach-tegra/gpio.c
> +++ b/arch/arm/mach-tegra/gpio.c
> @@ -347,7 +347,7 @@ static int __init tegra_gpio_init(void)
>  	 * driver is converted into a platform_device
>  	 */
>  	tegra_gpio_chip.of_node = of_find_compatible_node(NULL, NULL,
> -						"nvidia,tegra250-gpio");
> +						"nvidia,tegra20-gpio");
>  #endif /* CONFIG_OF_GPIO */
>  
>  	gpiochip_add(&tegra_gpio_chip);
> -- 
> 1.7.0.4
> 
