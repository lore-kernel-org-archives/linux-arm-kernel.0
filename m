From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 26 May 2016 11:50:12 +0300
Subject: [PATCH 1/2] ARM: dts: imx6q: extend support for the cm-fx6
In-Reply-To: <1463994191.2370.3.camel@pengutronix.de>
References: <709d6b3d522f4fcb8112830e0426dbb3@rwthex-s1-b.rwth-ad.de>
 <1463994191.2370.3.camel@pengutronix.de>
Message-ID: <5746B8C4.6020406@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

Thanks for reviewing the patch(es).

On 05/23/2016 12:03 PM, Lucas Stach wrote:
> Am Montag, den 23.05.2016, 00:47 +0200 schrieb
> christopher.spinrath at rwth-aachen.de:
>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

[...]

>> +&ecspi1 {
>> +	fsl,spi-num-chipselects = <2>;
>> +	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi1>;
>> +	status = "okay";
>> +
>> +	flash: m25p80 at 0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "st,m25p", "jedec,spi-nor";
>> +		spi-max-frequency = <20000000>;
>> +		reg = <0>;
>> +
>> +		partition at 0 {
>> +			label = "uboot";
>> +			reg = <0x0 0xc0000>;
>> +		};
>> +
>> +		partition at c0000 {
>> +			label = "uboot environment";
>> +			reg = <0xc0000 0x40000>;
>> +		};
>> +
>> +		partition at 100000 {
>> +			label = "reserved";
>> +			reg = <0x100000 0x100000>;
>> +		};
> 
> Partition layouts don't belong in the upstream DT, as it a device
> configuration thing. Please kep them in the bootloader/firmware and make
> this one pass the partition layout to the kernel.

I don't completely agree with this.
We have lots of partition layouts in the upstream DT.
Moreover, this is the default layout and changing it, will
result in incompatibilities and also might result in device "bricking".
Those can be changed from the boot loader in case you need those
the other way around.
Another question of mine is, why should you?


-- 
Regards,
Igor.
