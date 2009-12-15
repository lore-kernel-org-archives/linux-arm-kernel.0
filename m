From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 15 Dec 2009 15:07:36 +0000
Subject: [PATCH v2 09/09] regulator: refresh 88pm8607 driver with
	updated api
In-Reply-To: <771cded00912091944q14be2f94gc7343f232abdbd0f@mail.gmail.com>
References: <771cded00912090518s29c295a9v7f555a543f3bc4e6@mail.gmail.com>
	<20091209152026.GD32223@rakim.wolfsonmicro.main>
	<771cded00912091944q14be2f94gc7343f232abdbd0f@mail.gmail.com>
Message-ID: <1260889656.3591.584.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-09 at 22:44 -0500, Haojian Zhuang wrote:
> On Wed, Dec 9, 2009 at 10:20 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, Dec 09, 2009 at 08:18:18AM -0500, Haojian Zhuang wrote:
> >
> >> Since i2c API of mfd 88pm860x driver is changed, refresh 88pm8607 driver.
> >> Remove the support of 88PM8607 A0/A1 stepping.
> >
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >
> > Might be nice to split the removal of the old devices into a separate
> > patch but that is definitely a win.  One blocker below, though.
> >
> >> +             ret = (index < 3) ? (index * 50000 + 1800000) :
> >> +                     ((index < 7) ? (index * 50000 + 2550000) :
> >> +                     3300000);
> >
> > I know the previous code did this but I'm really not loving the multiple
> > ternery operators here for legibility.
> >
> >>       return 0;
> >>  }
> >> -subsys_initcall(pm8607_regulator_init);
> >> +module_init(pm8607_regulator_init);
> >
> > This should be left at subsys_initcall() to try to ensure that the
> > regulators are initialsied before the things that use them, otherwise
> > the handling of init sequencing gets too complex.
> >
> 
> Now split this patch into two. Thanks :)


Applied both.

Thanks

Liam
