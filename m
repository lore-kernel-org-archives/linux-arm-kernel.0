From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Mon, 4 Apr 2016 16:40:33 -0700
Subject: [PATCH 2/4] Documentation: Add documentation for APM X-Gene SoC
 PMU DTS binding
In-Reply-To: <20160401123000.GC29876@leverpostej>
References: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
 <1459467472-31561-3-git-send-email-ttnguyen@apm.com>
 <20160401123000.GC29876@leverpostej>
Message-ID: <CACgAJHyS+o_Nyrc7pDxVCTHK7tue9L9F2weGQt_2WqeGfZBeag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Apr 1, 2016 at 5:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> As per Documentation/devicetree/bindings/submitting-patches.txt, please
> put binding patches earlier in a series than the code using them.
>
> On Thu, Mar 31, 2016 at 04:37:50PM -0700, Tai Nguyen wrote:
>> Documentation: Add documentation for APM X-Gene SoC PMU DTS binding
>>
>> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
>> ---
>>  .../devicetree/bindings/perf/apm-xgene-pmu.txt     | 116 +++++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt b/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
>> new file mode 100644
>> index 0000000..40dfd4e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
>> @@ -0,0 +1,116 @@
>> +* APM X-Gene SoC PMU bindings
>> +
>> +This is APM X-Gene SoC PMU (Performance Monitoring Unit) module.
>> +The following PMU devices are supported:
>> +
>> +  L3C                        - L3 cache controller
>> +  IOB                        - IO bridge
>> +  MCB                        - Memory controller bridge
>> +  MC                 - Memory controller
>
> These sound like separate units. How do these relate?
>
> Is there an SOC-wide PMU that aggregates counters, or are these actually
> independent?
>

Yes, they are independent, but sharing the same top level status interrupt.
There's no SOC-wide PMU which aggregates these counters.

>> +
>> +The following section describes the SoC PMU DT node binding.
>> +
>> +Required properties:
>> +- compatible         : Shall be "apm,xgene-pmu" for revision 1 or
>> +                          "apm,xgene-pmu-v2" for revision 2.
>
> That name is very general. Is there not a more specific name for the SOC
> PMU?
>

Beside the ARMv8 core PMU which has the compatible name "arm,armv8-pmuv3",
these are all the PMUs in X-Gene SoCs. Also, we are using the same PMU
driver across our platforms. I think a general name is what it should be.

>> +Required properties for L3C subnode:
>> +- compatible         : Shall be "apm,xgene-pmu-l3c".
>> +- reg                        : First resource shall be the L3C PMU resource.
>> +- index                      : Instance number of the L3C PMU.
>> +
>> +Required properties for IOB subnode:
>> +- compatible         : Shall be "apm,xgene-pmu-iob".
>> +- reg                        : First resource shall be the IOB PMU resource.
>> +- index                      : Instance number of the IOB PMU.
>> +
>> +Required properties for MCB subnode:
>> +- compatible         : Shall be "apm,xgene-pmu-mcb".
>> +- reg                        : First resource shall be the MCB PMU resource.
>> +- index                      : Instance number of the MCB PMU.
>> +
>> +Required properties for MC subnode:
>> +- compatible         : Shall be "apm,xgene-pmu-mc".
>> +- reg                        : First resource shall be the MC PMU resource.
>> +- index                      : Instance number of the MC PMU.
>
> What's the index property useful for?
>

The index property is used for indicating the physical hardware PMU id.
For example, on X-Gene1 there are 4 memory controllers (MC), each of them has
its own PMU. The index property tells us which MC a PMU belongs to.
The same for MCB/L3C and IOB.

> Thanks,
> Mark.

Thanks,
Tai
