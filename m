From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Jun 2013 11:04:50 +0100
Subject: [PATCH] ARM: kernel: document ARM CPUs clock-frequency property
In-Reply-To: <1371635237-22860-1-git-send-email-f.fainelli@gmail.com>
References: <1371635237-22860-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20130619100450.GA27181@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 10:47:17AM +0100, Florian Fainelli wrote:
> ARM CPU device tree nodes may contain an optional clock-frequency
> property, when set, this property must contain the CPU frequency in Hz,
> which is then used by the topology parsing code in
> arch/arm/kernel/topology.c to infer the CPU capacity.

I see that arch/arm/kernel/topology.c does a pr_err when clock-frequency isn't
present. If we're documenting it as optional, should we not downgrade that or
remove it entirely?

Thanks,
Mark.

> 
> Document this property to avoid any possible confusion on the
> clock-frequency unit.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index f32494d..a33b956 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -45,6 +45,8 @@ For the ARM architecture every CPU node must contain the following properties:
>  		"marvell,xsc3"
>  		"marvell,xscale"
>  
> +- clock-frequency : The frequency of the CPU, in Hz. Optional.
> +
>  Example:
>  
>  	cpus {
> -- 
> 1.8.1.2
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
