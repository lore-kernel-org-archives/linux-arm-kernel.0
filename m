From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Aug 2018 12:34:34 +0200
Subject: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new rockchip,
 force-bvalid property.
In-Reply-To: <20180815095934.11205-5-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-5-enric.balletbo@collabora.com>
Message-ID: <6944969.kWmPjI4VuS@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. August 2018, 11:59:34 CEST schrieb Enric Balletbo i Serra:
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

I guess you could drop that rk3399 mention instead make the
driver complain? Trying to keep that list up to date will get hard
and I guess the other socs may very well hide that setting somewhere
in their undocumented phy registers as well.

I guess a bit of alphabetical ordering might also be nice,
rockchip,force-bvalid above rockchip,utmi-avalid
Makes it easier to read ;-)

Heiko
