From: arnaud.ferraris.external@sigfox.com (Arnaud Ferraris)
Date: Thu, 5 Jul 2018 17:04:39 +0200
Subject: [PATCH] arm64: dts: marvell: a3700: reserve ATF memory
In-Reply-To: <87bmbl21fj.fsf@bootlin.com>
References: <1530801041-6909-1-git-send-email-arnaud.ferraris.external@sigfox.com>
 <87bmbl21fj.fsf@bootlin.com>
Message-ID: <a5e3843b-6400-f1e6-d675-f44b9954aabc@sigfox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 05/07/2018 16:37, Gregory CLEMENT wrote:

> A similar patch[1] was applied last week in mvebu/dt64 and should be in
> linux-next.

My bad, I forgot to check linux-next.

Thanks,

Arnaud

> But keep in mind that U-Boot is supposed to update the reg value to
> match your configuration.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/587408.html
>
> Thanks,
>
> Gregory
>
>> Signed-off-by: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
>> ---
>>   arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> index 3353252..2110e7d 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> @@ -34,6 +34,17 @@
>>   		};
>>   	};
>>   
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		arm-trusted-firmware at 4000000 {
>> +			no-map;
>> +			reg = <0x0 0x04000000 0x0 0x01000000>;
>> +		};
>> +	};
>> +
>>   	psci {
>>   		compatible = "arm,psci-0.2";
>>   		method = "smc";
>> -- 
>> 2.7.4
>>
>
