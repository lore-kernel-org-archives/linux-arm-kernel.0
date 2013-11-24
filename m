From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 22:29:18 -0500
Subject: [PATCH] arm: mvebu: fix some sparse warnings
In-Reply-To: <1383814958-5272-1-git-send-email-jszhang@marvell.com>
References: <1383814958-5272-1-git-send-email-jszhang@marvell.com>
Message-ID: <20131124032918.GV29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 05:02:38PM +0800, Jisheng Zhang wrote:
> This patch fixes conflicting types for 'set_cpu_coherent' and fixes the
> following sparse warnings.
> 
> arch/arm/mach-mvebu/system-controller.c:42:38:
> warning: symbol 'armada_370_xp_system_controller' was not declared. Should it be static?
> arch/arm/mach-mvebu/system-controller.c:49:38:
> warning: symbol 'orion_system_controller' was not declared. Should it be static?
> arch/arm/mach-mvebu/system-controller.c:67:6:
> warning: symbol 'mvebu_restart' was not declared. Should it be static?
> arch/arm/mach-mvebu/coherency.c:31:15:
> warning: symbol 'coherency_phys_base' was not declared. Should it be static?
> arch/arm/mach-mvebu/coherency.c:48:5:
> warning: symbol 'set_cpu_coherent' was not declared. Should it be static?
> arch/arm/mach-mvebu/coherency.c:123:12:
> warning: symbol 'coherency_init' was not declared. Should it be static?
> arch/arm/mach-mvebu/pmsu.c:38:5: warning:
> symbol 'armada_xp_boot_cpu' was not declared. Should it be static?
> arch/arm/mach-mvebu/pmsu.c:61:12: warning:
> symbol 'armada_370_xp_pmsu_init' was not declared. Should it be static?
> arch/arm/mach-mvebu/platsmp.c:49:13: warning:
> symbol 'set_secondary_cpus_clock' was not declared. Should it be static?
> arch/arm/mach-mvebu/platsmp.c:97:13: warning:
> symbol 'armada_xp_smp_prepare_cpus' was not declared. Should it be static?
> arch/arm/mach-mvebu/hotplug.c:24:12: warning:
> symbol 'armada_xp_cpu_die' was not declared. Should it be static?
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm/mach-mvebu/coherency.c         | 1 +
>  arch/arm/mach-mvebu/coherency.h         | 4 +++-
>  arch/arm/mach-mvebu/common.h            | 1 -
>  arch/arm/mach-mvebu/hotplug.c           | 1 +
>  arch/arm/mach-mvebu/platsmp.c           | 4 ++--
>  arch/arm/mach-mvebu/pmsu.c              | 3 ++-
>  arch/arm/mach-mvebu/system-controller.c | 5 +++--
>  7 files changed, 12 insertions(+), 7 deletions(-)

Applied to mvebu/soc with Gregory's Ack.

thx,

Jason.
