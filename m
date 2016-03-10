From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 10 Mar 2016 14:42:43 +0100
Subject: [PATCH 30/30] ARM: dts: r8a7794: Reference both DMA controllers
 in QSPI node
In-Reply-To: <CAMuHMdW_nMfWF-sQPFgtxmtA_1vxw_hFPsb1DkRp7TJtKrB2ig@mail.gmail.com>
References: <1457609782-24108-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457609782-24108-31-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdW_nMfWF-sQPFgtxmtA_1vxw_hFPsb1DkRp7TJtKrB2ig@mail.gmail.com>
Message-ID: <20160310134243.GA24099@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-10 13:08:56 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Thu, Mar 10, 2016 at 12:36 PM, Niklas S?derlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > R-Car Gen2 have two DMA controllers, which are equivalent. Add
> > references to both dmac0 and dmac1 so the driver can fallback to the
> > later if the first one is unavailable.
> >
> > Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >  arch/arm/boot/dts/r8a7794.dtsi | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> > index 76709ff..e098eab 100644
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -605,8 +605,9 @@
> >                 reg = <0 0xee200000 0 0x80>;
> >                 interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
> >                 clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
> 
> This one has the wrong subject: QSPI vs. MMCIF.

Thanks for noticing, would have been embarrassing for me.

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

-- 
Regards,
Niklas S?derlund
