From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 10:59:42 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun7i: Add CAN node and can0_pins_a
 pinctrl settings
In-Reply-To: <91bc06e3-3173-43a1-32f2-a35d94855d46@posteo.de>
References: <1490392339-23565-1-git-send-email-menschel.p@posteo.de>
 <1490392339-23565-3-git-send-email-menschel.p@posteo.de>
 <20170327064625.we7ydn2oapwizncb@lukather>
 <91bc06e3-3173-43a1-32f2-a35d94855d46@posteo.de>
Message-ID: <20170403085942.ereuwdqfrv5npxjn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 06:51:38PM +0200, Patrick Menschel wrote:
> Hello Maxime,
> 
> Am 27.03.2017 um 08:46 schrieb Maxime Ripard:
> >> @@ -1582,6 +1587,14 @@
> >>  			#size-cells = <0>;
> >>  		};
> >>  
> >> +		can0: can at 01c2bc00 {
> >> +			compatible = "allwinner,sun4i-a10-can";
> > 
> > Sorry for not spotting this earlier, but this would need an A20
> > compatible too, to deal with the case where it turns out not to be
> > compatible.
> > 
> > you can do something like this:
> > compatible = "allwinner,sun7i-a20-can", "allwinner,sun4i-a10-can";
> 
> Adding "sun7i-a20-can" to the compatible list results in a checkpatch
> warning, that the "driver" is not documented.
> 
>  WARNING: DT compatible string "allwinner,sun7i-a20-can" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> #27: FILE: arch/arm/boot/dts/sun7i-a20.dtsi:1586:
> +			compatible = "allwinner,sun7i-a20-can",
> 
> Is it really OK to add a driver that doesn't exist yet?

It's not what you are doing, what you're doing is adding an extra
compatible that is not there yet.

Since it doesn't exist, it will fallback on the second one, which does
exist. So yes, it's ok to do so.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
