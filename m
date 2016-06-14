From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 14 Jun 2016 08:36:11 +0800
Subject: [PATCH v2 09/11] phy: rockchip-emmc: Minor code cleanup in
 rockchip_emmc_phy_power_on/off()
In-Reply-To: <1465859076-4868-10-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-10-git-send-email-dianders@chromium.org>
Message-ID: <361ee77c-ae92-a8f5-c716-1867652db653@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/6/14 7:04, Douglas Anderson ??:
> There's no reason to store the return value of rockchip_emmc_phy_power()
> in a variable nor to check it.  Just return it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)

Looks good to me.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>
>  drivers/phy/phy-rockchip-emmc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 2d059c046978..23fe50864526 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -169,20 +169,14 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  static int rockchip_emmc_phy_power_off(struct phy *phy)
>  {
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	int ret = 0;
>
>  	/* Power down emmc phy analog blocks */
> -	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
>  }
>
>  static int rockchip_emmc_phy_power_on(struct phy *phy)
>  {
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	int ret = 0;
>
>  	/* DLL operation: 200 MHz */
>  	regmap_write(rk_phy->reg_base,
> @@ -213,11 +207,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  				   PHYCTRL_OTAPDLYSEL_SHIFT));
>
>  	/* Power up emmc phy analog blocks */
> -	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
>  }
>
>  static const struct phy_ops ops = {
>


-- 
Best Regards
Shawn Lin
