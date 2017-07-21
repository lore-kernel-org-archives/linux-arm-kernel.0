From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 21 Jul 2017 14:00:57 +0100
Subject: [PATCH v2 2/4] net: ethernet: nb8800: Set RGMII_MODE for all
 RGMII modes
In-Reply-To: <237905ff-385e-fa2f-bbbf-6c550a48e15c@sigmadesigns.com> (Marc
 Gonzalez's message of "Fri, 21 Jul 2017 13:25:52 +0200")
References: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
 <237905ff-385e-fa2f-bbbf-6c550a48e15c@sigmadesigns.com>
Message-ID: <yw1x379qq706.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> There are 4 RGMII phy-modes to handle.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Acked-by: Mans Rullgard <mans@mansr.com>

> ---
>  drivers/net/ethernet/aurora/nb8800.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
> index 041cfb7952f8..ded041dbafe7 100644
> --- a/drivers/net/ethernet/aurora/nb8800.c
> +++ b/drivers/net/ethernet/aurora/nb8800.c
> @@ -609,7 +609,7 @@ static void nb8800_mac_config(struct net_device *dev)
>  		mac_mode |= HALF_DUPLEX;
>
>  	if (gigabit) {
> -		if (priv->phy_mode == PHY_INTERFACE_MODE_RGMII)
> +		if (phy_interface_is_rgmii(dev->phydev))
>  			mac_mode |= RGMII_MODE;
>
>  		mac_mode |= GMAC_MODE;
> -- 
> 2.11.0
>

-- 
M?ns Rullg?rd
