From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 19 Jan 2017 21:11:49 +0800
Subject: [linux-sunxi] [PATCH 1/2] drivers: pinctrl: add driver for
 Allwinner H5 SoC
In-Reply-To: <CACRpkdaTVY7Of5bKyk81xA2kUnZVMQ8LnWEJosg7Ns3s5nAEYQ@mail.gmail.com>
References: <20161223125001.1176-1-icenowy@aosc.xyz>
 <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
 <CACRpkdYQhfid3VRcaj=7as_+Zg=pX3Svp9FJ_W_Ft8nVuoZqKQ@mail.gmail.com>
 <20170105224210.wfinfucbpkkd44om@lukather>
 <38fe3491-457a-f0c5-54fb-9defdcd45045@arm.com>
 <20170116163124.c5gusyd3j3goivnf@lukather>
 <87a535d3-1170-c388-ce7d-4921e69f4cab@arm.com>
 <CACRpkdaTVY7Of5bKyk81xA2kUnZVMQ8LnWEJosg7Ns3s5nAEYQ@mail.gmail.com>
Message-ID: <128701484831509@web34m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



19.01.2017, 17:23, "Linus Walleij" <linus.walleij@linaro.org>:
> On Wed, Jan 18, 2017 at 10:44 AM, Andre Przywara <andre.przywara@arm.com> wrote:
>
>> ?Any future SoCs could then just use that compatible and would describe
>> ?the SoC details in the DT, like it's meant to be and like we do already,
>> ?but extended by putting the mux value in there as well.
>> ?So the only kernel contribution would then be the DT, really, (...)
>
> Your different positions have existed since the inception of the
> pinctrl subsystem:
>
> - One camp (myself included) wanted to describe the hardware mostly
> ??in the driver: functions, groups etc are tables in the driver file.
>
> - Another camp (OMAP included) think that the device tree should take
> ??store most things: groups functions, etc.
>
> What we know for sure should be described in DT is how different
> IP blocks are connected in an SoC (e.g. interrupts, clocks, DMA
> channels, regulators) and on the of course outside of the SoC, on
> the board.
>
> The question here is whether the way a hardware has instantiated
> a certain IP block when doing physical compilation in their
> Verilog, VHDL or SystemC files, is something that should be
> described in DT.
>
> Many companies have developed tools to
> extract this data from their hardware design files and provide
> it to developers as a blob och incomprehensible data, such was
> the situation for OMAP for example. So to them it made most
> sense to implement pinctrl-single, just parsing that data into
> DTS(I) files.
>
> Other companies (such as STMicroelectronics) instead put a
> team of people to write a datasheet with a special chapter
> on how pins etc are connected, and programmers are given
> this datasheet and need to again type in the data and define
> groups etc.
>
> Whether parametrization of a HW block should be done in the
> driver file from the compatible string or with custom attributes
> in the node is not a simple answer to the question. OF is vague
> on this kind of things: both solutions exist.
>
> Allwinner and Qualcomm authors faced a situation such as that
> they were given a code dump and no datasheet and no data
> tables either. That creates an especially complicated situation
> where none of the above scenarios apply.

Allwinner do give user manual about the pin controller, and they're
used when we write the pinctrl-sunxi driver.

>
> What we/you need to ask: what is most helpful for the Allwinner
> community? What makes the barrier low for new contributions,
> and makes it easiest to cooperate?
>
> I try to live by this motto from IETF:
>
> ???"rough consensus and running code"
>
> Please do the same.
>
> Yours,
> Linus Walleij
