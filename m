From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jul 2015 23:57:45 -0700
Subject: [PATCH 1/3] ARM: dts: Correct audio input route & set mic bias
In-Reply-To: <1433441299-18887-2-git-send-email-arun@gumstix.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
 <1433441299-18887-2-git-send-email-arun@gumstix.com>
Message-ID: <20150714065745.GE17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arun Bharadwaj <arun@gumstix.com> [150604 11:10]:
> From: Adam YH Lee <adam.yh.lee@gmail.com>
> 
> Audio-in was incorrectly routed to Line In. It should be Mic3L as per
> schematic.
> 
> Using mic-bias voltage at 2.0v (<0x1>) does not work for some reason. There
> is no voltage seen on micbias (R127). Mic-bias voltage of 2.5v (<0x2>) works.
> I see voltage of 2.475v across GND and micbias.
> 
> With these changes, I can record audio with a pair of proliferate TRRS earbuds.
> 
> Signed-off-by: Ash Charles <ashcharles@gmail.com>

Can you please repost this with after checking From
and Signed-off-by?

Regards,

Tony

> ---
>  arch/arm/boot/dts/am335x-pepper.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
> index 0d35ab6..473d8ee 100644
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -74,6 +74,7 @@
>  	audio_codec: tlv320aic3106 at 1b {
>  		compatible = "ti,tlv320aic3106";
>  		reg = <0x1b>;
> +		ai3x-micbias-vg = <0x2>;
>  	};
>  
>  	accel: lis331dlh at 1d {
> @@ -153,7 +154,7 @@
>  	ti,audio-routing =
>  		"Headphone Jack",	"HPLOUT",
>  		"Headphone Jack",	"HPROUT",
> -		"LINE1L",		"Line In";
> +		"MIC3L",		"Mic3L Switch";
>  };
>  
>  &mcasp0 {
> -- 
> 2.1.4
> 
