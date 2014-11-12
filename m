From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Nov 2014 17:19:14 +0900
Subject: [PATCH/RFC] ARM: shmobile: koelsch: Fix SPI mode of SPI-Flash
 into mode3
In-Reply-To: <CAMuHMdVpnoZatm8kCi=DLUWx9dDm9F8HkEtO4LKjj9J1KiKU=w@mail.gmail.com>
References: <1414648424-29688-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVpnoZatm8kCi=DLUWx9dDm9F8HkEtO4LKjj9J1KiKU=w@mail.gmail.com>
Message-ID: <20141112081914.GS9007@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 10:11:59AM +0100, Geert Uytterhoeven wrote:
> On Thu, Oct 30, 2014 at 6:53 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >
> > In order to change into mode3, CPOL and CPHA bit of SPCMD register
> > of MSIOF is changed. Mode3 can avoid intermediate voltage.
> 
> This is the QSPI node, not MSIOF?

Indeed.

Nakamura-san's patch, which I up-ported, was against the QSPI node
but the version I posted below is indeed against the MSIOF.

Futhermore, I see that spi-cpol and spi-cpha are already present
in the MSIOF node in mainline. I would like to withdraw this patch.

> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
> >
> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > index 523ae4d..ced0738 100644
> > --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > @@ -387,6 +387,8 @@
> >                 spi-tx-bus-width = <4>;
> >                 spi-rx-bus-width = <4>;
> >                 m25p,fast-read;
> > +               spi-cpol;
> > +               spi-cpha;
> >
> >                 partition at 0 {
> >                         label = "loader";
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
> 
