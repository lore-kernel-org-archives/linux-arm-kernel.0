From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 08 Oct 2016 17:24:38 +0200
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Add rk3066 MK808 board
In-Reply-To: <c5ca69d3-698a-5ef4-623b-204c2a50c28f@rock-chips.com>
References: <cover.1475774981.git.paweljarosz3691@gmail.com>
 <2320435.WKGs9crzlB@phil>
 <c5ca69d3-698a-5ef4-623b-204c2a50c28f@rock-chips.com>
Message-ID: <6652929.xB7y1bpV6i@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 8. Oktober 2016, 11:01:08 schrieb Shawn Lin:
> ? 2016/10/7 18:01, Heiko Stuebner ??:
> > Am Freitag, 7. Oktober 2016, 10:29:48 CEST schrieb Shawn Lin:
> >> Hi Pawe? ,
> >> 
> >> On 2016/10/7 1:38, Pawe? Jarosz wrote:
> >>> MK808 is a tv stick which has rockchip rk3066 CPU inside, two usb ports
> >>> - host and otg, micro sd card slot and onboard wifi RK901.
> >>> 
> >>> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
> >>> ---
> >>> 
> >>> Changes in v2:
> >>> - included Heiko sugestion.
> >>> 
> >>>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
> >>>  arch/arm/boot/dts/Makefile                         |   1 +
> >>>  arch/arm/boot/dts/rk3066a-mk808.dts                | 184
> >>>  +++++++++++++++++++++ 3 files changed, 189 insertions(+)
> >>>  create mode 100644 arch/arm/boot/dts/rk3066a-mk808.dts
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> >>> b/Documentation/devicetree/bindings/arm/rockchip.txt index
> >>> 55f388f..c09595b 100644
> >>> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> >>> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> >>> @@ -17,6 +17,10 @@ Rockchip platforms device tree bindings
> >>> 
> >>>      Required root node properties:
> >>>        - compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
> >>> 
> >>> +- Rikomagic MK808 v1 board:
> >>> +    Required root node properties:
> >>> +      - compatible = "rikomagic,mk808", "rockchip,rk3066a";
> >>> +
> >>> 
> >>>  - Radxa Rock board:
> >>>      Required root node properties:
> >>>        - compatible = "radxa,rock", "rockchip,rk3188";
> >>> 
> >>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>> index befcd26..f19cc1d 100644
> >>> --- a/arch/arm/boot/dts/Makefile
> >>> +++ b/arch/arm/boot/dts/Makefile
> >>> @@ -639,6 +639,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
> >>> 
> >>>  	rk3036-kylin.dtb \
> >>>  	rk3066a-bqcurie2.dtb \
> >>>  	rk3066a-marsboard.dtb \
> >>> 
> >>> +	rk3066a-mk808.dtb \
> >>> 
> >>>  	rk3066a-rayeager.dtb \
> >>>  	rk3188-radxarock.dtb \
> >>>  	rk3228-evb.dtb \
> >>> 
> >>> diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts
> >>> b/arch/arm/boot/dts/rk3066a-mk808.dts new file mode 100644
> >>> index 0000000..2878562
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/rk3066a-mk808.dts
> >>> @@ -0,0 +1,184 @@
> >>> +/*
> >>> + * Copyright (c) 2016 Pawe? Jarosz <paweljarosz3691@gmail.com>
> >>> + *
> >>> + * This file is dual-licensed: you can use it either under the terms
> >>> + * of the GPL or the X11 license, at your option. Note that this dual
> >>> + * licensing only applies to this file, and not this project as a
> >>> + * whole.
> >>> + *
> >>> + *  a) This file is free software; you can redistribute it and/or
> >>> + *     modify it under the terms of the GNU General Public License as
> >>> + *     published by the Free Software Foundation; either version 2 of
> >>> the
> >>> + *     License, or (at your option) any later version.
> >>> + *
> >>> + *     This file is distributed in the hope that it will be useful,
> >>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + *     GNU General Public License for more details.
> >>> + *
> >>> + * Or, alternatively,
> >>> + *
> >>> + *  b) Permission is hereby granted, free of charge, to any person
> >>> + *     obtaining a copy of this software and associated documentation
> >>> + *     files (the "Software"), to deal in the Software without
> >>> + *     restriction, including without limitation the rights to use,
> >>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> >>> + *     sell copies of the Software, and to permit persons to whom the
> >>> + *     Software is furnished to do so, subject to the following
> >>> + *     conditions:
> >>> + *
> >>> + *     The above copyright notice and this permission notice shall be
> >>> + *     included in all copies or substantial portions of the Software.
> >>> + *
> >>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>> + *     OTHER DEALINGS IN THE SOFTWARE.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +#include "rk3066a.dtsi"
> >>> +
> >>> +/ {
> >>> +	model = "Rikomagic MK808";
> >>> +	compatible = "rikomagic,mk808", "rockchip,rk3066a";
> >>> +
> >>> +	chosen {
> >>> +		stdout-path = "serial2:115200n8";
> >>> +	};
> >>> +
> >>> +	memory at 60000000 {
> >>> +		device_type = "memory";
> >>> +		reg = <0x60000000 0x40000000>;
> >>> +	};
> >>> +
> >>> +	gpio-leds {
> >>> +		compatible = "gpio-leds";
> >>> +
> >>> +		blue {
> >>> +			label = "mk808:blue:power";
> >>> +			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
> >>> +			default-state = "off";
> >>> +			linux,default-trigger = "default-on";
> >>> +		};
> >>> +	};
> >>> +
> >>> +	mmc_pwrseq: mmc-pwrseq {
> >>> +		compatible = "mmc-pwrseq-simple";
> >>> +		pinctrl-names = "default";
> >>> +		pinctrl-0 = <&sdmmc_pwr>;
> >> 
> >> sd slot does not contain a reset pin. So the power pin should be
> >> enough. just add sdmmc_pwr to mmc0's pinctrl-0 and let mmc driver
> >> control it should be enough. Typically pwrseq is for emmc and sdio.
> >> We don't need a pwerseq to control power for sd slot..
> >> 
> >> But it seems sdmmc_pwr is a GPIO, but not functional port.
> >> So I am interesting that why MK808 board doesn't use the mmc
> >> controller's default power pin but chosing another gpio, so finally
> >> we have to add thses code for your DT.
> > 
> > Actually, we always model the sd-mmc pwr-pin as gpio-based regulator (see
> > sdmmc-regulator for example in the rk3066a-rayeager.dts), and specifiy
> > this
> > regulator as vmmc. That way the mmc core really can control the power.
> 
> yes it did. There are two ways for us to control vmmc properly.
> If we use gpio-based regulator or PMIC, mmc core take over it
> to control the power correctly. But if we use the dafault functional
> port, namely SDMMC_PWREN, the dw_mmc driver could handle the control
> when doing set_ios.. Both of these two could work fine. But I always
> chose the latter one to simplify the dts.
> 
> Anyway, I won't insist on it if it looks okay to you. :)

yes, I'd really prefer the mmc subsystem explicitly controlling the cards 
power via a regulator :-) .


Heiko
