From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Mar 2014 09:24:28 +0900
Subject: [PATCH v2 00/11] ARM: shmobile: MSIOF integration on
 r8a7790/lager and r8a7791/koelsch
In-Reply-To: <CAMuHMdX16VGZ=MjCj0St9spWGZo-bnQ6EXuiibZENTWKfASxEg@mail.gmail.com>
References: <1393324219-3317-1-git-send-email-geert@linux-m68k.org>
 <CANqRtoSM-51NRVAtYOOAzZQ-pagC2JteC+M=SKMuBYniLFfhLA@mail.gmail.com>
 <20140306013824.GF13581@verge.net.au>
 <CANqRtoSkHWGRypPymh87ikmcEWqMsn=eRoPkc2JpaSZVqP21Lw@mail.gmail.com>
 <CAMuHMdX16VGZ=MjCj0St9spWGZo-bnQ6EXuiibZENTWKfASxEg@mail.gmail.com>
Message-ID: <20140307002428.GC11702@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 04:28:26PM +0100, Geert Uytterhoeven wrote:
> Hi Magnus, Simon,
> 
> On Thu, Mar 6, 2014 at 3:25 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > On Thu, Mar 6, 2014 at 10:38 AM, Simon Horman <horms@verge.net.au> wrote:
> >> On Wed, Mar 05, 2014 at 05:31:42PM +0900, Magnus Damm wrote:
> >>> On Tue, Feb 25, 2014 at 7:30 PM, Geert Uytterhoeven
> >>> <geert@linux-m68k.org> wrote:
> >>> >         Hi Simon, Magnus,
> >>> >
> >>> > This patch series integrates support for the MSIOF module in the Renesas
> >>> > R-Car H2 (r8a7790) and M2 (r8a7791) SoCs on the Lager and Koelsch
> >>> > development boards.
> >>> >
> >>> > It was tested on Lager and Koelsch, both legacy and DT, using a dummy
> >>> > driver for the Renesas r2a11302ft PMIC that reads out the PMIC's version
> >>> > ID.
> >>> >
> >>> >     [01/11] ARM: shmobile: r8a7790: Add MSIOF clocks
> >>> >     [02/11] ARM: shmobile: r8a7791: Add MSIOF clocks
> >>> >     [03/11] ARM: shmobile: lager legacy: Add MSIOF support
> >>> >     [04/11] ARM: shmobile: koelsch legacy: Add MSIOF support
> >>> >     [05/11] ARM: shmobile: r8a7790/lager dts: Rename label spi to qspi, add
> >>> >             spi0 alias
> >>> >     [06/11] ARM: shmobile: r8a7791/koelsch dts: Rename label spi to qspi,
> >>> >             add spi0 alias
> >>> >     [07/11] ARM: shmobile: r8a7790 dtsi: Add MSIOF nodes and aliases
> >>> >     [08/11] ARM: shmobile: r8a7791 dtsi: Add MSIOF nodes and aliases
> >>> >     [09/11] ARM: shmobile: lager dts: Add MSIOF nodes
> >>> >     [10/11] ARM: shmobile: koelsch dts: Add MSIOF nodes
> >>> >     [11/11] ARM: shmobile: koelsch/lager/multi defconfig: Enable MSIOF
> >>> >
> >>> > These are (reworked versions of) the remaining patches not taken from v1.
> >>> > Changelogs are available in the individual patches.
> >>>
> >>> Hi Geert,
> >>>
> >>> Thanks for your efforts. All these look fine to me.
> >>>
> >>> Acked-by: Magnus Damm <damm@opensource.se>
> >>>
> >>> Exactly what to merge upstream depends on what the ARM SoC maintainers prefer.
> >>
> >> I wonder if for now we could move things forwards by merging the
> >> non-legacy code. I think that would mean the following:
> >>
> >>     [05/11] ARM: shmobile: r8a7790/lager dts: Rename label spi to qspi, add
> >>             spi0 alias
> >>     [06/11] ARM: shmobile: r8a7791/koelsch dts: Rename label spi to qspi,
> >>             add spi0 alias
> >>     [07/11] ARM: shmobile: r8a7790 dtsi: Add MSIOF nodes and aliases
> >>     [08/11] ARM: shmobile: r8a7791 dtsi: Add MSIOF nodes and aliases
> >>     [09/11] ARM: shmobile: lager dts: Add MSIOF nodes
> >>     [10/11] ARM: shmobile: koelsch dts: Add MSIOF nodes
> >>
> >> And just the 'multi' portion of:
> >>
> >>     [11/11] ARM: shmobile: koelsch/lager/multi defconfig: Enable MSIOF
> >>
> >>
> >> Would that result in working MSIOF support for koelsch and lager
> >> when using multiplatform?
> >
> > I believe so, but I rely on Geert to point out if this assumption is wrong.
> 
> Yes, that should work.

Thanks. I have queued things up as described above.

> >> Then later, if appropriate, in accordance with discussions with the
> >> ARM SoC maintainers, we could merge the remaining changes in
> >> this series: the legacy code.
> >
> > Sure, sounds good.
> 
> Indeed.
> 
> Thanks a lot!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
