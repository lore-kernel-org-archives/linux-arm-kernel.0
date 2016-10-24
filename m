From: dingtianhong@huawei.com (Ding Tianhong)
Date: Mon, 24 Oct 2016 13:46:33 +0800
Subject: [PATCH 1/3] arm64: arch_timer: Add device tree binding for
 hisilicon-161x01 erratum
In-Reply-To: <20161023120423.GO30578@tiger>
References: <962ea92f-870b-e1d0-5bb7-1a6d66c35122@huawei.com>
 <20161023120423.GO30578@tiger>
Message-ID: <f1d3b4bb-e3ba-3cdf-69d5-46c8487a5a7f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/23 20:04, Shawn Guo wrote:
> On Sun, Oct 23, 2016 at 11:21:10AM +0800, Ding Tianhong wrote:
>> This erratum describes a bug in logic outside the core, so MIDR can't be
>> used to identify its presence, and reading an SoC-specific revision
>> register from common arch timer code would be awkward.  So, describe it
>> in the device tree.
>>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/arm/arch_timer.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
>> index ef5fbe9..26bc837 100644
>> --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
>> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
>> @@ -31,6 +31,12 @@ to deliver its interrupts via SPIs.
>>    This also affects writes to the tval register, due to the implicit
>>    counter read.
>>
>> +- hisilicon,erratum-161x01 : A boolean property. Indicates the presence of
>> +  QorIQ erratum 161201, which says that reading the counter is
> 
> QorIQ is a Freescale/NXP specific name, and shouldn't be there.
> 
> Shawn
> 

Got it, will wait other feedback and fix them together, thanks.

Ding

>> +  unreliable unless the small range of value is returned by back-to-back reads.
>> +  This also affects writes to the tval register, due to the implicit
>> +  counter read.
>> +
>>  ** Optional properties:
>>
>>  - arm,cpu-registers-not-fw-configured : Firmware does not initialize
>> -- 
>> 1.9.0
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 
