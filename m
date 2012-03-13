From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Mar 2012 11:32:12 -0500
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <1331500100-31351-4-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-4-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020695AB97DC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, March 11, 2012 2:08 PM, Rob Herring wrote:
>
> Several platforms create IOMEM defines for casting to 'void __iomem *',
> and other platforms are incorrectly using __io() macro for the same
> purpose. This creates a common definition and removes all the platform
> specific versions. Rather than try to make linux/io.h and asm/io.h
> assembly safe, the assembly version of IOMEM is moved into
> asm/assembler.h.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/include/asm/assembler.h                |    2 ++
>  arch/arm/include/asm/io.h                       |    2 ++
>  arch/arm/kernel/debug.S                         |    1 +
>  arch/arm/kernel/entry-armv.S                    |    1 +
>  arch/arm/mach-davinci/include/mach/hardware.h   |    6 ------
>  arch/arm/mach-davinci/include/mach/uncompress.h |    2 ++
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    9 ---------
>  arch/arm/mach-mmp/include/mach/addr-map.h       |    6 ------
>  arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |    6 ------
>  arch/arm/mach-msm/include/mach/msm_iomap.h      |    6 ------
>  arch/arm/mach-mxs/include/mach/hardware.h       |    6 ------
>  arch/arm/mach-omap1/ams-delta-fiq-handler.S     |    1 +
>  arch/arm/mach-omap1/iomap.h                     |    6 ------
>  arch/arm/mach-omap2/clock3xxx_data.c            |    1 +
>  arch/arm/mach-omap2/clock44xx_data.c            |    1 +
>  arch/arm/mach-omap2/iomap.h                     |    6 ------
>  arch/arm/mach-rpc/include/mach/hardware.h       |    6 ------
>  arch/arm/mach-spear3xx/clock.c                  |    1 +
>  arch/arm/mach-spear6xx/clock.c                  |    1 +
>  arch/arm/mach-tegra/include/mach/iomap.h        |    6 ------
>  arch/arm/mach-u300/include/mach/u300-regs.h     |    6 ------
>  arch/arm/plat-mxc/include/mach/hardware.h       |    6 ------
>  arch/arm/plat-omap/include/plat/hardware.h      |    6 ------
>  arch/arm/plat-omap/include/plat/usb.h           |    1 -
>  arch/arm/plat-spear/include/plat/hardware.h     |    6 ------
>  25 files changed, 13 insertions(+), 88 deletions(-)
>

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
