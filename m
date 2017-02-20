From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 20 Feb 2017 10:18:48 +0000
Subject: [PATCH 2/3] arm64: dts: r8a7796: Add CA53 L2 cache-controller node
In-Reply-To: <CAMuHMdV1JqRV6AqQDbMQNrkcDpzfUq7DU4NXVvTeCiSeW1-NYw@mail.gmail.com>
References: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
 <1487345435-1088-3-git-send-email-geert+renesas@glider.be>
 <05e43b97-eaa3-f1df-1fc8-b7bab05cc89c@arm.com>
 <CAMuHMdXd=u4hdRsfqt5o7-PQ=F4352oj3U3sivACVHv756BYcw@mail.gmail.com>
 <CAMuHMdV1JqRV6AqQDbMQNrkcDpzfUq7DU4NXVvTeCiSeW1-NYw@mail.gmail.com>
Message-ID: <36fbfe05-5e17-c520-d024-6ae0cbb2e833@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/02/17 20:40, Geert Uytterhoeven wrote:
> On Fri, Feb 17, 2017 at 8:07 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Feb 17, 2017 at 6:51 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 17/02/17 15:30, Geert Uytterhoeven wrote:
>>>> Add a device node for the Cortex-A53 L2 cache-controller.
>>>>
>>>> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
>>>> 32 KiB x 16 ways).
>>>>
>>>> Extracted from a patch by Takeshi Kihara in the BSP.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> ---
>>>>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>>>> index 6c0a65abf9fd09eb..d848e94d7282e5aa 100644
>>>> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>>>> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>>>> @@ -62,6 +62,14 @@
>>>>                       cache-unified;
>>>>                       cache-level = <2>;
>>>>               };
>>>> +
>>>> +             L2_CA53: cache-controller at 100 {
>>>> +                     compatible = "cache";
>>>> +                     reg = <0x100>;
>>>
>>> Is this not integrated L2 cache ? IIUC reg is MPIDR of the cpu and
>>> representing it as cache controller with some reg value doesn't sound
>>> correct IMO.
>>
>> So this should be cache-controller-1, without a reg property?
> 
> BTW, that means the advice from https://lkml.org/lkml/2016/3/8/80:
> 
> | Just add a reg property. The values should probably match the MPIDR in
> | some way (e.g. 0 and 100).
> 
> was wrong, and we should fix all cache-controller nodes that got "fixed"?
> 

OK. IMO it's cpu peripheral which has no mmio similar to architected
timers that are accessed via system registers. So representing them with
reg = mpidr sounds not correct. If DT maintainers are OK with such
representation, it should be fine but better to document it.

> Having better DT documentation for caches on ARM would be nice...
> There's only a (too) minimalist example in
> Documentation/devicetree/bindings/arm/cpu-capacity.txt
> 

Agreed as I mentioned above.

-- 
Regards,
Sudeep
