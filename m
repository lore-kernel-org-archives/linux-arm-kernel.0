From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 14:51:25 -0600
Subject: [PATCH 3/5] dt-bindings: soc: Add a binding for the Broadcom VCHI
 services.
In-Reply-To: <20180305202806.21219-4-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
 <20180305202806.21219-4-eric@anholt.net>
Message-ID: <CAL_Jsq+rEbghtLib4B-eQSLRtdODqeKVdXFJrPjb-JJbJgdpiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 2:28 PM, Eric Anholt <eric@anholt.net> wrote:
> The VCHI communication channel can be provided by BCM283x and Capri

VCHI or VCHIQ?

> SoCs, to communicate with the VPU-side OS services.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> new file mode 100644
> index 000000000000..4055a8977f3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> @@ -0,0 +1,18 @@
> +Broadcom VCHIQ firmware services
> +
> +Required properties:
> +
> +- compatible:  Should be "brcm,bcm2835-vchiq"
> +- reg:         Physical base address and length of the doorbell register pair
> +- interrupts:  The interrupt number
> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +- firmware:    Reference to the RPi firmware device node

There's only one, just get it by compatible or path.

> +
> +Example:
> +
> +vchi at 7e00b840 {
> +       compatible = "brcm,bcm2835-vchiq";
> +       reg = <0x7e00b840 0xf>;
> +       interrupts = <0 2>;
> +       firmware = <&firmware>;
> +};
> --
> 2.16.2
>
