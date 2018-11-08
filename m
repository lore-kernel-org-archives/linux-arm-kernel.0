From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Nov 2018 00:42:00 +0000
Subject: [PATCH 2/5] phy: core: add PHY_MODE_ETHERNET
In-Reply-To: <20181108003617.10334-3-grygorii.strashko@ti.com>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
 <20181108003617.10334-3-grygorii.strashko@ti.com>
Message-ID: <20181108004200.GW30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 06:36:14PM -0600, Grygorii Strashko wrote:
> Add new PHY's mode to be used by Ethernet PHY interface drivers or
> multipurpose PHYs like serdes. It will be reused in further changes.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index b17e770..02c9ef0 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -42,6 +42,7 @@ enum phy_mode {
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,
>  	PHY_MODE_PCIE,
> +	PHY_MODE_ETHERNET,

Are you sure about this - we already have a bunch of "ethernet" modes
that are more specific, like PHY_MODE_SGMII, PHY_MODE_2500SGMII and
PHY_MODE_10GKR which require PHYs to be configured differently.  Having
a very generic "ethernet" mode brings up questions about when it should
be used vs the more specific modes.

(I've already mentioned that the SGMII modes are mis-named, since
they also apply to 1000base-X and 2500base-X - the only difference
is how one 16-bit word in the data stream is used which has no effect
on the PHY.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
