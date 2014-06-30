From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 10:52:34 +0100
Subject: [PATCH 3/3] mtd: hisilicon: add device tree binding documentation
In-Reply-To: <1404115409-20200-4-git-send-email-wangzhou.bry@gmail.com>
References: <1404115409-20200-1-git-send-email-wangzhou.bry@gmail.com>
 <1404115409-20200-4-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <20140630095234.GZ7262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 09:03:29AM +0100, Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
> ---
>  .../devicetree/bindings/mtd/hisi-nand.txt          |   38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/hisi-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/hisi-nand.txt b/Documentation/devicetree/bindings/mtd/hisi-nand.txt
> new file mode 100644
> index 0000000..1cc6470
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/hisi-nand.txt
> @@ -0,0 +1,38 @@
> +Hisilicon Hip04 Soc NAND controller DT binding
> +
> +Required properties:
> +- compatible:          Should be "hisilicon,nfc504".
> +- reg:                 Contain registers location and length for reg and data.

I'm not sure I follow. The example below has two reg entries. What does
each entry represent, and what does the presence of multiple entries
mean?

> +- interrupts:          Interrupt number for nfc.

Just the one?

> +- nand-bus-width:      See nand.txt.
> +- nand-ecc-mode:       See nand.txt.
> +- hisi,nand-ecc-bits:  ECC bits type support.
> +		<0>:   none ecc
> +		<1>:   Can correct 1bit per 512byte.
> +		<6>:   Can correct 16bits per 1K byte.

Is this an enumeration, or a number of bits?

> +- #address-cells:      partition address.
> +- #size-cells:         partition size.

Are these only allowed to be 1 cell, or can they be more?

Thanks,
Mark.

> +
> +Flash chip may optionally contain additional sub-nodes describing partitions of
> +the address space. See partition.txt for more detail.
> +
> +Example:
> +
> +	nand: nand at 4020000 {
> +		compatible = "hisilicon,nfc504";
> +		reg = <0x4020000 0x10000>, <0x5000000 0x1000>;
> +		interrupts = <0 379 4>;
> +		nand-bus-width = <8>;
> +		nand-ecc-mode = "hw";
> +		hisi,nand-ecc-bits = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition at 0 {
> +			label = "nand_text";
> +			reg = <0x00000000 0x00400000>;
> +		};
> +
> +		...
> +
> +	};
> -- 
> 1.7.9.5
> 
> 
