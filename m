From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 21 Jun 2014 11:06:18 +0200
Subject: [PATCHv6 2/3] devicetree: Addition of the Altera SDRAM EDAC
In-Reply-To: <1403306523-4174-3-git-send-email-tthayer@altera.com>
References: <1403306523-4174-2-git-send-email-tthayer@altera.com>
 <1403306523-4174-3-git-send-email-tthayer@altera.com>
Message-ID: <20140621090618.GB8053@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 06:22:02PM -0500, tthayer at altera.com wrote:
> From: Thor Thayer <tthayer@altera.com>
> 
> Addition of the Altera SDRAM EDAC bindings and device tree changes
> 
> v2: Changes to SoC EDAC source code.
> 
> v3: Fix typo in device tree documentation.
> 
> v4,v5: No changes - bump version for consistency.
> 
> v6: Assign ECC registers in SDRAM controller to EDAC
> 
> Signed-off-by: Thor Thayer <tthayer@altera.com>
> ---
>  .../bindings/arm/altera/socfpga-sdram-edac.txt     |   15 +++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |    6 ++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> new file mode 100644
> index 0000000..540c9cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> @@ -0,0 +1,15 @@
> +Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
> +
> +Required properties:
> +- compatible : should contain "altr,sdram-edac";
> +- reg : should contain the ECC register range in sdram
> +        controller (address and length).
> +- interrupts : Should contain the SDRAM ECC IRQ in the
> +	appropriate format for the IRQ controller.
> +
> +Example:
> +	sdramedac at 0 {
> +		compatible = "altr,sdram-edac";
> +		reg = <0xffc2502C 0x28>;
> +		interrupts = <0 39 4>;
> +	};
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 310292e..fe9832e 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -687,6 +687,12 @@
>  			reg = <0xffc25000 0x4>;
>  		};
>  
> +		sdramedac at 0 {
                         ^^^

Please fix the baseaddress (also in the binding doc).

> +			compatible = "altr,sdram-edac";
> +			reg = <0xffc2502C 0x28>;
> +			interrupts = <0 39 4>;
> +		};
> +
>  		rst: rstmgr at ffd05000 {
>  			compatible = "altr,rst-mgr";
>  			reg = <0xffd05000 0x1000>;

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
