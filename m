From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 10 Jan 2017 15:24:11 -0800
Subject: [PATCH] net: phy: marvell: fix Marvell 88E1512 used in SGMII mode
In-Reply-To: <E1cR5bt-0000O8-1T@rmk-PC.armlinux.org.uk>
References: <E1cR5bt-0000O8-1T@rmk-PC.armlinux.org.uk>
Message-ID: <61950d83-cbe1-6e1b-4afc-bc471b386ff3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2017 03:13 PM, Russell King wrote:
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

Fixes: 6cfb3bcc0641 ("Marvell phy: check link status in case of fiber
link.")
-- 
Florian
