From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Oct 2012 20:51:57 +0530
Subject: [RFC 6/6] ARM: sched: clear SD_SHARE_POWERLINE
In-Reply-To: <1349595838-31274-7-git-send-email-vincent.guittot@linaro.org>
References: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
 <1349595838-31274-7-git-send-email-vincent.guittot@linaro.org>
Message-ID: <50880795.4030609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 October 2012 01:13 PM, Vincent Guittot wrote:
> The ARM platforms take advantage of packing small tasks on few cores.
> This is true even when the cores of a cluster can't be powergated
> independently.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   arch/arm/kernel/topology.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 26c12c6..00511d0 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -226,6 +226,11 @@ static inline void update_cpu_power(unsigned int cpuid, unsigned int mpidr) {}
>    */
>   struct cputopo_arm cpu_topology[NR_CPUS];
>
> +int arch_sd_share_power_line(void)
> +{
> +	return 0*SD_SHARE_POWERLINE;
> +}

Making this selection of policy based on sched domain will better. Just
gives the flexibility to choose a separate scheme for big and little
systems which will be very convenient.

Regards
Santosh
