From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Jan 2018 20:08:31 +0000
Subject: [PATCH 1/3] ARM: dts: enable L2 cache parity and ecc on
 db-xc3-24g4xg board
References: <20180108223158.21930-1-chris.packham@alliedtelesis.co.nz>
 <20180108223158.21930-2-chris.packham@alliedtelesis.co.nz>
 <87y3l66s0r.fsf@free-electrons.com>
Message-ID: <236e468acaef47d6847809d09a88ee06@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 10/01/18 21:24, Gregory CLEMENT wrote:
> Hi Chris,
> 
>   On mar., janv. 09 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> 
> Could you have add a (even small) message in the commit log?
> 
> Also could you improve the title by specify that it applies on
> armada-xp, like this:
> 
> ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
>

Will do.

>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>   arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
>> index 06fce35d7491..00ca489fc788 100644
>> --- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
>> +++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
>> @@ -70,6 +70,11 @@
>>   	};
>>   };
>>   
>> +&L2 {
>> +	arm,parity-enable;
>> +	marvell,ecc-enable;
> 
> It is not a problem for me to already applied the device tree change
> even if the driver is not merged yet. But I would like to have an
> acked-by on this new property by either a device tree maintainer or at
> least the EDAC maintainer, of course having both acked-by would be
> perfect ! :)

Thanks, I was hoping you would say that. That way I can keep this 
independent of the EDAC driver changes.

> 
> Thanks,
> 
> Gregory
> 
> 
> 
> 
>> +};
>> +
>>   &devbus_bootcs {
>>   	status = "okay";
>>   
>> -- 
>> 2.15.1
>>
> 
