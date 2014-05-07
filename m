From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 7 May 2014 19:05:30 +0530
Subject: [PATCH 3/7] phy: usb: sunxi: Introduce Allwinner A31 USB PHY
 support
In-Reply-To: <1399434623-20383-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399434623-20383-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <536A36A2.5030109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 07 May 2014 09:20 AM, Maxime Ripard wrote:
> The USB phy controller in the A31 differs mostly from the older controllers
> because it has a clock dedicated for each phy, while the older ones were having
> a single clock for all the phys.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/phy/phy-sun4i-usb.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index e6e6c4ba7145..1d83abe07a29 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -61,16 +61,17 @@
>  #define MAX_PHYS			3
>  
>  struct sun4i_usb_phy_data {
> -	struct clk *clk;
>  	void __iomem *base;
>  	struct mutex mutex;
>  	int num_phys;
>  	u32 disc_thresh;
> +	bool dedicated_clocks;

Don't think we need this structure member as it's been used only in probe.

Thanks
Kishon
