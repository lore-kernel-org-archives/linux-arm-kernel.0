From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 28 Oct 2012 15:28:47 +0400
Subject: [PATCH 01/12] ARM: shmobile: r8a7740: Enable PMU
In-Reply-To: <1351391173-32379-2-git-send-email-horms@verge.net.au>
References: <1351391173-32379-1-git-send-email-horms@verge.net.au>
 <1351391173-32379-2-git-send-email-horms@verge.net.au>
Message-ID: <508D16EF.7030800@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-10-2012 6:26, Simon Horman wrote:

> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

> This patch enables PMU for r8a7740.

    And enables performance events on the Armadillo board. Perhaps the 
defconfig part was worth a separate patch...

> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 11bb1d9..1e032cb 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -590,6 +590,21 @@ static struct platform_device i2c1_device = {
>   	.num_resources	= ARRAY_SIZE(i2c1_resources),
>   };
>
> +static struct resource pmu_resources[] = {
> +	[0] = {
> +		.start	= evt2irq(0x19a0),
> +		.end	= evt2irq(0x19a0),
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device pmu_device = {
> +	.name	= "arm-pmu",
> +	.id		= -1,

    I think you should either align '=' with tabs, or not bother doing this, 
not both. :-)

> +	.num_resources = ARRAY_SIZE(pmu_resources),
> +	.resource = pmu_resources,
> +};
> +
>   static struct platform_device *r8a7740_late_devices[] __initdata = {
>   	&i2c0_device,
>   	&i2c1_device,

WBR, Sergei
