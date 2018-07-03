From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 03 Jul 2018 16:44:50 +0200
Subject: [PATCH 1/3] dt-bindings: marvell: Add documentation for the
 Armada 3700 AVS binding
In-Reply-To: <20180619124402.902-2-gregory.clement@bootlin.com>
References: <20180619124402.902-1-gregory.clement@bootlin.com>
 <20180619124402.902-2-gregory.clement@bootlin.com>
Message-ID: <7581910.yGXAn98Nt4@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 19, 2018 2:44:00 PM CEST Gregory CLEMENT wrote:
> Extend the documentation of the Armada 37xx SoC with the Adaptive Voltage
> Scaling (AVS) registers.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../bindings/arm/marvell/armada-37xx.txt         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> index 35c3c3460d17..22438f659d1e 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> @@ -33,3 +33,19 @@ nb_pm: syscon at 14000 {
>  	compatible = "marvell,armada-3700-nb-pm", "syscon";
>  	reg = <0x14000 0x60>;
>  }
> +
> +AVS
> +---
> +
> +For AVS an other component is needed:
> +
> +Required properties:
> +- compatible     : should contain "marvell,armada-3700-avs", "syscon";
> +- reg            : the register start and length for the AVS
> +
> +Example:
> +avs: avs at 11500 {
> +	compatible = "marvell,armada-3700-avs", "syscon";
> +	reg = <0x11500 0x40>;
> +}
> +
> 

I can't apply this one without a Rob's ACK.
