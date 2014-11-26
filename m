From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 26 Nov 2014 09:58:18 +0100
Subject: [PATCH 5/5] ARM: dts: sun6i: Add dts file for CSQ CS908 board
In-Reply-To: <20141125182147.GD25249@lukather>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
 <1416747283-13489-6-git-send-email-hdegoede@redhat.com>
 <20141125182147.GD25249@lukather>
Message-ID: <5475962A.4090508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/25/2014 07:21 PM, Maxime Ripard wrote:
> On Sun, Nov 23, 2014 at 01:54:43PM +0100, Hans de Goede wrote:
>> The CSQ CS908 is an A31s based top-set box, with 1G RAM, 8G NAND,
>> rtl8188etv usb wifi, 2 USB A receptacles (1 connected through the OTG
>> controller), ethernet, 3.5 mm jack with a/v out and hdmi out:
>>
>> http://www.geekbuying.com/item/CS908-Allwinner-A31S-Quad-Core-1-2GHz-Android-4-4-Mini-TV-Box-HDMI-HDD-Player-1G-8G-WIFI-Miracast---Black-333395.html
>>
>> Note it has no sdcard slot and therefore can only be fel booted.
>
> Thanks a lot for working on this!
>
> I also bought another board with an A31s, but it ended up having
> neither USB OTG or MMC, which rendered it pretty useless.

Are you sure ? The cs908 also does not have an otg connector,
as said it has 2 usb-a receptacles, with the following usb "routing":

usb0 (otg): usb-a receptacle 1 (labeled 1 on the box, 0 on the print)
usb1 (ehci): routed to internal wifi
usb2 (ehci): usb-a receptacle 2 (labeled 2 on both the box and the print)

I'm using fel mode with an usb-a <-> usb-a cable connected to usb0 on
the cs908. The cs908 has no fel button, so I've hooked up the serial console,
and then keep 2 pressed on the serial console while inserting the usb-a into
the PC (which will also power the board). boot0 from the nand will then jump
into fel mode when it sees the 2 keypress.

This was an interesting exercise to confirm that everything on the A31s just
works with A31 code, but now that is confirms A31s devices are not all that
interesting anymore :)

> I wonder wether to put URL in the commit log is the right thing
> though. It's most likely to be dead in a very near future. The cover
> letter would be a better fit for that.

Ok, I'll drop it from the commit message.

Regards,

Hans

>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/Makefile             |   3 +-
>>   arch/arm/boot/dts/sun6i-a31s-cs908.dts | 109 +++++++++++++++++++++++++++++++++
>>   2 files changed, 111 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/sun6i-a31s-cs908.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 8ebfa76..0c0201c 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -434,7 +434,8 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>>   	sun6i-a31-app4-evb1.dtb \
>>   	sun6i-a31-colombus.dtb \
>>   	sun6i-a31-hummingbird.dtb \
>> -	sun6i-a31-m9.dtb
>> +	sun6i-a31-m9.dtb \
>> +	sun6i-a31s-cs908.dtb
>>   dtb-$(CONFIG_MACH_SUN7I) += \
>>   	sun7i-a20-bananapi.dtb \
>>   	sun7i-a20-cubieboard2.dtb \
>> diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
>> new file mode 100644
>> index 0000000..48d3a70
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
>> @@ -0,0 +1,109 @@
>> +/*
>> + * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + *     You should have received a copy of the GNU General Public
>> + *     License along with this library; if not, write to the Free
>> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
>> + *     MA 02110-1301 USA
>
> s/library/file/
>
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "sun6i-a31s.dtsi"
>> +
>> +/ {
>> +	model = "CSQ CS908 top set box";
>
> Shouldn't it be Set Top Box instead?
>
>> +	compatible = "csq,cs908", "allwinner,sun6i-a31s";
>> +
>> +	chosen {
>> +		bootargs = "earlyprintk console=ttyS0,115200";
>> +	};
>> +
>> +	soc at 01c00000 {
>> +		usbphy: phy at 01c19400 {
>> +			status = "okay";
>> +		};
>> +
>> +		ehci0: usb at 01c1a000 {
>> +			status = "okay";
>> +		};
>> +
>> +		ehci1: usb at 01c1b000 {
>> +			status = "okay";
>> +		};
>> +
>> +		ohci1: usb at 01c1b400 {
>> +			status = "okay";
>> +		};
>> +
>> +		pio: pinctrl at 01c20800 {
>> +			usb1_vbus_pin_csq908: usb1_vbus_pin at 0 {
>> +				allwinner,pins = "PC27";
>> +				allwinner,function = "gpio_out";
>> +				allwinner,drive = <0>;
>> +				allwinner,pull = <0>;
>> +			};
>> +		};
>> +
>> +		uart0: serial at 01c28000 {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&uart0_pins_a>;
>> +			status = "okay";
>> +		};
>> +
>> +		gmac: ethernet at 01c30000 {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&gmac_pins_mii_a>;
>> +			phy = <&phy1>;
>> +			phy-mode = "mii";
>> +			status = "okay";
>> +
>> +			phy1: ethernet-phy at 1 {
>> +				reg = <1>;
>> +			};
>> +		};
>> +
>> +		ir at 01f02000 {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&ir_pins_a>;
>> +			status = "okay";
>> +		};
>> +	};
>> +};
>> --
>> 2.1.0
>>
>
