From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 10 Jul 2018 17:51:42 +0200
Subject: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
In-Reply-To: <cb832db4-ad2c-09c1-86ae-e7f9c05cd872@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com>
 <cb832db4-ad2c-09c1-86ae-e7f9c05cd872@amlogic.com>
Message-ID: <1531237902.2708.76.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-10 at 20:59 +0800, Yixun Lan wrote:
> > > > > +static const struct of_device_id clkc_match_table[] = {
> > > > > +       { .compatible = "amlogic,g12a-clkc" },
> > > > 
> > > > I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
> > > > and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
> > > > correct - I'll CC Rob Herring on the dt-bindings patch)
> > > > 
> > > 
> > > we're fine with either way, since the g12a is recently new added SoC.
> > > 
> > > but I guess those old compatibles which already exist won't be changed,
> > > as it will break the DT
> > 
> > Yes, I doubt we are going to change the compatibles. With or without the meson
> > prefix, I suppose it going to stay that way.
> > 
> > It is worth thinking about it for new drivers though.
> > We already have the "amlogic,", so do we really to prefix even more with "meson-
> > "
> > 
> > Also, if we were really strict about that scheme, should meson8b compatible be
> > 
> > "amlogic,meson-meson8b-foo-bar" ... the SoC is meson8b, not just 8b after all ?
> > 
> > For the particular case of the clock controller, I don't care very much, as long
> > as the compatible is coherent with documentation.
> > 
> > I might have a preference for the current compatible ... just for consistency
> > with the other clock controllers.
> > 
> 
> do you imply that we should just stick to 'amlogic,g12a-clkc'?
> 
> it sound good to me, at least it's shorter than 'amlogic,meson-g12a-clkc'..

I did not imply anything.
Martin raised a valid point. I'm merely giving my opinion on the matter and I'm
interested to get others view on this.
