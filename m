From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 27 Feb 2017 15:40:07 +0100
Subject: [RFC v2 03/17] dt-bindings: timer: Document Owl timer
In-Reply-To: <20170224034055.18807-4-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-4-afaerber@suse.de>
Message-ID: <0c3f94c0-b920-25f9-7347-b43407d66dfa@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.02.2017 um 04:40 schrieb Andreas F?rber:
> The Actions Semi S500 SoC contains a timer block with two timers.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: new
>  
>  .../devicetree/bindings/timer/actions,owl-timer.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> new file mode 100644
> index 0000000..141bc7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> @@ -0,0 +1,16 @@
> +Actions Semi Owl Timer
> +
> +Required properties:
> +- compatible :  "actions,owl-timer"
> +- reg        :  Offset and length of the register set for the device.
> +- interrupts :  Should contain two timer interrupts.
> +
> +
> +Example:
> +
> +		timer at b0168000 {
> +			compatible = "actions,owl-timer";
> +			reg = <0xb0168000 0x100>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		};

I need to modify these bindings for upcoming v3 in the following ways:

* "actions,s500-timer", "actions,owl-timer" to deal with S500 vs. S900
differences while keeping a single driver registration (or would two
registrations be preferred, dropping the second compatible? they do
share a common subset)

* Use named interrupts to deal with 2x 2Hz + 2x Timer vs. 4x Timer for
complete hardware description

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
