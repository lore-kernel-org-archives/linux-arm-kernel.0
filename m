From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 31 Jul 2015 16:17:13 -0700
Subject: [PATCH v9 3/5] mtd: nand: vf610_nfc: add device tree bindings
In-Reply-To: <1438361581-2702-4-git-send-email-stefan@agner.ch>
References: <1438361581-2702-1-git-send-email-stefan@agner.ch>
 <1438361581-2702-4-git-send-email-stefan@agner.ch>
Message-ID: <20150731231713.GM10676@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:52:59PM +0200, Stefan Agner wrote:
> Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

The rest looks good to me. Thanks!

Reviewed-by: Brian Norris <computersforpeace@gmail.com>

> ---
>  .../devicetree/bindings/mtd/vf610-nfc.txt          | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/vf610-nfc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/vf610-nfc.txt b/Documentation/devicetree/bindings/mtd/vf610-nfc.txt
> new file mode 100644
> index 0000000..cae5f25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/vf610-nfc.txt
> @@ -0,0 +1,45 @@
> +Freescale's NAND flash controller (NFC)
> +
> +This variant of the Freescale NAND flash controller (NFC) can be found on
> +Vybrid (vf610), MPC5125, MCF54418 and Kinetis K70.
> +
> +Required properties:
> +- compatible: Should be set to "fsl,vf610-nfc"
> +- reg: address range of the NFC
> +- interrupts: interrupt of the NFC
> +- nand-bus-width: see nand.txt
> +- nand-ecc-mode: see nand.txt
> +- nand-on-flash-bbt: see nand.txt
> +- assigned-clocks: main clock from the SoC, for Vybrid <&clks VF610_CLK_NFC>;
> +- assigned-clock-rates: The NAND bus timing is derived from this clock
> +    rate and should not exceed maximum timing for any NAND memory chip
> +    in a board stuffing. Typical NAND memory timings derived from this
> +    clock are found in the SoC hardware reference manual. Furthermore,
> +    there might be restrictions on maximum rates when using hardware ECC.
> +
> +- #address-cells, #size-cells : Must be present if the device has sub-nodes
> +  representing partitions.
> +
> +Required properties for hardware ECC:
> +- nand-ecc-strength: supported strengths are 24 and 32 bit (see nand.txt)
> +- nand-ecc-step-size: step size equals page size, currently only 2k pages are
> +    supported
> +
> +Example:
> +
> +	nfc: nand at 400e0000 {
> +		compatible = "fsl,vf610-nfc";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x400e0000 0x4000>;
> +		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks VF610_CLK_NFC>;
> +		clock-names = "nfc";
> +		assigned-clocks = <&clks VF610_CLK_NFC>;
> +		assigned-clock-rates = <33000000>;
> +		nand-bus-width = <8>;
> +		nand-ecc-mode = "hw";
> +		nand-ecc-strength = <32>;
> +		nand-ecc-step-size = <2048>;
> +		nand-on-flash-bbt;
> +	};
> -- 
> 2.4.5
> 
