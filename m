From: nm@ti.com (Nishanth Menon)
Date: Wed, 11 Dec 2013 04:21:43 -0600
Subject: [PATCH 0/2] net: smc91x: add DT flags for legacy platforms
Message-ID: <1386757305-12545-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

SMC91x driver has been converted to device tree, however users of
older lan91c94 based platform need description provided previously by
platform_data. Without this, ethernet fails to function on these platforms.

For example, on SDP2430:
Before: http://pastebin.mozilla.org/3753793
After: http://pastebin.mozilla.org/3753792

Nishanth Menon (2):
  net: smc91x: Read hardware behavior flags from device tree
  ARM: dts: omap2430-sdp: add flags for ethernet functionality

 Documentation/devicetree/bindings/net/smsc91x.txt |   45 +++++++++
 arch/arm/boot/dts/omap2430-sdp.dts                |    5 +
 drivers/net/ethernet/smsc/smc91x.c                |  106 ++++++++++++++++++++-
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/smsc91x.txt

Regards,
Nishanth Menon
-- 
1.7.9.5
