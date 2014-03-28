From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 28 Mar 2014 19:51:19 +0100
Subject: [STLinux Kernel] [PATCH 49/75] ARM: l2c: fix register naming
In-Reply-To: <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
Message-ID: <5335C4A7.60904@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russel,

On 03/28/2014 04:18 PM, Russell King wrote:
> We have a mixture of different devices with different register layouts,
> but we group all the bits together in an opaque mess.  Split them out
> into those which are L2C-310 specific and ones which refer to earlier
> devices.  Provide full auxiliary control register definitions.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/include/asm/hardware/cache-l2x0.h | 73 ++++++++++++++++++++----------
>   arch/arm/mach-cns3xxx/core.c               |  8 ++--
>   arch/arm/mach-imx/system.c                 |  8 ++--
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c  |  2 +-
>   arch/arm/mach-omap2/omap4-common.c         | 18 ++++----
>   arch/arm/mach-prima2/l2x0.c                |  5 +-
>   arch/arm/mach-realview/realview_pbx.c      |  4 +-
>   arch/arm/mach-spear/spear13xx.c            |  6 +--
>   arch/arm/mach-sti/board-dt.c               |  8 ++--
>   arch/arm/mach-tegra/sleep.h                |  8 ++--
>   arch/arm/mach-ux500/cache-l2x0.c           |  4 +-
>   arch/arm/mach-vexpress/ct-ca9x4.c          |  4 +-
>   arch/arm/mm/cache-l2x0.c                   | 57 +++++++++++------------
>   arch/arm/plat-samsung/s5p-sleep.S          |  8 ++--
>   14 files changed, 118 insertions(+), 95 deletions(-)
>

For the mach-sti part:

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
