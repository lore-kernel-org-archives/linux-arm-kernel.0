From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 14:34:05 +0000
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <cover.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
Message-ID: <201204171434.06178.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Viresh Kumar wrote:
> SPEAr now supports common clock framework. This patchset contains changes
> related to this. It also contain few dependency commits for clock framework that
> are earlier sent separately.
> 
> @Mike: It would be easiest to get these through ARM-SoC tree. So, would need
> your Acked-by on these patches. But firstly they must get reivewed :)

We should agree on how we want to do the common clk patches for v3.5.
The two options I see are either we take all the patches that Mike
Acks into arm-soc, or Mike applies the patches in his own tree and
submits them to arm-soc. I think either way is fine for me, but
some people might feel strongly one way or another.

>  MAINTAINERS                                     |    4 +-
>  arch/arm/Kconfig                                |    1 +
>  arch/arm/mach-spear3xx/clock.c                  | 1354 +++++++++--------------
>  arch/arm/mach-spear3xx/include/mach/generic.h   |    4 +-
>  arch/arm/mach-spear3xx/include/mach/misc_regs.h |    2 +
>  arch/arm/mach-spear3xx/include/mach/spear.h     |   13 +
>  arch/arm/mach-spear3xx/spear300.c               |    1 -
>  arch/arm/mach-spear3xx/spear310.c               |    1 -
>  arch/arm/mach-spear3xx/spear320.c               |   12 +-
>  arch/arm/mach-spear3xx/spear3xx.c               |    2 +
>  arch/arm/mach-spear6xx/clock.c                  | 1015 +++++------------
>  arch/arm/mach-spear6xx/include/mach/misc_regs.h |    2 +
>  arch/arm/mach-spear6xx/spear6xx.c               |    5 +-
>  arch/arm/plat-spear/Makefile                    |    3 +-
>  arch/arm/plat-spear/clk-aux-synth.c             |  195 ++++
>  arch/arm/plat-spear/clk-frac-synth.c            |  156 +++
>  arch/arm/plat-spear/clk-gpt-synth.c             |  145 +++
>  arch/arm/plat-spear/clk-vco-pll.c               |  346 ++++++
>  arch/arm/plat-spear/clock.c                     | 1005 -----------------

I wonder: should the clock drivers remain part of the platform directory,
or get moved into a subdirectory of drivers/clk? I was assuming that 
we'd do the latter, but I haven't been following the clk discussions
that closely.

	Arnd
