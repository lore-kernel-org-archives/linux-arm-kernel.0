From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Aug 2014 20:58:10 +0200
Subject: [PATCH v4 2/2] mtd: nand: add sunxi NFC dt bindings doc
In-Reply-To: <1408382788-32153-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1408382788-32153-1-git-send-email-boris.brezillon@free-electrons.com>
 <1408382788-32153-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140818185810.GG15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Mon, Aug 18, 2014 at 07:26:28PM +0200, Boris BREZILLON wrote:
> Add the sunxi NAND Flash Controller dt bindings documentation.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/sunxi-nand.txt         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/sunxi-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
> new file mode 100644
> index 0000000..798c691
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
> @@ -0,0 +1,45 @@
> +Allwinner NAND Flash Controller (NFC)
> +
> +Required properties:
> +- compatible : "allwinner,sun4i-nand".

The pattern we usually have for the sunxi SoCs is
allwinner,family-soc-*, which would be allwinner,sun4i-a10-nand in
this case.

> +- reg : shall contain registers location and length for data and reg.
> +- interrupts : shall define the nand controller interrupt.
> +- #address-cells: shall be set to 1. Encode the nand CS.
> +- #size-cells : shall be set to 0.
> +- clocks : shall reference nand controller clocks.
> +- clock-names : nand controller internal clock names. Shall contain :
> +    * "ahb_clk" : AHB gating clock
> +    * "sclk" : nand controller clock

And we're usually using "ahb" and "mod" in such a case.

It looks fine otherwise.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/8f7c5ae4/attachment.sig>
