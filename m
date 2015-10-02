From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Oct 2015 18:33:48 +0200
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <yw1xoaghl099.fsf@unicorn.mansr.com>
References: <560EAA7C.3070302@free.fr> <yw1xoaghl099.fsf@unicorn.mansr.com>
Message-ID: <560EB1EC.3020403@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2015 18:10, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
>> new file mode 100644
>> index 000000000000..7336fcc3ac1d
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tango4.dtsi
>
> Once more with feeling, why don't you want to use the fine clock driver
> I wrote?

I'll send you my clock tree driver next week. Then we can discuss.

>> +		uart0 {
>> +			compatible = "ralink,rt2880-uart";
>> +			reg = <0x10700 0x100>;
>> +			clock-frequency = <7372800>;
>> +			reg-shift = <2>;
>> +/*			fifo-size = <16>; BROKEN */
> 
> Either fix whatever is broken or drop that line.

I can't leave TODO reminders in the platform Kconfig?
Even as comments?

>> +		};
>> +
>> +		eth0: eth0 {
>> +			compatible = "sigma,smp8640-emac";
>> +			reg = <0x26000 0x800>;
>> +			interrupts = <38 4>;
>> +			interrupt-parent = <&irq0>;
>> +			mac-address = [ 00 16 e8 02 08 42 ];
> 
> mac-address should not be hardcoded here or anywhere else.

Sorry. I missed that in my clean up.

>> +			clocks = <&sysclk>;
>> +		};
>> +
>> +		intc: intc at e000 {
>> +			compatible = "sigma,tango-intc";
> 
> Why do you insist on using other names than the ones I've been using for
> months?  Just want to leave your own mark on the code?

You're using "sigma,smp8640-intc".
The SMP8640 is a Tango3 (MIPS-based) platform.
It makes no sense to have references to Tango3 in tango4.dtsi
Aside from the CPU difference, Tango3 and Tango4 have a lot in common though.

Which reminds me that I forgot to change "sigma,smp8640-emac"
I'll send an updated patch.

Regards.
