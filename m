From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 May 2017 19:40:02 +0100
Subject: [PATCH v5 2/7] arm: fix return value of parse_cpu_capacity
In-Reply-To: <20170531165931.6945-3-juri.lelli@arm.com>
References: <20170531165931.6945-1-juri.lelli@arm.com>
 <20170531165931.6945-3-juri.lelli@arm.com>
Message-ID: <20170531184002.GC27796@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 05:59:26PM +0100, Juri Lelli wrote:
> parse_cpu_capacity() has to return 0 on failure, but it currently returns
> 1 instead if raw_capacity kcalloc failed.
> 
> Fix it (by directly returning 0).
> 
> Cc: Russell King <linux@arm.linux.org.uk>

You can drop these Cc's now.  Thanks.

> Reported-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Fixes: 06073ee26775 ('ARM: 8621/3: parse cpu capacity-dmips-mhz from DT')
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Vincent Guittot <vincent.guittot@linaor.org>
> ---
>  arch/arm/kernel/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index f8a3ab82e77f..1b8ec3054642 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -166,7 +166,7 @@ static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  			if (!raw_capacity) {
>  				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
>  				cap_parsing_failed = true;
> -				return !ret;
> +				return 0;
>  			}
>  		}
>  		capacity_scale = max(cpu_capacity, capacity_scale);
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
