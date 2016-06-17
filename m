From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 17 Jun 2016 16:33:53 +0100
Subject: [PATCH 1/3] arm64: dts: juno: add coresight support
In-Reply-To: <CANLsYkyWhknAb9QeGGjM2Et0+VUVjz7W2xyUJGstxfNc2bC20Q@mail.gmail.com>
References: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
 <1465228765-14038-2-git-send-email-sudeep.holla@arm.com>
 <CANLsYkyWhknAb9QeGGjM2Et0+VUVjz7W2xyUJGstxfNc2bC20Q@mail.gmail.com>
Message-ID: <57641861.7040408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/06/16 16:29, Mathieu Poirier wrote:
> On 6 June 2016 at 09:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Most of the debug-related components on Juno are located in the coreSight
>> subsystem while others are located in the Cortex-Axx clusters, the SCP
>> subsystem, and in the main system.
>>
>> Each core in the two processor clusters contain an Embedded Trace
>> Macrocell(ETM) which generates real-time trace information that trace
>> tools can use and an ATB trace output that is sent to a funnel before
>> going to the CoreSight subsystem.
>>
>> The trace output signals combine with two trace expansions using another
>> funnel and fed into the Embedded Trace FIFO(ETF0).
>>
>> The output trace data stream of the funnel is then replicated before it
>> is sent to either the:
>> - Trace Port Interface Unit(TPIU), that sends it out using the trace port.
>> - ETR that can write the trace data to memory located in the application
>>    memory space
>>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/boot/dts/arm/juno-base.dtsi | 296 +++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/arm/juno-r1.dts    |  24 +++
>>   arch/arm64/boot/dts/arm/juno-r2.dts    |  24 +++
>>   arch/arm64/boot/dts/arm/juno.dts       |  24 +++
>>   4 files changed, 368 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> index dee2386d3b9b..90a8710f7032 100644
>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi

[...]

>> +
>> +       coresight-replicator {
>> +               /* non-configurable replicators don't show up on the
>> +                * AMBA bus.  As such no need to add "arm,primecell".
>> +                */
>
> Please use kernel documentation style.
>

Ah, that's copy paste from arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts ;)


[...]

>>
>
> With the above change:
>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>

Thanks.

-- 
Regards,
Sudeep
