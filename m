From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 15:36:06 +0200
Subject: [PATCH v2 1/3] ARM: zynq: Move common.h to generic location
In-Reply-To: <742a19eb987f3f99b42ba4b7e7ebc27bf19d7d72.1413811526.git.michal.simek@xilinx.com>
References: <742a19eb987f3f99b42ba4b7e7ebc27bf19d7d72.1413811526.git.michal.simek@xilinx.com>
Message-ID: <3225036.9QQDRKvzZS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 October 2014 15:25:31 Michal Simek wrote:
> include/soc/zynq/ is the right location for this header
> to be able to share information from this header with other
> drivers which require it.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Update pm.c added in 3.17 too - Soren pointed on it
> 
>  arch/arm/mach-zynq/common.c                       |  2 +-
>  arch/arm/mach-zynq/hotplug.c                      | 14 --------------
>  arch/arm/mach-zynq/platsmp.c                      |  2 +-
>  arch/arm/mach-zynq/pm.c                           |  2 +-
>  arch/arm/mach-zynq/slcr.c                         |  2 +-
>  {arch/arm/mach-zynq => include/soc/zynq}/common.h |  0
>  6 files changed, 4 insertions(+), 18 deletions(-)
>  delete mode 100644 arch/arm/mach-zynq/hotplug.c
>  rename {arch/arm/mach-zynq => include/soc/zynq}/common.h (100%)
> 

NAK

Most (if not all) of that header should not be visible to drivers.
If you need to share some symbols, make a proper header file for those,
not one called 'common.h'.

	Arnd
