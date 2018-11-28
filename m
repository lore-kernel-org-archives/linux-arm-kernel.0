From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:32:19 +0100
Subject: [PATCH 04/15] dt-bindings: rtc: sun6i-rtc: Export internal RC
 oscillator
In-Reply-To: <20181128093013.24442-5-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-5-wens@csie.org>
Message-ID: <20181128103219.b625lttcgoluhgz5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:01PM +0800, Chen-Yu Tsai wrote:
> Experiments showed that on at least the H3/H5/A64 the RTC's internal
> oscillator also feeds the CPUS mux in the PRCM.
> 
> Export this clock through the device tree, instead of having to use
> a dummy fixed-clock device node, for the PRCM to consume. This will
> properly describe the relationship between the clocks.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> index 78c4fb472eb7..1bd37faadecb 100644
> --- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> @@ -24,7 +24,7 @@ Required properties:
>  
>  Required properties for new device trees
>  - clocks	: phandle to the 32kHz external oscillator
> -- clock-output-names : names of the two clock outputs. See below.
> +- clock-output-names : names of the three clock outputs. See below.
>  - #clock-cells  : must be equal to 1.
>  
>  The RTC provides the following clocks at the given indices:
> @@ -32,6 +32,7 @@ The RTC provides the following clocks at the given indices:
>  - 1: LOSC external output, known as X32KFOUT in the datasheet.
>       This clock is not available on the A31 and is deprecated for old
>       device trees still using the "allwinner,sun6i-a31-rtc" compatible.
> +- 2: InternalOSC, or internal RC oscillator

It seems to be required only for a few RTC though (H3, H5 and R40?)

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/7c1671a6/attachment-0001.sig>
