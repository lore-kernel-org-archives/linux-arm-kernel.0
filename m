From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jul 2018 17:41:37 +0100
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
Message-ID: <20180730164137.GD17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a re-posting of the series I responded to Peter Rosin's May
posting, with a few bugs fixed, and the bridge registered outside of
the component helper.  This should allow Peter to use the driver
while maintaining armada drm and tilcdc support.

No comments (other than 0-day test results) were received on the
previous posting.

This is independent of the component helper vs bridge safety issues.

 drivers/gpu/drm/i2c/tda998x_drv.c | 288 ++++++++++++++++++++------------------
 1 file changed, 151 insertions(+), 137 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
