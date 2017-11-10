From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 12:23:34 +0100
Subject: [PATCH v4 10/15] arm64: dts: renesas: r8a7795: Point VSPI via
 FCPVI to IPMMU-VP0/1
In-Reply-To: <CAMuHMdWy7xK8GJSU7G_CrVob8PuVWB61TugGBtTYyugJ+M3Cfw@mail.gmail.com>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
 <20171101103452.7491-11-horms+renesas@verge.net.au>
 <CAMuHMdWy7xK8GJSU7G_CrVob8PuVWB61TugGBtTYyugJ+M3Cfw@mail.gmail.com>
Message-ID: <20171110112333.n7q36b3ij6wwi6l4@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 10:35:23AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > Hook up the FCPVI devices to allow use of VSPI with
> > IPMMU-VP0 and IPMMU-VP1.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> > @@ -155,6 +155,10 @@
> >         iommus = <&ipmmu_vp0 1>;
> >  };
> >
> > +&fcpvi1 {
> > +       iommus = <&ipmmu_vp0 9>;
> > +};
> 
> Do we sort labels alphabetically?
> Or do we follow the order of the original targets?
> 
> (Random comment that may apply elsewhere, too)

In these IPMMU patches I tried to sort them in the same order
as they appear in r8a7795.dtsi. I'm happy to change that if
we decided on a scheme to adopt.

> 
> > +
> >  &fcpvd2 {
> >         iommus = <&ipmmu_vi0 10>;
> >  };
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
