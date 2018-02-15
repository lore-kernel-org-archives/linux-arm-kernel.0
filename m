From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 15 Feb 2018 17:10:28 +0100
Subject: [PATCH v2 2/6] dt-bindings: phy-rockchip-typec: deprecate some
 register properties.
In-Reply-To: <20180214165447.12181-2-enric.balletbo@collabora.com>
References: <20180214165447.12181-1-enric.balletbo@collabora.com>
 <20180214165447.12181-2-enric.balletbo@collabora.com>
Message-ID: <2023405.MLPHBTM0h1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 14. Februar 2018, 17:54:43 CET schrieb Enric Balletbo i Serra:
> As now the following register properties are in the driver, document as
> deprecated these properties and recommend to not use them on new bindings.
> 
> The deprecated properties are:
> 
> - rockchip,typec-conn-dir : the register of type-c connector direction
> - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2
>                            enable control.
> - rockchip,external-psm : the register of type-c phy external psm clock
>                           selection.
> - rockchip,pipe-status : the register of type-c phy pipe status.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v1:
> - This patch is new on these series and is just a documentation update
>   due patch [1/6]
> 
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 33 +++++-----------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> index 6ea867e3176f..bc44d6abe283 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -16,24 +16,6 @@ Required properties:
>  		 "uphy", "uphy-pipe", "uphy-tcphy"
>   - extcon : extcon specifier for the Power Delivery
>  
> -Note, there are 2 type-c phys for RK3399, and they are almost identical, except
> -these registers(description below), every register node contains 3 sections:
> -offset, enable bit, write mask bit.
> - - rockchip,typec-conn-dir : the register of type-c connector direction,
> -   for type-c phy0, it must be <0xe580 0 16>;
> -   for type-c phy1, it must be <0xe58c 0 16>;
> - - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2 enable
> -   control.
> -   for type-c phy0, it must be <0xe580 3 19>;
> -   for type-c phy1, it must be <0xe58c 3 19>;
> - - rockchip,external-psm : the register of type-c phy external psm clock
> -   selection.
> -   for type-c phy0, it must be <0xe588 14 30>;
> -   for type-c phy1, it must be <0xe594 14 30>;
> - - rockchip,pipe-status : the register of type-c phy pipe status.
> -   for type-c phy0, it must be <0xe5c0 0 0>;
> -   for type-c phy1, it must be <0xe5c0 16 16>;
> -
>  Required nodes : a sub-node is required for each port the phy provides.
>  		 The sub-node name is used to identify dp or usb3 port,
>  		 and shall be the following entries:
> @@ -43,6 +25,13 @@ Required nodes : a sub-node is required for each port the phy provides.
>  Required properties (port (child) node):
>  - #phy-cells : must be 0, See ./phy-bindings.txt for details.
>  
> +Deprecated properties, do not use in new device tree sources, these
> +properties are now in the driver:

nit: "[...] these properties are determined by the compatible value" ?

A dt-binding does not care about drivers ;-)


Heiko
