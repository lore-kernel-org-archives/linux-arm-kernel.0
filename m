From: ralf@linux-mips.org (Ralf Baechle)
Date: Fri, 30 May 2014 17:48:59 +0200
Subject: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
In-Reply-To: <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
Message-ID: <20140530154859.GK17197@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 01:39:15PM +0200, Geert Uytterhoeven wrote:

> > +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> > +                       panic("gpio: removing gpiochip with gpios still requested\n");
> 
> panic?
> 
> Is this likely to happen?

And while we're at it - panic() is going to add a \n itself so don't pass a
string ending in \n to panic().

  Ralf
