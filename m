From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Feb 2018 14:51:43 +0100
Subject: [PATCH 05/11] arm64: dts: renesas: initial R8A77980 SoC device
 tree
In-Reply-To: <ad83625d-c166-cacb-eae2-a6d64f7d2b26@cogentembedded.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
 <32142684-d5cf-035f-8401-86a36dcbafd6@cogentembedded.com>
 <CAMuHMdWad2OJ33Hu0KbYS3nLWhgmj81_wRbtwApw-N81q3+nsA@mail.gmail.com>
 <ad83625d-c166-cacb-eae2-a6d64f7d2b26@cogentembedded.com>
Message-ID: <CAMuHMdVfuruK36OUVdOcHaJogoM8oee_+b+4UzjBfUBoMiEbOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Feb 5, 2018 at 2:48 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 2/5/2018 4:32 PM, Geert Uytterhoeven wrote:
>>> The initial R8A77980 SoC device tree including Cortex-A53 CPU, GIC,
>>> timer,
>>> CPG, RST, and SYSC.
>>>
>>> Based on the original (and large) patch by Vladimir Barinov.
>>>
>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>
>> Thanks for your patch!
>>
>>> --- /dev/null
>>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
>>> @@ -0,0 +1,122 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Device Tree Source for the r8a77980 SoC
>>> + *
>>> + * Copyright (C) 2018 Renesas Electronics Corp.
>>> + * Copyright (C) 2018 Cogent Embedded, Inc.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/clock/renesas-cpg-mssr.h>
>>
>> I think you want to leave out the above #include, as it will go upstream
>> through a different path (you're already using hardcoded clock numbers,
>> assuming the same).
>
>    I still need CPG_{CORE|MOD}.

You're right. Please ignore my comment.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
