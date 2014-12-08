From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Dec 2014 09:31:05 +0900
Subject: [PATCH/RFC] ARM: shmobile: lager: Fix SPI mode of SPI-Flash into
 mode3
In-Reply-To: <20141112082242.GU9007@verge.net.au>
References: <1414648551-30318-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVQ0s35sW=kvf80c0s++R-5uNuJQtxMcX1R5ogxNwkp9w@mail.gmail.com>
 <20141112082242.GU9007@verge.net.au>
Message-ID: <20141208003105.GC7420@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 05:22:43PM +0900, Simon Horman wrote:
> On Thu, Oct 30, 2014 at 10:26:33AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Oct 30, 2014 at 6:55 AM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > >
> > > In order to change into mode3, CPOL and CPHA bit of SPCMD register
> > > of MSIOF is changed. Mode3 can avoid intermediate voltage.
> > 
> > This is the QSPI node, not MSIOF?
> 
> Indeed.
> 
> Nakamura-san's patch, which I up-ported, was against the QSPI node
> but the version I posted below is indeed against the MSIOF.
> 
> Furthermore, I see that spi-cpol and spi-cpha are already present
> in the MSIOF node in mainline. I would like to withdraw this patch.

Hi Geert,

coming back to this I'm a little confused.

I believe that the patch below is for the QSPI node and that was
intended by it. Is such a change appropriate for mainline?
Should I confirm some details with Nakamura-san?

In mainline spi-cpol and spi-cpha are currently set in the
MSIOF node but not the QSPI node. I believe the same holds for koelsch too.

> 
> > > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > > Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
> > >
> > >  arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> > > index 830f2e8..1606fad 100644
> > > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > > @@ -343,6 +343,8 @@
> > >                 spi-tx-bus-width = <4>;
> > >                 spi-rx-bus-width = <4>;
> > >                 m25p,fast-read;
> > > +               spi-cpol;
> > > +               spi-cpha;
> > >
> > >                 partition at 0 {
> > >                         label = "loader";
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
