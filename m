From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 21 May 2011 16:35:38 +0200
Subject: Disable CF during suspend
In-Reply-To: <1305988078.5824.14.camel@utx.lan>
References: <20110521094326.GB26323@elf.ucw.cz>
	<1305988078.5824.14.camel@utx.lan>
Message-ID: <20110521143535.GA2422@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Disable SPITZ_SCP_CF_POWER during suspend. Otherwise it eats battery,
> > fast. Thanks to Stanislav Brabec.
> 
> If you can verify that your card turns off on suspend, then you have my:
> Acked-by: Stanislav Brabec <utx@penguin.cz>

Yes, I checked the LEDs to make sure it is off. It is.

> But I would line to see more aggressive power control, something like
> spitz_card_pwr_ctrl() in old kernels - if there is no CF and no
> (external) CF card inserted, then SPITZ_SCP_CF_POWER card be turned off.
> If they are memory cards, they can be turned off even while idle.

Yes, that would be nice; but this is already good first step.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
