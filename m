From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Aug 2018 16:26:04 -0600
Subject: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new
 rockchip,force-bvalid property.
In-Reply-To: <20180815095934.11205-5-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-5-enric.balletbo@collabora.com>
Message-ID: <20180815222604.GB8193@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2018 at 11:59:34AM +0200, Enric Balletbo i Serra wrote:
> This property is used when the otg-id pin is not connected. When this
> property is set it forces to set the B-Device Session Valid bit when the
> port works as device and clears that bit when the port works as host.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index 2d4808d3920b..55761f466c41 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -48,6 +48,11 @@ Optional properties:
>  		See ./phy-bindings.txt for details.
>   - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
>  			  Otherwise, use the bvalid register.
> + - rockchip,force-bvalid : boolean, set this to force the B-Device Session
> +			  Valid bit when the usb port is in device mode. This
> +			  is used when the otg-id pin is not connected.
> +			  Only supported in case of compatible being:
> +			  * "rockchip,rk3399-usb2phy"

Shouldn't you describe the property of the h/w that ID pin is not 
connected, rather than what you do with that information.

Is the pin not connected because it's a connector without ID pin? If so, 
that should be a property of the connector (or inferred from the 
connector compatible string).

Rob
