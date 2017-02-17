From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 20:07:17 +0100
Subject: [PATCH 2/3] arm64: dts: r8a7796: Add CA53 L2 cache-controller node
In-Reply-To: <05e43b97-eaa3-f1df-1fc8-b7bab05cc89c@arm.com>
References: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
 <1487345435-1088-3-git-send-email-geert+renesas@glider.be>
 <05e43b97-eaa3-f1df-1fc8-b7bab05cc89c@arm.com>
Message-ID: <CAMuHMdXd=u4hdRsfqt5o7-PQ=F4352oj3U3sivACVHv756BYcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Fri, Feb 17, 2017 at 6:51 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 17/02/17 15:30, Geert Uytterhoeven wrote:
>> Add a device node for the Cortex-A53 L2 cache-controller.
>>
>> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
>> 32 KiB x 16 ways).
>>
>> Extracted from a patch by Takeshi Kihara in the BSP.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>> index 6c0a65abf9fd09eb..d848e94d7282e5aa 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>> @@ -62,6 +62,14 @@
>>                       cache-unified;
>>                       cache-level = <2>;
>>               };
>> +
>> +             L2_CA53: cache-controller at 100 {
>> +                     compatible = "cache";
>> +                     reg = <0x100>;
>
> Is this not integrated L2 cache ? IIUC reg is MPIDR of the cpu and
> representing it as cache controller with some reg value doesn't sound
> correct IMO.

So this should be cache-controller-1, without a reg property?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
