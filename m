From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 30 Mar 2017 11:02:41 +0530
Subject: [PATCH] phy: rockchip-inno-usb2: fix spelling mistake:
 "connecetd" -> "connected"
In-Reply-To: <20170222233052.8016-1-colin.king@canonical.com>
References: <20170222233052.8016-1-colin.king@canonical.com>
Message-ID: <07c054ae-69bf-6348-b7a6-afa367358ba4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 23 February 2017 05:00 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in dev_dbg message, also rejoin
> lines to clean up checkpatch warning
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

merged, thanks.

-Kishon
> ---
>  drivers/phy/phy-rockchip-inno-usb2.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
> index 4ea95c2..761a921 100644
> --- a/drivers/phy/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/phy-rockchip-inno-usb2.c
> @@ -554,8 +554,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
>  			case USB_CHG_STATE_DETECTED:
>  				switch (rphy->chg_type) {
>  				case POWER_SUPPLY_TYPE_USB:
> -					dev_dbg(&rport->phy->dev,
> -						"sdp cable is connecetd\n");
> +					dev_dbg(&rport->phy->dev, "sdp cable is connected\n");
>  					rockchip_usb2phy_power_on(rport->phy);
>  					rport->state = OTG_STATE_B_PERIPHERAL;
>  					notify_charger = true;
> @@ -563,16 +562,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
>  					cable = EXTCON_CHG_USB_SDP;
>  					break;
>  				case POWER_SUPPLY_TYPE_USB_DCP:
> -					dev_dbg(&rport->phy->dev,
> -						"dcp cable is connecetd\n");
> +					dev_dbg(&rport->phy->dev, "dcp cable is connected\n");
>  					rockchip_usb2phy_power_off(rport->phy);
>  					notify_charger = true;
>  					sch_work = true;
>  					cable = EXTCON_CHG_USB_DCP;
>  					break;
>  				case POWER_SUPPLY_TYPE_USB_CDP:
> -					dev_dbg(&rport->phy->dev,
> -						"cdp cable is connecetd\n");
> +					dev_dbg(&rport->phy->dev, "cdp cable is connected\n");
>  					rockchip_usb2phy_power_on(rport->phy);
>  					rport->state = OTG_STATE_B_PERIPHERAL;
>  					notify_charger = true;
> 
