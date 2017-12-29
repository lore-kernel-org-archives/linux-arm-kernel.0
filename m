From: mylene.josserand@free-electrons.com (Mylene JOSSERAND)
Date: Fri, 29 Dec 2017 12:24:17 +0100
Subject: [PATCH v2 0/5] Sunxi: Add SMP support on A83T
In-Reply-To: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
References: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
Message-ID: <20171229122417.27c74c3f@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Fri, 29 Dec 2017 11:55:01 +0100,
Myl?ne Josserand <mylene.josserand@free-electrons.com> a ?crit :

> Hello everyone,
> 
> This is a V2 of my series that adds SMP support for Allwinner sun8i-a83t
> with MCPM (Multi-Cluster Power Management).
> Based on last linux-next (next-20171222).
> 
> Changes since v1:
>     - Add Chen Yu's patch in my series (see path 01)
>     - Add new compatibles for prcm and cpucfg registers for sun8i-a83t.
>     Create two functions to separate the DT parsing of sun9i-a80 and
>     sun8i-a83t.
>     - Thanks to Maxime's review: order device tree's nodes according
>     to physical addresses, remove unused label and fix registers' sizes.
>     Update the commit log and commit title of my last patch (see
>     patch 05).
> 
> Patch 01: Patch from Chen Yu Tsai that adds SMP support on A80
> with MCPM
> Patch 02: Convert the MCPM driver to use it for A83T. This SoC has a
> bit flip that needs to be handled.
> Patch 03: Add registers nodes (prcm, cpucfg and r_cpucfg) needed
> for MCPM.
> Patch 04: Add CCI-400 node for a83t.
> Patch 05: Fix the use of virtual timers that hangs the kernel in
> case of SMP support.
> 
> If you have any remarks/questions, let me know.
> Thank you in advance,
> Myl?ne
> 
> Chen-Yu Tsai (1):
>   ARM: sun9i: Support SMP on A80 with Multi-Cluster Power Management
>     (MCPM)

Oops, I noticed that Chen Yu sent a new version of his patches on
July 2017:

https://patchwork.kernel.org/patch/9861179/
https://patchwork.kernel.org/patch/9861175/
https://patchwork.kernel.org/patch/9861173/
https://patchwork.kernel.org/patch/9861177/

I will send a V3 using this series instead of the old RFC one:
https://patchwork.kernel.org/patch/6402801/

Sorry about the noise.

Myl?ne

> 
> Myl?ne Josserand (4):
>   ARM: sunxi: mcpm: Add support for A83T
>   arm: dts: sun8i: a83t: Add registers needed for MCPM
>   arm: dts: sun8i: a83t: Add CCI-400 node
>   arm: dts: sun8i: a83t: Fix undefined offset with virtual timer
> 
>  arch/arm/boot/dts/sun8i-a83t.dtsi |  57 +++++
>  arch/arm/mach-sunxi/Kconfig       |  11 +
>  arch/arm/mach-sunxi/Makefile      |   1 +
>  arch/arm/mach-sunxi/mcpm.c        | 513 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 582 insertions(+)
>  create mode 100644 arch/arm/mach-sunxi/mcpm.c
> 
