From: valentin@compulab.co.il (Valentin Raevsky)
Date: Sun, 27 Oct 2013 16:24:08 +0200
Subject: [PATCH] ARM: dts: Add initial support for cm-fx6
In-Reply-To: <20131021050610.GA9716@S2101-09.ap.freescale.net>
References: <1381848564-29839-1-git-send-email-valentin@compulab.co.il>
 <20131021050610.GA9716@S2101-09.ap.freescale.net>
Message-ID: <526D2208.9020404@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2013 08:06 AM, Shawn Guo wrote:
> On Tue, Oct 15, 2013 at 05:49:24PM +0300, Valentin Raevsky wrote:
>> Add initial support for cm-fx6 module.
>>
>> cm-fx6 is a module based on mx6q SoC with the following features:
>> - Up to 4GB of DDR3
>> - 1 LCD/DVI output port
>> - 1 HDMI output port
>> - 2 LVDS LCD ports
>> - Gigabit Ethernet
>> - Analog Audio
>> - CAN
>> - SATA
>> - NAND
>> - PCIE
>>
>> This patch allows to boot up the module, configures the serial console,
>> the Ethernet adapter and the hearbeat led.
>>
>> Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
>> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>   arch/arm/boot/dts/cm-fx6.dts |   51 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/cm-fx6.dts
>
> Please name the file with 'imx6q-' prefix, and add dtb target into
> arch/arm/boot/dts/Makefile.

thatnks, got it. will be in v2.

>
>>
>> diff --git a/arch/arm/boot/dts/cm-fx6.dts b/arch/arm/boot/dts/cm-fx6.dts
>> new file mode 100644
>> index 0000000..1080215
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/cm-fx6.dts
>> @@ -0,0 +1,51 @@
>> +/*
>> + * Copyright 2013 CompuLab Ltd.
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/dts-v1/;
>> +#include "imx6q.dtsi"
>> +
>> +/ {
>> +	model = "CompuLab CM-FX6";
>> +	compatible = "compulab,cm-fx6", "fsl,imx6q";
>> +
>> +	memory {
>> +		reg = <0x10000000 0x80000000>;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		debug-led {
>> +			label = "Heartbeat";
>> +			gpios = <&gpio2 31 0>;
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +	};
>> +};
>> +
>> +&gpmi {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpmi_nand_1>;
>> +	status = "okay";
>> +};
>> +
>> +&fec {
>
> Please sort the nodes alphabetically in label names.

got it. will be in v2.

>
> Shawn
>
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet_1>;
>> +	phy-mode = "rgmii";
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart4_1>;
>> +	status = "okay";
>> +};
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
