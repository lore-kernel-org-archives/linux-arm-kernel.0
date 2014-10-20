From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 20 Oct 2014 14:22:45 +0200
Subject: [PATCHv2 0/3] Remove mach/atmel-mci.h
In-Reply-To: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20141020122245.GA7443@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 10:26:35AM +0200, Alexandre Belloni wrote:
> This patch series removes the uses of mach/atmel-mci.h and the files themselves.
> The final goal is to be able to switch AT91 to multiplatform.
> 
> The first patch introduces a new platform_data file and uses it in the driver.
> The two following patches remove the uses of mach/atmel-mci.h and the header
> itself from avR32 and ARM/at91.
> 
> Changes in v2:
>  - include back linux/atmel-mci.h and really remove mach/atmel-mci.h in at91sam9g45_devices.c

s/move mache header/move mach header. Otherwise, for the whole series:

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> 
> Alexandre Belloni (3):
>   mmc: atmel-mci: move mache header to platform_data
>   ARM: at91: remove mach/atmel-mci.h
>   avr32: remove mach/atmel-mci.h
> 
>  arch/arm/mach-at91/at91sam9g45_devices.c        |  2 +-
>  arch/arm/mach-at91/include/mach/atmel-mci.h     | 17 -----------------
>  arch/avr32/mach-at32ap/at32ap700x.c             |  2 +-
>  arch/avr32/mach-at32ap/include/mach/atmel-mci.h | 17 -----------------
>  drivers/mmc/host/atmel-mci.c                    |  2 +-
>  include/linux/platform_data/mmc-atmel-mci.h     | 22 ++++++++++++++++++++++
>  6 files changed, 25 insertions(+), 37 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/atmel-mci.h
>  delete mode 100644 arch/avr32/mach-at32ap/include/mach/atmel-mci.h
>  create mode 100644 include/linux/platform_data/mmc-atmel-mci.h
> 
> -- 
> 1.9.1
> 
