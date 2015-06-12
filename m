From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 12 Jun 2015 15:55:37 +0200
Subject: [PATCH] ARM: mvebu: add missing newline at end of messages
In-Reply-To: <1434116314-10533-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434116314-10533-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150612135537.GH21991@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 03:38:34PM +0200, Thomas Petazzoni wrote:
> Commit 548ae94c1cc7f ("ARM: mvebu: Disable CPU Idle on Armada 38x")
> added two new pr_warn() messages in mach-mvebu/pmsu.c. However, these
> messages lack the final new line, causing the next message to be
> displayed on the same line.
> 
> This commit adds the missing ending newlines.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hardly needs it, but

Acked-by: Andrew Lunn <andrew@lunn.ch>?

	  Andrew


> ---
>  arch/arm/mach-mvebu/pmsu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 4f4e222..e8fdb9c 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -415,7 +415,7 @@ static __init int armada_38x_cpuidle_init(void)
>  	void __iomem *mpsoc_base;
>  	u32 reg;
>  
> -	pr_warn("CPU idle is currently broken on Armada 38x: disabling");
> +	pr_warn("CPU idle is currently broken on Armada 38x: disabling\n");
>  	return 0;
>  
>  	np = of_find_compatible_node(NULL, NULL,
> @@ -486,7 +486,7 @@ static int __init mvebu_v7_cpu_pm_init(void)
>  	 */
>  	if (of_machine_is_compatible("marvell,armada380")) {
>  		cpu_hotplug_disable();
> -		pr_warn("CPU hotplug support is currently broken on Armada 38x: disabling");
> +		pr_warn("CPU hotplug support is currently broken on Armada 38x: disabling\n");
>  	}
>  
>  	if (of_machine_is_compatible("marvell,armadaxp"))
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
