From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Aug 2018 12:29:55 +0200
Subject: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add
 documentation for extcon and utmi-avalid properties.
In-Reply-To: <20180815095934.11205-3-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-3-enric.balletbo@collabora.com>
Message-ID: <2023816.cqyDmH3see@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

Am Mittwoch, 15. August 2018, 11:59:32 CEST schrieb Enric Balletbo i Serra:
> Commit 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for
> rk3399") introduces two new properties. The extcon property is used to
> detect the cable-state, and the rockchip,utmi-avalid is used to indicate
> which register should be used to detect the vbus state.
> 
> Document these properties in the documentation binding.
> 
> Fixes: 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index 074a7b3b0425..2d4808d3920b 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -23,6 +23,7 @@ Optional properties:
>  		 register files". When set driver will request its
>  		 phandle as one companion-grf for some special SoCs
>  		 (e.g RV1108).
> + - extcon : phandle to the extcon device for the otg phy.

That should probably mention that this is the extcon providing the cable-state?


>  Required nodes : a sub-node is required for each port the phy provides.
>  		 The sub-node name is used to identify host or otg port,
> @@ -45,6 +46,8 @@ Required properties (port (child) node):
>  Optional properties:
>   - phy-supply : phandle to a regulator that provides power to VBUS.
>  		See ./phy-bindings.txt for details.
> + - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
> +			  Otherwise, use the bvalid register.

Not having looked to deeply into the usb2 phy, this might raise questions
on why this is a hardware-description? Is this needed when something is not
connected on the board?


Heiko
