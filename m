From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Tue, 09 Feb 2016 11:45:08 +0100
Subject: [PATCH v2 06/10] ARM64: dts: rockchip: Add IR receiver to
 GeekBox
In-Reply-To: <56B95827.7060204@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
 <1454897859-7601-7-git-send-email-afaerber@suse.de>
 <56B95827.7060204@suse.de>
Message-ID: <56B9C334.2070002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Le 09/02/2016 04:08, Andreas F?rber a ?crit :
> Am 08.02.2016 um 03:17 schrieb Andreas F?rber:
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>   v2: New
>>   
>>   arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
>> index e4523a74050f..e84383fd6f10 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
>> @@ -63,6 +63,13 @@
>>   		#clock-cells = <0>;
>>   	};
>>   
>> +	ir: ir-receiver {
>> +		compatible = "gpio-ir-receiver";
>> +		gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&ir_int>;
> 		status = "disabled";
>
> Should only be enabled in the new Landingship config. Will fix.
>
> Andreas
Actually there's two IR receivers:
- one on the geekbox module (on the bottom side)
- and another one on the landingship.

Both are connected to the same GPIO pin, so you can keep it enabled in 
the main geekbox dts.

About the pinctrl, same remark as for gpio-keys: there's already 
external pull-up resistors on this pin, so it should be better to use 
pcfg_pull_none instead of pcfg_pull_up.

Julien
>
> P.S. See Heiko, two bugs in the new nodes already, glad I have them
> separate. :)
>
>> +	};
>> +
>>   	leds: gpio-leds {
>>   		compatible = "gpio-leds";
>>   
> [snip]
>
