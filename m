From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 16 Apr 2011 09:41:34 +0200
Subject: Zaurus CF tests -- ok
In-Reply-To: <20110415213817.GC4420@atrey.karlin.mff.cuni.cz>
References: <20110415211822.GB21111@atrey.karlin.mff.cuni.cz>
	<20110415213817.GC4420@atrey.karlin.mff.cuni.cz>
Message-ID: <20110416074134.GA26440@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > After getting _good_ power supply, I was able to untar and rm ltp tree
> > 100 times so far. 2.6.38, ext3. (So metan no, I do not see any weird
> > ext3 problems).
> 
> Hmm, I'm using original adapter, but who knows if it's okay to use...

It probably is...

> > Another strange thing is... I see lots of duplicated keystrokes --
> > like type "pavel" but machine understands "paavel". But it only seems
> > to happen when I'm _not_ trying to debug it?!
> 
> That seems to be side effect of machine under load (it has gpio keyboard).

ouch. original corgi_kbd driver used timers, new one uses threads --
more affected by scheduling. I'm not even sure if the worker thread it
uses runs at elevated priority...

> > With power from USB extension cable, it crashes in <5 minutes. It
> > seems to toggle charger a lot, as voltage on the cable is only
> > 4.2..4.5V. I guess it is software problem in the charging code.
> > )
> 
> The zaurus actually is AFAIK unable to run from battery when connected to the
> external power, so weak power line may explain some of the strange behaviour.

?? IIRC Stanislav told me that hardware will always run off whatever
is available...?
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
