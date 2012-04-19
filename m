From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 19:59:14 +0000
Subject: [PATCH V2 6/6] SPEAr: Switch to common clock framework
In-Reply-To: <ddade82f0666c3186b8a694aa2b79acd3f7e5d50.1334852395.git.viresh.kumar@st.com>
References: <cover.1334852393.git.viresh.kumar@st.com>
 <ddade82f0666c3186b8a694aa2b79acd3f7e5d50.1334852395.git.viresh.kumar@st.com>
Message-ID: <201204191959.15182.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 April 2012, Viresh Kumar wrote:
> SPEAr SoCs used its own clock framework since now. From now on they will move to
> use common clock framework.
> 
> This patch updates existing SPEAr machine support to adapt for common clock
> framework.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  MAINTAINERS                                     |    4 +-
>  arch/arm/Kconfig                                |    1 +
>  arch/arm/mach-spear3xx/Makefile                 |    2 +-
>  arch/arm/mach-spear3xx/clock.c                  |  892 --------------------
>  arch/arm/mach-spear3xx/include/mach/generic.h   |    4 +-
>  arch/arm/mach-spear3xx/include/mach/misc_regs.h |    2 +
>  arch/arm/mach-spear3xx/include/mach/spear.h     |   13 +
>  arch/arm/mach-spear3xx/spear300.c               |    1 -
>  arch/arm/mach-spear3xx/spear310.c               |    1 -
>  arch/arm/mach-spear3xx/spear320.c               |   12 +-
>  arch/arm/mach-spear3xx/spear3xx.c               |    2 +
>  arch/arm/mach-spear6xx/Makefile                 |    2 +-
>  arch/arm/mach-spear6xx/clock.c                  |  789 ------------------
>  arch/arm/mach-spear6xx/include/mach/misc_regs.h |    2 +
>  arch/arm/mach-spear6xx/spear6xx.c               |    5 +-
>  arch/arm/plat-spear/Makefile                    |    2 +-
>  arch/arm/plat-spear/clock.c                     | 1005 -----------------------
>  arch/arm/plat-spear/include/plat/clock.h        |  249 ------
>  drivers/clk/spear/Makefile                      |    3 +
>  drivers/clk/spear/spear3xx_clock.c              |  612 ++++++++++++++
>  drivers/clk/spear/spear6xx_clock.c              |  342 ++++++++
>  21 files changed, 994 insertions(+), 2951 deletions(-)

Great diffstat!

	Arnd
