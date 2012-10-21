From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Oct 2012 23:57:00 +0200
Subject: [PATCH v2 0/3] make cadence ethernet drivers build on any architecture
Message-ID: <1350856623-9819-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes the at91_ether and macb driver build-able on any architecture.

Patch 1 removes the HAVE_NET_MACB from the cadence Kconfig and this allow macb to be built on any architecture. The macb driver requires no other modifications.

Patch 3 moves a bootloader quirk for CSB337 from at91_ether into platform data as a flag. This allow us to remove the last mach include and build this driver on any architecture. It also make it easier to share the address setup between at91_ether and macb.


The next series will make the at91_ether driver use address setting and statistics from macb. There is also a clean up of print outs plus some comment/style fixes.

Joachim Eastwood (3):
  net/cadence: get rid of HAVE_NET_MACB
  net/at91_ether: select MACB in Kconfig
  net/at91_ether: add pdata flag for reverse Eth addr

 arch/arm/mach-at91/Kconfig                | 4 ----
 arch/arm/mach-at91/board-csb337.c         | 2 ++
 arch/avr32/Kconfig                        | 1 -
 drivers/net/ethernet/cadence/Kconfig      | 8 +-------
 drivers/net/ethernet/cadence/Makefile     | 2 +-
 drivers/net/ethernet/cadence/at91_ether.c | 5 ++---
 include/linux/platform_data/macb.h        | 1 +
 7 files changed, 7 insertions(+), 16 deletions(-)

-- 
1.7.12.4
