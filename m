From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Jan 2017 14:01:03 +0000
Subject: [PATCH v4 4/4] arm64: dts: juno: add missing CoreSight STM
 component
In-Reply-To: <5c742b98-0707-67fd-d8a1-467f34d99cdb@arm.com>
References: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
 <1484655313-9025-5-git-send-email-sudeep.holla@arm.com>
 <5c742b98-0707-67fd-d8a1-467f34d99cdb@arm.com>
Message-ID: <6473418b-95d5-5be3-47fd-4c554f353923@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/01/17 13:39, Suzuki K Poulose wrote:
> On 17/01/17 12:15, Sudeep Holla wrote:
>> From: Mike Leach <mike.leach@linaro.org>
>>
>> This patch adds the missing CoreSight STM component definition to the
>> device tree of all the juno variants(r0,r1,r2)
>>
>> STM component is connected to different funnels depending on Juno
>> platform variant.
>>
>> Reviewed-and-Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>> [sudeep.holla at arm.com: minor changelog update and reorganising the STM
>>     node back into juno-base.dtsi to avoid duplication]
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm64/boot/dts/arm/juno-base.dtsi | 15 +++++++++++++++
>>  arch/arm64/boot/dts/arm/juno-r1.dts    |  4 ++++
>>  arch/arm64/boot/dts/arm/juno-r2.dts    |  4 ++++
>>  arch/arm64/boot/dts/arm/juno.dts       | 16 ++++++++++++++++
>>  4 files changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> index faedf357db3b..58c1773c3aa4 100644
>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> @@ -185,6 +185,21 @@
>>          };
>>      };
>>
>> +    stm at 20100000 {
>> +        compatible = "arm,coresight-stm", "arm,primecell";
>> +        reg = <0 0x20100000 0 0x1000>,
>> +              <0 0x28000000 0 0x180000>;
> 
> The size of the stimulus base is 16MB (as per TRM), implies => 0x1000000.
> 

Fixed locally.

Mike,

Can you confirm ? I know TRM had some issues with size of other
coresight components.

> with that fixed :
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 

Thanks.

-- 
Regards,
Sudeep
