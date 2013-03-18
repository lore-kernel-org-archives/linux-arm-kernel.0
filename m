From: sourav.poddar@ti.com (Sourav Poddar)
Date: Mon, 18 Mar 2013 16:24:41 +0530
Subject: [PATCH 0/2] omap serial fix.
Message-ID: <1363604081-11169-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch is a rearrangement of a macro "OMAP_MAX_HSUART_PORTS"
to a header file so that it can be used in other file. 
The second patch fixes the wakeup from uart issue while using "no_console_suspend" in the
bootargs.

These patches are developed on 3.8 custom kernel containing omap5 supend/resume support.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Rajendra nayak <rnayak@ti.com>

Sourav Poddar (2):
  driver: serial-omap: move max uart count into generic header file.
  arm: mach-omap2: prevent UART console idle on suspend while using
    "no_console_suspend"

 arch/arm/mach-omap2/omap_device.c         |   36 ++++++++++++++++++++++++++++-
 drivers/tty/serial/omap-serial.c          |    2 -
 include/linux/platform_data/serial-omap.h |    1 +
 3 files changed, 36 insertions(+), 3 deletions(-)
