From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 16:31:03 -0700
Subject: [PATCH 4/7] mfd: sun6i-prcm: document DT bindings
In-Reply-To: <1398697130-8338-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
 <1398697130-8338-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140428233103.GS3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 04:58:47PM +0200, Boris BREZILLON wrote:
> Document DT bindings of the PRCM (Power/Reset/Clock Management) unit.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/mfd/sun6i-prcm.txt         | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> new file mode 100644
> index 0000000..de92429
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> @@ -0,0 +1,71 @@
> +* Allwinner PRCM (Power/Reset/Clock Management) Multi-Functional Device
> +
> +PRCM is an MFD device exposing several Power Management related devices
> +(like clks and reset controllers).
> +
> +Required properties:
> + - compatible: "allwinner,sun6i-a31-prcm"
> + - reg: The PRCM registers range
> +
> +The prcm node may contain several subdevices definitions:
> + - see Documentation/devicetree/clk/sunxi.txt for clock devices
> + - see Documentation/devicetree/reset/allwinner,sunxi-clock-reset.txt for reset
> +   controller devices
> +
> +
> +Example:
> +
> +	prcm: prcm at 01f01400 {
> +		compatible = "allwinner,sun6i-a31-prcm";
> +		reg = <0x01f01400>;

You're missing the size of the address range here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/d08e5529/attachment.sig>
