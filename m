From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 11 May 2018 12:20:33 +0200
Subject: [PATCH v3 02/14] drivers: soc: sunxi: Add dedicated compatibles
 for the A13, A20 and A33
In-Reply-To: <CAGb2v67An8RSCKEDSgW_jY7m8iw22K4rRHb02q67decmCBcjhg@mail.gmail.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-3-paul.kocialkowski@bootlin.com>
 <CAGb2v67An8RSCKEDSgW_jY7m8iw22K4rRHb02q67decmCBcjhg@mail.gmail.com>
Message-ID: <20180511102033.i6jtzljbvkg47wz3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 10:05:33PM -0700, Chen-Yu Tsai wrote:
> On Mon, May 7, 2018 at 5:44 AM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > This introduces platform-specific compatibles for the A13, A20 and A33
> > SRAM driver. No particular adaptation for these platforms is required at
> > this point, although this might become the case in the future.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/soc/sunxi/sunxi_sram.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> > index 74cb81f37bd6..43ebc3bd33f2 100644
> > --- a/drivers/soc/sunxi/sunxi_sram.c
> > +++ b/drivers/soc/sunxi/sunxi_sram.c
> > @@ -315,6 +315,9 @@ static int sunxi_sram_probe(struct platform_device *pdev)
> >
> >  static const struct of_device_id sunxi_sram_dt_match[] = {
> >         { .compatible = "allwinner,sun4i-a10-sram-controller" },
> > +       { .compatible = "allwinner,sun5i-a13-sram-controller" },
> > +       { .compatible = "allwinner,sun7i-a20-sram-controller" },
> > +       { .compatible = "allwinner,sun8i-a33-sram-controller" },
> 
> We should probably name these "system-controller". Maxime?

This would make sense yes, but we don't really need to add the A20 one
to the driver, it's exactly the same than the A10.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180511/829346ef/attachment.sig>
