From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 5 Jan 2012 11:08:11 -0700
Subject: [PULL] gpio pl061 for 3.3
In-Reply-To: <4F05BAC1.1000706@gmail.com>
References: <4F05BAC1.1000706@gmail.com>
Message-ID: <20120105180811.GD22653@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 08:59:13AM -0600, Rob Herring wrote:
> Grant,
> 
> Since it seems irqdomain issues aren't going to get sorted out for 3.3,
> please pull the pl061 changes which are not dependent on irqdomain.
> Sorry it is a bit late.
> 
> The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:
> 
>   Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)
> 
> are available in the git repository at:
>   git://sources.calxeda.com/kernel/linux.git gpio-for-grant

Merged, thanks.

g.

> 
> Rob Herring (5):
>       gpio: pl061: use chained_irq_* functions in irq handler
>       gpio: pl061: convert to use 0 for no irq
>       ARM: realview: convert pl061 no irq to 0 instead of -1
>       gpio: pl061: convert to use generic irq chip
>       gpio: pl061: remove combined interrupt
> 
>  arch/arm/mach-realview/realview_eb.c     |    3 -
>  arch/arm/mach-realview/realview_pb1176.c |    3 -
>  arch/arm/mach-realview/realview_pb11mp.c |    3 -
>  arch/arm/mach-realview/realview_pba8.c   |    3 -
>  arch/arm/mach-realview/realview_pbx.c    |    3 -
>  drivers/gpio/Kconfig                     |    1 +
>  drivers/gpio/gpio-pl061.c                |  132
> ++++++++++--------------------
>  include/linux/amba/pl061.h               |    2 +-
>  8 files changed, 44 insertions(+), 106 deletions(-)
> 
> Rob
