From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 13:19:15 +0200
Subject: [PATCH v3 03/20] dt-bindings: net: Add DT bindings documentation
 for Allwinner dwmac-sun8i
In-Reply-To: <20170403091444.29876-4-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
 <20170403091444.29876-4-clabbe.montjoie@gmail.com>
Message-ID: <20170403111915.4har25efln4c3qko@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:14:27AM +0200, Corentin Labbe wrote:
> This patch adds documentation for Device-Tree bindings for the
> Allwinner dwmac-sun8i driver.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/net/dwmac-sun8i.txt        | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> new file mode 100644
> index 0000000..f01ef17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> @@ -0,0 +1,77 @@
> +* Allwinner sun8i GMAC ethernet controller
> +
> +This device is a platform glue layer for stmmac.
> +Please see stmmac.txt for the other unchanged properties.
> +
> +Required properties:
> +- compatible: should be one of the following string:
> +		"allwinner,sun8i-a83t-emac"
> +		"allwinner,sun8i-h3-emac"
> +		"allwinner,sun50i-a64-emac"
> +- reg: address and length of the register for the device.
> +- interrupts: interrupt for the device
> +- interrupt-names: should be "macirq"
> +- clocks: A phandle to the reference clock for this device
> +- clock-names: should be "stmmaceth"
> +- resets: A phandle to the reset control for this device
> +- reset-names: should be "stmmaceth"
> +- phy-mode: See ethernet.txt
> +- phy-handle: See ethernet.txt
> +- #address-cells: shall be 1
> +- #size-cells: shall be 0
> +- syscon: A phandle to the syscon of the SoC with one of the following
> + compatible string:
> +  - allwinner,sun8i-h3-system-controller
> +  - allwinner,sun8i-a64-system-controller
> +  - allwinner,sun8i-a83t-system-controller

I'm not sure you need to document those compatibles here.

> +Optional properties:
> +- allwinner,tx-delay: TX clock delay chain value. Range value is 0-0x07. Default is 0)
> +- allwinner,rx-delay: RX clock delay chain value. Range value is 0-0x1F. Default is 0)
> +Both delay properties are in 0.1ns step.

allwinner,tx-delay-ps and allwinner,rx-delay-ps, with the value in
picoseconds?

Looks good otherwise, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/7856f283/attachment.sig>
