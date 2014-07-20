From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 20 Jul 2014 10:57:33 +0800
Subject: FEC driver hangs hardware on i.MX6SX
Message-ID: <20140720025732.GF8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fugang,

Your commit e8fcfcd5684a (net: fec: optimize the clock management to
save power) landed on mainline with v3.16-rc1.  It causes a hardware
hang on i.MX6SX, if the rootfs is not on NFS but something else like
MMC.

I think the cause is that PTP is still accessing registers after FEC
driver calls fec_enet_clk_enable(ndev, false) to disable FEC clocks.
Can you please try to provide a fix for this regression soon?

Shawn
