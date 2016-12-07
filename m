From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 7 Dec 2016 14:26:37 -0500
Subject: [PATCH V2 4/5] ARM: BCM5301X: Specify all RAM by including an
 extra block
In-Reply-To: <20161207075655.7396-4-zajec5@gmail.com>
References: <20161207075655.7396-1-zajec5@gmail.com>
 <20161207075655.7396-4-zajec5@gmail.com>
Message-ID: <20161207192624.GA25946@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 08:56:54AM +0100, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> The first 128 MiB of RAM can be accessed using an alias at address 0x0.
> 
> In theory we could access whole RAM using 0x80000000 - 0xbfffffff range
> (up to 1 GiB) but it doesn't seem to work on Northstar. For some reason
> (hardware setup left by the bootloader maybe?) 0x80000000 - 0x87ffffff
> range can't be used. I reproduced this problem on:
> 1) Buffalo WZR-600DHP2 (BCM47081)
> 2) Netgear R6250 (BCM4708)
> 3) D-Link DIR-885L (BCM47094)
> 
> So it seems we're forced to access first 128 MiB using alias at 0x0 and
> the rest using real base address + 128 MiB offset which is 0x88000000.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Acked-by: Jon Mason <jon.mason@broadcom.com>

> ---
> V2: Updated commit message, thanks Jon!
>     Included XWR-3100
> ---
>  arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        | 3 ++-
>  arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        | 3 ++-
>  arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 3 ++-
>  arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 3 ++-
>  arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 3 ++-
>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 3 ++-
>  arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 3 ++-
>  arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 3 ++-
>  arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  | 3 ++-
>  arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        | 3 ++-
>  arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  | 3 ++-
>  arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 3 ++-
>  arch/arm/boot/dts/bcm4709-netgear-r8000.dts        | 3 ++-
>  arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 3 ++-
>  arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      | 3 ++-
>  arch/arm/boot/dts/bcm47094-netgear-r8500.dts       | 3 ++-
>  16 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
> index 112a5a8..d241cee 100644
> --- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
> +++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> index 3600f56..b0e6204 100644
> --- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> +++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
> index d49afec0..c9ba6b9 100644
> --- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
> +++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x18000000>;
>  	};
>  
>  	spi {
> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> index 8519548..b9f66c0 100644
> --- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> index 6229ef2..ae0199f 100644
> --- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> index 74cfcd3..36b628b1 100644
> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> index 71b98cf..db8608b 100644
> --- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> +++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> index 2922536..d51586d 100644
> --- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> +++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	spi {
> diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
> index 184fd92..de041b8 100644
> --- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
> +++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	gpio-keys {
> diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
> index eac0f52..eaca687 100644
> --- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
> +++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
> index aab39c9..b32957c 100644
> --- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
> +++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x18000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> index 7ab1176..f459a98 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> index 56d38a3..cd13534 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> index 7fb9270..64ded76 100644
> --- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> +++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> @@ -21,7 +21,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	nand: nand at 18028000 {
> diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> index 93cc91d..5cf4ab1 100644
> --- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> +++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> @@ -18,7 +18,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> index 7ecd57c..600795e 100644
> --- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> +++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> @@ -18,7 +18,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x18000000>;
>  	};
>  
>  	leds {
> -- 
> 2.10.1
> 
