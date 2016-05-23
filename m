From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Tue, 24 May 2016 01:15:07 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: add support for the Utilite Pro
In-Reply-To: <9b24c4b30f424407902589fcc4598ec5@rwthex-w2-a.rwth-ad.de>
References: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
 <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
 <9b24c4b30f424407902589fcc4598ec5@rwthex-w2-a.rwth-ad.de>
Message-ID: <2d1541bdd75c48a593f0e180c411cd4b@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 05/23/2016 10:56 PM, Stefan Wahren wrote:
> Hi Christopher,
> 
>> christopher.spinrath at rwth-aachen.de hat am 23. Mai 2016 um 00:47 geschrieben:
>>
>>
>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>
>> The CompuLab Utilite Pro is a miniature fanless desktop pc based on
>> the i.MX6 Quad powered cm-fx6 module. It features two serial ports,
>> USB OTG, 4x USB, analog audio and S/PDIF, 2x Gb Ethernet, HDMI and
>> DVI ports, an on-board 32GB SSD, a mmc slot, and on-board wifi/bt.
>>
>> Add initial support for it including USB, Ethernet (both ports), sata
>> and HDMI support.
>>
>> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>> ---
>>  arch/arm/boot/dts/Makefile              |   1 +
>>  arch/arm/boot/dts/imx6q-utilite-pro.dts | 128
>> ++++++++++++++++++++++++++++++++
>>  2 files changed, 129 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx6q-utilite-pro.dts
>>
>> ...
>> diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> new file mode 100644
>> index 0000000..bcd8e0d
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> @@ -0,0 +1,128 @@
>> +/*
>> + * Copyright 2016 Christopher Spinrath
>> + * Copyright 2013 CompuLab Ltd.
>> + *
>> + * Based on the GPLv2 licensed devicetree distributed with the vendor
>> + * kernel for the Utilite Pro:
>> + *	Copyright 2013 CompuLab Ltd.
>> + *	Author: Valentin Raevsky <valentin@compulab.co.il>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> ...
>> +
>> +		pinctrl_uart2: uart2grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_GPIO_7__UART2_TX_DATA 0x1b0b1
>> +				MX6QDL_PAD_GPIO_8__UART2_RX_DATA 0x1b0b1
>> +				MX6QDL_PAD_SD4_DAT5__UART2_RTS_B 0x1b0b1
>> +				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B 0x1b0b1
>> +			>;
>> +		};
>> +	};
>> +};
>> +
>> +&pcie {
>> +	pcie at 0,0 {
>> +		reg = <0x000000 0 0 0 0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		/* non-removable i211 ethernet card */
>> +		eth1: intel,i211 at pcie0,0 {
>> +			reg = <0x010000 0 0 0 0>;
>> +		};
>> +	};
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart2>;
>> +	fsl,uart-has-rtscts;
> 
> this property is deprecated so please use the generic one:
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=1006ed7e1b258dac3e85c9fafe9d38b6020c917f
> 

Thanks for pointing that out. I will switch to the generic property.

Cheers,
Christopher

> Stefan
> 
>> +	dma-names = "rx", "tx";
>> +	dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
>> +	status = "okay";
>> +};
>> -- 
>> 2.8.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
