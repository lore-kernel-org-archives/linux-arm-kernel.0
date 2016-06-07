From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 7 Jun 2016 14:29:49 +0530
Subject: [PATCH 6/7] phy: miphy28lp: Inform the reset framework that our
 reset line may be shared
In-Reply-To: <20160606155655.10860-7-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-7-lee.jones@linaro.org>
Message-ID: <57568D05.6020001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 06 June 2016 09:26 PM, Lee Jones wrote:
> On the STiH410 B2120 development board the MiPHY28lp shares its reset
> line with the Synopsys DWC3 SuperSpeed (SS) USB 3.0 Dual-Role-Device
> (DRD).  New functionality in the reset subsystems forces consumers to
> be explicit when requesting shared/exclusive reset lines.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/phy-miphy28lp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
> index 3acd2a1..213e2e1 100644
> --- a/drivers/phy/phy-miphy28lp.c
> +++ b/drivers/phy/phy-miphy28lp.c
> @@ -1143,7 +1143,8 @@ static int miphy28lp_probe_resets(struct device_node *node,
>  	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
>  	int err;
>  
> -	miphy_phy->miphy_rst = of_reset_control_get(node, "miphy-sw-rst");
> +	miphy_phy->miphy_rst =
> +		of_reset_control_get_shared(node, "miphy-sw-rst");
>  
>  	if (IS_ERR(miphy_phy->miphy_rst)) {
>  		dev_err(miphy_dev->dev,
> 
