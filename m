From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 2 Sep 2014 21:30:00 -0500
Subject: [PATCHv10 2/2] arm: dts: Add Altera SDRAM EDAC bindings &
 devicetree entries.
In-Reply-To: <1407770293-27190-3-git-send-email-tthayer@opensource.altera.com>
References: <1407770293-27190-1-git-send-email-tthayer@opensource.altera.com>
 <1407770293-27190-3-git-send-email-tthayer@opensource.altera.com>
Message-ID: <54067D28.20408@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi DTS maintainers,

If possible, can I please get an Acked-by for this patch?

Many thanks...

Dinh

On 8/11/14, 10:18 AM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the Altera SDRAM EDAC bindings and device tree changes to the Altera SoC project.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Changes to SoC SDRAM EDAC code.
> 
> v3: Implement code suggestions for SDRAM EDAC code.
> 
> v4: Remove syscon from SDRAM controller bindings.
> 
> v5: No Change, bump version for consistency.
> 
> v6: Only map the ctrlcfg register as syscon.
> 
> v7: No change. Bump for consistency.
> 
> v8: No change. Bump for consistency.
> 
> v9: Changes to support a MFD SDRAM controller with nested EDAC.
> 
> v10: Revert to using syscon based on feedback.
> ---
>  .../bindings/arm/altera/socfpga-sdram-edac.txt     |   15 +++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   11 +++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> new file mode 100644
> index 0000000..d0ce01d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> @@ -0,0 +1,15 @@
> +Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
> +The EDAC accesses a range of registers in the SDRAM controller.
> +
> +Required properties:
> +- compatible : should contain "altr,sdram-edac";
> +- altr,sdr-syscon : phandle of the sdr module
> +- interrupts : Should contain the SDRAM ECC IRQ in the
> +	appropriate format for the IRQ controller.
> +
> +Example:
> +	sdramedac {
> +		compatible = "altr,sdram-edac";
> +		altr,sdr-syscon = <&sdr>;
> +		interrupts = <0 39 4>;
> +	};
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 4676f25..45b361e 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -603,6 +603,17 @@
>  			};
>  		};
>  
> +		sdr: sdr at ffc25000 {
> +			compatible = "syscon";
> +			reg = <0xffc25000 0x1000>;
> +		};
> +
> +		sdramedac {
> +			compatible = "altr,sdram-edac";
> +			altr,sdr-syscon = <&sdr>;
> +			interrupts = <0 39 4>;
> +		};
> +
>  		L2: l2-cache at fffef000 {
>  			compatible = "arm,pl310-cache";
>  			reg = <0xfffef000 0x1000>;
> 
