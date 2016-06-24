From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Jun 2016 10:43:23 -0500
Subject: [PATCH v3 1/3] Documentation: DT: Add iproc-static-adc binding
In-Reply-To: <1466575913-5027-2-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1466575913-5027-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1466575913-5027-2-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <20160624154323.GA6046@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 11:41:51AM +0530, Raveendra Padasalagi wrote:
> The patch adds devicetree binding document for broadcom's
> iproc-static-adc controller driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> new file mode 100644
> index 0000000..a82076e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> @@ -0,0 +1,38 @@
> +* Broadcom's IPROC Static ADC controller
> +
> +Broadcom iProc ADC controller has 8 channels 10bit ADC.
> +Allows user to convert analog input voltage values to digital.
> +
> +Required properties:
> +
> +- compatible: Must be "brcm,iproc-static-adc"
> +
> +- adc-syscon: Handler of syscon node defining physical base address of the
> +  controller and length of memory mapped region.
> +
> +- #io-channel-cells = <1>; As ADC has multiple outputs
> +  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
> +
> +- clocks: Clock used for this block.
> +
> +- clock-names: Clock name should be given as tsc_clk.
> +
> +- interrupts: interrupt line number.
> +
> +For example:
> +
> +	ts_adc_syscon: ts_adc_syscon at 180a6000 {
> +		compatible = "brcm,iproc-ts-adc-syscon","syscon";
> +		reg = <0x180a6000 0xc30>;
> +	};
> +
> +	adc: adc at 180a6000 {
> +		compatible = "brcm,iproc-static-adc";
> +		adc-syscon = <&ts_adc_syscon>;
> +		#io-channel-cells = <1>;
> +		io-channel-ranges;

Not documented.

> +		clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
> +		clock-names = "tsc_clk";
> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> -- 
> 1.9.1
> 
