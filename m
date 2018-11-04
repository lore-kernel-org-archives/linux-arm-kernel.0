From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:00:42 +0100
Subject: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
In-Reply-To: <20181010170936.316862-2-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
Message-ID: <20181104120042.GM23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:09:26, Lubomir Rintel wrote:
> This is the SPI controller found on Marvel MMP2 and perhaps more
> platforms.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rob, do you want to apply this?

								Pavel

> @@ -0,0 +1,24 @@
> +PXA2xx SSP SPI Controller
> +
> +Required properties:
> +- compatible: Must be "marvell,mmp2-ssp".
> +- reg: Offset and length of the device's register set.
> +- interrupts: Should be the interrupt number.
> +- clocks: Should contain a single entry describing the clock input.
> +- #address-cells:  Number of cells required to define a chip select address.
> +- #size-cells: Should be zero.
> +
> +Optional properties:
> +- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
> +  Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Child nodes represent devices on the SPI bus
> +  See ../spi/spi-bus.txt
> +
> +Example:
> +	ssp1: spi at d4035000 {
> +		compatible = "marvell,mmp2-ssp";
> +		reg = <0xd4035000 0x1000>;
> +		clocks = <&soc_clocks MMP2_CLK_SSP0>;
> +		interrupts = <0>;
> +	};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/a0450a30/attachment.sig>
