From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jul 2016 22:21:18 +0200
Subject: [linux-sunxi] [PATCH] regulator: axp20x: support AXP813 variant
In-Reply-To: <CAGRGNgUeORYesjLAeaO=GGhC1rv9FUU5ZUdjRx8+Pz=vCggsEw@mail.gmail.com>
References: <5799d673.58a51c0a.97cf9.b9c0SMTPIN_ADDED_MISSING@gmr-mx.google.com>
 <CAGRGNgUeORYesjLAeaO=GGhC1rv9FUU5ZUdjRx8+Pz=vCggsEw@mail.gmail.com>
Message-ID: <20160728202118.GI6682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 08:24:41PM +1000, Julian Calaby wrote:
> Hi All,
> 
> On Thu, Jul 28, 2016 at 5:28 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > The X-Powers AXP813 PMIC is close enough to the AXP809 with some
> > more outputs.
> >
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> >  Documentation/devicetree/bindings/mfd/axp20x.txt | 32 ++++++++-
> >  drivers/mfd/axp20x-rsb.c                         |  1 +
> >  drivers/mfd/axp20x.c                             |  3 +
> >  drivers/regulator/axp20x-regulator.c             | 82 +++++++++++++++++++++++-
> >  include/linux/mfd/axp20x.h                       | 38 +++++++++++
> >  5 files changed, 153 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> > index 6d9ac76..c3287c9 100644
> > --- a/drivers/regulator/axp20x-regulator.c
> > +++ b/drivers/regulator/axp20x-regulator.c
> > @@ -467,7 +543,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
> >                  * name.
> >                  */
> >                 if ((regulators == axp22x_regulators && i == AXP22X_DC1SW) ||
> > -                   (regulators == axp809_regulators && i == AXP809_DC1SW)) {
> > +                   (regulators == axp809_regulators && i == AXP809_DC1SW) ||
> > +                   (regulators == axp813_regulators && i == AXP813_DC1SW)) {
> 
> Are we getting to the point now where we need some other way to flag
> these? Maybe a set of flags per regulator?

I'd be inclined to say yes. We can also associate a structure to the
compatible, and store a bunch of infos there (like does it have a
DC1SW regulator in this case).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/e3c453e7/attachment.sig>
