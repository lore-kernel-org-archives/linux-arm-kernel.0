From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2016 15:24:05 +0000
Subject: [PATCHv2 0/2] net: fec: Reset ethernet PHY whenever the enet_out
 clock is being enabled
In-Reply-To: <1452611876-451-1-git-send-email-LW@KARO-electronics.de>
References: <1452611876-451-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160112152405.GZ19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 04:17:54PM +0100, Lothar Wa?mann wrote:
> This patchset fixes a regression introduced by
> commit e8fcfcd5684a ("net: fec: optimize the clock management to save power")
> for ethernet PHYs that are using ENET_OUT as reference clock (on i.MX6 or i.MX28)
> 
> Changes vs. v1:
> - fixed reference to the commit that introduced the regression.
> - dropped patch to use gpiod framework. This should be added later,
>   after the affected DTBs have been updated to specify the correct
>   gpio_flags.
> 
> Patch overview:
> 1. cleanup patch to remove redundant NULL checks
> 2. call fec_reset_phy() after the ENET_OUT clock has been enabled

I definitely want to test these on my SolidRun boards before these get
merged: the AR8035 on there is configured via pin-straps, and then
further tweaked with PHY quirks.  Resetting with the iMX6 in the
wrong state may result in the AR8035 being reconfigured (even jumping
to a different MDIO address) and certainly would need the PHY quirks
re-running.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
