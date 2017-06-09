From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 9 Jun 2017 10:36:38 +0100
Subject: [PATCH v4 1/3] nvmem: dt: document SNVS LPGPR binding
In-Reply-To: <20170608165134.14971-2-o.rempel@pengutronix.de>
References: <20170608165134.14971-1-o.rempel@pengutronix.de>
 <20170608165134.14971-2-o.rempel@pengutronix.de>
Message-ID: <82860099-f4d3-400f-1c6b-45837d91fd54@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/06/17 17:51, Oleksij Rempel wrote:
> Documentation bindings for the Low Power General Purpose Register
> available on i.MX6 SoCs in the Secure Non-Volatile Storage.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   .../devicetree/bindings/nvmem/snvs-lpgpr.txt          | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt

These look okay, but bindings needs ack from DT maintainers for me to 
pick it up.

--srini

> new file mode 100644
> index 000000000000..21910fb3159f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
> @@ -0,0 +1,19 @@
> +Device tree bindings for Low Power General Purpose Register found in i.MX6Q/D
> +Secure Non-Volatile Storage.
> +
> +This DT node should be represented as a sub-node of a "syscon",
> +"simple-mfd" node.
> +
> +Required properties:
> +- compatible: should be:
> +	"fsl,imx6q-snvs-lpgpr" for Freescale i.MX6Q/D/DL/S
> +
> +Example:
> +snvs: snvs at 020cc000 {
> +	compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> +	reg = <0x020cc000 0x4000>;
> +
> +	snvs_lpgpr: snvs-lpgpr {
> +		compatible = "fsl,imx6q-snvs-lpgpr";
> +	};
> +};
> 
