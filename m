From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 06 Nov 2015 11:14:49 +0300
Subject: [PATCH v6 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <563BEE44.4040207@samsung.com>
References: <cover.1446724046.git.p.fedin@samsung.com>
 <26ce9f26ee8537b2f81ad0bf470d1c6b1c8a1a31.1446724046.git.p.fedin@samsung.com>
 <563BEE44.4040207@samsung.com>
Message-ID: <001001d1186b$358b6470$a0a22d50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +- samsung,srom-timing : array of 6 integers, specifying bank timings in the
> > +                        following order: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> > +                        Each value is specified in cycles and has the following
> > +                        meaning and valid range:
> > +                        Tacp : Page mode access cycle at Page mode (0 - 15)
> > +                        Tcah : Address holding time after CSn (0 - 15)
> > +                        Tcoh : Chip selection hold on OEn (0 - 15)
> > +                        Tacc : Access cycle (0 - 32)
> 
> All of the manuals have error here. Probably it can be either: 1-32 or
> 0-31. I would bet on 0-31, what do you think?

 Damn, everything starts from 0, so i automatically put '0 - 32'. The actual time, however, varies from 1 to 32, but the value is
from 0 to 31, i. e. <time> - 1
 What shall we do? Just document this, or adjust the code to take number of cycles and subtract 1? To tell the truth, i'm already
sick of these small fixups, and i would prefer just to fix documentation.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
