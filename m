From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Apr 2014 11:51:23 +0100
Subject: [PATCH 2/3] dts: socfpga: Add bindings for Altera SoC SDRAM EDAC
In-Reply-To: <1396907649-20212-3-git-send-email-tthayer@altera.com>
References: <1396907649-20212-1-git-send-email-tthayer@altera.com>
 <1396907649-20212-3-git-send-email-tthayer@altera.com>
Message-ID: <20140408105123.GC11876@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 10:54:08PM +0100, tthayer at altera.com wrote:
> From: Thor Thayer <tthayer@altera.com>
> 
> Addition of the Altera SDRAM EDAC bindings and device
> tree changes to the Altera SoC project.
> 
> Signed-off-by: Thor Thayer <tthayer@altera.com>
> To: Rob Herring <robherring2@gmail.com>
> To: Pawel Moll <pawel.moll@arm.com>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Ian Campbell <ijc+devicetree@hellion.org.uk>
> To: Kumar Gala <galak@codeaurora.org>
> To: Rob Landley <rob@landley.net>
> To: Russell King <linux@arm.linux.org.uk>
> To: Dinh Nguyen <dinguyen@altera.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  .../bindings/arm/altera/socfpga-sdram-edac.txt     |   12 ++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> new file mode 100644
> index 0000000..9348c53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> @@ -0,0 +1,12 @@
> +Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
> +
> +Required properties:
> +- compatible : should contain "altr,sdr-edac";
> +- interrupts : Should contain the SDRAM ECC IRQ in the
> +	appropriate format for the IRQ controller.
> +
> +Example:
> +	sdramedac at 0 {

Nit: If there's no reg, there shouldn't be a unit-address (the "@0").

> +		compatible = "altr,sdram-edac";
> +		interrupts = <0 39 4>;
> +	};

No phandle to the actual SDRAM controller node? Is there a guaranteed
limitation of a single SDRAM controller?

I don't see the point in describing this separately from the main SDRAM
controller node, given this seems to be a subcomponent.

> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 6ce912e..a0ea69b 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -681,6 +681,11 @@
>  			reg = <0xffc25000 0x1000>;
>  		};
>  
> +		sdramedac at 0 {

Nit: get rid of the unit-address here too.

Cheers,
Mark.

> +			compatible = "altr,sdram-edac";
> +			interrupts = <0 39 4>;
> +		};
> +
>  		rstmgr at ffd05000 {
>  			compatible = "altr,rst-mgr";
>  			reg = <0xffd05000 0x1000>;
> -- 
> 1.7.9.5
> 
> 
