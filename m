From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Jun 2013 23:09:33 +0900
Subject: [PATCH] ARM: shmobile: Rework sh7372 sleep code to use
 virt_to_phys()
In-Reply-To: <20130605074553.16962.7736.sendpatchset@w520>
References: <20130605074553.16962.7736.sendpatchset@w520>
Message-ID: <20130612140932.GQ32751@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 04:45:53PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Instead of having a hard coded virt-to-phys address
> conversion code in sleep-sh7372.S, rework the code
> to do the conversion in C using virt_to_phys().
> 
> This removes the need for PLAT_PHYS_OFFSET which
> in turn is needed for ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Tested with A3SM Suspend-to-RAM on Mackerel.
> 
>  arch/arm/mach-shmobile/include/mach/sh7372.h |    2 ++
>  arch/arm/mach-shmobile/pm-sh7372.c           |    3 +++
>  arch/arm/mach-shmobile/sleep-sh7372.S        |    5 ++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
