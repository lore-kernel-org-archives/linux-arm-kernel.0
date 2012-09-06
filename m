From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 6 Sep 2012 20:25:28 +0530
Subject: [PATCH 0/3] omap: musb: Add device tree support
Message-ID: <1346943331-18120-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds device tree support for MUSB.

The glue layer is now made to write to mailbox register (present in
control module) instead of calling phy layer to write to mailbox
register. Writing to mailbox register notifies the core of events like
device connect/disconnect.

Previously these patches were part of
[PATCH v7 0/7] omap: musb: Add device tree support

This patch series was created to contain only the *musb* part and it
also has one hwmod patch.

This patch series was created on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git musb

Kishon Vijay Abraham I (3):
  arm: omap: hwmod: add a new addr space in otg for writing to control
    module
  usb: musb: omap: write directly to mailbox instead of using phy
  usb: musb: omap: Add device tree support for omap musb glue

 Documentation/devicetree/bindings/usb/omap-usb.txt |   33 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    5 +
 drivers/usb/musb/omap2430.c                        |  106 ++++++++++++++++++--
 drivers/usb/musb/omap2430.h                        |    9 ++
 4 files changed, 146 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/omap-usb.txt

-- 
1.7.9.5
