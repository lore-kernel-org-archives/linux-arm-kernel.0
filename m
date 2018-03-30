From: jic23@kernel.org (Jonathan Cameron)
Date: Fri, 30 Mar 2018 13:51:13 +0100
Subject: [PATCH 3/3] iio: adc: meson-axg: add saradc driver
In-Reply-To: <CAFBinCCK+Y0QAHcGDXvXvSqChS91XK5C6d5XunkmUVBQa4nn+Q@mail.gmail.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
 <20180326084629.100070-4-yixun.lan@amlogic.com>
 <CAFBinCCK+Y0QAHcGDXvXvSqChS91XK5C6d5XunkmUVBQa4nn+Q@mail.gmail.com>
Message-ID: <20180330135113.1d64afd1@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Mar 2018 13:09:31 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Mon, Mar 26, 2018 at 10:46 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> > From: Xingyu Chen <xingyu.chen@amlogic.com>
> >
> > Add the SAR ADC driver for the Amlogic Meson-AXG SoC.
> >
> > Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>  
> I suggest changing the subject of this patch to:
> iio: adc: meson-saradc: add support for Meson AXG
> 
Good point - updated.
> (because "iio: adc: meson-axg" does not point to the "meson-saradc"
> driver and no new driver is added with this patch)
> 
> with that:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Thanks, acks added to all 3 patches.

Jonathan

> 
> > ---
> >  drivers/iio/adc/meson_saradc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 799ed929ab99..a5d481a2b4ef 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -935,6 +935,11 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
> >         .name = "meson-gxm-saradc",
> >  };
> >
> > +static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> > +       .param = &meson_sar_adc_gxl_param,
> > +       .name = "meson-axg-saradc",
> > +};
> > +
> >  static const struct of_device_id meson_sar_adc_of_match[] = {
> >         {
> >                 .compatible = "amlogic,meson8-saradc",
> > @@ -953,6 +958,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
> >         }, {
> >                 .compatible = "amlogic,meson-gxm-saradc",
> >                 .data = &meson_sar_adc_gxm_data,
> > +       }, {
> > +               .compatible = "amlogic,meson-axg-saradc",
> > +               .data = &meson_sar_adc_axg_data,
> >         },
> >         {},
> >  };
> > --
> > 2.15.1
> >  
