From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 24 Jun 2017 04:19:10 +0200
Subject: [PATCH 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <1498192929-7519-2-git-send-email-david.wu@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
 <1498192929-7519-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170624021910.GB4875@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 12:41:59PM +0800, David Wu wrote:
> Support internal ephy currently.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/net/phy/Kconfig    |  4 ++
>  drivers/net/phy/Makefile   |  1 +
>  drivers/net/phy/rockchip.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 drivers/net/phy/rockchip.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index c360dd6..86010d4 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -350,6 +350,10 @@ config XILINX_GMII2RGMII
>           the Reduced Gigabit Media Independent Interface(RGMII) between
>           Ethernet physical media devices and the Gigabit Ethernet controller.
>  
> +config ROCKCHIP_MAC_PHY

This is a bit of an odd name, having both MAC and PHY in it. Are there
any other RockChip PHYs? Any external PHYS? Are they register
incompatible with the internal PHY?  Is it even RockChip IP? Or has it
been licensed from somebody else?

I would more likely just call it ROCKCHIP_PHY.

  Andrew
