From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 13 May 2017 12:53:10 -0700
Subject: [PATCH 0/4] ARM: ep93xx: various updates
In-Reply-To: <20170221181529.6780-1-hsweeten@visionengravers.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
Message-ID: <523dbf2f-caf1-dc33-fb9a-a243e2d22657@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

Le 02/21/17 ? 10:15, H Hartley Sweeten a ?crit :
> Here are a couple mach-ep93xx patches that I have been holding on to.
> Some of these have been previously posted.
> 
> The first patch is needed for 128 MiB version of the TS-7300 board.
> That board uses multiple chip selects for the SDRAM and does not boot
> with the previous flatmem setup. With the switch, all the other ep93xx
> boards I have still work properly.
> 
> The second patch has been rebased due to the chip select change in
> the spi-ep93xx driver which has been merged.
> 
> Patch 3 is just a cosmetic change.
> 
> Patch 4 was originally from Florian Fainelli's github ts72xx branch.
> It has been updated to the new spi-ep93xx chip select method.

Patch 4 does no longer apply cleanly because of this commit:

264a4e1c6241fddc5980b3429e133621b3fe01fe ("ARM: EP93xx: Register ethoc
on TS-7300 boards"), do you mind resubmitting so this can be included?

Thanks!

> 
> H Hartley Sweeten (4):
>   ARM: ep93xx: switch to SPARSEMEM
>   ARM: ep93xx: simone: let the mmc_spi driver handle the card detect
>   ARM: ep93xx: tidy up TS-72xx Watchdog resources
>   ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards
> 
>  arch/arm/Kconfig              |  2 +-
>  arch/arm/mach-ep93xx/simone.c | 54 +++----------------------------------------
>  arch/arm/mach-ep93xx/ts72xx.c | 47 +++++++++++++++++++++++++++----------
>  arch/arm/mach-ep93xx/ts72xx.h |  3 ---
>  4 files changed, 39 insertions(+), 67 deletions(-)
> 


-- 
Florian
