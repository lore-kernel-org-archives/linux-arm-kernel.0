From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 27 Jul 2017 17:09:02 +0100
Subject: [PATCH v3 5/6] dt-bindings: Document devicetree binding for ARM
 DSU PMU
In-Reply-To: <CAL_JsqLkeaMh8afWvYwca61OrX7QYzDt+eup_b3rQuyxumLwfw@mail.gmail.com>
References: <1501168218-26741-1-git-send-email-suzuki.poulose@arm.com>
 <1501168218-26741-6-git-send-email-suzuki.poulose@arm.com>
 <CAL_JsqLkeaMh8afWvYwca61OrX7QYzDt+eup_b3rQuyxumLwfw@mail.gmail.com>
Message-ID: <0df5b445-6bbe-03ba-c302-9e1d580e9228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/17 16:52, Rob Herring wrote:
> +DT list
>
> On Thu, Jul 27, 2017 at 10:10 AM, Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
>> This patch documents the devicetree bindings for ARM DSU PMU.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  .../devicetree/bindings/arm/arm-dsu-pmu.txt        | 27 ++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
>> new file mode 100644
>> index 0000000..b9935ac
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
>> @@ -0,0 +1,27 @@
>> +* ARM DynamIQ Shared Unit (DSU) Performance Monitor Unit (PMU)
>> +
>> +ARM DyanmIQ Shared Unit (DSU) integrates one or more CPU cores
>> +with a shared L3 memory system, control logic and external interfaces to
>> +form a multicore cluster. The PMU enables to gather various statistics on
>> +the operations of the DSU. The PMU provides independent 32bit counters that
>> +can count any of the supported events, along with a 64bit cycle counter.
>> +The PMU is accessed via CPU system registers and has no MMIO component.
>> +
>> +** DSU PMU required properties:
>> +
>> +- compatible   : should be one of :
>> +
>> +               "arm,dsu-pmu"
>
> Seems kind of generic. There's only one flavor is DSU?
>

Yes, there is only flavor. It is not something others can modify.
There could be different revisions of the product (in the future), but that
can be identified from the ID registers and can be handled accordingly.

>> +
>> +- interrupts   : Exactly 1 SPI must be listed.
>> +
>> +- cpus         : List of phandles for the CPUs connected to this DSU instance.
>> +
>> +
>> +** Example:
>> +
>> +dsu_pmu at 0 {
>
> Don't use "_" in node names and unit-address is not valid without a
> reg property.

Ok.

Thanks for the comments, I will fix them in the next version.

Suzuki
