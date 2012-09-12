From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Sep 2012 09:59:01 +0200
Subject: [PATCH v11 0/4] AT91: replace old i2c-at91.c TWI driver
In-Reply-To: <cover.1346225321.git.n.voss@weinmann.de>
References: <cover.1346225321.git.n.voss@weinmann.de>
Message-ID: <505040C5.4090703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2012 09:28 AM, Nikolaus Voss :
> The old driver has two main deficencies:
> i)  No repeated start (Sr) condiction is possible, this makes it unusable
>     e.g. for most SMBus transfers.
> ii) I/O was done with polling/busy waiting what caused over-/underruns
>     even at light system loads and clock speeds.
> 
> The new driver overcomes these deficencies and in addition allows for
> more than one TWI interface.
> 
> A remaining limitation is the fact, that only one repeated start is
> possible (two concatenated messages). This limitation is imposed by
> the hardware. However, this should not be a problem as all common
> i2c-client communication does not rely on more than one repeated start.
> 
> Changes since v11:
> - corrected wrong id_entry on sam9261 twi gpio pdev

Hi Wolfram,

Despite the patch revision written in the subject, it is actually the
real v12 patch series from Nikolaus.
BTW, I suspect that you were not in copy...

In addition to the "Tested-By" tag by Ludovic, you can add my:

Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> Nikolaus Voss (4):
>   drivers/i2c/busses/i2c-at91.c: remove old polling driver
>   Replace clk_lookup.con_id with clk_lookup.dev_id entries for twi clk
>   drivers/i2c/busses/i2c-at91.c: add new driver
>   G45 TWI: remove open drain setting for twi function gpios
> 
>  arch/arm/mach-at91/at91rm9200.c            |    1 +
>  arch/arm/mach-at91/at91rm9200_devices.c    |    9 +
>  arch/arm/mach-at91/at91sam9260.c           |    1 +
>  arch/arm/mach-at91/at91sam9261.c           |    1 +
>  arch/arm/mach-at91/at91sam9261_devices.c   |    9 +
>  arch/arm/mach-at91/at91sam9263.c           |    1 +
>  arch/arm/mach-at91/at91sam9g45.c           |    2 +
>  arch/arm/mach-at91/at91sam9g45_devices.c   |    6 -
>  arch/arm/mach-at91/at91sam9rl.c            |    2 +
>  arch/arm/mach-at91/at91sam9x5.c            |    3 +
>  arch/arm/mach-at91/include/mach/at91_twi.h |   68 ----
>  drivers/i2c/busses/Kconfig                 |   11 +-
>  drivers/i2c/busses/i2c-at91.c              |  591 ++++++++++++++++++----------
>  13 files changed, 418 insertions(+), 287 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_twi.h
> 


-- 
Nicolas Ferre
