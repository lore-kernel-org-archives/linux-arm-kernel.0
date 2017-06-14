From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Wed, 14 Jun 2017 10:35:12 +0300
Subject: [PATCH v5 1/3] nvmem: dt: document SNVS LPGPR binding
In-Reply-To: <20170609125730.25502-2-o.rempel@pengutronix.de>
References: <20170609125730.25502-1-o.rempel@pengutronix.de>
 <20170609125730.25502-2-o.rempel@pengutronix.de>
Message-ID: <442e0336-fbd3-f92c-ab6a-0622c710e232@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2017 15:57, Oleksij Rempel wrote:

> Documentation bindings for the Low Power General Purpose Register
> available on i.MX6 SoCs in the Secure Non-Volatile Storage.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/nvmem/snvs-lpgpr.txt          | 19
> +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
>
> diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
> b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
> new file mode 100644
> index 000000000000..21910fb3159f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
> @@ -0,0 +1,19 @@
> +Device tree bindings for Low Power General Purpose Register found in
> i.MX6Q/D
> +Secure Non-Volatile Storage.
> +
> +This DT node should be represented as a sub-node of a "syscon",
> +"simple-mfd" node.
> +
> +Required properties:
> +- compatible: should be:
> +	"fsl,imx6q-snvs-lpgpr" for Freescale i.MX6Q/D/DL/S

I've tested the basic functionality on i.MX6UL. It seems to work as is.
Please add "/UL" on the next version.

Regards,
Guy

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
