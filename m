From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 20 Nov 2013 13:32:45 +0100
Subject: [PATCHv5 10/20] arm: dts: add omap4430 thermal data
In-Reply-To: <1384285582-16933-11-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
 <1384285582-16933-11-git-send-email-eduardo.valentin@ti.com>
Message-ID: <20131120123245.GA3242@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI!

> This patch changes the dtsi entry on omap4430 to contain
> the thermal data. This data will enable the passive
> cooling with CPUfreq cooling device at 100C and the
> system will do a thermal shutdown at 125C.
> 
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
> index bcf455e..e9c97d6 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -12,7 +12,7 @@
>  
>  / {
>  	cpus {
> -		cpu at 0 {
> +		cpu0: cpu at 0 {
>  			/* OMAP443x variants OPP50-OPPNT */
>  			operating-points = <
>  				/* kHz    uV */

I see you also add labels to various other entries...

> @@ -25,9 +25,15 @@
>  		};
>  	};
>  
> -	bandgap {
> +	thermal-zones{

You may want to include space here.

> +		#include "omap4-cpu-thermal.dtsi"
> +	};
> +
> +	bandgap: bandgap {
>  		reg = <0x4a002260 0x4
>  		       0x4a00232C 0x4>;
>  		compatible = "ti,omap4430-bandgap";
> +
> +		#thermal-sensor-cells = <0>;
>  	};
>  };

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
