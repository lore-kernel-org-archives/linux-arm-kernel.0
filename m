From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 15:54:11 +0000
Subject: [PATCH] arm64: dts: juno: update definition for programmable
 replicator.
In-Reply-To: <CANLsYkzRayLerx7+gLiqJ9yVSCf+GEiyRqnFZopQ1i3EB-yGFw@mail.gmail.com>
References: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
 <2ba59da5-fc79-ab53-2f2a-2ddc6e5e9c3d@arm.com>
 <CANLsYkzRayLerx7+gLiqJ9yVSCf+GEiyRqnFZopQ1i3EB-yGFw@mail.gmail.com>
Message-ID: <1754732c-9271-d462-b4e1-0f019771c73e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/02/17 15:47, Mathieu Poirier wrote:
> On 21 February 2017 at 04:02, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Mike,
>>
>> On 17/02/17 19:13, Mike Leach wrote:
>>> Juno platforms have a programmable replicator splitting the trace output to
>>> TPIU and ETR. Currently this is not being programmed as it is being treated
>>> as a none-programmable replicator - which is the default operational mode
>>> for these devices. The TPIU in the system is enabled by default, and this
>>> combination is causing back-pressure in the trace system resulting in
>>> overflows at the source.
>>>
>>> Replaces the existing definition with one that defines the programmable
>>> replicator, using the "qcom,coresight-replicator1x" driver that provides
>>> the correct functionality for CoreSight programmable replicators.
>>>
>>
>> I assume this is just enhancement and not a fix. Since it's too late for
>> v4.11 (already in merge window now), I will queue this for v4.12
>>
>>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/arm/juno-base.dtsi | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
>>> index 9d799d9..6546e23 100644
>>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
>>> @@ -372,12 +372,14 @@
>>>               };
>>>       };
>>>
>>> -     coresight-replicator {
>>> -             /*
>>> -              * Non-configurable replicators don't show up on the
>>> -              * AMBA bus.  As such no need to add "arm,primecell".
>>> -              */
>>> -             compatible = "arm,coresight-replicator";
>>> +     coresight-replicator at 20120000 {
>>> +
> 
> As stated in a previous post please remove the extra line and the
> "coresight-".  Since programmable replicators show up on the AMBA bus
> there is no need to differentiate them from other CoreSight devices.
> 

Already done in my local branch ;) along with you tags.

Also I away when merge window closes, so I will be able to send only at
-rc2. ARM SoC team generally prefer to rebase fixes on top of -rc1.

-- 
Regards,
Sudeep
