From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Sep 2012 13:20:02 -0700
Subject: [PATCH v2 6/8] ARM/dts: omap3-beagle: Enable audio support
In-Reply-To: <1346247067-9632-7-git-send-email-peter.ujfalusi@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-7-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120906202002.GH1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120829 06:31]:
> Add the needed sections to enable audio support on BeagleBoard when booted
> with DT blob.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index cdcb98c..28cf180 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts

I've renamed this to omap3-beagle-xm.dts as it's for beagle xm only
based on the 512 MB of ram. Not a big deal, we can deal with it
while I pull in the branch from Benoit if it does not get automatically
resolved.

Regards,

Tony


> @@ -17,6 +17,14 @@
>  		device_type = "memory";
>  		reg = <0x80000000 0x20000000>; /* 512 MB */
>  	};
> +
> +	sound {
> +		compatible = "ti,omap-twl4030";
> +		ti,model = "omap3beagle";
> +
> +		ti,mcbsp = <&mcbsp2>;
> +		ti,codec = <&twl_audio>;
> +	};
>  };
>  
>  &i2c1 {
> @@ -32,6 +40,12 @@
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <3000000>;
>  		};
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +			codec {
> +			};
> +		};
>  	};
>  };
>  
> -- 
> 1.7.8.6
> 
