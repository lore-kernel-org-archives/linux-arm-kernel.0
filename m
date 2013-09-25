From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Sep 2013 14:29:39 +0900
Subject: [PATCH] ARM: shmobile: r8a7791 SMP support
In-Reply-To: <20130912005007.24692.14749.sendpatchset@w520>
References: <20130912005007.24692.14749.sendpatchset@w520>
Message-ID: <20130925052938.GB1916@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 09:50:07AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add r8a7791 SMP support using the shared APMU code. This patch
> also includes DTS modifications to enable the secondary CA15
> CPU core to fully support the single cluster dual core r8a7791.
> 
> SMP boot and CPU Hotplug are known to be working.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-devel-20130906, depends on
>  [PATCH v2 01/03] ARM: shmobile: Shared APMU SMP support code without DT
> 
>  arch/arm/boot/dts/r8a7791.dtsi                |    7 ++
>  arch/arm/mach-shmobile/Makefile               |    1 
>  arch/arm/mach-shmobile/board-koelsch.c        |    1 
>  arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 
>  arch/arm/mach-shmobile/setup-r8a7791.c        |    1 
>  arch/arm/mach-shmobile/smp-r8a7791.c          |   62 +++++++++++++++++++++++++
>  6 files changed, 73 insertions(+)

Hi Magnus,

please split this into three patches.

1. An SoC patch: The *r8a7791.[ch] and Makefile changes
2. A board patch: The board-koelsh.c change
3. A dt patch: The .dtsi change
