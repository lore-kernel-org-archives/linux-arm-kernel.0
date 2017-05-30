From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 May 2017 15:22:18 +0100
Subject: [PATCH 0/4] dw-hdmi CEC support
Message-ID: <20170530142218.GS22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds dw-hdmi CEC support.  This is done in four stages:

1. Remove definitions that are not required from dw-hdmi.h
2. Add cec-notifier support
3. Fix up the clkdis register support, as this register contains a
   clock disable bit for the CEC module.
4. Add the driver.

The CEC driver has been updated to use the register accessors in the
main driver - it would be nice if it was possible to use the regmap
support directly, but there's some knowledge private to the main
driver that's required to correctly access the registers.  (I don't
understand why the register stride isn't part of regmap.)

 drivers/gpu/drm/bridge/synopsys/Kconfig       |   8 +
 drivers/gpu/drm/bridge/synopsys/Makefile      |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 320 ++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h |  19 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  87 ++++++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  45 ----
 6 files changed, 423 insertions(+), 57 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
