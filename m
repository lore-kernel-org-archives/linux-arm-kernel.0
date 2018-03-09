From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 9 Mar 2018 21:31:30 +0100 (CET)
Subject: [PATCH v3 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services. (v3)
In-Reply-To: <20180309184417.23368-3-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
 <20180309184417.23368-3-eric@anholt.net>
Message-ID: <1683748924.258615.1520627491004@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 9. M?rz 2018 um 19:44 geschrieben:
> 
> 
> The VCHIQ communication channel can be provided by BCM283x and Capri
> SoCs, to communicate with the VPU-side OS services.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: VCHI->VCHIQ, dropped firmware property, added cache-line-size
> v3: Dropped cache-line-size, s/vchi@/mailbox@/
> 
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> new file mode 100644
> index 000000000000..8dd7b3a7de65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> @@ -0,0 +1,16 @@
> +Broadcom VCHIQ firmware services
> +
> +Required properties:
> +
> +- compatible:	Should be "brcm,bcm2835-vchiq"
> +- reg:		Physical base address and length of the doorbell register pair
> +- interrupts:	The interrupt number
> +		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Example:
> +
> +mailbox at 7e00b840 {

just a question: do you think this is future-proof to claim the doorbell for VCHIQ?

Stefan

> +	compatible = "brcm,bcm2835-vchiq";
> +	reg = <0x7e00b840 0xf>;
> +	interrupts = <0 2>;
> +};
> -- 
> 2.16.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
