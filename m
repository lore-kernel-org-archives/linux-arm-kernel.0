From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 13 Jun 2016 16:56:47 +0800
Subject: [PATCH 10/11] phy: rockchip-emmc: Minor code cleanup in
 rockchip_emmc_phy_power_off()
In-Reply-To: <1465339484-969-11-git-send-email-dianders@chromium.org>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-11-git-send-email-dianders@chromium.org>
Message-ID: <f80ba471-95dd-5cda-00a2-9006cfe15167@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/6/8 6:44, Douglas Anderson wrote:
> There's no reason to store the return value of rockchip_emmc_phy_power()
> in a variable nor to check it.  Just return it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 0fce7359d468..188e4c387ba8 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -227,8 +227,6 @@ static int rockchip_emmc_phy_power_off(struct phy *phy)
>  static int rockchip_emmc_phy_power_on(struct phy *phy)
>  {

I saw the cleanup for power_off is done on [patch 9/11]

shouldn't be in this patch? :)

>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	int ret = 0;
> -
>
>  	/* Drive impedance: 50 Ohm */
>  	regmap_write(rk_phy->reg_base,
> @@ -252,11 +250,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  				   PHYCTRL_OTAPDLYSEL_SHIFT));
>
>  	/* Power up emmc phy analog blocks */
> -	ret = rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
>  }
>
>  static const struct phy_ops ops = {
>


-- 
Best Regards
Shawn Lin
