From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Tue, 15 Mar 2011 15:41:52 +0100
Subject: [PATCH 0/4] Fix ST-Ericsson Ux500 specific PL022 & PL180 amba devices
Message-ID: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

Add name based matching for ST-Ericsson amba devices with same ID but with
some differences.
This patch set fixes mmci/pl180 U8500v2 variant (datactrl register divergence),
and spi/pl022 U5500 variant (loopback support).

Philippe Langlais (2):
  mmci/pl180: Support for db8500v2.     ST-Ericsson modified ARM
    PrimeCell PL180 block has not got     an updated corresponding
    amba-id, althought the IP block has     changed in db8500v2. The
    change was done to the datactrl register.
  ux500: pass name for db5500-spi & db8500v2-sdi devices

Prajadevi H (1):
  amba-pl022: Add loopback support for the SPI on 5500

Rabin Vincent (1):
  amba: add name based matching

 arch/arm/mach-ux500/devices-common.c        |    8 ++++--
 arch/arm/mach-ux500/devices-common.h        |   31 ++++++++++++++++++--------
 arch/arm/mach-ux500/devices-db8500.h        |    2 +-
 arch/arm/mach-ux500/include/mach/hardware.h |    3 --
 drivers/amba/bus.c                          |    6 +++++
 drivers/mmc/host/mmci.c                     |   24 ++++++++++++++++++++-
 drivers/spi/amba-pl022.c                    |   21 +++++++++++++++++-
 include/linux/amba/bus.h                    |    2 +
 8 files changed, 78 insertions(+), 19 deletions(-)

-- 
1.7.3.1
