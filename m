From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 14:25:02 -0800
Subject: [PATCH 5/9] ARM: dts: omap3-gta04: Add basic sound support.
In-Reply-To: <1390685343-11663-6-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
 <1390685343-11663-6-git-send-email-marek@goldelico.com>
Message-ID: <20140228222501.GL13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [140125 13:31]:

Hmm care to add descriptions and repost the remaining patches
that I did not yet pick up for the fixes?

> Signed-off-by: NeilBrown <neilb@suse.de>

Hmm should this also have From: NeilBrown <neilb@suse.de>?

Also, while at it, maybe change your long time habit of adding
a period to the end of the subject line? That is of course
if you don't insist on having it, it's not usually used if
you look at git log --pretty=oneline :)

Regards,

Tony

> ---
>  arch/arm/boot/dts/omap3-gta04.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
> index 7e09410..a924a843 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dts
> +++ b/arch/arm/boot/dts/omap3-gta04.dts
> @@ -36,6 +36,14 @@
>  			gpio-key,wakeup;
>  		};
>  	};
> +
> +	sound {
> +		compatible = "ti,omap-twl4030";
> +		ti,model = "gta04";
> +
> +		ti,mcbsp = <&mcbsp2>;
> +		ti,codec = <&twl_audio>;
> +	};
>  };
>  
>  &omap3_pmx_core {
> @@ -79,6 +87,13 @@
>  		reg = <0x48>;
>  		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>  		interrupt-parent = <&intc>;
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +			codec {
> +			};
> +		};
> +
>  		vaux4: regulator-vaux4 {
>  			compatible = "ti,twl4030-vaux4";
>  			regulator-min-microvolt = <2800000>;
> -- 
> 1.8.3.2
> 
