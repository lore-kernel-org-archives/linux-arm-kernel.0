From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Nov 2016 17:00:33 +0100
Subject: [PATCH v5 2/2] ARM: dts: add support for Turris Omnia
In-Reply-To: <87lgw7ilg9.fsf@free-electrons.com>
References: <20161125142658.21690-1-uwe@kleine-koenig.org>
 <20161125142658.21690-3-uwe@kleine-koenig.org>
 <87lgw7ilg9.fsf@free-electrons.com>
Message-ID: <a7f47999-ec83-6cc8-8119-0087dee17bac@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.11.2016 um 17:16 schrieb Gregory CLEMENT:
> On ven., nov. 25 2016, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:
>> This machine is an open hardware router by cz.nic driven by a
>> Marvell Armada 385.
>>
>> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> 
> Applied on mvebu/dt with few changes:
[...]
>> +&spi0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi0_pins &spi0cs0_pins>;
>> +	status = "okay";
>> +
>> +	spi-nor at 0 {
>> +		compatible = "spansion,s25fl164k", "jedec,spi-nor";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		reg = <0>;
>> +		spi-max-frequency = <40000000>;
>> +
> 
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> it is mandatory since v4.4 to use this pattern for partitions.
> 
> 
>> +		partition at 0 {
>> +			reg = <0x0 0x00100000>;
>> +			label = "U-Boot";
>> +		};
>> +
>> +		partition at 1 {
>                          @0x100000
> We should use the reg value here ^

The unit name should be without 0x though. In your tree you seem to have
it correctly.

@Uwe: Note that I had already told CZ.NIC's Michal ~two weeks ago that I
have a WIP .dts for the Omnia - looks like no one knows what the other
is doing. :( My branch includes cleanups for 385 .dtsi and bug fixes for
the switch that I am not seeing in your series:

https://github.com/afaerber/linux/commits/omnia-next

I am still looking into phy backtraces when the network interfaces go down.

@Gregory: Can we please follow up with cleaning up these ugly
internal-regs and pcie-controller nodes for consistency?

Regards,
Andreas

>> +			reg = <0x00100000 0x00700000>;
>> +			label = "Rescue system";
>> +		};
> 
> + };

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
