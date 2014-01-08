From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jan 2014 22:28:55 +0100
Subject: [RFC PATCH 6/9] mtd: nand: add sunxi NFC dt bindings doc
In-Reply-To: <1389190924-26226-7-git-send-email-b.brezillon@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389190924-26226-7-git-send-email-b.brezillon@overkiz.com>
Message-ID: <201401082228.55807.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014, Boris BREZILLON wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
> @@ -0,0 +1,71 @@
> +Allwinner NAND Flash Controller (NFC)
> +
> +Required properties:
> +- compatible : "allwinner,sun4i-nfc".
> +- reg : shall contain registers location and length for data and reg.
> +- interrupts : shall define the NFC interrupt.
> +- #address-cells: shall be set to 1. Encode the nand CS.
> +- #size-cells : shall be set to 0.
> +- clocks : shall reference NFC clocks.
> +- clock-names : NFC internal clock names. Shall contain :
> +    * "ahb_clk" : AHB gating clock
> +    * "sclk" : NFC clock
> +

One small request: Can we try to avoid the "NFC" name here? I think it's
too overloaded and people may confuse it with near-field communication,
which I'm sure will be supported in sunxi based devices at some point.

It doesn't hurt to also mention that the function block is called
nfc, but I think references to it are better named "nand", which is
less confusing.

	Arnd
