From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:01:18 +0100
Subject: [PATCH v2 14/15] arm64: dts: allwinner: a64: Add DSI pipeline
In-Reply-To: <CAMty3ZC1jCfuP8tFKvgcdJ5R_Ou0ejAT_VYv=fV1Kh4UanLWcg@mail.gmail.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-15-jagan@amarulasolutions.com>
 <20181024181048.w4iwebtac6wzmgt4@flea>
 <CAMty3ZC1jCfuP8tFKvgcdJ5R_Ou0ejAT_VYv=fV1Kh4UanLWcg@mail.gmail.com>
Message-ID: <20181029090118.mqha2wgghtqhnyyd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 06:51:14PM +0530, Jagan Teki wrote:
> On Wed, Oct 24, 2018 at 11:40 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Oct 23, 2018 at 09:20:34PM +0530, Jagan Teki wrote:
> > > The A64 has a MIPI-DSI block which is similar to A31
> > > without mod clock.
> > >
> > > So, add dsi node with A64 compatible, dphy node with
> > > A31 compatible and finally connect dsi to tcon0 to
> > > make proper DSI pipeline.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - use A64 dphy compatible
> > >
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > index f3a66f888205..f82e6b165d57 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > @@ -320,6 +320,11 @@
> > >                                       #address-cells = <1>;
> > >                                       #size-cells = <0>;
> > >                                       reg = <1>;
> > > +
> > > +                                     tcon0_out_dsi: endpoint at 1 {
> > > +                                             reg = <1>;
> > > +                                             remote-endpoint = <&dsi_in_tcon0>;
> >
> > You need to set the allwinner,channel property there.
> 
> Are you referring to allwinner,tcon-channel = <1> ?

Yep

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/eae37f0e/attachment-0001.sig>
