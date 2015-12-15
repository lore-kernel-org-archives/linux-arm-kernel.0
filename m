From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Dec 2015 09:33:25 +0100
Subject: [PATCH 3/3] arm64: dts: r8a7795: Add pmu device nodes
In-Reply-To: <566ED3D5.1080301@arm.com>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
 <1449236333-4410-3-git-send-email-dirk.behme@gmail.com>
 <566ED3D5.1080301@arm.com>
Message-ID: <CAMuHMdU940q78hpDjJEHkeyqRRPTWLxqR46K69DCTMOJHBbKcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 3:36 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 04/12/15 13:38, Dirk Behme wrote:
>>
>> From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
>>
>> Enabling the performance monitor unit on r8a7795.
>>
>> Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
>> Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
>> Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
>> ---
>> Note: This patch picked from
>>
>>
>> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/log/?h=v4.2/rcar-3.0.x
>>
>> and rebased against
>>
>>
>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/gen3-latest
>> renesas-drivers-2015-12-01-v4.4-rc3
>>
>>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> index 946a5bb..8113b71 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -247,6 +247,18 @@
>>                         power-domains = <&cpg>;
>>                 };
>>
>> +               pmu {
>> +                       compatible = "arm,armv8-pmuv3";
>
>
> You can add more specific compatible "arm,cortex-a57-pmu" if it's Cortex
> A57.

Except that one is not documented.

Oh, it is. Someone mistyped the commas. Patch sent.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
