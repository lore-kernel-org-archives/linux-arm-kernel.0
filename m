From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 20 Oct 2012 21:19:19 +0200
Subject: [PATCH] usb: phy: samsung: Introducing usb phy driver for hsotg
In-Reply-To: <20121015132836.GT24333@arwen.pp.htv.fi>
References: <1349256393-11741-1-git-send-email-p.paneri@samsung.com>
 <1350036934-6051-1-git-send-email-p.paneri@samsung.com>
 <20121015132836.GT24333@arwen.pp.htv.fi>
Message-ID: <20121020191919.GA555@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +#define S3C_PHYPWR				(0x00)
...
> > +#define S3C_PHYCLK				(0x04)
> > +
> > +#define S3C_PHYCLK_MODE_SERIAL			(1 << 6)
> > +#define S3C_PHYCLK_EXT_OSC			(1 << 5)
> > +#define S3C_PHYCLK_COMMON_ON_N			(1 << 4)
> > +#define S3C_PHYCLK_ID_PULL			(1 << 2)
> > +#define S3C_PHYCLK_CLKSEL_MASK			(0x3 << 0)
> > +#define S3C_PHYCLK_CLKSEL_SHIFT			(0)
> > +#define S3C_PHYCLK_CLKSEL_48M			(0x0 << 0)
> > +#define S3C_PHYCLK_CLKSEL_12M			(0x2 << 0)
> > +#define S3C_PHYCLK_CLKSEL_24M			(0x3 << 0)

I believe these 0x 's should be removed. Ouch and << 0 is interesting,
too, just remove it.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
