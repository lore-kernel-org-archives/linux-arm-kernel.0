From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 15:23:52 +0100
Subject: [PATCH 77/77] ARM: dts: sun9i: Add missing unit address
In-Reply-To: <CAGb2v67atuezsjqb-1-0e7Nr1Rt=Fz7TfQhq8R-+meUpDd-M6Q@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <39e9a2c3caec8bf63469f65563361b39c85b607a.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v67atuezsjqb-1-0e7Nr1Rt=Fz7TfQhq8R-+meUpDd-M6Q@mail.gmail.com>
Message-ID: <20181128142352.xsl5p7z4afl7gjs5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 09:07:24PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The soc node in the A80 DTSI has a ranges property, but no matching unit
> > address, which results in a DTC warning. Add the unit address to remove
> > that warning.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun9i-a80.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> > index 27c2ad6bf002..ec504cea1b3e 100644
> > --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> > +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> > @@ -254,7 +254,7 @@
> >                 status = "disabled";
> >         };
> >
> > -       soc {
> > +       soc at 20000 {
> 
> Shouldn't it be 0? The BROM, though unlisted, is at 0x0.

Hmm, I don't know what happened here, you're obviously right :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/9f7c684d/attachment.sig>
