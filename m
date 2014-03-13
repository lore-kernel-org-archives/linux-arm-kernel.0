From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 10:16:31 +0900
Subject: [PATCH v2 00/03] ARM: shmobile: Break out and extend clock
 workaround V2
In-Reply-To: <20140312233608.17009.65690.sendpatchset@w520>
References: <20140312233608.17009.65690.sendpatchset@w520>
Message-ID: <20140313011627.GA9077@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 08:36:08AM +0900, Magnus Damm wrote:
> ARM: shmobile: Break out and extend clock workaround V2
> 
> [PATCH v2 01/03] ARM: shmobile: Introduce shmobile_clk_workaround()
> [PATCH 02/03] ARM: shmobile: Use shmobile_clk_workaround() on Lager
> [PATCH 03/03] ARM: shmobile: Use shmobile_clk_workaround() on Koelsch

If the series is v2 please annotate all patches in the series as v2,
even if they haven't changed.

> These patches consolidates the clkdev workaround present in the DT
> reference version of board code for Lager and Koelsch, and it also
> extends it to allow static enablement of a selected set of clocks
> during boot. The latter is needed for USB PCI support patches that
> have been posted.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Changes since V1:
>  - Reworked dependencies, updated header file path in patch [1/3].
> 
>  Written against renesas.git tag renesas-devel-v3.14-rc6-20140311
> 
>  arch/arm/mach-shmobile/Makefile                  |    2 
>  arch/arm/mach-shmobile/board-koelsch-reference.c |   71 ++++++++--------------
>  arch/arm/mach-shmobile/board-lager-reference.c   |   65 +++++++-------------
>  arch/arm/mach-shmobile/clock.c                   |   29 ++++++++
>  arch/arm/mach-shmobile/include/mach/clock.h      |   16 ++++
>  5 files changed, 99 insertions(+), 84 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
