From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 May 2012 15:29:00 +0800
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20403.20214.297216.188300@ipc1.ka-ro>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
Message-ID: <20120516072859.GE21517@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 08:53:42AM +0200, Lothar Wa?mann wrote:
> > @@ -394,6 +394,10 @@ int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
> >                 return ret;
> > 
> >         bgc->data = bgc->read_reg(bgc->reg_dat);
> > +       if (bgc->gc.set == bgpio_set_set)
> > +               bgc->data = bgc->read_reg(bgc->reg_set);
> > +       if (bgc->reg_dir)
> > +               bgc->dir = bgc->read_reg(bgc->reg_dir);
> > 
> >         return ret;
> >  }
> > 
> That might change the behaviour of existing implementations.
> 
Can you be specific?  I do not quite follow on that.

-- 
Regards,
Shawn
