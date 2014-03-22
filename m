From: carlo@caione.org (Carlo Caione)
Date: Sat, 22 Mar 2014 20:08:03 +0100
Subject: [linux-sunxi] Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
In-Reply-To: <20140322184201.GA27611@core.coreip.homeip.net>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
 <20140322165132.GC20668@localhost.fastwebnet.it>
 <20140322173313.GU552@sirena.org.uk>
 <CAOQ7t2Yg5pp_rXYfsdnHpy-zGFGimzT3EW15P_0ugYMtgPtOrw@mail.gmail.com>
 <20140322184201.GA27611@core.coreip.homeip.net>
Message-ID: <20140322190803.GA20987@localhost.fastwebnet.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 11:42:01AM -0700, Dmitry Torokhov wrote:
> On Sat, Mar 22, 2014 at 07:13:36PM +0100, Carlo Caione wrote:
> > On Sat, Mar 22, 2014 at 6:33 PM, Mark Brown <broonie@kernel.org> wrote:
> > > On Sat, Mar 22, 2014 at 05:51:32PM +0100, Carlo Caione wrote:
> > >> On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:
> > >
> > >> > > + of_id = of_match_device(axp20x_of_match, &i2c->dev);
> > >> > > + if (!of_id) {
> > >> > > +         dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> > >> > > +         return -ENODEV;
> > >> > > + }
> > >> > > + axp20x->variant = (int) of_id->data;
> > >
> > >> > No need to cast from void *.
> > >
> > >> My compiler says otherwise :)
> > >
> > > Are you sure your compiler isn't correctly telling you not to cast away
> > > const?  If the compiler is complaining about a cast on void then it's
> > > spotted a definite bug.
> > 
> > [resend since gmail decided to not put broonie in CC]
> > 
> > drivers/mfd/axp20x.c:172:18: warning: assignment makes integer
> > frompointer without a cast [enabled by default]
> 
> You need to cast to long, otherwise you will get warnings when compiling
> on 64 bit arches.

Actually no warning also with (int) cast.

-- 
Carlo Caione
