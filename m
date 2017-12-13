From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Dec 2017 11:05:23 +0100
Subject: [PATCH 2/3] ARM: dts: r8a7743: Add CMT SoC specific support
In-Reply-To: <TY1PR06MB0895B34EFC2A48F49AFF0694C0350@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1513104579-6333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513104579-6333-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20171213083829.ptdeggbon3szmko4@verge.net.au>
 <TY1PR06MB0895B34EFC2A48F49AFF0694C0350@TY1PR06MB0895.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdWEFttz_Shve+D1Ku2NoUYX-AomzXY9JFGRjzzM=hOc_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Wed, Dec 13, 2017 at 10:42 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
>> On Tue, Dec 12, 2017 at 06:49:38PM +0000, Fabrizio Castro wrote:
>> > Add CMT[01] support to SoC DT.
>> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>> > ---
>> >  arch/arm/boot/dts/r8a7743.dtsi | 30 ++++++++++++++++++++++++++++++
>> >  1 file changed, 30 insertions(+)
>>
>> I was expecting the cmt nodes to be "disabled" in the SoC file
>> and then enabled selectively in board files. Am I missing something?
>
> Since this component is just a compare and match timer, I  thought there was no harm in enabling it by default in the SoC specific DT. The system will park it and leave its clock disabled until actually needed for something.
> The user can still disable it in the board specific DT if he/she doesn't mean to even have the option to use it. Do you prefer I left it disabled by default?

It's debatable (thus up to Simon the maintainer ;-).
For I/O devices, we disable them in the SoC .dtsi file.
For core infrastructure like interrupt, DMA, and GPIO controllers, we keep
them enabled.

Timers are core functionality, but who's actually using these timers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
