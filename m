From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 16 Feb 2016 08:33:41 +0100
Subject: [PATCH v3 7/7] arm64: dts: r8a7795: Add CA53 L2 cache-controller
 node
In-Reply-To: <CAMuHMdX=Kgb-i+QpP=yNO2e6nw7sXuCutXPoK0U9NwK-OyANFA@mail.gmail.com>
References: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
 <1455568715-20880-8-git-send-email-geert+renesas@glider.be>
 <56C2C534.30704@de.bosch.com>
 <CAMuHMdX=Kgb-i+QpP=yNO2e6nw7sXuCutXPoK0U9NwK-OyANFA@mail.gmail.com>
Message-ID: <56C2D0D5.7090705@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 16.02.2016 08:12, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Tue, Feb 16, 2016 at 7:44 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> On 15.02.2016 21:38, Geert Uytterhoeven wrote:
>>> Add a device node for the Cortex-A53 L2 cache-controller.
>>>
>>> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
>>> 32 KiB x 16 ways).
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> v3:
>>>     - Remaining part of "[PATCH v2 6/6] arm64: renesas: r8a7795: Add L2
>>>       cache-controller nodes".
>>> ---
>>>    arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> index c07f4e83b988ba42..c572527afec3403a 100644
>>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>> @@ -72,6 +72,12 @@
>>>                  cache-level = <2>;
>>>          };
>>>
>>> +       L2_CA53: cache-controller at 1 {
>>> +               compatible = "cache";
>>> +               cache-unified;
>>> +               cache-level = <2>;
>>> +       };
>>> +
>>
>> As we don't have any CA53 in the device tree yet, and it was rejected to add
>> it, I'd think that we don't want these unused entries at the moment.
>
> This is a preparatory step for adding the SYSC PM Domains.


Yes. But what do you want to control if it's not enabled at all?

To my understanding, as long as we don't enable the CA53 cores, we don't 
enable their L2 caches, too. And then we don't have to PM control them?


>> I'd propose to add the CA53 entries, first. And then add their L2 cache
>> entries.
>>
>> Based on the outcome of the discussion for the CA57 we have to see if we
>> want to add the unused cache-unified and cache-level, then, too.
>
> These are specified by ePAPR, as I said before.
> Remember, DT describes the hardware, not what Linux (or any other OS) is
> using.


Yes, this is understood :)

Your argument is the Spec/ePAPR, my point of view is the practical 
implementation. I'd think both are valid. Therefore let's see what 
Sudeep thinks ;)


Best regards

Dirk
