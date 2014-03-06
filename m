From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Mar 2014 10:00:58 -0600
Subject: [PATCH v2 03/13] phy: omap-control: update dra7 and am437 usb2
 bindings
In-Reply-To: <1394116729-28811-4-git-send-email-rogerq@ti.com>
References: <1394116729-28811-1-git-send-email-rogerq@ti.com>
 <1394116729-28811-4-git-send-email-rogerq@ti.com>
Message-ID: <20140306160058.GF25648@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 04:38:39PM +0200, Roger Quadros wrote:
> The dra7-usb2 and am437-usb2 bindings have not yet been used.
> Change them to be more elegant.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt | 4 ++--
>  drivers/phy/phy-omap-control.c                   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 5c5b1b0..28e674b 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -9,9 +9,9 @@ Required properties:
>                          e.g. USB2_PHY on OMAP5.
>   "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
>                          e.g. USB3 PHY and SATA PHY on OMAP5.
> - "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
> + "ti,control-phy-dra7-usb2" - if it has power down register like USB2 PHY on
>                          DRA7 platform.
> - "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
> + "ti,control-phy-am437-usb2" - if it has power down register like USB2 PHY on
>                          AM437 platform.
>   - reg : Address and length of the register set for the device. It contains
>     the address of "otghs_control" for control-phy-otghs or "power" register

I can take the Documentation part (which I've just done) but...

> diff --git a/drivers/phy/phy-omap-control.c b/drivers/phy/phy-omap-control.c
> index 17fc200..a7e2d7f 100644
> --- a/drivers/phy/phy-omap-control.c
> +++ b/drivers/phy/phy-omap-control.c
> @@ -228,11 +228,11 @@ static const struct of_device_id omap_control_phy_id_table[] = {
>  		.data = &pipe3_data,
>  	},
>  	{
> -		.compatible = "ti,control-phy-dra7usb2",
> +		.compatible = "ti,control-phy-dra7-usb2",
>  		.data = &dra7usb2_data,
>  	},
>  	{
> -		.compatible = "ti,control-phy-am437usb2",
> +		.compatible = "ti,control-phy-am437-usb2",
>  		.data = &am437usb2_data,
>  	},
>  	{},

I don't have this file in my tree ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/f806670d/attachment.sig>
