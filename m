From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Apr 2017 21:14:59 -0700
Subject: [PATCH] ARM: dts: Add devicetree for the Raspberry Pi 3, for
 arm32 (v5)
In-Reply-To: <20170424200037.25615-1-eric@anholt.net>
References: <20170424200037.25615-1-eric@anholt.net>
Message-ID: <881bbae2-9add-051d-74df-518a2e7db4d1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/24/2017 01:00 PM, Eric Anholt wrote:
> Raspbian and Fedora have decided to support the Pi3 in 32-bit mode for
> now, so it's useful to be able to test that mode on an upstream
> kernel.  It's also been useful for me to use the same board for 32-bit
> and 64-bit development.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm/boot/dts/Makefile            | 1 +
>  arch/arm/boot/dts/bcm2837-rpi-3.b.dts | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3.b.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 011808490fed..eded842d9978 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -72,6 +72,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2835-rpi-b-plus.dtb \
>  	bcm2835-rpi-a-plus.dtb \
>  	bcm2836-rpi-2-b.dtb \
> +	bcm2837-rpi-3-b.dtb \
>  	bcm2835-rpi-zero.dtb
>  dtb-$(CONFIG_ARCH_BCM_5301X) += \
>  	bcm4708-asus-rt-ac56u.dtb \
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3.b.dts b/arch/arm/boot/dts/bcm2837-rpi-3.b.dts
> new file mode 100644
> index 000000000000..8c8aa4d1e9b3
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3.b.dts
> @@ -0,0 +1 @@
> +#include "arm64/broadcom/bcm2837-rpi-3.b.dts"

Sounds like this should be
../arm64/boot/dts/broadcom/bcm2837-rpi-3.b.dts are reported by the
kbuild test robot?
-- 
Florian
