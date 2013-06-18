From: s-anna@ti.com (Suman Anna)
Date: Tue, 18 Jun 2013 17:34:42 -0500
Subject: [PATCH 0/3] omap mailbox dt support
Message-ID: <1371594882-37530-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the device tree support to the OMAP mailbox
driver. The first patch in the series is a multi-purpose 
preparatory patch, useful for adapting to the upcoming mailbox
framework, and storing certain DT entries that are per mailbox
IP block instance. The second patch adds the dt parsing support
to the OMAP2+ mailbox driver, while the last patch adds the DT
nodes for OMAP2, OMAP3 and OMAP4 SoCs. The DT nodes for OMAP5,
AM335, AM437 will be added separately.

This series is dependent on the recent OMAP mailbox driver move
to drivers/mailbox [1] and Benoit's DT branch for 3.11 [2]. After
this series, the hwmod attr data for mailboxes can be dropped
once the corresponding SoC is switched to a DT-boot only.

I have tested this series on Panda 4 and Beagle-XM.

[1] http://marc.info/?l=linux-omap&m=137146636924592&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.11/dts

Suman Anna (3):
  mailbox/omap: add a parent structure common to all mboxes
  mailbox/omap: add support for parsing dt devices
  ARM: dts: OMAP2+: Add mailbox nodes

 .../devicetree/bindings/mailbox/omap-mailbox.txt   |  46 +++++
 arch/arm/boot/dts/omap2420.dtsi                    |  13 ++
 arch/arm/boot/dts/omap2430.dtsi                    |  12 ++
 arch/arm/boot/dts/omap3.dtsi                       |  12 ++
 arch/arm/boot/dts/omap4.dtsi                       |  12 ++
 arch/arm/mach-omap2/devices.c                      |   2 +-
 drivers/mailbox/mailbox-omap1.c                    |  27 ++-
 drivers/mailbox/mailbox-omap2.c                    | 228 ++++++++++++++++-----
 drivers/mailbox/omap-mailbox.c                     |  32 ++-
 drivers/mailbox/omap-mbox.h                        |  10 +
 10 files changed, 320 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

-- 
1.8.3.1
