From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Apr 2010 15:32:16 +0200
Subject: [PATCH 1/4] arm: msm: gpio support
In-Reply-To: <1270075991.2488.9.camel@m0nster>
References: <1269990717-2969-1-git-send-email-dwalker@codeaurora.org>
	<0D753D10438DA54287A00B027084269763691C346E@AUSP01VMBX24.collaborationhost.net>
	<d6200be21003301814m538a5902s649415d6cc7ec8fa@mail.gmail.com>
	<1270044182.2025.0.camel@m0nster>
	<l2ud6200be21003311421p8dc78179sf62b1d62d468528a@mail.gmail.com>
	<1270075991.2488.9.camel@m0nster>
Message-ID: <20100406133216.GE1424@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >> >> +     spin_lock_irqsave(&msm_chip->lock, irq_flags);
> > >> >> +
> > >> >> +     b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);
> > >> >
> > >> > Urk... That's a bit confusing...
> > >> >
> > >> > You might want to make this a macro or an inline function with some kind
> > >> > of comment.
> > >> >
> > >>
> > >> On a related note, why did you inline msm_gpio_clear_detect_status? It
> > >> is used from two other functions.
> > >>
> > >
> > > You mean other places in the Android tree?
> > 
> > No, you copied it three times in this file.
> 
> Oh, well it was part of the API elimination , but it's helpful when
> doing clean up to have stuff all unrolled so optimization possibilities
> present themselves more easily .. You think I should convert it into an
> inline?

I guess so. Premature optimalization is sqrt(all evil).

Really, leave that to compiler.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
