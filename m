From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 18 Jan 2017 01:08:14 +0800
Subject: [PATCH v2 2/4] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170117090456.fgw6lpqgurwwcczj@lukather>
References: <20170116180116.36729-2-icenowy@aosc.xyz>
 <20170116180116.36729-3-icenowy@aosc.xyz>
 <20170117090456.fgw6lpqgurwwcczj@lukather>
Message-ID: <5926181484672894@web12g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



17.01.2017, 17:05, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Tue, Jan 17, 2017 at 02:01:14AM +0800, Icenowy Zheng wrote:
>> ?V3s has a similar but cut-down CCU to H3.
>>
>> ?Add support for it.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?---
>
> Output from checkpatch:
> total: 5 errors, 2 warnings, 3 checks, 857 lines checked

I remembered some errors' code is directly derived from ccu-sun8i-h3.c,
so I generated a patch file for "clk: sunxi-ng: Add H3 clocks" and run
checkpatch on it:
total: 4 errors, 5 warnings, 1159 lines checked

Should I still get all errors fixed?

>
>> ?I think I should make a comparsion between V3s and H3 CCU here:
>> ?(I won't mention the missing/added clocks here, only list conflicting clocks)
>
> That should be in your commit log.
>
>> ?- "bus-ehci0" is at different bit (The bit that is "bus-ehci0" on V3s is
>> ???"bus-ehci2" on H3)
>> ?- The mux of "ce" is different. (According the view at V3s datasheet by the
>> ???author of sun4i-ss, V3s may have sun4i-ss, not sun8i-ce)
>> ?- The mux of "de" is different. (V3s do not have "pll-de", but it can mux "de"
>> ???to "pll-video")
>> ?- Clocks about CSI largely differs. (As V3s is designed as a camera SoC, and
>> ???it have an extra "pll-isp")
>
> OK.
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
