From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 2 Dec 2015 13:34:20 -0500
Subject: [PATCH v3 5/7] ARM: dts: imx: Add support for Advantech/GE B450v3
In-Reply-To: <1447672792.3144.11.camel@pengutronix.de>
References: <1447178408-26982-1-git-send-email-akshay.bhat@timesys.com>
 <1447178408-26982-6-git-send-email-akshay.bhat@timesys.com>
 <1447672792.3144.11.camel@pengutronix.de>
Message-ID: <565F39AC.1010201@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/16/2015 06:19 AM, Lucas Stach wrote:
> Am Dienstag, den 10.11.2015, 13:00 -0500 schrieb Akshay Bhat:
>> Add support for Advantech/GE B450v3 board.
>>
>> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
>> ---
>>   arch/arm/boot/dts/Makefile         |  1 +
>>   arch/arm/boot/dts/imx6q-b450v3.dts | 75 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 76 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 30bbc37..b3330fe 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -310,6 +310,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>   	imx6dl-wandboard-revb1.dtb \
>>   	imx6q-apf6dev.dtb \
>>   	imx6q-arm2.dtb \
>> +	imx6q-b450v3.dtb \
>>   	imx6q-cm-fx6.dtb \
>>   	imx6q-cubox-i.dtb \
>>   	imx6q-dfi-fs700-m60.dtb \
>> diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
>> new file mode 100644
>> index 0000000..919e4a4
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6q-b450v3.dts
>> @@ -0,0 +1,75 @@
>> +/*
>> + * Copyright 2015 Timesys Corporation.
>> + * Copyright 2015 General Electric Company
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
>> +
>> +#include "imx6q-bx50v3.dtsi"
>> +
>> +/ {
>> +	model = "Advantech MX6Q B450V3 QSeven Board";
>> +	compatible = "ge,imx6q-b450v3", "advantech,imx6q-ba16", "fsl,imx6q";
>> +
>> +	chosen {
>> +		stdout-path = &uart3;
>> +	};
>> +};
>> +
>> +&ldb {
>> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
>> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
>> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
>> +				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
>> +	status = "okay";
>> +
>> +	lvds0: lvds-channel at 0 {
>> +		fsl,data-mapping = "spwg";
>> +		fsl,data-width = <24>;
>> +		status = "okay";
>> +
>> +		display-timings {
>> +			native-mode = <&timing0>;
>> +			timing0: G121X1-L03 {
>> +				clock-frequency = <65000000>;
>> +				hactive = <1024>;
>> +				vactive = <768>;
>> +				hback-porch = <320>;
>> +				hfront-porch = <0>;
>> +				vback-porch = <0>;
>> +				vfront-porch = <38>;
>> +				hsync-len = <1>;
>> +				vsync-len = <1>;
>> +			};
>> +		};
>
> Display timings in DT are deprecated and new boards should add the
> display with a specific compatible to the simple-panel driver and then
> link a panel node to the LVDS channels. Take a look at the i.MX6
> Nitrogen DTs for an example on how to do this.
>
> Same comment applies to the next patches as well.

Thanks for the example Lucas. Added G121X1-L03 panel which is now in 
linux-next 
(https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/panel?h=next-20151127&id=f8fa17ba812b7df1535f6bb75d7264670f5997a6)

v4 patch now uses simple-panel:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390373.html

>
>> +	};
>> +
>> +	lvds1: lvds-channel at 1 {
>> +		fsl,data-mapping = "spwg";
>> +		fsl,data-width = <24>;
>> +		status = "okay";
>> +
>> +		display-timings {
>> +			native-mode = <&timing1>;
>> +			timing1: G121X1-L03 {
>> +				clock-frequency = <65000000>;
>> +				hactive = <1024>;
>> +				vactive = <768>;
>> +				hback-porch = <320>;
>> +				hfront-porch = <0>;
>> +				vback-porch = <0>;
>> +				vfront-porch = <38>;
>> +				hsync-len = <1>;
>> +				vsync-len = <1>;
>> +			};
>> +		};
>> +	};
>> +
>> +};
>
