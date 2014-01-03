From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  3 Jan 2014 10:59:43 +0100
Subject: [PATCH v2 0/2] Fix i2c bus hang on A0 version of the Armada XP SoCs
Message-ID: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This the 2nd version of the series fixing the i2c bus hang on A0
version of the Armada XP SoCs. It occurred on the early release of the
OpenBlocks AX3-4 boards. Indeed the first variants of Armada XP SoCs
(A0 stepping) have issues related to the i2c controller which prevent
to use the offload mechanism and lead to a kernel hang during boot.

The first patch add a mean to detect the SoCs version at run-time and
the second one use this feature in the driver.

These 2 patches should be applied on 3.13-rc and on stable kernel 3.12
as it fixes a regression introduce by the commit 930ab3d403ae "i2c:
mv64xxx: Add I2C Transaction Generator support".

The first patch could be latter be extend to also be used with dove,
kirkwood, orion5x and mv78x00 when there will be merged in mvebu.

Thanks,

Gregory

Changelog:

v1 -> v2:

- Changed the way to test the return of the function mvebu_get_soc_id
  in order to make it clearer.

- Removed the superfluous parentheses

- Added Wolfram's acked-by on the 2nd patch

Gregory CLEMENT (2):
  ARM: mvebu: Add support to get the ID and the revision of a SoC
  i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs

 arch/arm/mach-mvebu/Makefile       |   2 +-
 arch/arm/mach-mvebu/mvebu-soc-id.c | 111 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mv64xxx.c   |  11 +++-
 include/linux/mvebu-soc-id.h       |  32 +++++++++++
 4 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/mvebu-soc-id.c
 create mode 100644 include/linux/mvebu-soc-id.h

-- 
1.8.1.2
