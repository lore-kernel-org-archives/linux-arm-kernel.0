From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 14:29:58 -0800
Subject: [PATCH 2/2] ARM64: dts: meson-gxm-rbox-pro: Enable Bluetooth
In-Reply-To: <20170117030611.23827-3-afaerber@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?=
 message of "Tue, 17 Jan 2017 04:06:11 +0100")
References: <20170117030611.23827-1-afaerber@suse.de>
 <20170117030611.23827-3-afaerber@suse.de>
Message-ID: <m2y3y8xaqh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Add an SDIO reset GPIO and enable the serial used by the AP6255
> Bluetooth module. Based on work by Martin Blumenstingl.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> index 9f04fa4e5aec..6ea225f584bd 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> @@ -58,6 +58,7 @@
>  
>  	aliases {
>  		serial0 = &uart_AO;
> +		serial1 = &uart_A;
>  	};
>  
>  	chosen {
> @@ -122,7 +123,8 @@
>  
>  	sdio_pwrseq: sdio-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
> -		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>,
> +				<&gpio GPIOX_17 GPIO_ACTIVE_LOW>;
>  		clocks = <&wifi32k>;
>  		clock-names = "ext_clock";

c.f. thread on Martin's series.   I don't like this (ab)use of
reset-gpios for sdio-pwrseq, and there's some work coming that will make
this much cleaner.

So, I'll hold off on this until the other solution is ready.

Kevin 
