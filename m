From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 25 Feb 2016 11:38:20 +0100
Subject: [PATCH v2] dts: add specific compatible type for Terasic
 DE0-NANO-SoC  Board
In-Reply-To: <2186741.ZYdHdfu2ug@dabox>
References: <8416439.76b9YNhpgR@dabox>
 <alpine.DEB.2.02.1602241048100.3815@linux-builds1>
 <2186741.ZYdHdfu2ug@dabox>
Message-ID: <20160225103820.GB747@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim!

On Thu, Feb 25, 2016 at 11:05:05AM +0100, Tim Sander wrote:
> From: Tim Sander <tim@krieglstein.org>
> 
> Add a more specific compatible string:"terasic,de0-nano-soc" for respective board.
> Background: when checking for bootspec entries, some board specific fixups are
> not apropriate for board of the same platform ("altr,socfpga-cyclone5").
> The same aproach is taken with the EBV-Socrates board.
> 
> Signed-off-by: Tim Sander <tim@krieglstein.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts     | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 72e2c5a..d1f7803 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -230,6 +230,7 @@ synology	Synology, Inc.
>  tbs	TBS Technologies
>  tcl	Toby Churchill Ltd.
>  technologic	Technologic Systems
> +terasic	Terasic Inc.
>  thine	THine Electronics, Inc.
>  ti	Texas Instruments
>  tlm	Trusted Logic Mobility

You should IMHO split this up in two patches.
First patch: add terasic

> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> index afea364..704aa9d 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> @@ -18,7 +18,7 @@
>  
>  / {
>  	model = "Terasic DE-0(Atlas)";
> -	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +	compatible = "terasic,de0-nano-soc","altr,socfpga-cyclone5", "altr,socfpga";

Second patch: this.

>  
>  	chosen {
>  		bootargs = "earlyprintk";

The naming of this board still confuses me though.
It has 3 different names now:

	- de0_sockit.dts
	- Terasic DE-0(Atlas)
	- de0-nano-soc

And according to Terasic DE0-Nano-SoC is the same as Atlas-SoC with a different software?!
So all three names are actually correct ?! Weird.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
