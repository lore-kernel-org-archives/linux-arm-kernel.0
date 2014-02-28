From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 28 Feb 2014 03:40:05 +0100
Subject: [PATCH 00/02] ARM: shmobile: CCI and MCPM support for r8a7790
In-Reply-To: <20140226231326.4303.71886.sendpatchset@w520>
References: <20140226231326.4303.71886.sendpatchset@w520>
Message-ID: <8057177.PCGjXm0ZkO@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thursday 27 February 2014 08:13:26 Magnus Damm wrote:
> ARM: shmobile: CCI and MCPM support for r8a7790
> 
> [PATCH 01/02] ARM: shmobile: Hook in CCI/MCPM support to shared APMU code
> [PATCH 02/02] ARM: shmobile: Add CCI nodes to r8a7790 DTS
> 
> Add code to interface to the CCI driver and MCPM to mach-shmobile. The
> shared APMU SMP code is extended to share CPU power domain power on
> and off support via both regular SMP hooks and MCPM callbacks.
> 
> It is worth noting that the APMU code is used for multiple SoCs including
> the Dual core CA15 r8a7791 where this MCPM support is not needed and the
> big.LITTLE r8a7790 that needs to program the CCI.
> 
> Previously posted as "[PATCH] ARM: shmobile: MCPM and CCI prototype".

I won't review these patches as I have no idea how CCI and MCPM work (I don't 
even know what the latter stands for), but is there a chance this could be 
useful for the IPMMU that can use CCI (and DVM) to remove the need for 
explicit cache management in page tables management ?

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git tag renesas-devel-v3.14-rc4-20140226
> 
>  arch/arm/boot/dts/r8a7790.dtsi               |   28 ++++++
>  arch/arm/mach-shmobile/headsmp.S             |    7 +
>  arch/arm/mach-shmobile/include/mach/common.h |    1
>  arch/arm/mach-shmobile/platsmp-apmu.c        |  111 +++++++++++++++++++++--
>  arch/arm/mach-shmobile/platsmp.c             |    4
>  5 files changed, 144 insertions(+), 7 deletions(-)

-- 
Regards,

Laurent Pinchart
