From: anurupvasu@gmail.com (Anurup M)
Date: Thu, 12 Jan 2017 11:27:50 +0530
Subject: [PATCH v3 02/10] dt-bindings: hisi: Add Hisilicon HiP05/06/07
 Djtag dts bindings
In-Reply-To: <20170110174515.GC24036@leverpostej>
References: <1483339743-23881-1-git-send-email-anurup.m@huawei.com>
 <20170103225623.ynhc7n267jpzu44z@rob-hp-laptop> <586DD28E.5050500@gmail.com>
 <20170110174515.GC24036@leverpostej>
Message-ID: <58771ADE.6060509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 10 January 2017 11:15 PM, Mark Rutland wrote:
> On Thu, Jan 05, 2017 at 10:28:54AM +0530, Anurup M wrote:
>>
>> On Wednesday 04 January 2017 04:26 AM, Rob Herring wrote:
>>> On Mon, Jan 02, 2017 at 01:49:03AM -0500, Anurup M wrote:
>>>> From: Tan Xiaojun <tanxiaojun@huawei.com>
>>>>
>>>> Add Hisilicon HiP05/06/07 Djtag dts bindings for CPU and IO Die
>>>>
>>>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>>>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>>>> ---
>>>>   .../devicetree/bindings/arm/hisilicon/djtag.txt    | 41 ++++++++++++++++++++++
>>>>   1 file changed, 41 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>>>> new file mode 100644
>>>> index 0000000..bbe8b45
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>>>> @@ -0,0 +1,41 @@
>>>> +The Hisilicon Djtag is an independent component which connects with some other
>>>> +components in the SoC by Debug Bus. The djtag is available in CPU and IO dies
>>>> +in the chip. The djtag controls access to connecting modules of CPU and IO
>>>> +dies.
>>>> +The various connecting components in CPU die (like L3 cache, L3 cache PMU etc.)
>>>> +are accessed by djtag during real time debugging. In IO die there are connecting
>>>> +components like RSA. These components appear as devices attached to djtag bus.
>>>> +
>>>> +Hisilicon HiP05/06/07 djtag for CPU and IO die
>>>> +Required properties:
>>>> +  - compatible : The value should be as follows
>>>> +	(a) "hisilicon,hip05-djtag-v1" for CPU and IO die which use v1 hw in
>>>> +	    HiP05 chipset.
>>> You don't need to distinguish the CPU and IO blocks?
>> The CPU and IO djtag nodes will have different base address(in reg
>> property).
>> There is no difference in handling of CPU and IO dies in the djtag driver.
>> So there is currently no need to distinguish them.
> It may still make sense to distinuguish them, even if the current djtag
> driver can handle them the same. Presumably clients of the djtag driver
> will poke CPU and IO djtag units differently.

Ok. I shall add "-cpu-/-io-" in the compatible field to distinguish. 
e.g. "hisilicon,hip05-cpu-djtag-v1".

Thanks,
Anurup

> Thanks,
> Mark.
