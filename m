From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Jun 2013 17:34:30 +0200
Subject: [PATCH] i.MX6 ethernet phy fixup
Message-ID: <1371742473-28026-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All i.MX6 boards with gigabit phy I'm aware of have the same fixup
in U-Boot for adjusting the rx/tx delay lines. In the kernel we
only have a fixup for the sabrelite board. Instead of adding individual
board hooks for each new boards I think we should just do register
the fixups unconditionally on i.MX for each known phy type.

This makes ethernet work on the different boards even when the bootloader
misses to do it (or Linux resets the phy during startup of the ethernet
interface).

I suspect this series is only the tip of the iceberg as I also see other
boards having to adjust the rx/tx delay lines. The proper fix would probably
be some phy level callbacks to adjust these values.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      ARM: i.MX6: call ksz9021 phy fixup for all i.MX6 boards
      ARM: i.MX6: add ethernet phy fixup for AR8031
      ARM: i.MX6: add ethernet phy fixup for KSZ9031

 arch/arm/mach-imx/mach-imx6q.c | 60 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)
