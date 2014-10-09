From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Oct 2014 21:56:30 +0200
Subject: [PATCH v4] ARM: sun7i: add support for A20-OLinuXino-Lime2
In-Reply-To: <54366326.3060303@gmail.com>
References: <54280AA7.1090401@gmail.com> <20140928164337.GB15315@lukather>
 <54295711.9010901@gmail.com> <20140929132543.GC4081@lukather>
 <54296D8B.3080304@gmail.com> <20141002124807.GC4039@lukather>
 <5431C8EF.3070809@gmail.com> <20141006092049.GF4090@lukather>
 <54366326.3060303@gmail.com>
Message-ID: <20141009195630.GJ19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iain,

On Thu, Oct 09, 2014 at 11:27:50AM +0100, Iain Paton wrote:
> This adds support for the Olimex A20-OLinuXino-Lime2
> https://www.olimex.com/Products/OLinuXino/A20/A20-OLinuXIno-LIME2
> 
> Differences to previous Lime boards are 1GB RAM and gigabit ethernet
> 
> Signed-off-by: Iain Paton <ipaton0@gmail.com>

Sorry for noticing this so late, but we sort the DT nodes by their
base address. Could you respin this for another version?

> ---
> 
> changes for v2
>  add axp209 regulators node
> 
> changes for v3
>  add reg_axp_ipsout regulator
>  follow suggestion by Chen-Yu in
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/292645.html
>   on parenting the regulators
> 
> changes for v4
>  give regulators better names
>  add spacing between nodes
>  drop ldo5 as it doesn't appear to be used
> 
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 229 ++++++++++++++++++++++++
>  2 files changed, 230 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2f42b18..ea6c672 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -420,6 +420,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
>  	sun7i-a20-olinuxino-lime.dtb \
> +	sun7i-a20-olinuxino-lime2.dtb \
>  	sun7i-a20-olinuxino-micro.dtb \
>  	sun7i-a20-pcduino3.dtb
>  dtb-$(CONFIG_MACH_SUN8I) += \
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> new file mode 100644
> index 0000000..4e68101
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -0,0 +1,229 @@
> +/*
> + * Copyright 2014 - Iain Paton <ipaton0@gmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this library; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +/include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
> +
> +/ {
> +	model = "Olimex A20-OLinuXino-LIME2";
> +	compatible = "olimex,a20-olinuxino-lime2", "allwinner,sun7i-a20";
> +
> +	soc at 01c00000 {
> +

And drop this newline while we're at it?

Thanks a lot,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141009/e0809c45/attachment.sig>
