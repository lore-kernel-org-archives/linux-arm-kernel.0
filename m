From: davem@davemloft.net (David Miller)
Date: Wed, 11 Jan 2017 10:03:07 -0500 (EST)
Subject: [PATCH] net: phy: marvell: fix Marvell 88E1512 used in SGMII mode
In-Reply-To: <E1cR5bt-0000O8-1T@rmk-PC.armlinux.org.uk>
References: <E1cR5bt-0000O8-1T@rmk-PC.armlinux.org.uk>
Message-ID: <20170111.100307.1659171906235723077.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Tue, 10 Jan 2017 23:13:45 +0000

> When an Marvell 88E1512 PHY is connected to a nic in SGMII mode, the
> fiber page is used for the SGMII host-side connection.  The PHY driver
> notices that SUPPORTED_FIBRE is set, so it tries reading the fiber page
> for the link status, and ends up reading the MAC-side status instead of
> the outgoing (copper) link.  This leads to incorrect results reported
> via ethtool.
> 
> If the PHY is connected via SGMII to the host, ignore the fiber page.
> However, continue to allow the existing power management code to
> suspend and resume the fiber page.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied, thanks Russell.
