From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2018 08:25:40 +0100
Subject: [PATCH v8 07/12] dt-bindings: mfd: Add a document for PECI
 client MFD
In-Reply-To: <20180918215124.14003-8-jae.hyun.yoo@linux.intel.com>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-8-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181024072540.GA4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Sep 2018, Jae Hyun Yoo wrote:

> This commit adds a dt-bindings document for PECI client MFD.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  .../bindings/mfd/intel-peci-client.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/intel-peci-client.txt b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> new file mode 100644
> index 000000000000..cb341e363add
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> @@ -0,0 +1,34 @@
> +* Intel PECI client bindings
> +
> +PECI (Platform Environment Control Interface) is a one-wire bus interface that
> +provides a communication channel from PECI clients in Intel processors and
> +chipset components to external monitoring or control devices. PECI is designed
> +to support the following sideband functions:
> +
> +- Processor and DRAM thermal management
> +- Platform Manageability
> +- Processor Interface Tuning and Diagnostics
> +- Failure Analysis
> +
> +Required properties:
> +- compatible : Should be "intel,peci-client".
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +	       clients starts from 0x30 based on PECI specification.

Nit: "start"

Would be better worded:

"According to the PECI specification client addresses start from 0x30."

> +Example:
> +	peci-bus at 0 {
> +		compatible = "vendor,soc-peci";
> +		reg = <0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		peci-client at 30 {
> +			compatible = "intel,peci-client";
> +			reg = <0x30>;
> +		};
> +
> +		peci-client at 31 {
> +			compatible = "intel,peci-client";
> +			reg = <0x31>;
> +		};
> +	};

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
