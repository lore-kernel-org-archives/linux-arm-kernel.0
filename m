From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Apr 2013 09:53:34 +0100
Subject: [PATCH 01/21] ARM: topology: export cpu_topology
In-Reply-To: <1366910944-3033663-2-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-2-git-send-email-arnd@arndb.de>
Message-ID: <20130426085333.GA30284@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 06:28:44PM +0100, Arnd Bergmann wrote:
> The cpu_topology symbol is required by any driver using the topology
> interfaces, which leads to a couple of build errors:
> 
> ERROR: "cpu_topology" [drivers/net/ethernet/sfc/sfc.ko] undefined!
> ERROR: "cpu_topology" [drivers/cpufreq/arm_big_little.ko] undefined!

Are these first two in mainline?

> ERROR: "cpu_topology" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
> 
> The obvious solution is to export this symbol.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm/kernel/topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index f10316b..7ac5714 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -200,6 +200,7 @@ static inline void update_cpu_power(unsigned int cpuid, unsigned int mpidr) {}
>   * cpu topology table
>   */
>  struct cputopo_arm cpu_topology[NR_CPUS];
> +EXPORT_SYMBOL_GPL(cpu_topology);


Make sense:

  Acked-by: Will Deacon <will.deacon@arm.com>

Probably best to put it in the patch system.

Will
