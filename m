From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 1 Dec 2016 13:59:36 -0500
Subject: [PATCH dt V2] ARM: BCM5301X: Enable UART by default for
 BCM4708(1), BCM4709(4) & BCM53012
In-Reply-To: <20161201174051.4965-1-zajec5@gmail.com>
References: <20161128140134.25128-1-zajec5@gmail.com>
 <20161201174051.4965-1-zajec5@gmail.com>
Message-ID: <20161201185914.GA4149@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 06:40:51PM +0100, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Every device tested so far got UART0 (at 0x18000300) working as serial
> console. It's most likely part of reference design and all vendors use
> it that way.
> 
> It seems to be easier to enable it by default and just disable it if we
> ever see a device with different hardware design.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Looks good to me!

Acked-by: Jon Mason <jon.mason@broadcom.com>

> ---
> V2: Update bcm94708.dts bcm94709.dts bcm953012er.dts & bcm953012k.dts
> ---
>  arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 4 ----
>  arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       | 4 ----
>  arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       | 4 ----
>  arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 4 ----
>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 4 ----
>  arch/arm/boot/dts/bcm4708.dtsi                     | 4 ++++
>  arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 4 ----
>  arch/arm/boot/dts/bcm47081.dtsi                    | 4 ++++
>  arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 4 ----
>  arch/arm/boot/dts/bcm4709-netgear-r8000.dts        | 4 ----
>  arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 4 ----
>  arch/arm/boot/dts/bcm4709.dtsi                     | 1 +
>  arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 4 ----
>  arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      | 4 ----
>  arch/arm/boot/dts/bcm47094-netgear-r8500.dts       | 4 ----
>  arch/arm/boot/dts/bcm47094.dtsi                    | 1 +
>  arch/arm/boot/dts/bcm94708.dts                     | 4 ----
>  arch/arm/boot/dts/bcm94709.dts                     | 4 ----
>  arch/arm/boot/dts/bcm953012er.dts                  | 4 ----
>  arch/arm/boot/dts/bcm953012k.dts                   | 1 -
>  20 files changed, 10 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
> index 9cb186e..d49afec0 100644
> --- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
> +++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
> @@ -136,10 +136,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &usb2 {
>  	vcc-gpio = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> index 35e6ed6..f591b0f 100644
> --- a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> +++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> @@ -55,10 +55,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &spi_nor {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> index 1c7e53d..50d65d8 100644
> --- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> +++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> @@ -56,10 +56,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &spi_nor {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> index 8ce39d5..8519548 100644
> --- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> @@ -83,10 +83,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &usb3 {
>  	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> index 70f4bb9..74cfcd3 100644
> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> @@ -119,10 +119,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &spi_nor {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
> index eed4dd1..d0eec09 100644
> --- a/arch/arm/boot/dts/bcm4708.dtsi
> +++ b/arch/arm/boot/dts/bcm4708.dtsi
> @@ -34,3 +34,7 @@
>  	};
>  
>  };
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> index a9c8def..2922536 100644
> --- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> +++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> @@ -122,7 +122,3 @@
>  		};
>  	};
>  };
> -
> -&uart0 {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/bcm47081.dtsi b/arch/arm/boot/dts/bcm47081.dtsi
> index f720012..c5f7619 100644
> --- a/arch/arm/boot/dts/bcm47081.dtsi
> +++ b/arch/arm/boot/dts/bcm47081.dtsi
> @@ -24,3 +24,7 @@
>  		};
>  	};
>  };
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> index fd38d2a..0225d82 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> @@ -100,7 +100,3 @@
>  		};
>  	};
>  };
> -
> -&uart0 {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> index 92f8a72..56d38a3 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> @@ -107,10 +107,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &usb2 {
>  	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
> index 9a92c24..c67bfaa 100644
> --- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
> +++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
> @@ -97,10 +97,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &usb2 {
>  	vcc-gpio = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm/boot/dts/bcm4709.dtsi b/arch/arm/boot/dts/bcm4709.dtsi
> index f039765..c645fea 100644
> --- a/arch/arm/boot/dts/bcm4709.dtsi
> +++ b/arch/arm/boot/dts/bcm4709.dtsi
> @@ -8,4 +8,5 @@
>  
>  &uart0 {
>  	clock-frequency = <125000000>;
> +	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> index 661348d..7fb9270 100644
> --- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> +++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> @@ -105,10 +105,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &usb3 {
>  	vcc-gpio = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> index 169b35f..2f4a651 100644
> --- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> +++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> @@ -98,10 +98,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &usb3 {
>  	vcc-gpio = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> index 521b415..7ecd57c 100644
> --- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> +++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> @@ -97,7 +97,3 @@
>  		};
>  	};
>  };
> -
> -&uart0 {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/bcm47094.dtsi
> index 4f09aa0..4840a78 100644
> --- a/arch/arm/boot/dts/bcm47094.dtsi
> +++ b/arch/arm/boot/dts/bcm47094.dtsi
> @@ -14,4 +14,5 @@
>  
>  &uart0 {
>  	clock-frequency = <125000000>;
> +	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/bcm94708.dts
> index 251a486..42855a7 100644
> --- a/arch/arm/boot/dts/bcm94708.dts
> +++ b/arch/arm/boot/dts/bcm94708.dts
> @@ -50,7 +50,3 @@
>  		reg = <0x00000000 0x08000000>;
>  	};
>  };
> -
> -&uart0 {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/bcm94709.dts b/arch/arm/boot/dts/bcm94709.dts
> index b16cac9..95e8be6 100644
> --- a/arch/arm/boot/dts/bcm94709.dts
> +++ b/arch/arm/boot/dts/bcm94709.dts
> @@ -50,7 +50,3 @@
>  		reg = <0x00000000 0x08000000>;
>  	};
>  };
> -
> -&uart0 {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/bcm953012er.dts
> index 0a9abec..decd86b 100644
> --- a/arch/arm/boot/dts/bcm953012er.dts
> +++ b/arch/arm/boot/dts/bcm953012er.dts
> @@ -70,10 +70,6 @@
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &spi_nor {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
> index 05a985a..bfd9230 100644
> --- a/arch/arm/boot/dts/bcm953012k.dts
> +++ b/arch/arm/boot/dts/bcm953012k.dts
> @@ -54,7 +54,6 @@
>  
>  &uart0 {
>  	clock-frequency = <62499840>;
> -	status = "okay";
>  };
>  
>  &uart1 {
> -- 
> 2.10.1
> 
