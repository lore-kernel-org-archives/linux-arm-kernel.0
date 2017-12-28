From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 28 Dec 2017 08:20:53 +0100
Subject: [PATCH net-next 1/6] phy: add 2.5G SGMII mode to the phy_mode enum
In-Reply-To: <20171227221446.18459-2-antoine.tenart@free-electrons.com>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-2-antoine.tenart@free-electrons.com>
Message-ID: <20171228072053.GA27336@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 11:14:41PM +0100, Antoine Tenart wrote:
> This patch adds one more generic PHY mode to the phy_mode enum, to allow
> configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
> callback.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 4f8423a948d5..70459a28f3a1 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -28,6 +28,7 @@ enum phy_mode {
>  	PHY_MODE_USB_DEVICE,
>  	PHY_MODE_USB_OTG,
>  	PHY_MODE_SGMII,
> +	PHY_MODE_SGMII_2_5G,
>  	PHY_MODE_10GKR,
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,

Hi Antoine

There was a discussion maybe last month about adding 2.5G SGMII. I
would prefer 2500SGMII. Putting the number first makes it uniform with
the other defines, 1000BASEX, 25000BASEX, 10GKR.

    Andrew
