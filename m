From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 21:59:25 -0500
Subject: [PATCH v2 1/2] remoteproc: dt: Provide bindings for iMX6SX/7D
 Remote Processor Controller driver
In-Reply-To: <20170808080030.2581-2-o.rempel@pengutronix.de>
References: <20170808080030.2581-1-o.rempel@pengutronix.de>
 <20170808080030.2581-2-o.rempel@pengutronix.de>
Message-ID: <20170811025925.dwkggu4tuyjj67va@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 10:00:29AM +0200, Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/remoteproc/imx-rproc.txt   | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
> new file mode 100644
> index 000000000000..faf30ef3d6cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
> @@ -0,0 +1,33 @@
> +NXP iMX6SX/iMX7D Co-Processor Bindings
> +----------------------------------------
> +
> +This binding provides support for ARM Cortex M4 Co-processor found on some
> +NXP iMX SoCs.
> +
> +Required properties:
> +- compatible		Should be one of:
> +				"fsl,imx7d-rproc"
> +				"fsl,imx6sx-rproc"

rproc is a Linuxism. Name it after what the M4 is called.

> +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
> +- syscon		Phandle to syscon block which provide access to
> +			System Reset Controller
> +
> +Optional properties:
> +- memory-region		list of phandels to the reserved memory regions.
> +			(See: ../reserved-memory/reserved-memory.txt)
> +
> +Example:
> +	m4_reserved_sysmem1: rproc at 80000000 {
> +		reg = <0x80000000 0x80000>;
> +	};
> +
> +	m4_reserved_sysmem2: rproc at 81000000 {
> +		reg = <0x81000000 0x80000>;
> +	};
> +
> +	imx7d-rproc {
> +		compatible	= "fsl,imx7d-rproc";
> +		memory-region	= <&m4_reserved_sysmem1>, <&m4_reserved_sysmem2>;
> +		syscon		= <&src>;
> +		clocks		= <&clks IMX7D_ARM_M4_ROOT_CLK>;
> +	};
> -- 
> 2.11.0
> 
