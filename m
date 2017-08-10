From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 12:06:40 -0500
Subject: [PATCH v3 4/5] dt-bindings: phy-rockchip-inno-usb2: add otg-mux
 interrupt
In-Reply-To: <1501747753-6983-5-git-send-email-frank.wang@rock-chips.com>
References: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
 <1501747753-6983-5-git-send-email-frank.wang@rock-chips.com>
Message-ID: <20170810170640.xdntfubu3lzoqsad@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 04:09:12PM +0800, Frank Wang wrote:
> Add otg-mux property to support multiplexed interrupt in otg-port
> on some Rockchip SoC (e.g RV1108).
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index ddf868a..ed6aee4 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -32,10 +32,14 @@ Required nodes : a sub-node is required for each port the phy provides.
>  Required properties (port (child) node):
>   - #phy-cells : must be 0. See ./phy-bindings.txt for details.
>   - interrupts : specify an interrupt for each entry in interrupt-names.
> - - interrupt-names : a list which shall be the following entries:
> + - interrupt-names : a list which should be one of the following cases:
> +	Regular case:
>  	* "otg-id" : for the otg id interrupt.
>  	* "otg-bvalid" : for the otg vbus interrupt.
>  	* "linestate" : for the host/otg linestate interrupt.
> +	Some SoCs use one interrupt with the obove muxed together, so for these

s/obove/above/

With that,

Acked-by: Rob Herring <robh@kernel.org>
