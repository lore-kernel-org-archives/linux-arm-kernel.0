From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Mar 2014 12:02:40 +0100
Subject: [PATCH v4 3/3] ARM: sun7i/sun6i: irqchip: Update the documentation
In-Reply-To: <1393529662-8663-4-git-send-email-carlo@caione.org>
References: <1393529662-8663-1-git-send-email-carlo@caione.org>
 <1393529662-8663-4-git-send-email-carlo@caione.org>
Message-ID: <20140303110240.GW607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 27, 2014 at 08:34:22PM +0100, Carlo Caione wrote:
> Added documentation for NMI irqchip.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  .../allwinner,sun67i-sc-nmi.txt                    | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
> new file mode 100644
> index 0000000..ac31487
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
> @@ -0,0 +1,27 @@
> +Allwinner Sunxi NMI Controller
> +==============================
> +
> +Required properties:
> +
> +- compatible : should be "allwinner,sun7i-a20-sc-nmi" or
> +  "allwinner,sun6i-a31-sc-nmi"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 2. The first cell is the IRQ number, the
> +  second cell the trigger type.

What values correspond to what trigger type? What are the accepted values?

> +- interrupt-parent: Specifies the parent interrupt controller.
> +- interrupts: Specifies the list of interrupt lines which are handled by
> +  the interrupt controller in the parent controller's notation. This value
> +  shall be the NMI.

Hmmm, there's only one interrupt, not a list of them.

> +
> +Example:
> +
> +sc-nmi-intc at 01c00030 {
> +	compatible = "allwinner,sun7i-a20-sc-nmi";
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	reg = <0x01c00030 0x0c>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 0 4>;
> +};
> -- 
> 1.8.3.2
> 

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/96759468/attachment.sig>
