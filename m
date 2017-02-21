From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Tue, 21 Feb 2017 11:15:25 -0700
Subject: [PATCH 0/4] ARM: ep93xx: various updates
Message-ID: <20170221181529.6780-1-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are a couple mach-ep93xx patches that I have been holding on to.
Some of these have been previously posted.

The first patch is needed for 128 MiB version of the TS-7300 board.
That board uses multiple chip selects for the SDRAM and does not boot
with the previous flatmem setup. With the switch, all the other ep93xx
boards I have still work properly.

The second patch has been rebased due to the chip select change in
the spi-ep93xx driver which has been merged.

Patch 3 is just a cosmetic change.

Patch 4 was originally from Florian Fainelli's github ts72xx branch.
It has been updated to the new spi-ep93xx chip select method.

H Hartley Sweeten (4):
  ARM: ep93xx: switch to SPARSEMEM
  ARM: ep93xx: simone: let the mmc_spi driver handle the card detect
  ARM: ep93xx: tidy up TS-72xx Watchdog resources
  ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards

 arch/arm/Kconfig              |  2 +-
 arch/arm/mach-ep93xx/simone.c | 54 +++----------------------------------------
 arch/arm/mach-ep93xx/ts72xx.c | 47 +++++++++++++++++++++++++++----------
 arch/arm/mach-ep93xx/ts72xx.h |  3 ---
 4 files changed, 39 insertions(+), 67 deletions(-)

-- 
2.10.0
