From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Apr 2017 16:31:28 +0900
Subject: [PATCH/RFT] ARM: dts: silk: Enable UHS-I SDR-50
In-Reply-To: <CAMuHMdV_L_Fpm0=WQkHgVn123G4X+cUSxECqw4yi3TYvdSSGCA@mail.gmail.com>
References: <1492493267-20807-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdV_L_Fpm0=WQkHgVn123G4X+cUSxECqw4yi3TYvdSSGCA@mail.gmail.com>
Message-ID: <20170418073127.GC16340@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 09:22:24AM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 18, 2017 at 7:27 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI1.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > * Compile tested only; no access to silk board
> > ---
> >  arch/arm/boot/dts/r8a7794-silk.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
> > index 4cb5278d104d..b0ef8ea75c29 100644
> > --- a/arch/arm/boot/dts/r8a7794-silk.dts
> > +++ b/arch/arm/boot/dts/r8a7794-silk.dts
> > @@ -226,6 +226,13 @@
> >         du1_pins: du1 {
> >                 groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_clk0_out";
> >                 function = "du1";
> > +               power-source = <3300>;
> > +       };
> > +
> > +       sdhi1_pins_uhs: sd1_uhs {
> > +               groups = "sdhi1_data4", "sdhi1_ctrl";
> > +               function = "sdhi1";
> > +               power-source = <1800>;
> 
> Shouldn't this be inserted right after the existing sdhi1_pins?
> Yes, the list is only partially sorted.

Oh wow, I messed that up completely.
Let me post a v2.
