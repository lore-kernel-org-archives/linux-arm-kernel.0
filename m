From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 24 Apr 2016 11:15:16 +0200
Subject: [PATCH v4 4/5] dt-bindings: arm: add DT binding for Marvell CP110
 system controller
In-Reply-To: <20160423162223.16e3ca28@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459070777-18049-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160328194756.GA28967@rob-hp-laptop>
 <20160413180122.4f997a9a@free-electrons.com>
 <CAMuHMdVYtXEZF0+G3W+Q8cDcBFB55s1ru6N6J3tgFy9BcGZiXw@mail.gmail.com>
 <20160423162223.16e3ca28@free-electrons.com>
Message-ID: <CAMuHMdUPMcuQVd-5Gw7Be5eL24yoM_uN-1NBp-0JCcbcipAVig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sat, Apr 23, 2016 at 4:22 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Thu, 14 Apr 2016 21:19:54 +0200, Geert Uytterhoeven wrote:
>> From my experience with clock drivers for Renesas SoCs, life is much easier
>> when handling all of this (clock names, parents, ...) in C. The same is true
>> BTW for PM Domains.
>>
>> The clock controllers of r8a7791 and r8a7795 are very similar, and could
>> be handled similarly.
>> Compare the DT hierarchy for CPG and MSTP/MSSR in
>> arch/arm/boot/dts/r8a7791.dtsi and arch/arm64/boot/dts/renesas/r8a7795.dtsi.
>
> Thanks for your feedback. However in practice, there will ultimately be
> two instances of this clock controller, as some variants of the SoC
> will contain two CP parts. Due to this, it is going to be quite
> convenient to have the clock names configurable from the DT, as I will
> be able to give the same clock on the master CP and the slave CP a
> different name.

You could still prefix the names by e.g. an instance number.

> That's actually why my binding documentation uses names like
> "cpm-<foo>" for all the clocks, where "cpm" stands for "CP Master". In
> the future, another instance will have clocks named "cps-<foo>" for "CP
> Slave".

So the names are actually part of the binding, while nothing really relies
on the actual names, right? Clocks are referred to by clock specifier (phandle
+ some optonal bits).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
