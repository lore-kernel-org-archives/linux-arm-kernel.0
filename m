From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 19 Aug 2013 12:21:34 +0100
Subject: [PATCH v2] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <4698B009-124E-4D51-868B-336F80A7D7F8@codeaurora.org>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
 <4698B009-124E-4D51-868B-336F80A7D7F8@codeaurora.org>
Message-ID: <5211FFBE.2040002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

On 16/08/13 19:47, Kumar Gala wrote:
>
> On Aug 16, 2013, at 12:19 PM, Punit Agrawal wrote:
>
[...]
>>
>> 	Description: masters in the device tree connected to a CCI port
>> @@ -163,6 +197,16 @@ Example:
>> 			interface-type = "ace";
>> 			reg = <0x5000 0x1000>;
>> 		};
>> +
>> +		pmu at 9000 {
>> +			 compatible = "arm,cci-400-pmu,rev0";
>
> drop the ',rev0'
>

Missed this instance in the update. Now taken care of.

Will post the next (and hopefully last) version addressing Stephen's 
comments as well.

Can I use either your Acked-by or Reviewd-by with these changes in place?

Cheers,
Punit

>> +			 reg = <0x9000 0x5000>;
>> +			 interrupts = <0 101 4>,
>> +				      <0 102 4>,
>> +				      <0 103 4>,
>> +				      <0 104 4>,
>> +				      <0 105 4>;
>> +		};
>> 	};
>>
>> This CCI node corresponds to a CCI component whose control registers sits
>
> [snip]
>
> - k
>
