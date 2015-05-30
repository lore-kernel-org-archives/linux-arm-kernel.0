From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 30 May 2015 04:21:12 +0200
Subject: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
In-Reply-To: <20150529193211.GA7599@amd>
References: <201505241444.41039@pali> <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali> <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth> <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd> <20150529193211.GA7599@amd>
Message-ID: <20150530022111.GA28241@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> Fix dts to match what the Linux kernel expects. This works around
> touchscreen problems in 4.1 linux on Nokia n900.
>     
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> index 4b641c7..09089a6 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> @@ -32,8 +32,8 @@ Example:
>  		touchscreen-fuzz-x = <4>;
>  		touchscreen-fuzz-y = <7>;
>  		touchscreen-fuzz-pressure = <2>;
> -		touchscreen-max-x = <4096>;
> -		touchscreen-max-y = <4096>;
> +		touchscreen-size-x = <4096>;
> +		touchscreen-size-y = <4096>;
>  		touchscreen-max-pressure = <2048>;
>  
>  		ti,x-plate-ohms = <280>;
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 5c16145..5f5e0f3 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -832,8 +832,8 @@
>  		touchscreen-fuzz-x = <4>;
>  		touchscreen-fuzz-y = <7>;
>  		touchscreen-fuzz-pressure = <2>;
> -		touchscreen-max-x = <4096>;
> -		touchscreen-max-y = <4096>;
> +		touchscreen-size-x = <4096>;
> +		touchscreen-size-y = <4096>;
>  		touchscreen-max-pressure = <2048>;
>  
>  		ti,x-plate-ohms = <280>;

Acked-By: Sebastian Reichel <sre@kernel.org>

max-x/fuzz-x is a leftover from development of the generic bindings
(Initially I used min and max).

If 3eea8b5d68c801fec788b411582b803463834752's behaviour should
become the new behaviour it should be documented, that maximum and
fuzz values are dependent on each other. Instead I suggest to
restore the old behaviour.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150530/2f9f6d69/attachment.sig>
