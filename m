From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Sep 2014 17:17:38 +0100
Subject: [PATCH 1/2] devicetree: cadence_ttc: Document binding for timer
 width
In-Reply-To: <3537996136ec435ea660da869102d0a019214979.1410964243.git.michal.simek@xilinx.com>
References: <3537996136ec435ea660da869102d0a019214979.1410964243.git.michal.simek@xilinx.com>
Message-ID: <20140917161737.GA7983@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 03:30:49PM +0100, Michal Simek wrote:
> From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> 
> Modern TTC implementations can extend the timer width to 32 bit. This
> feature is not self identifying so the driver needs to be made aware
> via device tree.
> 
> Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
> index 993695c659e1..5439976eca6b 100644
> --- a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
> @@ -6,6 +6,9 @@ Required properties:
>  - interrupts : A list of 3 interrupts; one per timer channel.
>  - clocks: phandle to the source clock
> 
> +Optional properties:
> +- timer-width: Bit width of the timer. Either 16 or 32 (default 16).

Are we expecting TTC implementations with widths other than 16 or 32?

This looks sane to me, but we might be able to just have a 32-bit-timer
property if we don't expect arbitrary widths.

Mark.
