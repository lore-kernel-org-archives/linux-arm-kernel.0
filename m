From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun,  3 Sep 2017 10:43:43 -0700
Subject: [PATCH v2 0/4] ARM: ep93xx: various updates
Message-ID: <20170903174347.6148-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a rebase of Hartley's original submission:

https://www.spinics.net/lists/arm-kernel/msg564135.html

rebased against v4.13-rc1, I have been using these patches on a TS-7300 board
with 32MB of RAM and everything works fine here as well.

Here is what Hartley wrote in v1:

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
 arch/arm/mach-ep93xx/ts72xx.c | 46 +++++++++++++++++++++++++++---------
 arch/arm/mach-ep93xx/ts72xx.h |  3 ---
 4 files changed, 39 insertions(+), 66 deletions(-)

-- 
2.11.0
