From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 9 Jun 2017 16:59:00 +0200
Subject: [PATCH v5 1/3] nvmem: dt: document SNVS LPGPR binding
In-Reply-To: <20170609125730.25502-2-o.rempel@pengutronix.de>
References: <20170609125730.25502-1-o.rempel@pengutronix.de>
 <20170609125730.25502-2-o.rempel@pengutronix.de>
Message-ID: <8e50ff3d-d1f0-2795-5dc9-302979ca9694@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

Am 09.06.2017 um 14:57 schrieb Oleksij Rempel:
> Documentation bindings for the Low Power General Purpose Register
> available on i.MX6 SoCs in the Secure Non-Volatile Storage.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/nvmem/snvs-lpgpr.txt          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
>
> diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
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

according to the reference manual at least the clock "lp_ipg_clk_s" is
required for register R/W access.
So it should be added to the binding and enabled by the driver.

Best regards
Stefan

> +	};
> +};
