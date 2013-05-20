From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 20 May 2013 11:59:04 +0200
Subject: [RFC PATCH 1/2] ARM: delay: print dummy values for bogomips
In-Reply-To: <alpine.LFD.2.03.1305150830540.31158@syhkavp.arg>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
 <1367602547-19322-2-git-send-email-will.deacon@arm.com>
 <20130506231554.GB16801@amd.pavel.ucw.cz>
 <5188B8B2.5030601@arm.com>
 <alpine.LFD.2.03.1305141547180.31158@syhkavp.arg>
 <CAL_Jsq+Q5UMGo3J+vKKCRU+w4Kj0YN0exs7UCWTEOxmFjWfo3g@mail.gmail.com>
 <alpine.LFD.2.03.1305141945160.31158@syhkavp.arg>
 <20130515090103.GA12907@mudshark.cambridge.arm.com>
 <20130515114737.GA7900@amd.pavel.ucw.cz>
 <alpine.LFD.2.03.1305150830540.31158@syhkavp.arg>
Message-ID: <20130520095904.GA7279@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > In fact, I just tried it and at least my linaro filesystem seems happy
> > > enough.
> > 
> > Would it be too much work to simply put the field back with the right
> > value? We don't have to get it as precise as we used to, that should
> > make slowdown minimum.
> 
> There is simply no right value.  And whenever there is a value, people 
> read too much into it.

You are right that there is no right value. But there are many _wrong_
values.

Take a look at CPU temperature. There's no right value there, either,
as CPU has different temperatures at different places. Displaying
heatsink temp +5C is probably ok. Displaying case temperature or
compile time constant is not.

Now, bogoMIPS is supposed to be instructions per second. Measure
instructions per second, and you have acceptable value to display. Put
back code from previous version, and you have acceptable value to
display.

"0", "1" or value from Kconfig is _not_ acceptable value.

Maybe bogomips should not have been exposed in /proc in the first
place, but it is too late now. "No regressions".

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
