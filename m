From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Jun 2016 21:56:19 -0500
Subject: [PATCH 6/7] dt-bindings: net: bgmac: add bindings documentation
 for bgmac
In-Reply-To: <1467327554-22074-7-git-send-email-jon.mason@broadcom.com>
References: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
 <1467327554-22074-7-git-send-email-jon.mason@broadcom.com>
Message-ID: <20160701025619.GA4906@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 06:59:13PM -0400, Jon Mason wrote:
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  .../devicetree/bindings/net/brcm,bgmac-nsp.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt b/Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
> new file mode 100644
> index 0000000..022946c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
> @@ -0,0 +1,24 @@
> +Broadcom GMAC Ethernet Controller Device Tree Bindings
> +-------------------------------------------------------------
> +
> +Required properties:
> + - compatible:	"brcm,bgmac-nsp"

Usually we do <soc>-<block> order.

> + - reg:		Address and length of the GMAC registers,
> +		Address and length of the GMAC IDM registers
> + - reg-names:	Names of the registers.  Must have both "gmac_base" and
> +		"idm_base"
> + - interrupts:	Interrupt number
> +
> +Optional properties:
> +- mac-address:	See ethernet.txt file in the same directory
> +
> +Examples:
> +
> +gmac0: ethernet at 18022000 {
> +	compatible = "brcm,bgmac-nsp";
> +	reg = <0x18022000 0x1000>,
> +	      <0x18110000 0x1000>;
> +	reg-names = "gmac_base", "idm_base";
> +	interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +	status = "disabled";
> +};
> -- 
> 1.9.1
> 
