From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Mar 2010 14:16:05 -0700
Subject: [PATCH 0/7] omap3: serial code for 3630 and zoom2/3 fixes
In-Reply-To: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
References: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Message-ID: <20100322211604.GV11448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergio Aguirre <saaguirre@ti.com> [100315 15:59]:
> Hi,
> 
> This series contains fixes for omap2/3/4 serial code, and are
> fixing:
>  - Avoid doing ioremap of a zero-based physical address.
>    (causing a kernel panic during early init on 3630boards)
>  - Unproper omap_revision check during uart globals setup.
>    (omap_revision is not yet filled at that point)
>  - Don't try to enable all uarts generically for zoom2/3
>    and 3630sdp.
>  - Make zoom2/3 just register one serial port (ttyS0).

Thanks, I've pulled this into omap-fixes-for-linus.

Regards,

Tony

 
> This is a subset of the original series found here: [1]
> 
> Thanks to:
>  - Vikram Pandita
>  - Paul Walmsley
>  - Kevin Hilman
>  - Manjunath Kondaiah
>  - Felipe Balbi
>  - Tony Lindgreen
> 
> For all the feedback recieved so far.
> 
> Regards,
> Sergio
> 
> Detailed changelog:
> 
> Sergio Aguirre (7):
>   OMAP3: serial: Check for zero-based physical addr
>   OMAP3: serial: Use dev_* macros instead of printk
>   omap2/3/4: serial: Remove condition for getting uart4_phys
>   omap3: zoom2/3 / 3630sdp: Don't init always all uarts
>   omap3: 3630sdp: Explicitly enable all UARTs
>   omap3: zoom 2/3: Change debugboard serial port id
>   omap3: zoom2/3: Register only 1 8250 port
> 
>  arch/arm/configs/omap_zoom2_defconfig        |    2 +-
>  arch/arm/configs/omap_zoom3_defconfig        |    2 +-
>  arch/arm/mach-omap2/board-3630sdp.c          |    1 +
>  arch/arm/mach-omap2/board-zoom-debugboard.c  |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
>  arch/arm/mach-omap2/serial.c                 |   35 +++++++++++++------------
>  6 files changed, 22 insertions(+), 21 deletions(-)
> 
> [1] http://marc.info/?l=linux-omap&m=126826639903105&w=2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
