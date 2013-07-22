From: s-anna@ti.com (Suman Anna)
Date: Mon, 22 Jul 2013 16:26:28 -0500
Subject: [PATCHv2 0/5] omap mailbox dt support
Message-ID: <1374528388-59442-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an updated series for adding the device tree support to
the OMAP mailbox driver. The series is based on 3.11-rc2 and I
have tested this on Beagle-XM, Panda4 and OMAP5 uEVM (with
out-of-tree clock patches).

Changes in v2:
- Removed the #ti,mbox-data-cells from DT bindings and node data
- Includes 2 new patches that adds the data for OMAP5.

v1:
http://marc.info/?l=linux-omap&m=137159523405468&w=2

Suman Anna (5):
  mailbox/omap: add a parent structure common to all mboxes
  mailbox/omap: add support for parsing dt devices
  ARM: dts: OMAP2+: Add mailbox nodes
  ARM: OMAP5: hwmod data: Add mailbox data
  ARM: dts: OMAP5: Add mailbox dt node

 .../devicetree/bindings/mailbox/omap-mailbox.txt   |  43 ++++
 arch/arm/boot/dts/omap2420.dtsi                    |  12 ++
 arch/arm/boot/dts/omap2430.dtsi                    |  11 ++
 arch/arm/boot/dts/omap3.dtsi                       |  11 ++
 arch/arm/boot/dts/omap4.dtsi                       |  11 ++
 arch/arm/boot/dts/omap5.dtsi                       |  11 ++
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  42 ++++
 drivers/mailbox/mailbox-omap1.c                    |  27 ++-
 drivers/mailbox/mailbox-omap2.c                    | 217 ++++++++++++++++-----
 drivers/mailbox/omap-mailbox.c                     |  32 ++-
 drivers/mailbox/omap-mbox.h                        |  10 +
 12 files changed, 355 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

-- 
1.8.3.3
