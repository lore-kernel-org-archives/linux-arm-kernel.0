From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Aug 2012 13:27:08 -0700
Subject: [PATCH 0/5] hwrng/ARM: OMAP: convert to use runtime PM
In-Reply-To: <20120827232922.15045.56522.stgit@dusk.lan>
References: <20120827232922.15045.56522.stgit@dusk.lan>
Message-ID: <20120830202708.GZ1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120827 16:39]:
> This series converts the OMAP hardware random number generator driver
> to use runtime PM.  Hardware integration data is added for OMAP2xxx
> systems.  I'm pretty sure this device is available on other OMAP chips
> too, but may require some experimentation with the integration details.

Good to hear. I believe that at some point this got moved to be
only accessible in the secure mode on later omaps?
 
> There are still a few rough edges with this series.  Something is
> still not right with the reset behavior on OMAP2430, at least.  But it
> would be good to get acks from the hwrng folks for the three patches that
> touch files in that directory.  Will continue with the testing process
> here.

Yes Matt & Herbert, care to ack the drivers/char/hw_random related changes?

This series will conflict with the planned ARM common zImage changes
that we have planned so I'd like to merge them via the ARM soc tree.

Regards,

Tony
 
> - Paul
> 
> ---
> 
> Paul Walmsley (5):
>       ARM: OMAP2/3: hwmod: add RNG integration data
>       hwrng: OMAP: store per-device data in per-device variables, not file statics
>       hwrng: OMAP: convert to use runtime PM
>       ARM: OMAP: split OMAP1, OMAP2+ RNG device registration
>       hwrng: OMAP: remove SoC restrictions from driver registration
> 
> 
>  arch/arm/mach-omap1/devices.c                      |   28 +++++
>  arch/arm/mach-omap2/devices.c                      |   18 +++
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 
>  .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 +++
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   37 ++++++
>  arch/arm/mach-omap2/omap_hwmod_common_data.h       |    5 -
>  arch/arm/plat-omap/Makefile                        |    3 
>  arch/arm/plat-omap/devices.c                       |   92 ---------------
>  drivers/char/hw_random/omap-rng.c                  |  121 ++++++++++++--------
>  10 files changed, 176 insertions(+), 147 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/devices.c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
