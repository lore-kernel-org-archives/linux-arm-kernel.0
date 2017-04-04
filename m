From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 04 Apr 2017 13:05:47 +0300
Subject: [PATCH] ARM: dts: koelsch: Correct clock frequency of X2 DU clock
 input
In-Reply-To: <1491213319-7668-1-git-send-email-geert+renesas@glider.be>
References: <1491213319-7668-1-git-send-email-geert+renesas@glider.be>
Message-ID: <2246751.IOz92zzvZ6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Monday 03 Apr 2017 11:55:19 Geert Uytterhoeven wrote:
> The X2 crystal oscillator on the Koelsch development board provides a
> 74.25 MHz clock, not a 148.5 MHz clock.
> 
> Fixes: cd21cb46e14aae3a ("ARM: shmobile: koelsch: Add DU external pixel
> clocks to DT") Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Confirmed by schematics, user manual, and physical inspection of 2
> Koelsch instances (my scope has not enough bandwidth to measure the
> actual frequency).

Stupid question, have you tested the corresponding (HDMI) DU output ? If so,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Probably this was copied from r8a7790-lager.dts, as Lager does have two
> identical crystal oscillators X2 and X13.
> 
> Note that X2 is socketed, so it can be changed.
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> b/arch/arm/boot/dts/r8a7791-koelsch.dts index
> 59beb8402a36007b..001e6116c47c7c3b 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -292,7 +292,7 @@
>  	x2_clk: x2-clock {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency = <148500000>;
> +		clock-frequency = <74250000>;
>  	};
> 
>  	x13_clk: x13-clock {

-- 
Regards,

Laurent Pinchart
