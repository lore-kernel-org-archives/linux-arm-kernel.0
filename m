From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 14:11:24 -0500
Subject: [PATCH 1/5] dt: bindings: add means to control flags of specific
 clocks
In-Reply-To: <1462463608-22940-2-git-send-email-kernel@martin.sperl.org>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
 <1462463608-22940-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160509191124.GA31621@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 03:53:24PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add documentation for "brcm,clock-index" and "brcm,clock-flags"
> which allows to set flags to enable the use of parent clocks
> that may be different from the default.

assigned-clocks provides a way to do this already though that does mean 
exposing all the parents to DT. Does that not work for you?

> In the future this may also contain flags that would allow
> enabling higher order mash dividers.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  .../devicetree/bindings/clock/brcm,bcm2835-cprman.txt      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt b/Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
> index e56a1df..cbcca56 100644
> --- a/Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
> +++ b/Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
> @@ -18,6 +18,15 @@ Required properties:
>  - reg:		Specifies base physical address and size of the registers
>  - clocks:	The external oscillator clock phandle
> 
> +Optional properties:
> +- brcm,clock-index: clock id to which the corresponding brcm,clock-flags
> +		      value applies
> +- brcm,clock-flags: flags for the specific clock id given in
> +		      brcm,clock-index - the bits are defined in
> +		      include/dt-bindings/clock/bcm2835.h
> +		      of which the bottom 16 bits are reserved for
> +		      parent clock selection.

These are an array or single value?

I tend to think these should be generic properties or not at all. I'd 
like to hear Mike's and/or Stephen's opinion on it.

Rob
