From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2017 11:26:56 +0000
Subject: [PATCH RFC 0/4] Fix orion-mdio resource/interrupt issues indentified
 while reviewing mvpp2
Message-ID: <20170107112656.GL14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes some issues identified while reviewing the
mvpp2 driver changes recently posted by Thomas.  I've left the clock
issue, and the question over whether this should be separate out of
this series, concentrating on the resource size / interrupt issue.

This series updates the binding to reflect reality, and ensures that
the driver will not try to access registers outside its binding.  It
also ensures that it doesn't leave the interrupt enabled in hardware
on probe failure.

 .../devicetree/bindings/net/marvell-orion-mdio.txt      | 17 +++++++++++++++--
 drivers/net/ethernet/marvell/mvmdio.c                   | 11 ++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
