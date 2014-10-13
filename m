From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Oct 2014 13:40:31 +0100
Subject: [PATCH V4 1/6] Documentation: DT: Add bindings for FSL NS16550A
 UART
In-Reply-To: <1412980849-21318-2-git-send-email-bhupesh.sharma@freescale.com>
References: <1412980849-21318-1-git-send-email-bhupesh.sharma@freescale.com>
 <1412980849-21318-2-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <20141013124031.GE15326@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 11:40:44PM +0100, Bhupesh Sharma wrote:
> This patch addss the device-tree documentation for Freescale's
> NS16550 UART (also called DUART).
> 
> There is a specific errata fix required in FSL NS16550 UART
> which ensures that an random interrupt storm is not observed when
> a break is provided as an input to the UART.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  .../devicetree/bindings/serial/of-serial.txt       |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
> index 7705477..1bdc569 100644
> --- a/Documentation/devicetree/bindings/serial/of-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/of-serial.txt
> @@ -14,6 +14,7 @@ Required properties:
>  	- "altr,16550-FIFO32"
>  	- "altr,16550-FIFO64"
>  	- "altr,16550-FIFO128"
> +	- "fsl,ns16550"

This will need rebasing due to the addition of "fsl,16550-FIFO64". It's
a shame that the two strings follow different conventions, but it's too
late to change either now.

>  	- "serial" if the port type is unknown.
>  - reg : offset and length of the register set for the device.
>  - interrupts : should contain uart interrupt.
> @@ -39,6 +40,17 @@ Optional properties:
>    property.
>  - has-hw-flow-control: the hardware has flow control capability.
>  
> +Note:
> +* fsl,ns16550:
> +  ------------
> +  Freescale DUART is very similar to the PC16552D (and to a
> +  pair of NS16550A), albeit with some nonstandard behavior such as
> +  erratum A-004737 (relating to incorrect BRK handling).
> +
> +  Represents a single port that is compatible with the DUART found
> +  on many Freescale chips (examples include mpc8349, mpc8548,
> +  mpc8641d, p4080 and ls2085a).

Ideally this would be described with the string entry in the list above,
rather than as a separate note.

Given the lack of notes for other instances, I'm happy to leave htis
here for now. So:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +
>  Example:
>  
>  	uart at 80230000 {
> -- 
> 1.7.9.5
> 
> 
