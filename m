From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Feb 2014 09:29:37 +0000
Subject: [PATCH v3 7/7] devicetree: bindings: Document PM8921/8058 PMICs
In-Reply-To: <1389206270-3728-8-git-send-email-sboyd@codeaurora.org>
References: <1389206270-3728-1-git-send-email-sboyd@codeaurora.org>
 <1389206270-3728-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140211092937.GG32042@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> PM8921 and PM8058 are PMICs found paired with MSM8960 and MSM8660
> devices respectively. They contain subdevices such as keypads,
> RTCs, regulators, clocks, etc.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/mfd/qcom,pm8xxx.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8xxx.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8xxx.txt b/Documentation/devicetree/bindings/mfd/qcom,pm8xxx.txt
> new file mode 100644
> index 000000000000..e3fe625ffd58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8xxx.txt
> @@ -0,0 +1,63 @@

<snip>

> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>

Either provide an example or a comment to see the description of
#interrupt-cells 

> +	Definition: specifies the interrupt that indicates a subdevice
> +		    has generated an interrupt (summary interrupt). The
> +		    format of the specifier is defined by the binding document
> +		    describing the node's interrupt parent.
> +
> +- #interrupt-cells:
> +	Usage: required
> +	Value type : <u32>
> +	Definition: must be 2. Specifies the number of cells needed to encode
> +		    an interrupt source. The 1st cell contains the interrupt
> +		    number. The 2nd cell is the trigger type and level flags
> +		    encoded as follows:
> +
> +			1 = low-to-high edge triggered
> +			2 = high-to-low edge triggered
> +			4 = active high level-sensitive
> +			8 = active low level-sensitive

Actually I'd prefer if you used the definitions in:
  dt-bindings/interrupt-controller/irq.h

> +- interrupt-controller:
> +	Usage: required
> +	Value type: <empty>
> +	Definition: identifies this node as an interrupt controller
> +
> +EXAMPLE
> +
> +	pmicintc: pmic at 0 {
> +		compatible = "qcom,pm8921";
> +		interrupts = <104 8>;

As above.

> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pwrkey {
> +			compatible = "qcom,pm8921-pwrkey";
> +			interrupt-parent = <&pmicintc>;
> +			interrupts = <50 1>, <51 1>;

As above.

> +		};
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
