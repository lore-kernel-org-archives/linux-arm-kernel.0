From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 23:06:39 +0200
Subject: [GIT PULL v2 1/2] ARM: vexpress: addition of MPS2 platform
 support for v4.7
In-Reply-To: <1461601876-25288-1-git-send-email-sudeep.holla@arm.com>
References: <1461601876-25288-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <7512668.6FnnShhbHF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 17:31:15 Sudeep Holla wrote:
> ARMv7 Cortex-M Prototyping System (MPS2) support
> 
> Basic support for ARM Versatile Express Cortex-M Prototyping System
> (V2M-MPS2). ucLinux can be now run on both the hardware and FVP models
> with Cortex-M3/M4/M7 configurations (Vladimir Murzin)
> 
> ----------------------------------------------------------------
> Vladimir Murzin (5):
>       ARM: vexpress/mps2: introduce MPS2 platform
>       ARM: configs: add MPS2 defconfig
>       ARM: dts: introduce MPS2 AN385/AN386
>       ARM: dts: introduce MPS2 AN399/AN400
>       MAINTAINERS: Update ARM Versatile Express platform entry
> 
>  MAINTAINERS                          |   1 +
>  arch/arm/Kconfig                     |  12 ++
>  arch/arm/Makefile                    |   1 +
>  arch/arm/boot/dts/Makefile           |   3 +
>  arch/arm/boot/dts/mps2-an385.dts     |  92 +++++++++++++
>  arch/arm/boot/dts/mps2-an399.dts     |  92 +++++++++++++
>  arch/arm/boot/dts/mps2.dtsi          | 241 +++++++++++++++++++++++++++++++++++
>  arch/arm/configs/mps2_defconfig      | 109 ++++++++++++++++
>  arch/arm/mach-vexpress/Makefile      |   4 +-
>  arch/arm/mach-vexpress/Makefile.boot |   3 +
>  arch/arm/mach-vexpress/v2m-mps2.c    |  21 +++
> 

Thanks for respinning them, all the contents look good for arm-soc now.

However, the way we pull them in, I need them separately for dts, defconfig and
the rest. This means only one or two patches for each branch, which is getting
slightly silly at that point, so you could just send them as patches,
or I can cherry-pick the changes into the individual branches to save you
yet another respin.

	Arnd
