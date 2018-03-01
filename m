From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Mar 2018 14:32:43 -0800
Subject: [PATCH] arm: dts: omap3: Add missing #sound-dai-cells
In-Reply-To: <20180301202537.30571-2-robh@kernel.org>
References: <20180301202537.30571-2-robh@kernel.org>
Message-ID: <20180301223243.GI62820@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [180301 12:26]:
> dtc now gives the following warnings:
> 
> arch/arm/boot/dts/omap3-gta04a3.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp at 68000000/mcbsp at 49026000 or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/omap3-gta04a4.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp at 68000000/mcbsp at 49026000 or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/omap3-gta04a5.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp at 68000000/mcbsp at 49026000 or bad phandle (referred from sound-dai[0])
> 
> Add the missing #sound-dai-cells property.

Is this needed for the current -rc or is v4.17 OK?

Somehow I'm not seeing these with current -rc or next, is
there some special option (not W=2 :) that you're using?

Regards,

Tony

> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/omap3.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index a005802cd52b..4043ecb38016 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -557,6 +557,7 @@
>  			dma-names = "tx", "rx";
>  			clocks = <&mcbsp4_fck>;
>  			clock-names = "fck";
> +			#sound-dai-cells = <0>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.14.1
> 
