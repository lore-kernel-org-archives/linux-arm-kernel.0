From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 14:34:31 +0100
Subject: [PATCH v3 0/11] Xilinx watchdog changes
Message-ID: <cover.1392212059.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series contains changes for Xilinx watchdog.
The whole code series have been reviewed by Guenter
and device-tree binding was acked by Arnd.

I have also pushed this v3 to git repo
for easier pulling here:
git://git.monstr.eu/linux-2.6-microblaze.git watchdog

Thanks,
Michal

Changes in v3:
- Remove one if checking and use variable directly

Changes in v2:
- Fix enable_once logic
- Change patch subject
- New patch in this series

Michal Simek (11):
  watchdog: xilinx: Convert driver to the watchdog framework
  watchdog: xilinx: Move control_status_reg to functions
  watchdog: xilinx: Simplify probe and remove functions
  watchdog: xilinx: Move no_timeout to probe function
  watchdog: xilinx: Allocate private structure per device
  watchdog: xilinx: Fix all printk messages
  watchdog: xilinx: Use of_property_read_u32
  watchdog: xilinx: Use correct comment indentation
  watchdog: xilinx: Add missing binding
  watchdog: xilinx: Enable this driver for Zynq
  watchdog: xilinx: Remove no_timeout variable

 .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  23 ++
 drivers/watchdog/Kconfig                           |  21 +-
 drivers/watchdog/of_xilinx_wdt.c                   | 389 ++++++---------------
 3 files changed, 148 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/0c4ba478/attachment.sig>
