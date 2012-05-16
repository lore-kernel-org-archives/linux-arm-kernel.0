From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 16 May 2012 09:34:39 +0200
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20120516072859.GE21517@S2100-06.ap.freescale.net>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
Message-ID: <20403.22671.800713.334846@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo writes:
> On Wed, May 16, 2012 at 08:53:42AM +0200, Lothar Wa?mann wrote:
> > > @@ -394,6 +394,10 @@ int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
> > >                 return ret;
> > > 
> > >         bgc->data = bgc->read_reg(bgc->reg_dat);
> > > +       if (bgc->gc.set == bgpio_set_set)
> > > +               bgc->data = bgc->read_reg(bgc->reg_set);
> > > +       if (bgc->reg_dir)
> > > +               bgc->dir = bgc->read_reg(bgc->reg_dir);
> > > 
> > >         return ret;
> > >  }
> > > 
> > That might change the behaviour of existing implementations.
> > 
> Can you be specific?  I do not quite follow on that.
> 
You initialize a variable to a specific value that defaulted to zero
before.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
