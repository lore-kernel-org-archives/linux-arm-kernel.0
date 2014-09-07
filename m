From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 07 Sep 2014 17:35:18 +0400
Subject: [PATCH RFC 1/3] DT: add binding for MXS regulator
In-Reply-To: <1410089869-6611-2-git-send-email-info@lategoodbye.de>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
 <1410089869-6611-2-git-send-email-info@lategoodbye.de>
Message-ID: <540C5F16.4000108@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/7/2014 3:37 PM, Stefan Wahren wrote:

> This patch adds the Device tree bindings for the Freescale MXS on-chip
> regulators.

> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   .../bindings/regulator/mxs-regulator.txt           | 38 ++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt

> diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
> new file mode 100644
> index 0000000..c3226cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
> @@ -0,0 +1,38 @@
> +MXS regulators
> +
> +Required node properties:
> +- compatible: Should be "fsl,<soc>-power", where soc is "imx23" or "imx28"
> +- reg: Offset and length of the register set for the device
> +
> +Required regulator properties:
> +- compatible: Must be "fsl,mxs-regulator"
> +- reg: Offset of the register set for the regulator
> +- mxs-max-reg-val: Maximum value of this register
> +
> +Optional regulator properties:
> +- mxs-default-microvolt: initial voltage of the regulator

    Vendor specific property names should be prefixed with the vendor name and 
comma.

WBR, Sergei
