From: cjb@laptop.org (Chris Ball)
Date: Sun, 08 Apr 2012 21:48:02 -0400
Subject: [PATCH 1/3] ARM i.MX27: Add devicetree support
In-Reply-To: <1330503654-2197-2-git-send-email-s.hauer@pengutronix.de> (Sascha
 Hauer's message of "Wed, 29 Feb 2012 09:20:52 +0100")
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
 <1330503654-2197-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87lim5zne5.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Feb 29 2012, Sascha Hauer wrote:
> This patch adds basic devicetree support for i.MX27 based SoCs.
> Only the bindings for which drivers exist are added here:
>
> - UART
> - fec
> - CSPI
> - I2C
> - watchdog
> - gpio
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi            |  217 +++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/Kconfig               |    8 +
>  arch/arm/mach-imx/Makefile              |    1 +
>  arch/arm/mach-imx/clock-imx27.c         |   18 +++
>  arch/arm/mach-imx/imx27-dt.c            |   89 +++++++++++++
>  arch/arm/plat-mxc/include/mach/common.h |    1 +
>  6 files changed, 334 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx27.dtsi
>  create mode 100644 arch/arm/mach-imx/imx27-dt.c
>
> [...]
> diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> new file mode 100644
> index 0000000..861ceb8
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx27-dt.c
>
> [...]
> +static int __init imx27_avic_add_irq_domain(struct device_node *np,
> +				struct device_node *interrupt_parent)
> +{
> +	irq_domain_add_simple(np, 0);
> +	return 0;
> +}
> +
> +static int __init imx27_gpio_add_irq_domain(struct device_node *np,
> +				struct device_node *interrupt_parent)
> +{
> +	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +
> +	irq_domain_add_simple(np, gpio_irq_base);
> +
> +	return 0;
> +}

This patch was merged for 3.4-rc1, but it fails to compile because Grant
removed irq_domain_add_simple() in 3.4-rc1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
