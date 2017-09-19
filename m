From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Sep 2017 10:42:14 -0700
Subject: [PATCH] nokia n900: drop unneeded/undocumented parts of the dts
In-Reply-To: <20170828131816.GB30115@amd>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170828131816.GB30115@amd>
Message-ID: <20170919174214.GZ5024@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [170828 06:18]:
> 
> Sakari mentioned that some parts of the dts are not needed and do
> not have proper documentation, yet.
> 
> As the camera works without them, remove them for now.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applying into omap-for-v4.14/fixes to correct what already
got merged during the merge window.

Regards,

Tony

> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -144,15 +144,6 @@
>  		io-channel-names = "temp", "bsi", "vbat";
>  	};
>  
> -	rear_camera: camera at 0 {
> -		compatible = "linux,camera";
> -
> -		module {
> -			model = "TCM8341MD";
> -			sensor = <&cam1>;
> -		};
> -	};
> -
>  	pwm9: dmtimer-pwm {
>  		compatible = "ti,omap-dmtimer-pwm";
>  		#pwm-cells = <3>;
> @@ -189,10 +180,8 @@
>  				clock-lanes = <1>;
>  				data-lanes = <0>;
>  				lane-polarity = <0 0>;
> -				clock-inv = <0>;
>  				/* Select strobe = <1> for back camera, <0> for front camera */
>  				strobe = <1>;
> -				crc = <0>;
>  			};
>  		};
>  	};
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
