From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 8 Sep 2016 19:55:46 +0200
Subject: [PATCH] ARM: imx35: add iim module to imx35.dtsi
In-Reply-To: <CAOMZO5DmaLsxAsjORCauxBkqAmOMQxu4HTASo+jxBsoo+iL8Ow@mail.gmail.com>
References: <1473326895-19189-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5DmaLsxAsjORCauxBkqAmOMQxu4HTASo+jxBsoo+iL8Ow@mail.gmail.com>
Message-ID: <20160908175546.lvc5qehbekx7s2ty@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 01:21:49PM -0300, Fabio Estevam wrote:
> Hi Uwe,
> 
> On Thu, Sep 8, 2016 at 6:28 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > This is a prerequisite to remove the static mappings for imx35 devicetree
> > based machines.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx35.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> > index 490b7b44f1e7..f812d586c5ce 100644
> > --- a/arch/arm/boot/dts/imx35.dtsi
> > +++ b/arch/arm/boot/dts/imx35.dtsi
> > @@ -309,6 +309,13 @@
> >                                 status = "disabled";
> >                         };
> >
> > +                       iim at 53ff0000 {
> > +                               compatible = "fsl,imx35-iim";
> 
> Where is "fsl,imx35-iim" defined?

right next to the other fsl,imx*-iim :-)

By the way, compared to the other imx*.dtsi I didn't declare
compatibility to fsl,imx27-iim. I checked the i.MX25 reference manual
and the i.MX35 looked different. Didn't check for imx5x and the i.MX27
RM doesn't describe the registers. What do you think?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
