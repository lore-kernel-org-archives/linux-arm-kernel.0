From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Aug 2012 22:16:13 +0800
Subject: [PATCH 0/5] Add device tree support for on-chip SRAM
In-Reply-To: <1345799866-19876-1-git-send-email-p.zabel@pengutronix.de>
References: <1345799866-19876-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20120824141610.GG31998@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 11:17:41AM +0200, Philipp Zabel wrote:
> These patches add support to configure the on-chip SRAM via device-tree
> node and to obtain the resulting genalloc pool from a phandle pointing   
> at the node.
> This allows drivers to allocate SRAM with the genalloc API without
> hard-coding the genalloc pool address.
> 
It looks like a good stuff.  But in the end, there is nothing IMX
specific with iram_alloc.c.  Why do we name it in IMX?

Regards,
Shawn

> regards
> Philipp
> 
> ---
>  arch/arm/boot/dts/imx53.dtsi          |    5 ++
>  arch/arm/boot/dts/imx6q.dtsi          |    5 ++
>  arch/arm/plat-mxc/include/mach/iram.h |   41 -----------------
>  arch/arm/plat-mxc/iram_alloc.c        |   81 ++++++++++++++++++++-------------
>  include/linux/genalloc.h              |   14 ++++++
>  lib/genalloc.c                        |   77 +++++++++++++++++++++++++++++++
>  6 files changed, 150 insertions(+), 73 deletions(-)
> 
