From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 18 May 2013 19:33:54 +0200
Subject: [RFC 2/4] ARM: dove: add video card node for SolidRun CuBox
In-Reply-To: <1368897139-25485-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130518193354.1be73084@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 May 2013 19:12:17 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> This adds a video card node required for rmk's dove_drm driver. Reg
> property matches reserved memory region (currently 16M at top of memory),
> clocks property should carry extclk0 for now.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> ---
>  arch/arm/boot/dts/dove-cubox.dts |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index ed2b7b2..f26d0d2 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -8,7 +8,7 @@
>  
>  	memory {
>  		device_type = "memory";
> -		reg = <0x00000000 0x40000000>;
> +		reg = <0x00000000 0x3f000000>;
>  	};
>  
>  	chosen {
> @@ -52,10 +52,24 @@
>  			#clock-cells = <0>;
>  		};
>  	};
> +
> +	video {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vcard: video-card {
> +			compatible = "marvell,dove-video-card";
> +			reg = <0x3f000000 0x1000000>;
> +			clocks = <&si5351 0>, <&si5351 0>;
> +		};
> +	};
>  };
>  
>  &uart0 { status = "okay"; };
>  &sata0 { status = "okay"; };
> +&lcd0 { status = "okay"; };
>  
>  &i2c0 {
>  	status = "okay";

May you explain a bit more this strange hack?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
