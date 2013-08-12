From: pavel@denx.de (Pavel Machek)
Date: Mon, 12 Aug 2013 13:57:04 +0200
Subject: [PATCH 1/2] ARM: dts: Change dw-apb-timer-osc and
 dw-apb-timer-sp to just dw-apb-timer
In-Reply-To: <20130811214509.GA26757@quad.lixom.net>
References: <1374723797-22169-1-git-send-email-dinguyen@altera.com>
 <20130811214509.GA26757@quad.lixom.net>
Message-ID: <20130812115703.GA27616@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > index eb2327b..0a1020e 100644
> > --- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > +++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > @@ -1,7 +1,7 @@
> >  * Designware APB timer
> >  
> >  Required properties:
> > -- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
> > +- compatible: "snps,dw-apb-timer"
> >  - reg: physical base address of the controller and length of memory mapped
> >    region.
> >  - interrupts: IRQ line for the timer.
> 
> Here's a classic example of where we will eventually need to keep the ABI. You
> can add a comment that the preferred compatible value is the new one, but the
> old ones still need to be handled by the drivers, and shouldn't be removed.
> 
> That is, of course, if people are happy with the current binding and want to
> keep it instead of revising it before declaring it locked in.

The first -sp / -osc separation was bad idea from the start. It would
be better if we could get rid of it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
