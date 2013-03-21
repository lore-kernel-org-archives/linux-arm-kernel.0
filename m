From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Mar 2013 19:41:29 +0900
Subject: [PATCH 0/3 v3] ARM: shmobile: add R8A7778 Bock-W board support v3
In-Reply-To: <878v5hf4zr.wl%kuninori.morimoto.gx@renesas.com>
References: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
 <878v5hf4zr.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130321104127.GH2348@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 06:59:20PM +0900, Kuninori Morimoto wrote:
> 
> Hi Simon, Magnus, Arnd
> 
> These are v3 patch set of R8A7778 R-Car M1 SoC/board support
> This SoC/board support have limited DT only.
> (TMU/SCIF can't use DT at this point)
> 
> I will work for external IRQ and SMSC support
> if these are accepted.
> 
> These patches are based on simon/next branch

Good choice :^)

I have no objections to these changes at this point
but I would appreciate an ack from Magnus before applying them.

> Kuninori Morimoto (3):
>       ARM: shmobile: add R8A7778 basis support
>       ARM: shmobile: r8a7778 SCIF support
>       ARM: shmobile: add R-Car M1A Bock-W platform support
> 
>  arch/arm/boot/dts/Makefile                    |    1 +
>  arch/arm/boot/dts/r8a7778-bockw.dts           |   32 ++++
>  arch/arm/boot/dts/r8a7778.dtsi                |   35 +++++
>  arch/arm/configs/bockw_defconfig              |   66 +++++++++
>  arch/arm/mach-shmobile/Kconfig                |   12 ++
>  arch/arm/mach-shmobile/Makefile               |    2 +
>  arch/arm/mach-shmobile/board-bockw.c          |   43 ++++++
>  arch/arm/mach-shmobile/clock-r8a7778.c        |  104 +++++++++++++
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |   28 ++++
>  arch/arm/mach-shmobile/setup-r8a7778.c        |  193 +++++++++++++++++++++++++
>  10 files changed, 516 insertions(+)
> 
> This is my command for DT uImage
> 
> PC> make bockw_defconfig
> PC> make menuconfig
> PC> make zImage
> PC> make dtbs
> PC> duImage r8a7778-bockw-reference
> PC> cp arch/sh/boot/duImage ${PATH}
> 
> ---- duImage --------------------------------
> #! /bin/sh
> 
> # create zImage + dtb = dzImage
> cat arch/arm/boot/zImage arch/arm/boot/dts/${1}.dtb > arch/arm/boot/dzImage
> 
> # create duImage
> DUIMAGE=`cut -f 3- -d ' ' < arch/arm/boot/.uImage.cmd | sed -e "s/zImage/dzImage/" | sed -e "s/uImage/duImage/"`
> ${DUIMAGE}%
> ----------------------------------------------
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
