From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jan 2014 11:07:08 +0100
Subject: [PATCH] ARM: sun4i: dt: Add basic board support for LinkSprite
 pcDuino
In-Reply-To: <alpine.DEB.2.02.1401111509430.13932@trabant.deployis.eu>
References: <alpine.DEB.2.02.1401111509430.13932@trabant.deployis.eu>
Message-ID: <20140113100708.GY2941@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zoltan,

On Sat, Jan 11, 2014 at 04:54:52PM +0100, Zoltan HERPAI wrote:
> This patch will add a basic board support DT for the
> LinkSprite pcDuino.
> 
> Signed-off-by: Zoltan HERPAI <wigyori@uid0.hu>
> ---
>  arch/arm/boot/dts/Makefile              |    1 +
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts |   48 +++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-pcduino.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b663ed7..a2e3620 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -253,6 +253,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
>  	sun4i-a10-cubieboard.dtb \
>  	sun4i-a10-mini-xplus.dtb \
>  	sun4i-a10-hackberry.dtb \
> +	sun4i-a10-pcduino.dtb \
>  	sun5i-a10s-olinuxino-micro.dtb \
>  	sun5i-a13-olinuxino.dtb \
>  	sun5i-a13-olinuxino-micro.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> new file mode 100644
> index 0000000..752f002
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright 2014 Zoltan HERPAI
> + * Zoltan HERPAI <wigyori@uid0.hu>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun4i-a10.dtsi"
> +
> +/ {
> +	model = "LinkSprite pcDuino";
> +	compatible = "pcduino,a10-pcduino", "allwinner,sun4i-a10";

Is LinkSprite the retailer or the manufacturer?

If the former, it shouldn't appear in the model string, if the latter,
it should be the prefix in the compatible.

Otherwise, it looks very good, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/f47b7cb5/attachment.sig>
