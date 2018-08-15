From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Aug 2018 16:21:57 -0600
Subject: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add
 documentation for extcon and utmi-avalid properties.
In-Reply-To: <20180815095934.11205-3-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-3-enric.balletbo@collabora.com>
Message-ID: <20180815222157.GA8193@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2018 at 11:59:32AM +0200, Enric Balletbo i Serra wrote:
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

extcon is not a good binding. The usb connector binding should be used 
instead for new users.

Rob
